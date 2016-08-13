-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Wersja serwera:               5.6.24 - MySQL Community Server (GPL)
-- Serwer OS:                    Win32
-- HeidiSQL Wersja:              9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Zrzut struktury bazy danych rezerwacjebiletow
CREATE DATABASE IF NOT EXISTS `rezerwacjebiletow` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `rezerwacjebiletow`;


-- Zrzut struktury tabela rezerwacjebiletow.events
CREATE TABLE IF NOT EXISTS `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `eventDate` datetime DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `tickets` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_events_users` (`user_id`),
  CONSTRAINT `FK_events_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- Zrzucanie danych dla tabeli rezerwacjebiletow.events: ~5 rows (oko³o)
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` (`id`, `user_id`, `name`, `city`, `place`, `eventDate`, `price`, `tickets`) VALUES
	(1, 4, 'KSW 24', 'Warszawa', 'Torwar', '2016-01-23 19:00:00', 121.50, 0),
	(2, 4, 'Koncert Iron Maiden + Metallica', 'Warszawa', 'Stadion Narodowy', '2016-03-24 19:00:00', 400.00, 92),
	(10, 4, 'Mecz Legia - Wis³a', 'Warszawa', 'Stadion Legii', '2016-01-22 14:00:00', 14.99, 50),
	(11, 5, 'Walka Pudzian kontra Najman', '£ódŸ', 'Atlas arena', '2016-01-14 22:00:00', 50.00, 498),
	(13, 4, 'Ko³o siê toczy', 'Pcim dolny', 'Górka', '2016-01-12 12:12:00', 23.90, 2);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;


-- Zrzut struktury tabela rezerwacjebiletow.messages
CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipient_id` int(11) NOT NULL DEFAULT '0',
  `sender_id` int(11) NOT NULL DEFAULT '0',
  `event_id` int(11) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `readed` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_messages_users` (`recipient_id`),
  KEY `FK_messages_users_2` (`sender_id`),
  KEY `FK_messages_events` (`event_id`),
  CONSTRAINT `FK_messages_events` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_messages_users` FOREIGN KEY (`recipient_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_messages_users_2` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- Zrzucanie danych dla tabeli rezerwacjebiletow.messages: ~2 rows (oko³o)
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` (`id`, `recipient_id`, `sender_id`, `event_id`, `title`, `message`, `readed`) VALUES
	(1, 4, 5, 2, 'Kiedy bêdzie mo¿na przyjechaæ?', 'Witam chcia³em zapytaæ kiedy bêdzie mo¿na przyjechaæ ¿eby wpuœcili.', 0),
	(5, 4, 5, 10, 'A tytaj?', 'Kiedy mo¿na?', 1),
	(7, 5, 4, 10, 'RE: A tytaj?', 'A kiedy chcesz?', 1),
	(8, 5, 4, 2, 'Informacja w sprawie biletów', 'Twoje bilety bêd¹ wydrukowane na papierze toaletowym', 1),
	(9, 4, 5, 2, 'RE: Informacja w sprawie biletów', 'Naprawdê?', 1),
	(11, 2, 4, 2, 'Koncert prze³o¿ony', 'Koncert prze³o¿ony na godzinê póŸniej', 0),
	(12, 3, 4, 2, 'Koncert prze³o¿ony', 'Koncert prze³o¿ony na godzinê póŸniej', 0),
	(13, 5, 4, 2, 'Koncert prze³o¿ony', 'Koncert prze³o¿ony na godzinê póŸniej', 0),
	(14, 5, 4, 2, 'Anulowanie rezerwacji', 'Twoja rezerwacja zosta³a anulowana. Aby uzyskaæ wiêcej szczegó³ów skontaktuj siê z organizatorem.', 1),
	(15, 5, 4, 2, 'Anulowanie rezerwacji', 'Twoja rezerwacja zosta³a anulowana. Aby uzyskaæ wiêcej szczegó³ów skontaktuj siê z organizatorem.', 0);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;


-- Zrzut struktury tabela rezerwacjebiletow.reservations
CREATE TABLE IF NOT EXISTS `reservations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `tickets` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK__events` (`event_id`),
  KEY `FK__users` (`user_id`),
  CONSTRAINT `FK__events` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK__users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- Zrzucanie danych dla tabeli rezerwacjebiletow.reservations: ~4 rows (oko³o)
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` (`id`, `event_id`, `user_id`, `tickets`) VALUES
	(2, 2, 2, 2),
	(7, 2, 3, 5),
	(9, 11, 3, 1),
	(13, 2, 5, 1);
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;


-- Zrzut struktury tabela rezerwacjebiletow.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL DEFAULT '0',
  `password` varchar(50) NOT NULL DEFAULT '0',
  `type` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Zrzucanie danych dla tabeli rezerwacjebiletow.users: ~4 rows (oko³o)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `email`, `password`, `type`) VALUES
	(2, 'aaa@aaa.pl', '47bce5c74f589f4867dbd57e9ca9f808', 'klient'),
	(3, 'bbb@bbb.pl', '08f8e0260c64418510cefb2b06eee5cd', 'klient'),
	(4, 'ccc@ccc.pl', '9df62e693988eb4e1e1444ece0578579', 'organizator'),
	(5, 'ddd@ddd.pl', '77963b7a931377ad4ab5ad6a9cd718aa', 'organizator');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
