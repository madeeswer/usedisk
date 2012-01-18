-- MySQL dump 10.11
--
use maspi0_share;
-- Host: localhost    Database: upload_dev
-- ------------------------------------------------------
-- Server version	5.0.67

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cakes`
--

--
-- Table structure for table `downloads`
--

DROP TABLE IF EXISTS `downloads`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `downloads` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `ip` varchar(20) default NULL,
  `upload_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `downloads`
--

LOCK TABLES `downloads` WRITE;
/*!40000 ALTER TABLE `downloads` DISABLE KEYS */;
INSERT INTO `downloads` VALUES (1,'2010-03-26 21:23:20','2010-03-26 21:23:20','127.0.0.1',47),(2,'2010-03-26 22:10:00','2010-03-26 22:10:00','127.0.0.1',52),(3,'2010-03-27 01:10:09','2010-03-27 01:10:09','127.0.0.1',66),(4,'2010-03-27 03:01:09','2010-03-27 03:01:09','127.0.0.1',1);
/*!40000 ALTER TABLE `downloads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20100317220505'),('20100325030054'),('20100327020557'),('20100327021340'),('20100328021340');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uploads`
--

DROP TABLE IF EXISTS `uploads`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `uploads` (
  `id` int(11) NOT NULL auto_increment,
  `ip` varchar(20) default NULL,
  `filename` varchar(100) default NULL,
  `size` int(11) default NULL,
  `email` varchar(100) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `uploads`
--

LOCK TABLES `uploads` WRITE;
/*!40000 ALTER TABLE `uploads` DISABLE KEYS */;
INSERT INTO `uploads` VALUES (1,'127.0.0.1','bg_menu4.png',NULL,'833','2010-03-27 03:01:04','2010-03-27 03:01:04'),(2,'127.0.0.1','dsdsds',NULL,'0','2010-03-27 03:01:41','2010-03-27 03:01:41'),(3,'127.0.0.1','mount.sh',NULL,'397','2010-03-27 03:04:44','2010-03-27 03:04:44'),(4,'127.0.0.1','bg_menu.png',NULL,'851','2010-03-27 03:12:00','2010-03-27 03:12:00'),(5,'127.0.0.1','vcvcvcvcvc',NULL,'0','2010-03-27 03:12:27','2010-03-27 03:12:27'),(6,'127.0.0.1','bg_menu.pngdsds',0,'bg_menu.pngdsds','2010-03-27 03:16:47','2010-03-27 03:16:47'),(7,'127.0.0.1','bg_menu2.png',928,NULL,'2010-03-27 03:28:15','2010-03-27 03:28:15'),(8,'127.0.0.1','bg_menu2.png',928,NULL,'2010-03-27 03:30:59','2010-03-27 03:30:59'),(9,'127.0.0.1','bg_menu2.png',928,NULL,'2010-03-27 03:35:23','2010-03-27 03:35:23'),(10,'127.0.0.1','bg_menu.png',851,NULL,'2010-03-27 03:39:25','2010-03-27 03:39:25');
/*!40000 ALTER TABLE `uploads` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-03-27  3:45:39
