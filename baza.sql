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
CREATE DATABASE IF NOT EXISTS `sinan_RezerwacjeBiletow_1` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `sinan_RezerwacjeBiletow_1`;


-- Zrzut struktury tabela rezerwacjebiletow.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` VARCHAR(40) NOT NULL,
  `email` varchar(50) NOT NULL DEFAULT '0',
  `password` varchar(50) NOT NULL DEFAULT '0',
  `type` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Zrzucanie danych dla tabeli rezerwacjebiletow.users: ~4 rows (oko�o)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `email`, `password`, `type`) VALUES
	('01:12', 'aaa@aaa.pl', '47bce5c74f589f4867dbd57e9ca9f808', 'klient'),
	('01:13', 'bbb@bbb.pl', '08f8e0260c64418510cefb2b06eee5cd', 'klient'),
	('01:14', 'ccc@ccc.pl', '9df62e693988eb4e1e1444ece0578579', 'organizator'),
	('01:15', 'ddd@ddd.pl', '77963b7a931377ad4ab5ad6a9cd718aa', 'organizator');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;



-- Zrzut struktury tabela rezerwacjebiletow.events
CREATE TABLE IF NOT EXISTS `events` (
  `id` VARCHAR(40) NOT NULL,
  `user_id` VARCHAR(40) NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `eventDate` datetime DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `tickets` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_events_users` (`user_id`),
  CONSTRAINT `FK_events_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Zrzucanie danych dla tabeli rezerwacjebiletow.events: ~5 rows (oko�o)
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` (`id`, `user_id`, `name`, `city`, `place`, `eventDate`, `price`, `tickets`) VALUES
	('01:0d946400-5830-4706-8848-9c2f95a0977d', '01:14', 'KSW 24', 'Warszawa', 'Torwar', '2016-01-23 19:00:00', 121.50, 0),
	('01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', '01:14', 'Koncert Iron Maiden + Metallica', 'Warszawa', 'Stadion Narodowy', '2016-03-24 19:00:00', 400.00, 92),
	('01:5860fbe5-1a83-4ed5-9f82-c7244391f7cf', '01:14', 'Mecz Legia - Wis�a', 'Warszawa', 'Stadion Legii', '2016-01-22 14:00:00', 14.99, 50),
	('01:1525e687-f08d-4ea9-9e35-b05ee71b1b32', '01:15', 'Walka Pudzian kontra Najman', '��d�', 'Atlas arena', '2016-01-14 22:00:00', 50.00, 498),
	('01:01348b92-d3ae-4b53-abf3-5e84615d9b0d', '01:14', 'Ko�o si� toczy', 'Pcim dolny', 'G�rka', '2016-01-12 12:12:00', 23.90, 2);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;


