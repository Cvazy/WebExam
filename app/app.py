import functools
import hashlib
import os
import random
from datetime import datetime

from flask import Flask, render_template, request, redirect, url_for, flash, current_app, send_from_directory
from flask_login import LoginManager, UserMixin, login_user, logout_user, current_user, login_required
from mysql.connector.errors import DatabaseError
from werkzeug.utils import secure_filename

from mysqldb import DatabaseConnector
from users_policy import UsersPolicy

application = Flask(__name__)
application.config.from_pyfile("config.py")
login_manager = LoginManager()
login_manager.login_view = 'login'
login_manager.login_message = 'Для выполнения данного действия необходимо пройти процедуру аутентификации'
login_manager.login_message_category = 'danger'
login_manager.init_app(application)
db = DatabaseConnector(application)


class User(UserMixin):
    def __init__(self, user_login, user_id, role_id):
        self.login = user_login
        self.id = user_id
        self.role_id = role_id

    def is_admin(self):
        return self.role_id == current_app.config['ADMIN_ROLE_ID']

    def is_moder(self):
        return self.role_id == current_app.config['MODERATOR_ID']

    def can(self, action, record=None):
        policy = UsersPolicy(record)
        method = getattr(policy, action, None)
        if method is None:
            return False
        else:
            return method()


def check_rights(action):
    def decorator(f):
        @functools.wraps(f)
        def wrapper(*args, **kwargs):
            record = None
            if "user_id" in kwargs:
                try:
                    from app import db
                    cnx = db.connect()
                    with cnx.cursor(named_tuple=True) as cursor:
                        query = ("SELECT * FROM users WHERE id = %s")
                        cursor.execute(query, (kwargs["user_id"],))
                        record = cursor.fetchone()
                except DatabaseError:
                        record = None
            if not current_user.can(action, record):
                flash('У вас недостаточно прав для выполнения данного действия', 'danger')
                return redirect(url_for('index'))
            return f(*args, **kwargs)
        return wrapper
    return decorator


@login_manager.user_loader
def load_user(user_id):
    cnx = db.connect()
    with cnx.cursor(named_tuple=True) as cursor:
        cursor = cnx.cursor(named_tuple=True)
        cursor.execute("SELECT id, role_id, login FROM users where id = %s", (user_id,))
        user_data = cursor.fetchone()
    if user_data is not None:
        return User(user_data.login, user_data.id, user_data.role_id)
    return None


@application.route('/login', methods=['post', 'get'])
def login():
    if request.method == 'POST':
        user_login = request.form['user_login']
        user_password = request.form['user_password']
        check_remember = True if request.form.get('user_remember') else False
        cnx = db.connect()

        with cnx.cursor(named_tuple=True) as cursor:
            query = "SELECT login, id, role_id FROM users where login = %s and password_hash = SHA2(%s, 256)"
            cursor.execute(query, (user_login, user_password))
            user_data = cursor.fetchone()

        if user_data is not None:
            login_user(User(user_data.login, user_data.id, user_data.role_id), remember=check_remember)
            flash("Вход выполнен успешно", "success")
            return redirect(request.args.get('next', url_for('index')))

        massage = 'Невозможно аутентифицироваться с указанными логином и паролем'
        flash(massage, "danger")

    return render_template('login.html')


@application.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('index'))


@application.route('/')
def index():
    page = request.args.get('page', 1, type=int)
    per_page = 6
    offset = (page - 1) * per_page

    cnx = db.connect()

    with cnx.cursor(named_tuple=True) as cursor:
        cursor.execute("SELECT COUNT(*) AS count FROM books")
        total_books = cursor.fetchone().count
        total_pages = (total_books + per_page - 1) // per_page

        if page > total_pages:
            return redirect(url_for('index', page=total_pages))

        cursor.execute(
            """
            SELECT books.id AS book_id, books.name AS book_name, books.short_desc, books.genre, books.year, books.publishing_house, books.author, books.pages_qnt, books.cover_id AS book_cover_id, covers.id AS cover_id, covers.name AS cover_name, covers.mime_type, covers.md5_hash, ROUND(AVG(reviews.mark), 2) AS average_mark
            FROM books 
            LEFT JOIN covers ON books.cover_id = covers.id
            LEFT JOIN reviews ON books.id = reviews.book_id
            GROUP BY books.id
            LIMIT %s OFFSET %s
            """, (per_page, offset)
        )

        books_list = cursor.fetchall()

    return render_template('index.html', books_list=books_list, page=page, total_pages=total_pages)


@application.route('/books/<int:book_id>/view')
def book_details(book_id):
    cnx = db.connect()

    with cnx.cursor(named_tuple=True) as cursor:
        query = (
            "SELECT books.id AS book_id, books.name AS book_name, books.short_desc, books.genre, books.year, books.publishing_house, books.author, books.pages_qnt, books.cover_id AS book_cover_id, covers.id AS cover_id, covers.name AS cover_name, covers.mime_type, covers.md5_hash FROM books LEFT JOIN covers ON books.cover_id = covers.id WHERE books.id = %s"
        )

        cursor.execute(query, (book_id, ))
        book_data = cursor.fetchone()

        query_reviews = (
            "SELECT reviews.*, users.login FROM reviews INNER JOIN users ON reviews.user_id = users.id WHERE book_id = %s AND user_id != %s"
        )

        cursor.execute(query_reviews, (book_id, current_user.get_id()))
        reviews_data = cursor.fetchall()

        query_user_review = (
            "SELECT reviews.*, users.login FROM reviews INNER JOIN users ON reviews.user_id = users.id WHERE book_id = %s AND user_id = %s"
        )

        cursor.execute(query_user_review, (book_id, current_user.get_id()))
        user_review = cursor.fetchone()

    return render_template('book_details.html', book_data=book_data, reviews_data=reviews_data, user_review=user_review)


