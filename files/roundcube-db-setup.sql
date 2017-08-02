-- MySQL dump 10.16  Distrib 10.1.23-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: roundcube
-- ------------------------------------------------------
-- Server version	10.1.23-MariaDB-9+deb9u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
use roundcube;
--
-- Table structure for table `rc_cache`
--

DROP TABLE IF EXISTS `rc_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rc_cache` (
  `user_id` int(10) unsigned NOT NULL,
  `cache_key` varchar(128) CHARACTER SET ascii NOT NULL,
  `expires` datetime DEFAULT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`user_id`,`cache_key`),
  KEY `rc_expires_index` (`expires`),
  CONSTRAINT `rc_user_id_fk_cache` FOREIGN KEY (`user_id`) REFERENCES `rc_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rc_cache`
--

LOCK TABLES `rc_cache` WRITE;
/*!40000 ALTER TABLE `rc_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `rc_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rc_cache_index`
--

DROP TABLE IF EXISTS `rc_cache_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rc_cache_index` (
  `user_id` int(10) unsigned NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `expires` datetime DEFAULT NULL,
  `valid` tinyint(1) NOT NULL DEFAULT '0',
  `data` longtext NOT NULL,
  PRIMARY KEY (`user_id`,`mailbox`),
  KEY `rc_expires_index` (`expires`),
  CONSTRAINT `rc_user_id_fk_cache_index` FOREIGN KEY (`user_id`) REFERENCES `rc_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rc_cache_index`
--

LOCK TABLES `rc_cache_index` WRITE;
/*!40000 ALTER TABLE `rc_cache_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `rc_cache_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rc_cache_messages`
--

DROP TABLE IF EXISTS `rc_cache_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rc_cache_messages` (
  `user_id` int(10) unsigned NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `expires` datetime DEFAULT NULL,
  `data` longtext NOT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`mailbox`,`uid`),
  KEY `rc_expires_index` (`expires`),
  CONSTRAINT `rc_user_id_fk_cache_messages` FOREIGN KEY (`user_id`) REFERENCES `rc_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rc_cache_messages`
--

LOCK TABLES `rc_cache_messages` WRITE;
/*!40000 ALTER TABLE `rc_cache_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `rc_cache_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rc_cache_shared`
--

DROP TABLE IF EXISTS `rc_cache_shared`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rc_cache_shared` (
  `cache_key` varchar(255) CHARACTER SET ascii NOT NULL,
  `expires` datetime DEFAULT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`cache_key`),
  KEY `rc_expires_index` (`expires`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rc_cache_shared`
--

LOCK TABLES `rc_cache_shared` WRITE;
/*!40000 ALTER TABLE `rc_cache_shared` DISABLE KEYS */;
/*!40000 ALTER TABLE `rc_cache_shared` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rc_cache_thread`
--

DROP TABLE IF EXISTS `rc_cache_thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rc_cache_thread` (
  `user_id` int(10) unsigned NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `expires` datetime DEFAULT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`user_id`,`mailbox`),
  KEY `rc_expires_index` (`expires`),
  CONSTRAINT `rc_user_id_fk_cache_thread` FOREIGN KEY (`user_id`) REFERENCES `rc_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rc_cache_thread`
--

LOCK TABLES `rc_cache_thread` WRITE;
/*!40000 ALTER TABLE `rc_cache_thread` DISABLE KEYS */;
/*!40000 ALTER TABLE `rc_cache_thread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rc_contactgroupmembers`
--

DROP TABLE IF EXISTS `rc_contactgroupmembers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rc_contactgroupmembers` (
  `contactgroup_id` int(10) unsigned NOT NULL,
  `contact_id` int(10) unsigned NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`contactgroup_id`,`contact_id`),
  KEY `rc_contactgroupmembers_contact_index` (`contact_id`),
  CONSTRAINT `rc_contact_id_fk_contacts` FOREIGN KEY (`contact_id`) REFERENCES `rc_contacts` (`contact_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rc_contactgroup_id_fk_contactgroups` FOREIGN KEY (`contactgroup_id`) REFERENCES `rc_contactgroups` (`contactgroup_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rc_contactgroupmembers`
--

LOCK TABLES `rc_contactgroupmembers` WRITE;
/*!40000 ALTER TABLE `rc_contactgroupmembers` DISABLE KEYS */;
/*!40000 ALTER TABLE `rc_contactgroupmembers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rc_contactgroups`
--

DROP TABLE IF EXISTS `rc_contactgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rc_contactgroups` (
  `contactgroup_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`contactgroup_id`),
  KEY `rc_contactgroups_user_index` (`user_id`,`del`),
  CONSTRAINT `rc_user_id_fk_contactgroups` FOREIGN KEY (`user_id`) REFERENCES `rc_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rc_contactgroups`
--

LOCK TABLES `rc_contactgroups` WRITE;
/*!40000 ALTER TABLE `rc_contactgroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `rc_contactgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rc_contacts`
--

DROP TABLE IF EXISTS `rc_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rc_contacts` (
  `contact_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  `email` text NOT NULL,
  `firstname` varchar(128) NOT NULL DEFAULT '',
  `surname` varchar(128) NOT NULL DEFAULT '',
  `vcard` longtext,
  `words` text,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`contact_id`),
  KEY `rc_user_contacts_index` (`user_id`,`del`),
  CONSTRAINT `rc_user_id_fk_contacts` FOREIGN KEY (`user_id`) REFERENCES `rc_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rc_contacts`
--

LOCK TABLES `rc_contacts` WRITE;
/*!40000 ALTER TABLE `rc_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `rc_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rc_dictionary`
--

DROP TABLE IF EXISTS `rc_dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rc_dictionary` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `language` varchar(5) NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueness` (`user_id`,`language`),
  CONSTRAINT `rc_user_id_fk_dictionary` FOREIGN KEY (`user_id`) REFERENCES `rc_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rc_dictionary`
--

LOCK TABLES `rc_dictionary` WRITE;
/*!40000 ALTER TABLE `rc_dictionary` DISABLE KEYS */;
/*!40000 ALTER TABLE `rc_dictionary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rc_identities`
--

DROP TABLE IF EXISTS `rc_identities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rc_identities` (
  `identity_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `standard` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `organization` varchar(128) NOT NULL DEFAULT '',
  `email` varchar(128) NOT NULL,
  `reply-to` varchar(128) NOT NULL DEFAULT '',
  `bcc` varchar(128) NOT NULL DEFAULT '',
  `signature` longtext,
  `html_signature` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`identity_id`),
  KEY `rc_user_identities_index` (`user_id`,`del`),
  KEY `rc_email_identities_index` (`email`,`del`),
  CONSTRAINT `rc_user_id_fk_identities` FOREIGN KEY (`user_id`) REFERENCES `rc_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rc_identities`
--

LOCK TABLES `rc_identities` WRITE;
/*!40000 ALTER TABLE `rc_identities` DISABLE KEYS */;
/*!40000 ALTER TABLE `rc_identities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rc_searches`
--

DROP TABLE IF EXISTS `rc_searches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rc_searches` (
  `search_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `type` int(3) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `data` text,
  PRIMARY KEY (`search_id`),
  UNIQUE KEY `uniqueness` (`user_id`,`type`,`name`),
  CONSTRAINT `rc_user_id_fk_searches` FOREIGN KEY (`user_id`) REFERENCES `rc_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rc_searches`
--

LOCK TABLES `rc_searches` WRITE;
/*!40000 ALTER TABLE `rc_searches` DISABLE KEYS */;
/*!40000 ALTER TABLE `rc_searches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rc_session`
--

DROP TABLE IF EXISTS `rc_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rc_session` (
  `sess_id` varchar(128) NOT NULL,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `ip` varchar(40) NOT NULL,
  `vars` mediumtext NOT NULL,
  PRIMARY KEY (`sess_id`),
  KEY `rc_changed_index` (`changed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rc_session`
--

LOCK TABLES `rc_session` WRITE;
/*!40000 ALTER TABLE `rc_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `rc_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rc_system`
--

DROP TABLE IF EXISTS `rc_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rc_system` (
  `name` varchar(64) NOT NULL,
  `value` mediumtext,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rc_system`
--

LOCK TABLES `rc_system` WRITE;
/*!40000 ALTER TABLE `rc_system` DISABLE KEYS */;
INSERT INTO `rc_system` VALUES ('roundcube-version','2016112200');
/*!40000 ALTER TABLE `rc_system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rc_users`
--

DROP TABLE IF EXISTS `rc_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rc_users` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `mail_host` varchar(128) NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `last_login` datetime DEFAULT NULL,
  `failed_login` datetime DEFAULT NULL,
  `failed_login_counter` int(10) unsigned DEFAULT NULL,
  `language` varchar(5) DEFAULT NULL,
  `preferences` longtext,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`,`mail_host`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rc_users`
--

LOCK TABLES `rc_users` WRITE;
/*!40000 ALTER TABLE `rc_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `rc_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-02 13:13:04
