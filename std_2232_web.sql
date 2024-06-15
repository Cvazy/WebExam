-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: std-mysql
-- Время создания: Июн 15 2024 г., 18:59
-- Версия сервера: 5.7.26-0ubuntu0.16.04.1
-- Версия PHP: 8.1.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `std_2232_web`
--

-- --------------------------------------------------------

--
-- Структура таблицы `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `short_desc` text NOT NULL,
  `genre` varchar(255) NOT NULL,
  `year` year(4) NOT NULL,
  `publishing_house` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `pages_qnt` int(11) NOT NULL,
  `cover_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `books`
--

INSERT INTO `books` (`id`, `name`, `short_desc`, `genre`, `year`, `publishing_house`, `author`, `pages_qnt`, `cover_id`) VALUES
(49462876, 'Название третьей книги', 'Разнообразный и богатый опыт постоянный количественный рост и сфера нашей активности играет важную роль в формировании модели развития. С другой стороны консультация с широким активом позволяет оценить значение системы обучения кадров, соответствует насущным потребностям. Значимость этих проблем настолько очевидна, что новая модель организационной деятельности влечет за собой процесс внедрения и модернизации системы обучения кадров, соответствует насущным потребностям. Разнообразный и богатый опыт новая модель организационной деятельности в значительной степени обуславливает создание модели развития.', 'Ода', '1934', 'Какое-то издательство', 'Григорьев Григорий Геориевич', 821, 1180470038),
(162522852, 'Багряный коршун', 'Разнообразный и богатый опыт постоянный количественный рост и сфера нашей активности играет важную роль в формировании модели развития. С другой стороны консультация с широким активом позволяет оценить значение системы обучения кадров, соответствует насущным потребностям. Значимость этих проблем настолько очевидна, что новая модель организационной деятельности влечет за собой процесс внедрения и модернизации системы обучения кадров, соответствует насущным потребностям. Разнообразный и богатый опыт новая модель организационной деятельности в значительной степени обуславливает создание модели развития.', 'Повесть', '2024', 'Новое издательство', 'Пупкин Иван Иванович', 912, 727910824),
(451249750, 'Название четвёртой книги', 'Разнообразный и богатый опыт постоянный количественный рост и сфера нашей активности играет важную роль в формировании модели развития. С другой стороны консультация с широким активом позволяет оценить значение системы обучения кадров, соответствует насущным потребностям. Значимость этих проблем настолько очевидна, что новая модель организационной деятельности влечет за собой процесс внедрения и модернизации системы обучения кадров, соответствует насущным потребностям. Разнообразный и богатый опыт новая модель организационной деятельности в значительной степени обуславливает создание модели развития.', 'Повесть', '1973', 'Какое-то издательство', 'Пупкин Иван Иванович', 391, 1837181298),
(797854474, 'Название второй книги', 'Разнообразный и богатый опыт постоянный количественный рост и сфера нашей активности играет важную роль в формировании модели развития. С другой стороны консультация с широким активом позволяет оценить значение системы обучения кадров, соответствует насущным потребностям. Значимость этих проблем настолько очевидна, что новая модель организационной деятельности влечет за собой процесс внедрения и модернизации системы обучения кадров, соответствует насущным потребностям. Разнообразный и богатый опыт новая модель организационной деятельности в значительной степени обуславливает создание модели развития.', 'Пьеса', '2018', 'Какое-то издательство', 'Васильев Василий Васильевич', 481, 391956695),
(1276604316, 'Чёрный ворон', 'Разнообразный и богатый опыт постоянный количественный рост и сфера нашей активности играет важную роль в формировании модели развития. С другой стороны консультация с широким активом позволяет оценить значение системы обучения кадров, соответствует насущным потребностям. Значимость этих проблем настолько очевидна, что новая модель организационной деятельности влечет за собой процесс внедрения и модернизации системы обучения кадров, соответствует насущным потребностям. Разнообразный и богатый опыт новая модель организационной деятельности в значительной степени обуславливает создание модели развития.', 'Очерк', '2013', 'ООО \"МосПолитех\"', 'Васильев Василий Васильевич', 680, 1438188225),
(1310743312, 'Название шестой книги', 'Разнообразный и богатый опыт постоянный количественный рост и сфера нашей активности играет важную роль в формировании модели развития. С другой стороны консультация с широким активом позволяет оценить значение системы обучения кадров, соответствует насущным потребностям. Значимость этих проблем настолько очевидна, что новая модель организационной деятельности влечет за собой процесс внедрения и модернизации системы обучения кадров, соответствует насущным потребностям. Разнообразный и богатый опыт новая модель организационной деятельности в значительной степени обуславливает создание модели развития.', 'Поэма', '2000', 'Какое-то издательство', 'Васильев Василий Васильевич', 719, 233095421),
(1388201436, 'Новая книга', 'Разнообразный и богатый опыт постоянный количественный рост и сфера нашей активности играет важную роль в формировании модели развития. С другой стороны консультация с широким активом позволяет оценить значение системы обучения кадров, соответствует насущным потребностям. Значимость этих проблем настолько очевидна, что новая модель организационной деятельности влечет за собой процесс внедрения и модернизации системы обучения кадров, соответствует насущным потребностям. Разнообразный и богатый опыт новая модель организационной деятельности в значительной степени обуславливает создание модели развития.', 'Повесть', '1998', 'ООО \"МосПолитех\"', 'Григорьев Григорий Геориевич', 542, 520829559),
(1504840277, 'Название первой книги', 'Разнообразный и богатый опыт постоянный количественный рост и сфера нашей активности играет важную роль в формировании модели развития. С другой стороны консультация с широким активом позволяет оценить значение системы обучения кадров, соответствует насущным потребностям. Значимость этих проблем настолько очевидна, что новая модель организационной деятельности влечет за собой процесс внедрения и модернизации системы обучения кадров, соответствует насущным потребностям. Разнообразный и богатый опыт новая модель организационной деятельности в значительной степени обуславливает создание модели развития.', 'Поэма', '2011', 'Какое-то издательство', 'Пупкин Иван Иванович', 130, 938422125),
(1660757622, 'Название седьмой книги', 'Разнообразный и богатый опыт постоянный количественный рост и сфера нашей активности играет важную роль в формировании модели развития. С другой стороны консультация с широким активом позволяет оценить значение системы обучения кадров, соответствует насущным потребностям. Значимость этих проблем настолько очевидна, что новая модель организационной деятельности влечет за собой процесс внедрения и модернизации системы обучения кадров, соответствует насущным потребностям. Разнообразный и богатый опыт новая модель организационной деятельности в значительной степени обуславливает создание модели развития.', 'Новелла', '1980', 'Какое-то издательство', 'Пупкин Иван Иванович', 819, 1036345377),
(1839394737, 'Название пятой книги', 'Разнообразный и богатый опыт постоянный количественный рост и сфера нашей активности играет важную роль в формировании модели развития. С другой стороны консультация с широким активом позволяет оценить значение системы обучения кадров, соответствует насущным потребностям. Значимость этих проблем настолько очевидна, что новая модель организационной деятельности влечет за собой процесс внедрения и модернизации системы обучения кадров, соответствует насущным потребностям. Разнообразный и богатый опыт новая модель организационной деятельности в значительной степени обуславливает создание модели развития.', 'Видения', '2021', 'Какое-то издательство', 'Григорьев Григорий Геориевич', 319, 50021952);

