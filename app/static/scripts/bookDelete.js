const modalWindow = document.querySelector("#modal");
const modalBookName = document.querySelector("#book_name");
const modalBookId = document.querySelector("#book_id");

function deleteBook(button) {
  const bookId = button.getAttribute("data-book-id");
  const bookName = button.getAttribute("data-book-name");

  modalBookId.value = bookId;
  modalBookName.textContent = bookName;
  modalWindow.classList.remove("!hidden");
}

function modalClose() {
  modalWindow.classList.add("!hidden");
}
