CREATE DATABASE IF NOT EXISTS `sinan_RezerwacjeBiletow_1` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `sinan_RezerwacjeBiletow_1`;


SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE TABLE IF NOT EXISTS `events` (
  `id` varchar(40) NOT NULL,
  `user_id` varchar(40) NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `eventDate` datetime DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `tickets` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_events_users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `events` (`id`, `user_id`, `name`, `city`, `place`, `eventDate`, `price`, `tickets`) VALUES
('01:01348b92-d3ae-4b53-abf3-5e84615d9b0d', '01:14', 'Ko�o si� toczy', 'Pcim dolny', 'G�rka', '2016-01-12 12:12:00', '23.90', 2),
('01:0d946400-5830-4706-8848-9c2f95a0977d', '01:14', 'KSW 24', 'Warszawa', 'Torwar', '2016-01-23 19:00:00', '121.50', 0),
('01:1525e687-f08d-4ea9-9e35-b05ee71b1b32', '01:15', 'Walka Pudzian kontra Najman', '��d�', 'Atlas arena', '2016-01-14 22:00:00', '50.00', 498),
('01:5860fbe5-1a83-4ed5-9f82-c7244391f7cf', '01:14', 'Mecz Legia - Wis�a', 'Warszawa', 'Stadion Legii', '2016-01-22 14:00:00', '14.99', 50),
('01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', '01:14', 'Koncert Iron Maiden + Metallica', 'Warszawa', 'Stadion Narodowy', '2016-03-24 19:00:00', '400.00', 92);

CREATE TABLE IF NOT EXISTS `messages` (
  `id` varchar(40) NOT NULL,
  `recipient_id` varchar(40) NOT NULL DEFAULT '0',
  `sender_id` varchar(40) NOT NULL DEFAULT '0',
  `event_id` varchar(40) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `readed` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_messages_users` (`recipient_id`),
  KEY `FK_messages_users_2` (`sender_id`),
  KEY `FK_messages_events` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `messages` (`id`, `recipient_id`, `sender_id`, `event_id`, `title`, `message`, `readed`) VALUES
('01:0731c6f2-4eeb-4376-a0ec-cffb9b48b808', '01:15', '01:14', '01:5860fbe5-1a83-4ed5-9f82-c7244391f7cf', 'RE: A tytaj?', 'A kiedy chcesz?', 1),
('01:2475067b-8fa3-4a35-aff6-8106327d70d7', '01:14', '01:15', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', 'RE: Informacja w sprawie bilet�w', 'Naprawd�?', 1),
('01:45a79b39-0998-4c77-8f6e-a803480b7e3a', '01:15', '01:14', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', 'Anulowanie rezerwacji', 'Twoja rezerwacja zosta�a anulowana. Aby uzyska� wi�cej szczeg��w skontaktuj si� z organizatorem.', 0),
('01:46db6aa8-26f0-4a0d-8379-6d49942ef9c7', '01:15', '01:14', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', 'Koncert prze�o�ony', 'Koncert prze�o�ony na godzin� p�niej', 0),
('01:6b2f1108-65f2-422d-8284-463940501d37', '01:14', '01:15', '01:5860fbe5-1a83-4ed5-9f82-c7244391f7cf', 'A tytaj?', 'Kiedy mo�na?', 1),
('01:a9a7856b-1716-4e71-8638-7ef7ed9074f9', '01:15', '01:14', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', 'Informacja w sprawie bilet�w', 'Twoje bilety b�d� wydrukowane na papierze toaletowym', 1),
('01:adfe4dfa-b841-417e-adcc-1050aa42a7ef', '01:14', '01:15', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', 'Kiedy b�dzie mo�na przyjecha�?', 'Witam chcia�em zapyta� kiedy b�dzie mo�na przyjecha� �eby wpu�cili.', 0),
('01:ba131fd4-ac9b-44a5-8f56-c3e5f48b89b3', '01:15', '01:14', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', 'Anulowanie rezerwacji', 'Twoja rezerwacja zosta�a anulowana. Aby uzyska� wi�cej szczeg��w skontaktuj si� z organizatorem.', 1),
('01:dbfa7b1e-7e8e-463d-bf4f-3d754ea95a7f', '01:12', '01:14', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', 'Koncert prze�o�ony', 'Koncert prze�o�ony na godzin� p�niej', 0),
('01:fc8710d5-693d-4ad4-88a3-5ba243445334', '01:13', '01:14', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', 'Koncert prze�o�ony', 'Koncert prze�o�ony na godzin� p�niej', 0);

CREATE TABLE IF NOT EXISTS `reservations` (
  `id` varchar(40) NOT NULL,
  `event_id` varchar(40) NOT NULL DEFAULT '0',
  `user_id` varchar(40) NOT NULL DEFAULT '0',
  `tickets` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK__events` (`event_id`),
  KEY `FK__users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `reservations` (`id`, `event_id`, `user_id`, `tickets`) VALUES
('01:15e77c37-8a14-4bde-ad5a-d0246ee322e8', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', '01:12', 2),
('01:472e76d0-7b81-4039-a44a-de566d47f79b', '02:6ef57a4c-1587-47f2-9d95-38eb7fff52f2', '01:256d5775-1b2d-4ecb-a22b-603024297771', 2),
('01:71a22ba3-5b5b-4e88-9ca7-324f3745b4cc', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', '01:13', 5),
('01:78a0b403-f931-4163-b7f9-e1f853cf138c', '02:6ef57a4c-1587-47f2-9d95-38eb7fff52f2', '01:256d5775-1b2d-4ecb-a22b-603024297771', 1),
('01:8e4a02dc-7d01-4d42-9642-6c473947aa34', '01:63ddd411-7aa9-4d94-bf70-32e745ab16f5', '01:15', 1),
('01:d48b0e50-0cef-46cd-bfb6-2fe1e984895e', '01:1525e687-f08d-4ea9-9e35-b05ee71b1b32', '01:13', 1);

CREATE TABLE IF NOT EXISTS `users` (
  `id` varchar(40) NOT NULL,
  `email` varchar(50) NOT NULL DEFAULT '0',
  `password` varchar(50) NOT NULL DEFAULT '0',
  `type` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `users` (`id`, `email`, `password`, `type`) VALUES
('01:12', 'aaa@aaa.pl', '47bce5c74f589f4867dbd57e9ca9f808', 'klient'),
('01:13', 'bbb@bbb.pl', '08f8e0260c64418510cefb2b06eee5cd', 'klient'),
('01:14', 'ccc@ccc.pl', '9df62e693988eb4e1e1444ece0578579', 'organizator'),
('01:15', 'ddd@ddd.pl', '77963b7a931377ad4ab5ad6a9cd718aa', 'organizator'),
('01:256d5775-1b2d-4ecb-a22b-603024297771', 'pezhman1024@gmail.com', 'e3ceb5881a0a1fdaad01296d7554868d', 'klient');










CREATE DATABASE IF NOT EXISTS `sinan_RezerwacjeBiletow_2` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `sinan_RezerwacjeBiletow_2`;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE TABLE IF NOT EXISTS `events` (
  `id` varchar(40) NOT NULL,
  `user_id` varchar(40) NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `eventDate` datetime DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `tickets` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_events_users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `events` (`id`, `user_id`, `name`, `city`, `place`, `eventDate`, `price`, `tickets`) VALUES
('02:6ef57a4c-1587-47f2-9d95-38eb7fff52f2', '02:5296bf09-c4f1-472d-b8cf-2892f77a7108', 'Java conference', 'Berlin', 'University', '2016-10-10 13:10:00', '100.00', 1001);

CREATE TABLE IF NOT EXISTS `messages` (
  `id` varchar(40) NOT NULL,
  `recipient_id` varchar(40) NOT NULL DEFAULT '0',
  `sender_id` varchar(40) NOT NULL DEFAULT '0',
  `event_id` varchar(40) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `readed` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_messages_users` (`recipient_id`),
  KEY `FK_messages_users_2` (`sender_id`),
  KEY `FK_messages_events` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `messages` (`id`, `recipient_id`, `sender_id`, `event_id`, `title`, `message`, `readed`) VALUES
('02:6204ad1d-b6e8-4ba3-9383-b68026167039', '01:256d5775-1b2d-4ecb-a22b-603024297771', '02:5296bf09-c4f1-472d-b8cf-2892f77a7108', '02:6ef57a4c-1587-47f2-9d95-38eb7fff52f2', 'Anulowanie rezerwacji', 'Twoja rezerwacja została anulowana. Aby uzyskać więcej szczegółów skontaktuj się z organizatorem.', 0),
('02:cf2a1fc2-8892-40bc-98ab-4fe1d24281fa', '01:256d5775-1b2d-4ecb-a22b-603024297771', '02:5296bf09-c4f1-472d-b8cf-2892f77a7108', '02:6ef57a4c-1587-47f2-9d95-38eb7fff52f2', 'Anulowanie rezerwacji', 'Twoja rezerwacja została anulowana. Aby uzyskać więcej szczegółów skontaktuj się z organizatorem.', 0);

CREATE TABLE IF NOT EXISTS `reservations` (
  `id` varchar(40) NOT NULL,
  `event_id` varchar(40) NOT NULL DEFAULT '0',
  `user_id` varchar(40) NOT NULL DEFAULT '0',
  `tickets` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK__events` (`event_id`),
  KEY `FK__users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `users` (
  `id` varchar(40) NOT NULL,
  `email` varchar(50) NOT NULL DEFAULT '0',
  `password` varchar(50) NOT NULL DEFAULT '0',
  `type` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `users` (`id`, `email`, `password`, `type`) VALUES
('02:18bf5716-5989-4113-a8a9-707081d09268', 'pezhman128@gmail.com', 'e3ceb5881a0a1fdaad01296d7554868d', 'klient'),
('02:41152e09-ccf2-4240-bebf-d28e87ff9ad1', 'pezhman2048@gmail.com', 'e3ceb5881a0a1fdaad01296d7554868d', 'klient'),
('02:5296bf09-c4f1-472d-b8cf-2892f77a7108', 'pezhman64@gmail.com', 'e3ceb5881a0a1fdaad01296d7554868d', 'organizator'),
('02:64bdc2a5-5825-44de-941c-d19cbc04150d', 'pezhman256@gmail.com', 'e3ceb5881a0a1fdaad01296d7554868d', 'klient'),
('02:f1c34da5-bee7-47f2-9a77-e5c0c128e178', 'pezhman512@gmail.com', 'e3ceb5881a0a1fdaad01296d7554868d', 'klient');


ALTER TABLE `messages`
  ADD CONSTRAINT `FK_messages_events` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE;
