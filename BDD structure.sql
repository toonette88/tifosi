-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 16 août 2024 à 16:45
-- Version du serveur : 8.3.0
-- Version de PHP : 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `tifosi`
--
CREATE DATABASE IF NOT EXISTS `tifosi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `tifosi`;

-- --------------------------------------------------------

--
-- Utilisateurs : `tifosi`
--
CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'mdptifosi2024';
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';
FLUSH PRIVILEGES;

-- --------------------------------------------------------

--
-- Structure de la table `boisson`
--

DROP TABLE IF EXISTS `boisson`;
CREATE TABLE IF NOT EXISTS `boisson` (
  `id_boisson` int NOT NULL AUTO_INCREMENT,
  `nom_boisson` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `num_marque` int NOT NULL,
  PRIMARY KEY (`id_boisson`),
  KEY `num_marque` (`num_marque`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `id_client` int NOT NULL,
  `nom_client` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `age` int NOT NULL,
  `cp_client` int NOT NULL,
  KEY `id_client` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `client_focaccia`
--

DROP TABLE IF EXISTS `client_focaccia`;
CREATE TABLE IF NOT EXISTS `client_focaccia` (
  `jour` date NOT NULL,
  `num_client` int NOT NULL,
  `num_focaccia` int NOT NULL,
  KEY `num_client` (`num_client`),
  KEY `foccacia` (`num_focaccia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `client_menu`
--

DROP TABLE IF EXISTS `client_menu`;
CREATE TABLE IF NOT EXISTS `client_menu` (
  `jour` date NOT NULL,
  `num_client` int NOT NULL,
  `num_menu` int NOT NULL,
  KEY `num_client` (`num_client`),
  KEY `num_menu` (`num_menu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `focaccia`
--

DROP TABLE IF EXISTS `focaccia`;
CREATE TABLE IF NOT EXISTS `focaccia` (
  `id_focaccia` int NOT NULL,
  `nom_focaccia` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `prix_focaccia` float NOT NULL,
  PRIMARY KEY (`id_focaccia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `focaccia_ingredient`
--

DROP TABLE IF EXISTS `focaccia_ingredient`;
CREATE TABLE IF NOT EXISTS `focaccia_ingredient` (
  `num_focaccia` int NOT NULL,
  `num_ingredient` int NOT NULL,
  KEY `num_focaccia` (`num_focaccia`),
  KEY `num_ingredient` (`num_ingredient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
CREATE TABLE IF NOT EXISTS `ingredient` (
  `id_ingredient` int NOT NULL AUTO_INCREMENT,
  `nom_ingredient` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_ingredient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `marque`
--

DROP TABLE IF EXISTS `marque`;
CREATE TABLE IF NOT EXISTS `marque` (
  `id_marque` int NOT NULL AUTO_INCREMENT,
  `nom_marque` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_marque`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `menu`
--

DROP TABLE IF EXISTS `menu`;
CREATE TABLE IF NOT EXISTS `menu` (
  `id_menu` int NOT NULL AUTO_INCREMENT,
  `nom_menu` int NOT NULL,
  `num_focaccia` int NOT NULL,
  PRIMARY KEY (`id_menu`),
  KEY `num_focaccia` (`num_focaccia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `menu_boisson`
--

DROP TABLE IF EXISTS `menu_boisson`;
CREATE TABLE IF NOT EXISTS `menu_boisson` (
  `num_boisson` int NOT NULL,
  `num_menu` int NOT NULL,
  KEY `num_boisson` (`num_boisson`),
  KEY `num_menu` (`num_menu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `boisson`
--
ALTER TABLE `boisson`
  ADD CONSTRAINT `boisson_ibfk_1` FOREIGN KEY (`num_marque`) REFERENCES `marque` (`id_marque`);

--
-- Contraintes pour la table `client_menu`
--
ALTER TABLE `client_menu`
  ADD CONSTRAINT `client_menu_ibfk_1` FOREIGN KEY (`num_client`) REFERENCES `client` (`id_client`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `client_menu_ibfk_2` FOREIGN KEY (`num_menu`) REFERENCES `menu` (`id_menu`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `focaccia_ingredient`
--
ALTER TABLE `focaccia_ingredient`
  ADD CONSTRAINT `focaccia_ingredient_ibfk_1` FOREIGN KEY (`num_focaccia`) REFERENCES `focaccia` (`id_focaccia`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `focaccia_ingredient_ibfk_2` FOREIGN KEY (`num_ingredient`) REFERENCES `ingredient` (`id_ingredient`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`num_focaccia`) REFERENCES `focaccia` (`id_focaccia`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `menu_boisson`
--
ALTER TABLE `menu_boisson`
  ADD CONSTRAINT `menu_boisson_ibfk_1` FOREIGN KEY (`num_boisson`) REFERENCES `boisson` (`id_boisson`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `menu_boisson_ibfk_2` FOREIGN KEY (`num_menu`) REFERENCES `menu` (`id_menu`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