-- Zrzut struktury tabela rezerwacjebiletow.messages
CREATE TABLE IF NOT EXISTS `messages` (
  `id` VARCHAR(40) NOT NULL,
  `recipient_id` VARCHAR(40) NOT NULL DEFAULT '0',
  `sender_id` VARCHAR(40) NOT NULL DEFAULT '0',
  `event_id` VARCHAR(40) NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Zrzucanie danych dla tabeli rezerwacjebiletow.messages: ~2 rows (oko�o)
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` (`id`, `recipient_id`, `sender_id`, `event_id`, `title`, `message`, `readed`) VALUES
	('01:adfe4dfa-b841-417e-adcc-1050aa42a7ef', '01:14', '01:15', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', 'Kiedy b�dzie mo�na przyjecha�?', 'Witam chcia�em zapyta� kiedy b�dzie mo�na przyjecha� �eby wpu�cili.', 0),
	('01:6b2f1108-65f2-422d-8284-463940501d37', '01:14', '01:15', '01:5860fbe5-1a83-4ed5-9f82-c7244391f7cf', 'A tytaj?', 'Kiedy mo�na?', 1),
	('01:0731c6f2-4eeb-4376-a0ec-cffb9b48b808', '01:15', '01:14', '01:5860fbe5-1a83-4ed5-9f82-c7244391f7cf', 'RE: A tytaj?', 'A kiedy chcesz?', 1),
	('01:a9a7856b-1716-4e71-8638-7ef7ed9074f9', '01:15', '01:14', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', 'Informacja w sprawie bilet�w', 'Twoje bilety b�d� wydrukowane na papierze toaletowym', 1),
	('01:2475067b-8fa3-4a35-aff6-8106327d70d7', '01:14', '01:15', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', 'RE: Informacja w sprawie bilet�w', 'Naprawd�?', 1),
	('01:dbfa7b1e-7e8e-463d-bf4f-3d754ea95a7f', '01:12', '01:14', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', 'Koncert prze�o�ony', 'Koncert prze�o�ony na godzin� p�niej', 0),
	('01:fc8710d5-693d-4ad4-88a3-5ba243445334', '01:13', '01:14', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', 'Koncert prze�o�ony', 'Koncert prze�o�ony na godzin� p�niej', 0),
	('01:46db6aa8-26f0-4a0d-8379-6d49942ef9c7', '01:15', '01:14', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', 'Koncert prze�o�ony', 'Koncert prze�o�ony na godzin� p�niej', 0),
	('01:ba131fd4-ac9b-44a5-8f56-c3e5f48b89b3', '01:15', '01:14', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', 'Anulowanie rezerwacji', 'Twoja rezerwacja zosta�a anulowana. Aby uzyska� wi�cej szczeg��w skontaktuj si� z organizatorem.', 1),
	('01:45a79b39-0998-4c77-8f6e-a803480b7e3a', '01:15', '01:14', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', 'Anulowanie rezerwacji', 'Twoja rezerwacja zosta�a anulowana. Aby uzyska� wi�cej szczeg��w skontaktuj si� z organizatorem.', 0);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;


-- Zrzut struktury tabela rezerwacjebiletow.reservations
CREATE TABLE IF NOT EXISTS `reservations` (
  `id` VARCHAR(40) NOT NULL,
  `event_id` VARCHAR(40) NOT NULL DEFAULT '0',
  `user_id` VARCHAR(40) NOT NULL DEFAULT '0',
  `tickets` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK__events` (`event_id`),
  KEY `FK__users` (`user_id`),
  CONSTRAINT `FK__events` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK__users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Zrzucanie danych dla tabeli rezerwacjebiletow.reservations: ~4 rows (oko�o)
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` (`id`, `event_id`, `user_id`, `tickets`) VALUES
	('01:15e77c37-8a14-4bde-ad5a-d0246ee322e8', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', '01:12', 2),
	('01:71a22ba3-5b5b-4e88-9ca7-324f3745b4cc', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', '01:13', 5),
	('01:d48b0e50-0cef-46cd-bfb6-2fe1e984895e', '01:1525e687-f08d-4ea9-9e35-b05ee71b1b32', '01:13', 1),
	('01:8e4a02dc-7d01-4d42-9642-6c473947aa34', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', '01:15', 1);
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;


ALTER TABLE `messages` DROP FOREIGN KEY `FK_messages_users` ;
ALTER TABLE `messages` DROP FOREIGN KEY `FK_messages_users_2` ;
ALTER TABLE `reservations` DROP FOREIGN KEY `FK__events` ;
ALTER TABLE `reservations` DROP FOREIGN KEY `FK__users` ;
ALTER TABLE `reservations` DROP FOREIGN KEY `reservations_ibfk_1` ;
ALTER TABLE `reservations` DROP FOREIGN KEY `reservations_ibfk_2` ;
ALTER TABLE `events` DROP FOREIGN KEY `FK_events_users` ;
ALTER TABLE `events` DROP FOREIGN KEY `events_ibfk_1` ;
ALTER TABLE `messages` DROP FOREIGN KEY `FK_messages_events` ;
ALTER TABLE `messages` DROP FOREIGN KEY `messages_ibfk_2` ;
ALTER TABLE `messages` DROP FOREIGN KEY `messages_ibfk_3` ;
ALTER TABLE `messages` DROP FOREIGN KEY `messages_ibfk_1` ;