-- --------------------------------------------------------

--
-- Структура таблицы `covers`
--

CREATE TABLE `covers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `mime_type` varchar(255) NOT NULL,
  `md5_hash` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `covers`
--

INSERT INTO `covers` (`id`, `name`, `mime_type`, `md5_hash`) VALUES
(50021952, 'webp.webp', 'image/webp', '275c5a92a1a8598a6c0eed264e89eecb'),
(233095421, 'E96lKtOC8HgN4r77z66axAAFMn9l3I.jpg', 'image/jpeg', '5349d0cb0e15b79370f7492f59ac7071'),
(391956695, '1003w-4he1eqkeAQg.webp', 'image/webp', '7814e2ab2ccdb23b02fe110c9932b16d'),
(520829559, 'lent.jpeg', 'image/jpeg', '151b74923028080a0e96ea88802e6fec'),
(727910824, 'redstained.jpg', 'image/jpeg', '0b567b88bf5bbe3c5f51d833a423a348'),
(823673563, 'blades.jpg', 'image/jpeg', 'b9022c0a7d31d5d19b0934e18e96bd4b'),
(938422125, '29e90fbcac66748657516eb12f85832c.jpg', 'image/jpeg', '6cd4313a0a924ec41d21aa8fb79e8bd1'),
(1036345377, 'ee2138d7d617486dec8371d1e93f5d06.jpg', 'image/jpeg', '8261f3bf25fa537b7a4cc5214861d2e8'),
(1180470038, '1024w-iRBldJ_jyLw.webp', 'image/webp', 'e99fe9293ac5eb886d1fa14ee4f35abf'),
(1438188225, 'stormcrow.jpg', 'image/jpeg', 'de40c5b6b1aac8e4d7ae510b41822563'),
(1837181298, 'd5bazwrc.png', 'image/png', '7f5651fa240a78e547c736797313fc0d');

-- --------------------------------------------------------

--
-- Структура таблицы `genres`
--

CREATE TABLE `genres` (
  `author_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `mark` int(11) NOT NULL,
  `text` text NOT NULL,
  `publish_date` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `reviews`
--

INSERT INTO `reviews` (`id`, `book_id`, `user_id`, `mark`, `text`, `publish_date`) VALUES
(53987751, 162522852, 4, 4, 'Новый тестовый отзыв', '15-06-2024'),
(1015364541, 162522852, 2, 5, 'Новый отзыв от модератора', '15-06-2024');

-- --------------------------------------------------------

--
-- Структура таблицы `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`) VALUES
(1, 'Administrator', 'The superuser has full access to the system, including the creation and deletion of books'),
(2, 'Moderator', 'Can edit book data and moderate reviews'),
(3, 'User', 'Can leave reviews');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `login` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `patronymic` varchar(255) DEFAULT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `password_hash`, `surname`, `name`, `patronymic`, `role_id`) VALUES
(2, 'moderator', '4da7f8f2729db0f90ac6e352bdc54f9ce52e65d5937d501904e744525272677e', 'Ivanov', 'Ivan', 'Ivanovich', 2),
(3, 'user', 'c7f7278ad455e70505cf6eec61ae5d5154edde78330a7614d63e048d179050f4', 'Petrov', 'Petr', 'Petrovich', 3),
(4, 'admin', '0738a3e2111e114a665d35b24be5f42d1f98700f161633f63fbaa15b4b3103ab', 'Murakhtanov', 'Pavel', NULL, 1);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cover_id` (`cover_id`);

--
-- Индексы таблицы `covers`
--
ALTER TABLE `covers`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `genres`
--
ALTER TABLE `genres`
  ADD KEY `author_id` (`author_id`),
  ADD KEY `book_id` (`book_id`);

--
-- Индексы таблицы `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`);

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`cover_id`) REFERENCES `covers` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `genres`
--
ALTER TABLE `genres`
  ADD CONSTRAINT `genres_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `genres_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