@application.route('/books/new', methods=['GET', 'POST'])
@login_required
@check_rights('create')
def new_book():
    if request.method == 'POST':
        try:
            book_name = request.form.get('book_name')
            book_genre = request.form.get('book_genre')
            book_desc = request.form.get('book_desc')
            book_year = request.form.get('year')
            publishing_house = request.form.get('publishing_house')
            author = request.form.get('author')
            pages_qnt = request.form.get('pages_qnt')
            cover_image = request.files.get('book_cover')

            if cover_image and cover_image.filename:
                filename = secure_filename(cover_image.filename)
                mimetype = cover_image.mimetype
                md5hash = hashlib.md5(cover_image.read()).hexdigest()
                cover_image.seek(0)

                cnx = db.connect()
                cnx.start_transaction()

                with cnx.cursor(named_tuple=True) as cursor:
                    query = "SELECT id FROM covers WHERE md5_hash = %s"
                    cursor.execute(query, (md5hash,))
                    cover = cursor.fetchone()

                    if not cover:
                        cover_id = random.randint(1, 2147483647)
                        query = "INSERT INTO covers (id, name, mime_type, md5_hash) VALUES (%s, %s, %s, %s)"
                        cursor.execute(query, (cover_id, filename, mimetype, md5hash))
                        cnx.commit()

                        cover_image.save(os.path.join(current_app.config['UPLOAD_FOLDER'], cover_image.filename))

                    else:
                        cover_id = cover.id

                    cnx.start_transaction()
                    query = "INSERT INTO books (id, name, short_desc, genre, year, publishing_house, author, pages_qnt, cover_id) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"

                    cursor.execute(query, (random.randint(1, 2147483647), book_name, book_desc, book_genre, book_year, publishing_house, author, pages_qnt, cover_id))

                    cnx.commit()

                    flash('Книга была успешно добавлена!', 'success')
                    return redirect(url_for('index'))
            else:
                flash('Не удалось загрузить обложку книги.', 'danger')

        except Exception as error:
            cnx.rollback()
            flash(f'Произошла ошибка! {error}', 'danger')

    return render_template('add_book.html')


@application.route('/books/<int:book_id>/edit', methods=['GET', 'POST'])
@login_required
@check_rights('edit')
def edit_book(book_id):
    book_data = {}

    if request.method == 'GET':
        try:
            cnx = db.connect()
            with cnx.cursor(named_tuple=True) as cursor:
                query = ("SELECT * FROM books WHERE id = %s")
                cursor.execute(query, (book_id,))
                book_data = cursor.fetchone()
            if book_data is None:
                flash("Книга не найдена", category='info')
                return redirect(url_for('index'))
        except DatabaseError:
            flash('Возникла ошибка про обращении к БД!', category='danger')
            return redirect(url_for('index'))

    elif request.method == 'POST':
        data = {
            "id": book_id,
            'name': request.form['book_name'],
            'genre': request.form['book_genre'],
            'year': request.form['year'],
            'publishing_house': request.form['publishing_house'],
            'author': request.form['author'],
            'pages_qnt': request.form['pages_qnt'],
            'short_desc': request.form['book_desc'],
        }

        for key in data:
            if key != 'id' and data[key].strip() == '':
                data[key] = None

        try:
            cnx = db.connect()

            with cnx.cursor(named_tuple=True) as cursor:
                query = ("UPDATE books SET name = %(name)s, "
                         "genre = %(genre)s, year = %(year)s, "
                         "publishing_house = %(publishing_house)s, author = %(author)s, "
                         "pages_qnt = %(pages_qnt)s, short_desc = %(short_desc)s WHERE id = %(id)s")

                cursor.execute(query, data)

                cnx.commit()

                flash('Книга была успешно изменена', category='success')
                return redirect(url_for('index'))
        except DatabaseError:
            flash('Введены некоректные данные', category='danger')
            cnx.rollback()

    return render_template("edit_book.html", book_data=book_data)


@application.route('/remove', methods=['GET', 'POST'])
def remove_book():
    try:
        cnx = db.connect()

        with cnx.cursor(named_tuple=True) as cursor:
            cursor.execute("DELETE FROM books WHERE id = %s", (int(request.values.get('book_id')), ))

            cnx.commit()

            flash('Книга была удалена', category='success')

    except DatabaseError as e:
        print(e)
        flash('Произошла непредвиденная ошибка', category='danger')
        cnx.rollback()

    return redirect(url_for('index'))


@application.route('/book/<int:book_id>/review', methods=['GET', 'POST'])
def add_review(book_id):
    current_date = datetime.now()

    formatted_date = current_date.strftime('%d-%m-%Y')

    if request.method == 'GET':
        return render_template('add_review.html')
    elif request.method == 'POST':
        data = (
            random.randint(1, 2147483647),
            book_id,
            current_user.get_id(),
            request.form['review_mark_num'],
            request.form['review_text'],
            formatted_date,
        )

        try:
            cnx = db.connect()

            with cnx.cursor(named_tuple=True) as cursor:
                query = "INSERT INTO reviews (id, book_id, user_id, mark, text, publish_date) VALUES (%s, %s, %s, %s, %s, %s)"

                cursor.execute(query, data)

                cnx.commit()

                flash('Отзыв успешно опубликован', category='success')

        except DatabaseError as e:
            print(e)
            flash('При добавлении отзыва произошла ошибка', category='danger')
            cnx.rollback()

        return redirect(url_for('index'))


@application.route('/media/images/<filename>')
def serve_image(filename):
    return send_from_directory('media/images', filename)


if __name__ == '__main__':
    application.run(debug=True)
