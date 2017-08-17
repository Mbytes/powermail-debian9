-- MySQL dump 10.16  Distrib 10.1.23-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: nextcloud
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
use nextcloud;
--
-- Table structure for table `oc_accounts`
--

DROP TABLE IF EXISTS `oc_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_accounts` (
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `data` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_accounts`
--

LOCK TABLES `oc_accounts` WRITE;
/*!40000 ALTER TABLE `oc_accounts` DISABLE KEYS */;
INSERT INTO `oc_accounts` VALUES ('nextcloud','{\"displayname\":{\"value\":\"Nextcloud\",\"scope\":\"contacts\"},\"address\":{\"value\":\"\",\"scope\":\"private\"},\"website\":{\"value\":\"\",\"scope\":\"private\",\"verified\":\"0\"},\"email\":{\"value\":\"\",\"scope\":\"contacts\",\"verified\":\"1\"},\"avatar\":{\"scope\":\"contacts\"},\"phone\":{\"value\":\"\",\"scope\":\"private\"},\"twitter\":{\"value\":\"\",\"scope\":\"private\",\"verified\":\"0\"}}');
/*!40000 ALTER TABLE `oc_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_activity`
--

DROP TABLE IF EXISTS `oc_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_activity` (
  `activity_id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  `type` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `user` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `affecteduser` varchar(64) COLLATE utf8_bin NOT NULL,
  `app` varchar(32) COLLATE utf8_bin NOT NULL,
  `subject` varchar(255) COLLATE utf8_bin NOT NULL,
  `subjectparams` longtext COLLATE utf8_bin NOT NULL,
  `message` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `messageparams` longtext COLLATE utf8_bin,
  `file` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `link` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `object_type` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `object_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`activity_id`),
  KEY `activity_time` (`timestamp`),
  KEY `activity_user_time` (`affecteduser`,`timestamp`),
  KEY `activity_filter_by` (`affecteduser`,`user`,`timestamp`),
  KEY `activity_filter_app` (`affecteduser`,`app`,`timestamp`),
  KEY `activity_object` (`object_type`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_activity`
--

LOCK TABLES `oc_activity` WRITE;
/*!40000 ALTER TABLE `oc_activity` DISABLE KEYS */;
INSERT INTO `oc_activity` VALUES (1,1502970164,30,'calendar','nextcloud','system','dav','calendar_add','[\"nextcloud\",\"Contact birthdays\"]','','[]','','','calendar',1),(2,1502970164,30,'personal_settings','nextcloud','nextcloud','settings','email_changed_self','[]','','[]','','','',0);
/*!40000 ALTER TABLE `oc_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_activity_mq`
--

DROP TABLE IF EXISTS `oc_activity_mq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_activity_mq` (
  `mail_id` int(11) NOT NULL AUTO_INCREMENT,
  `amq_timestamp` int(11) NOT NULL DEFAULT '0',
  `amq_latest_send` int(11) NOT NULL DEFAULT '0',
  `amq_type` varchar(255) COLLATE utf8_bin NOT NULL,
  `amq_affecteduser` varchar(64) COLLATE utf8_bin NOT NULL,
  `amq_appid` varchar(255) COLLATE utf8_bin NOT NULL,
  `amq_subject` varchar(255) COLLATE utf8_bin NOT NULL,
  `amq_subjectparams` varchar(4000) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`mail_id`),
  KEY `amp_user` (`amq_affecteduser`),
  KEY `amp_latest_send_time` (`amq_latest_send`),
  KEY `amp_timestamp_time` (`amq_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_activity_mq`
--

LOCK TABLES `oc_activity_mq` WRITE;
/*!40000 ALTER TABLE `oc_activity_mq` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_activity_mq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_addressbookchanges`
--

DROP TABLE IF EXISTS `oc_addressbookchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_addressbookchanges` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT '1',
  `addressbookid` int(11) NOT NULL,
  `operation` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `addressbookid_synctoken` (`addressbookid`,`synctoken`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_addressbookchanges`
--

LOCK TABLES `oc_addressbookchanges` WRITE;
/*!40000 ALTER TABLE `oc_addressbookchanges` DISABLE KEYS */;
INSERT INTO `oc_addressbookchanges` VALUES (1,'Database:nextcloud.vcf',1,1,1),(2,'Database:nextcloud.vcf',2,1,2),(3,'Database:nextcloud.vcf',2,1,2),(4,'Database:nextcloud.vcf',4,1,2),(5,'Database:nextcloud.vcf',5,1,2),(6,'Database:nextcloud.vcf',5,1,2),(7,'Database:nextcloud.vcf',7,1,2),(8,'Database:nextcloud.vcf',8,1,2),(9,'Database:nextcloud.vcf',8,1,2);
/*!40000 ALTER TABLE `oc_addressbookchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_addressbooks`
--

DROP TABLE IF EXISTS `oc_addressbooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_addressbooks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principaluri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `displayname` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `addressbook_index` (`principaluri`,`uri`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_addressbooks`
--

LOCK TABLES `oc_addressbooks` WRITE;
/*!40000 ALTER TABLE `oc_addressbooks` DISABLE KEYS */;
INSERT INTO `oc_addressbooks` VALUES (1,'principals/system/system','system','system','System addressbook which holds all users of this instance',10);
/*!40000 ALTER TABLE `oc_addressbooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_admin_sections`
--

DROP TABLE IF EXISTS `oc_admin_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_admin_sections` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL,
  `class` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `priority` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_sections_class` (`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_admin_sections`
--

LOCK TABLES `oc_admin_sections` WRITE;
/*!40000 ALTER TABLE `oc_admin_sections` DISABLE KEYS */;
INSERT INTO `oc_admin_sections` VALUES ('activity','OCA\\Activity\\Settings\\Section',55),('logging','OCA\\LogReader\\Settings\\Section',90),('serverinfo','OCA\\ServerInfo\\Settings\\AdminSection',0),('theming','OCA\\Theming\\Settings\\Section',30),('workflow','OCA\\WorkflowEngine\\Settings\\Section',55);
/*!40000 ALTER TABLE `oc_admin_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_admin_settings`
--

DROP TABLE IF EXISTS `oc_admin_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_admin_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `section` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `priority` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_settings_class` (`class`),
  KEY `admin_settings_section` (`section`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_admin_settings`
--

LOCK TABLES `oc_admin_settings` WRITE;
/*!40000 ALTER TABLE `oc_admin_settings` DISABLE KEYS */;
INSERT INTO `oc_admin_settings` VALUES (1,'OCA\\LogReader\\Settings\\Admin','logging',90),(2,'OCA\\Theming\\Settings\\Admin','theming',5),(3,'OCA\\ServerInfo\\Settings\\AdminSettings','serverinfo',0),(4,'OCA\\UpdateNotification\\Controller\\AdminController','server',1),(5,'OCA\\ShareByMail\\Settings\\Admin','sharing',40),(6,'OCA\\Files\\Settings\\Admin','additional',5),(9,'OCA\\SystemTags\\Settings\\Admin','workflow',70),(10,'OCA\\OAuth2\\Settings\\Admin','security',0),(11,'OCA\\Activity\\Settings\\Admin','activity',55),(12,'OCA\\FederatedFileSharing\\Settings\\Admin','sharing',20),(13,'OCA\\Federation\\Settings\\Admin','sharing',30),(14,'OCA\\Password_Policy\\Settings','security',50),(15,'OCA\\BruteForceSettings\\Settings\\IPWhitelist','security',50),(16,'OCA\\External\\Settings\\Admin','additional',55);
/*!40000 ALTER TABLE `oc_admin_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_appconfig`
--

DROP TABLE IF EXISTS `oc_appconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_appconfig` (
  `appid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configkey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configvalue` longtext COLLATE utf8_bin,
  PRIMARY KEY (`appid`,`configkey`),
  KEY `appconfig_config_key_index` (`configkey`),
  KEY `appconfig_appid_key` (`appid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_appconfig`
--

LOCK TABLES `oc_appconfig` WRITE;
/*!40000 ALTER TABLE `oc_appconfig` DISABLE KEYS */;
INSERT INTO `oc_appconfig` VALUES ('activity','enabled','yes'),('activity','installed_version','2.5.2'),('activity','types','filesystem'),('admin_notifications','enabled','no'),('admin_notifications','installed_version','1.0.0'),('admin_notifications','types','logging'),('apporder','enabled','yes'),('apporder','installed_version','0.4.0'),('apporder','types',''),('backgroundjob','lastjob','6'),('bruteforcesettings','enabled','yes'),('bruteforcesettings','installed_version','1.0.2'),('bruteforcesettings','types',''),('calendar','enabled','yes'),('calendar','installed_version','1.5.3'),('calendar','types',''),('comments','enabled','yes'),('comments','installed_version','1.2.0'),('comments','types','logging'),('contacts','enabled','yes'),('contacts','installed_version','1.5.3'),('contacts','types',''),('core','backgroundjobs_mode','cron'),('core','installed.bundles','[\"CoreBundle\"]'),('core','installedat','1502962201.628'),('core','lastcron','1502962980'),('core','lastupdatedat','1502962201.6736'),('core','oc.integritycheck.checker','{\"core\":{\"FILE_MISSING\":{\"core\\/skeleton\\/Documents\\/About.odt\":{\"expected\":\"1cc2eae96696437edac41a8f9bc04a2ce2e8aac132cee19239222ef0f0ed0722a8279d6dae2073c230f9f2015f03559827a4bdd11ac068d2ee31f8bef9ec8b95\",\"current\":\"\"},\"core\\/skeleton\\/Documents\\/About.txt\":{\"expected\":\"246d73856029aac8fb5cfda0644c473bcc519017b8284e0b850b67025562170cf4c1afa39f037cff3c9a331f85ab29266353de184c039907a54a680a54c15040\",\"current\":\"\"},\"core\\/skeleton\\/Nextcloud Manual.pdf\":{\"expected\":\"9510c8b96baf420cb5849d0c60d1227ad648188f47189b6525a66bc931019b99df54ba7f8469c2ac0b8933760a339ed86ddde5ae75a26de9e69d6e222f44be6e\",\"current\":\"\"},\"core\\/skeleton\\/Nextcloud.mp4\":{\"expected\":\"20629a6a9e8750beac07541c77e8e694fb527cc653f2d6626d73c7381070726af4062169010947229e1b904e56308928e4897e31a7809bddd70dd2027ef5471a\",\"current\":\"\"},\"core\\/skeleton\\/Photos\\/Coast.jpg\":{\"expected\":\"2bb4fd0ca9fbcb71b3565f1c019233aac9d22d19e25a6c1afe1ba37dbe33a2d282ead22aafd6e5a012bb206c9606f1056d9f83955034a11d2c531d435f097933\",\"current\":\"\"},\"core\\/skeleton\\/Photos\\/Hummingbird.jpg\":{\"expected\":\"4c5c440aabadb7bc084502513f34691754ad0cd5b7dc60af5294c5076e17e102d209b2fec4d1a1f38b940887c6f8eb16efa9240944116d17e6c4a36689987d84\",\"current\":\"\"},\"core\\/skeleton\\/Photos\\/Nut.jpg\":{\"expected\":\"0a82a718fc89d438c5887bac2b4fe7f32ec39a3cf9aab38e7f544ed8493d328d2247fa4efa85d4caa650550c34f305ba7eb12973d2487e10507cb2ab0f38c122\",\"current\":\"\"}}}}'),('core','public_files','files_sharing/public.php'),('core','public_webdav','dav/appinfo/v1/publicwebdav.php'),('core','scss.variables','4f934a62f0926c3e21b395e2613cd414'),('core','vendor','nextcloud'),('dav','enabled','yes'),('dav','installed_version','1.3.0'),('dav','types','filesystem'),('external','enabled','yes'),('external','installed_version','2.0.3'),('external','types',''),('federatedfilesharing','enabled','yes'),('federatedfilesharing','installed_version','1.2.0'),('federatedfilesharing','types',''),('federation','enabled','yes'),('federation','installed_version','1.2.0'),('federation','types','authentication'),('files','cronjob_scan_files','500'),('files','enabled','yes'),('files','installed_version','1.7.2'),('files','types','filesystem'),('files_pdfviewer','enabled','yes'),('files_pdfviewer','installed_version','1.1.1'),('files_pdfviewer','ocsid','166049'),('files_pdfviewer','types',''),('files_sharing','enabled','yes'),('files_sharing','installed_version','1.4.0'),('files_sharing','types','filesystem'),('files_texteditor','enabled','yes'),('files_texteditor','installed_version','2.4.1'),('files_texteditor','ocsid','166051'),('files_texteditor','types',''),('files_trashbin','enabled','yes'),('files_trashbin','installed_version','1.2.0'),('files_trashbin','types','filesystem'),('files_versions','enabled','yes'),('files_versions','installed_version','1.5.0'),('files_versions','types','filesystem'),('files_videoplayer','enabled','yes'),('files_videoplayer','installed_version','1.1.0'),('files_videoplayer','types',''),('firstrunwizard','enabled','no'),('firstrunwizard','installed_version','2.1'),('firstrunwizard','types','logging'),('gallery','enabled','yes'),('gallery','installed_version','17.0.0'),('gallery','types',''),('logreader','enabled','yes'),('logreader','installed_version','2.0.0'),('logreader','ocsid','170871'),('logreader','types',''),('lookup_server_connector','enabled','yes'),('lookup_server_connector','installed_version','1.0.0'),('lookup_server_connector','types','authentication'),('nextcloud_announcements','enabled','no'),('nextcloud_announcements','installed_version','1.1'),('nextcloud_announcements','types','logging'),('notes','enabled','yes'),('notes','installed_version','2.3.1'),('notes','types',''),('notifications','enabled','yes'),('notifications','installed_version','2.0.0'),('notifications','types','logging'),('oauth2','enabled','yes'),('oauth2','installed_version','1.0.5'),('oauth2','types','authentication'),('password_policy','enabled','yes'),('password_policy','installed_version','1.2.2'),('password_policy','types',''),('provisioning_api','enabled','yes'),('provisioning_api','installed_version','1.2.0'),('provisioning_api','types','prevent_group_restriction'),('serverinfo','enabled','yes'),('serverinfo','installed_version','1.2.0'),('serverinfo','types',''),('sharebymail','enabled','yes'),('sharebymail','installed_version','1.2.0'),('sharebymail','types','filesystem'),('survey_client','enabled','no'),('survey_client','installed_version','1.0.0'),('survey_client','types',''),('systemtags','enabled','yes'),('systemtags','installed_version','1.2.0'),('systemtags','types','logging'),('tasks','enabled','yes'),('tasks','installed_version','0.9.5'),('tasks','types',''),('theming','enabled','yes'),('theming','installed_version','1.3.0'),('theming','types','logging'),('twofactor_backupcodes','enabled','yes'),('twofactor_backupcodes','installed_version','1.1.1'),('twofactor_backupcodes','types',''),('updatenotification','enabled','yes'),('updatenotification','installed_version','1.2.0'),('updatenotification','types',''),('user_external','enabled','yes'),('user_external','installed_version','0.4'),('user_external','types','authentication,prelogin'),('workflowengine','enabled','yes'),('workflowengine','installed_version','1.2.0'),('workflowengine','types','filesystem');
/*!40000 ALTER TABLE `oc_appconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_authtoken`
--

DROP TABLE IF EXISTS `oc_authtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_authtoken` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `login_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `password` longtext COLLATE utf8_bin,
  `name` longtext COLLATE utf8_bin NOT NULL,
  `token` varchar(200) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` smallint(5) unsigned NOT NULL DEFAULT '0',
  `remember` smallint(5) unsigned NOT NULL DEFAULT '0',
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `last_check` int(10) unsigned NOT NULL DEFAULT '0',
  `scope` longtext COLLATE utf8_bin,
  PRIMARY KEY (`id`),
  UNIQUE KEY `authtoken_token_index` (`token`),
  KEY `authtoken_last_activity_index` (`last_activity`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_authtoken`
--

LOCK TABLES `oc_authtoken` WRITE;
/*!40000 ALTER TABLE `oc_authtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_authtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_bruteforce_attempts`
--

DROP TABLE IF EXISTS `oc_bruteforce_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_bruteforce_attempts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `occurred` int(10) unsigned NOT NULL DEFAULT '0',
  `ip` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `subnet` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `metadata` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `bruteforce_attempts_ip` (`ip`),
  KEY `bruteforce_attempts_subnet` (`subnet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_bruteforce_attempts`
--

LOCK TABLES `oc_bruteforce_attempts` WRITE;
/*!40000 ALTER TABLE `oc_bruteforce_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_bruteforce_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendarchanges`
--

DROP TABLE IF EXISTS `oc_calendarchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_calendarchanges` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT '1',
  `calendarid` int(11) NOT NULL,
  `operation` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `calendarid_synctoken` (`calendarid`,`synctoken`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendarchanges`
--

LOCK TABLES `oc_calendarchanges` WRITE;
/*!40000 ALTER TABLE `oc_calendarchanges` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendarchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendarobjects`
--

DROP TABLE IF EXISTS `oc_calendarobjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_calendarobjects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `calendardata` longblob,
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `calendarid` int(10) unsigned NOT NULL,
  `lastmodified` int(10) unsigned DEFAULT NULL,
  `etag` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `componenttype` varchar(8) COLLATE utf8_bin DEFAULT NULL,
  `firstoccurence` bigint(20) unsigned DEFAULT NULL,
  `lastoccurence` bigint(20) unsigned DEFAULT NULL,
  `uid` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `classification` int(11) DEFAULT '0' COMMENT '0 - public, 1 - private, 2 - confidential',
  PRIMARY KEY (`id`),
  UNIQUE KEY `calobjects_index` (`calendarid`,`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendarobjects`
--

LOCK TABLES `oc_calendarobjects` WRITE;
/*!40000 ALTER TABLE `oc_calendarobjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendarobjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendarobjects_props`
--

DROP TABLE IF EXISTS `oc_calendarobjects_props`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_calendarobjects_props` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `calendarid` bigint(20) NOT NULL DEFAULT '0',
  `objectid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `name` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `parameter` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calendarobject_index` (`objectid`),
  KEY `calendarobject_name_index` (`name`),
  KEY `calendarobject_value_index` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendarobjects_props`
--

LOCK TABLES `oc_calendarobjects_props` WRITE;
/*!40000 ALTER TABLE `oc_calendarobjects_props` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendarobjects_props` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendars`
--

DROP TABLE IF EXISTS `oc_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_calendars` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principaluri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `displayname` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `synctoken` int(10) unsigned NOT NULL DEFAULT '1',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `calendarorder` int(10) unsigned NOT NULL DEFAULT '0',
  `calendarcolor` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `timezone` longtext COLLATE utf8_bin,
  `components` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `transparent` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `calendars_index` (`principaluri`,`uri`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendars`
--

LOCK TABLES `oc_calendars` WRITE;
/*!40000 ALTER TABLE `oc_calendars` DISABLE KEYS */;
INSERT INTO `oc_calendars` VALUES (1,'principals/system/system','Contact birthdays','contact_birthdays',1,NULL,0,'#FFFFCA',NULL,'VEVENT,VTODO',0);
/*!40000 ALTER TABLE `oc_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_calendarsubscriptions`
--

DROP TABLE IF EXISTS `oc_calendarsubscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_calendarsubscriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `principaluri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `source` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `displayname` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `refreshrate` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `calendarorder` int(10) unsigned NOT NULL DEFAULT '0',
  `calendarcolor` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `striptodos` smallint(6) DEFAULT NULL,
  `stripalarms` smallint(6) DEFAULT NULL,
  `stripattachments` smallint(6) DEFAULT NULL,
  `lastmodified` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `calsub_index` (`principaluri`,`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendarsubscriptions`
--

LOCK TABLES `oc_calendarsubscriptions` WRITE;
/*!40000 ALTER TABLE `oc_calendarsubscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_calendarsubscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_cards`
--

DROP TABLE IF EXISTS `oc_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_cards` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `addressbookid` int(11) NOT NULL DEFAULT '0',
  `carddata` longblob,
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `lastmodified` bigint(20) unsigned DEFAULT NULL,
  `etag` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `size` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_cards`
--

LOCK TABLES `oc_cards` WRITE;
/*!40000 ALTER TABLE `oc_cards` DISABLE KEYS */;
INSERT INTO `oc_cards` VALUES (1,1,'BEGIN:VCARD\r\nVERSION:3.0\r\nPRODID:-//Sabre//Sabre VObject 4.1.2//EN\r\nUID:nextcloud\r\nFN:Nextcloud\r\nN:Nextcloud;;;;\r\nCLOUD:nextcloud@live.technomail.in/nextcloud\r\nEND:VCARD\r\n','Database:nextcloud.vcf',1502970176,'60f12b2a912bfb1ce5c71a2442c2e9d6',171);
/*!40000 ALTER TABLE `oc_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_cards_properties`
--

DROP TABLE IF EXISTS `oc_cards_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_cards_properties` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `addressbookid` bigint(20) NOT NULL DEFAULT '0',
  `cardid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `name` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `preferred` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `card_contactid_index` (`cardid`),
  KEY `card_name_index` (`name`),
  KEY `card_value_index` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_cards_properties`
--

LOCK TABLES `oc_cards_properties` WRITE;
/*!40000 ALTER TABLE `oc_cards_properties` DISABLE KEYS */;
INSERT INTO `oc_cards_properties` VALUES (36,1,1,'FN','Nextcloud',0),(37,1,1,'UID','nextcloud',0),(38,1,1,'N','Nextcloud;;;;',0),(39,1,1,'FN','Nextcloud',0),(40,1,1,'CLOUD','nextcloud@live.technomail.in/nextcloud',0),(41,1,1,'N','Nextcloud;;;;',0),(42,1,1,'CLOUD','nextcloud@live.technomail.in/nextcloud',0);
/*!40000 ALTER TABLE `oc_cards_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_comments`
--

DROP TABLE IF EXISTS `oc_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `topmost_parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `children_count` int(10) unsigned NOT NULL DEFAULT '0',
  `actor_type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `actor_id` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `message` longtext COLLATE utf8_bin,
  `verb` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `creation_timestamp` datetime DEFAULT NULL,
  `latest_child_timestamp` datetime DEFAULT NULL,
  `object_type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `object_id` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `comments_parent_id_index` (`parent_id`),
  KEY `comments_topmost_parent_id_idx` (`topmost_parent_id`),
  KEY `comments_object_index` (`object_type`,`object_id`,`creation_timestamp`),
  KEY `comments_actor_index` (`actor_type`,`actor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_comments`
--

LOCK TABLES `oc_comments` WRITE;
/*!40000 ALTER TABLE `oc_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_comments_read_markers`
--

DROP TABLE IF EXISTS `oc_comments_read_markers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_comments_read_markers` (
  `user_id` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `marker_datetime` datetime DEFAULT NULL,
  `object_type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `object_id` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  UNIQUE KEY `comments_marker_index` (`user_id`,`object_type`,`object_id`),
  KEY `comments_marker_object_index` (`object_type`,`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_comments_read_markers`
--

LOCK TABLES `oc_comments_read_markers` WRITE;
/*!40000 ALTER TABLE `oc_comments_read_markers` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_comments_read_markers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_credentials`
--

DROP TABLE IF EXISTS `oc_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_credentials` (
  `user` varchar(64) COLLATE utf8_bin NOT NULL,
  `identifier` varchar(64) COLLATE utf8_bin NOT NULL,
  `credentials` longtext COLLATE utf8_bin,
  PRIMARY KEY (`user`,`identifier`),
  KEY `credentials_user` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_credentials`
--

LOCK TABLES `oc_credentials` WRITE;
/*!40000 ALTER TABLE `oc_credentials` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_dav_shares`
--

DROP TABLE IF EXISTS `oc_dav_shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_dav_shares` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principaluri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `access` smallint(6) DEFAULT NULL,
  `resourceid` int(10) unsigned NOT NULL,
  `publicuri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dav_shares_index` (`principaluri`,`resourceid`,`type`,`publicuri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_dav_shares`
--

LOCK TABLES `oc_dav_shares` WRITE;
/*!40000 ALTER TABLE `oc_dav_shares` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_dav_shares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_federated_reshares`
--

DROP TABLE IF EXISTS `oc_federated_reshares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_federated_reshares` (
  `share_id` int(11) NOT NULL,
  `remote_id` int(11) NOT NULL COMMENT 'share ID at the remote server',
  UNIQUE KEY `share_id_index` (`share_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_federated_reshares`
--

LOCK TABLES `oc_federated_reshares` WRITE;
/*!40000 ALTER TABLE `oc_federated_reshares` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_federated_reshares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_file_locks`
--

DROP TABLE IF EXISTS `oc_file_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_file_locks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lock` int(11) NOT NULL DEFAULT '0',
  `key` varchar(64) COLLATE utf8_bin NOT NULL,
  `ttl` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `lock_key_index` (`key`),
  KEY `lock_ttl_index` (`ttl`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_file_locks`
--

LOCK TABLES `oc_file_locks` WRITE;
/*!40000 ALTER TABLE `oc_file_locks` DISABLE KEYS */;
INSERT INTO `oc_file_locks` VALUES (1,0,'files/c13cadafd4a12388b33c70aa3c895a20',1502973807),(2,0,'files/88b27fb6a1b0923cfcb5b3580df8187a',1502973808),(3,0,'files/cb35e3f48784928928ce38d055ec2d2c',1502973809),(4,0,'files/22ff9f9d80152078508dc14bfd32cc0d',1502966092),(5,0,'files/2a2c78c892d878fe9e97932d526399dd',1502973747),(6,0,'files/f2497545e42172d0e105c988ca9f0c37',1502973751),(7,0,'files/dc4125530de86afb5c37c35ffe01d9f9',1502973751),(8,0,'files/cff72ddf2f033fd1efc50fe7ca02deba',1502973751),(9,0,'files/0466b3adb6ee4ff8aa5b3ce2fd9add1d',1502973764),(10,0,'files/915239343aaec7f96e909876b8dfdb1c',1502973764),(11,0,'files/6cc9f13d2eefd676a07748293c2feed3',1502973765),(12,0,'files/4137035d79ae9091d233db4a892f7855',1502973765);
/*!40000 ALTER TABLE `oc_file_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_filecache`
--

DROP TABLE IF EXISTS `oc_filecache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_filecache` (
  `fileid` int(11) NOT NULL AUTO_INCREMENT,
  `storage` int(11) NOT NULL DEFAULT '0',
  `path` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `path_hash` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `parent` int(11) NOT NULL DEFAULT '0',
  `name` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `mimetype` int(11) NOT NULL DEFAULT '0',
  `mimepart` int(11) NOT NULL DEFAULT '0',
  `size` bigint(20) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `storage_mtime` int(11) NOT NULL DEFAULT '0',
  `encrypted` int(11) NOT NULL DEFAULT '0',
  `unencrypted_size` bigint(20) NOT NULL DEFAULT '0',
  `etag` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `permissions` int(11) DEFAULT '0',
  `checksum` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`fileid`),
  UNIQUE KEY `fs_storage_path_hash` (`storage`,`path_hash`),
  KEY `fs_parent_name_hash` (`parent`,`name`),
  KEY `fs_storage_mimetype` (`storage`,`mimetype`),
  KEY `fs_storage_mimepart` (`storage`,`mimepart`),
  KEY `fs_storage_size` (`storage`,`size`,`fileid`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_filecache`
--

LOCK TABLES `oc_filecache` WRITE;
/*!40000 ALTER TABLE `oc_filecache` DISABLE KEYS */;
INSERT INTO `oc_filecache` VALUES (1,1,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,2529739,1502970213,1502962491,0,0,'59958165cbc66',23,''),(2,1,'appdata_oc1tcv5zvhcu','80c0351806b7e857e7a47e1dd312a94d',1,'appdata_oc1tcv5zvhcu',2,1,2529739,1502970213,1502970164,0,0,'59958165cbc66',31,''),(3,1,'appdata_oc1tcv5zvhcu/appstore','0b0b361c8675d5576d8eb2d9840b7e69',2,'appstore',2,1,362536,1502962667,1502962664,0,0,'599563ec295e5',31,''),(4,1,'appdata_oc1tcv5zvhcu/appstore/apps.json','555a12a81acc65e40bf041f8f79a2636',3,'apps.json',4,3,330004,1502962667,1502962667,0,0,'41bb002b8e10dcf2ac5294d7c7d00bc2',27,''),(5,1,'appdata_oc1tcv5zvhcu/preview','0f95e29a9b528c1a3de56a543a10bcb7',2,'preview',2,1,0,1502962261,1502962261,0,0,'5995625518560',31,''),(6,2,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,0,1502962276,1502962274,0,0,'59956264dc8c6',23,''),(7,2,'files','45b963397aa40d4a0063e0d85e4fe7a1',6,'files',2,1,0,1502962276,1502962276,0,0,'59956264dc8c6',31,''),(8,2,'files/Photos','d01bb67e7b71dd49fd06bad922f521c9',7,'Photos',2,1,0,1502962275,1502962275,0,0,'599562631cd73',31,''),(9,2,'files/Documents','0ad78ba05b6961d92f7970b2b3922eca',7,'Documents',2,1,0,1502962276,1502962276,0,0,'599562646d59c',31,''),(10,1,'appdata_oc1tcv5zvhcu/avatar','e2cb30e59b80ce9cde108c7fe0cc4d0e',2,'avatar',2,1,0,1502962286,1502962286,0,0,'5995626e993d3',31,''),(11,1,'appdata_oc1tcv5zvhcu/avatar/nextcloud','e157773b6eb0604d0c69c6d55a53422d',10,'nextcloud',2,1,0,1502962286,1502962286,0,0,'5995626e8a91b',31,''),(12,1,'appdata_oc1tcv5zvhcu/js','8fa824fbc013fae0bedf46526e521354',2,'js',2,1,1991116,1502962531,1502962356,0,0,'599563632b12f',31,''),(13,1,'appdata_oc1tcv5zvhcu/js/core','3943bd4e08e468f5336f9059014aa062',12,'core',2,1,346165,1502962531,1502962530,0,0,'599563632b12f',31,''),(14,1,'appdata_oc1tcv5zvhcu/js/core/merged-template-prepend.js','021f6a96c7dd695a70183f604d131bd0',13,'merged-template-prepend.js',5,3,144020,1502962291,1502962291,0,0,'8a3e45a04369c5c03d5bdfef5d5531c7',27,''),(15,1,'appdata_oc1tcv5zvhcu/js/core/merged-template-prepend.js.deps','47bfcb73f6e9d1eab4f44251f60f55b7',13,'merged-template-prepend.js.deps',6,3,1222,1502962291,1502962291,0,0,'c7bdafe148fe6d776b0a264f500e13ce',27,''),(16,1,'appdata_oc1tcv5zvhcu/js/core/merged-template-prepend.js.gzip','c8f7970cf23f2af24b50d9677d4913a3',13,'merged-template-prepend.js.gzip',7,3,39517,1502962291,1502962291,0,0,'03007458cb2f28e5b2a711d7bf324df0',27,''),(17,1,'appdata_oc1tcv5zvhcu/js/core/merged-share-backend.js','719b20d1a95973087c04468ee8057508',13,'merged-share-backend.js',5,3,104526,1502962296,1502962296,0,0,'418868f1c35cf42f6d4a883d4c86675f',27,''),(18,1,'appdata_oc1tcv5zvhcu/js/core/merged-share-backend.js.deps','d7eb23210d4c26e1c131b80101df4a23',13,'merged-share-backend.js.deps',6,3,752,1502962300,1502962300,0,0,'9dede1f6cee301fd83b88463c04f0cdc',27,''),(19,1,'appdata_oc1tcv5zvhcu/js/core/merged-share-backend.js.gzip','a013b1a2d1a3bd49a6b0057eb0d32441',13,'merged-share-backend.js.gzip',7,3,22504,1502962302,1502962302,0,0,'66420e14d481d6de094d3adba1e6cafe',27,''),(20,1,'appdata_oc1tcv5zvhcu/js/notifications','af0a93573d7b01558a503a609b09c363',12,'notifications',2,1,25923,1502962306,1502962305,0,0,'59956282989de',31,''),(21,1,'appdata_oc1tcv5zvhcu/js/notifications/merged.js','7fcfabf4da35c8ecf8c0e4eee2ba9e93',20,'merged.js',5,3,20454,1502962305,1502962305,0,0,'4b93a2dfcb602ea70c338a0fe452c64e',27,''),(22,1,'appdata_oc1tcv5zvhcu/js/notifications/merged.js.deps','9450b231befed303bab4535327be0f08',20,'merged.js.deps',6,3,330,1502962306,1502962306,0,0,'3cdbc963cbda9f04ffd4ae3aff8c967c',27,''),(23,1,'appdata_oc1tcv5zvhcu/js/notifications/merged.js.gzip','7efc555afacd0cd32edd4dece5cdde16',20,'merged.js.gzip',7,3,5139,1502962306,1502962306,0,0,'8c899c438c91da875033c636addd5231',27,''),(24,1,'appdata_oc1tcv5zvhcu/js/files','e6ce911fc55005ddaf7a2fb26e098813',12,'files',2,1,399537,1502962308,1502962308,0,0,'59956284cc37a',31,''),(25,1,'appdata_oc1tcv5zvhcu/js/files/merged-index.js','b3da32a97fe90e833a511aa2a3b2d1af',24,'merged-index.js',5,3,320876,1502962308,1502962308,0,0,'54a089cee0f903ae715b02e9f4030240',27,''),(26,1,'appdata_oc1tcv5zvhcu/js/files/merged-index.js.deps','0c1a821293232d3604a47c57f85be8ec',24,'merged-index.js.deps',6,3,2125,1502962308,1502962308,0,0,'c56b600b72195ab8799a179d87175180',27,''),(27,1,'appdata_oc1tcv5zvhcu/js/files/merged-index.js.gzip','f3407be522c73c548dabb5df4bc455b9',24,'merged-index.js.gzip',7,3,76536,1502962308,1502962308,0,0,'b997f539e8559b415f7d86a3e3488a68',27,''),(28,1,'appdata_oc1tcv5zvhcu/js/activity','195e49891e0ebbd013405deb9e76a245',12,'activity',2,1,20399,1502962311,1502962310,0,0,'599562888b82d',31,''),(29,1,'appdata_oc1tcv5zvhcu/js/activity/activity-sidebar.js','e3d9ca11e57df9fd82fd4a07c9c496b2',28,'activity-sidebar.js',5,3,15755,1502962310,1502962310,0,0,'04e9b10316ad0d4eb9fc903d3fece9fc',27,''),(30,1,'appdata_oc1tcv5zvhcu/js/activity/activity-sidebar.js.deps','b61cfc22f56b3d9eee56bd755102e48c',28,'activity-sidebar.js.deps',6,3,494,1502962310,1502962310,0,0,'9f0a9529967e93df01ba5c188d5b554e',27,''),(31,1,'appdata_oc1tcv5zvhcu/js/activity/activity-sidebar.js.gzip','80d1422a5d0b6eeb418f03962be6dcb0',28,'activity-sidebar.js.gzip',7,3,4150,1502962311,1502962311,0,0,'0bf23f880cb24299fddbae8757aebb8c',27,''),(32,1,'appdata_oc1tcv5zvhcu/js/comments','0687e1731ede732bc3bb8b425f6cf4c0',12,'comments',2,1,36996,1502962319,1502962318,0,0,'5995628fdbb5f',31,''),(33,1,'appdata_oc1tcv5zvhcu/js/comments/merged.js','6a972ec5eaad711192ad74f2faec6077',32,'merged.js',5,3,28929,1502962319,1502962319,0,0,'e343b9c7f1df95d2a66b16eb168f2f87',27,''),(34,1,'appdata_oc1tcv5zvhcu/js/comments/merged.js.deps','7ceba440ce187345cccc31ed401982ad',32,'merged.js.deps',6,3,635,1502962319,1502962319,0,0,'8f9f6296cc3c0bffbc372bbe8559cf15',27,''),(35,1,'appdata_oc1tcv5zvhcu/js/comments/merged.js.gzip','8808da290b5b0831a5f30eeba1afa932',32,'merged.js.gzip',7,3,7432,1502962319,1502962319,0,0,'958b19959d9707dd8d13759a92011736',27,''),(36,1,'appdata_oc1tcv5zvhcu/js/files_sharing','40ed00a28588b02df0813d03ea4b9cd1',12,'files_sharing',2,1,20226,1502962337,1502962337,0,0,'599562a19b556',31,''),(37,1,'appdata_oc1tcv5zvhcu/js/files_sharing/additionalScripts.js','51869ebd6a0cbb29f188ac07c0fc9baa',36,'additionalScripts.js',5,3,15161,1502962337,1502962337,0,0,'98791e03413dfb54178fef44850dde0d',27,''),(38,1,'appdata_oc1tcv5zvhcu/js/files_sharing/additionalScripts.js.deps','8e7fa406dceb6ac995f3697c91fe2f20',36,'additionalScripts.js.deps',6,3,340,1502962337,1502962337,0,0,'133bf0cae18042a0326f6d0fa3d6a416',27,''),(39,1,'appdata_oc1tcv5zvhcu/js/files_sharing/additionalScripts.js.gzip','0f3ed07d9f1fb4d4e454db597c6b192c',36,'additionalScripts.js.gzip',7,3,4725,1502962337,1502962337,0,0,'4b4ed43a0a2ffcb252fb44d8331b4d39',27,''),(40,1,'appdata_oc1tcv5zvhcu/js/files_texteditor','d71692fd14331850b5725d95f3179dd1',12,'files_texteditor',2,1,820413,1502962340,1502962338,0,0,'599562a435971',31,''),(41,1,'appdata_oc1tcv5zvhcu/js/files_texteditor/merged.js','dadffc12d56c3de9f8bcea3d3dc10737',40,'merged.js',5,3,682245,1502962339,1502962339,0,0,'34c2fa35ddaed2a1cae0c9588de44fb6',27,''),(42,1,'appdata_oc1tcv5zvhcu/js/files_texteditor/merged.js.deps','161eca340c7db1ee18403060e4f4576d',40,'merged.js.deps',6,3,370,1502962339,1502962339,0,0,'751ec4b4aadfe6941615be26d682b0ee',27,''),(43,1,'appdata_oc1tcv5zvhcu/js/files_texteditor/merged.js.gzip','9e1667952cb99186d88157c40bbccb02',40,'merged.js.gzip',7,3,137798,1502962340,1502962340,0,0,'ad9f299a0075c352dd1ad23264c7d48e',27,''),(44,1,'appdata_oc1tcv5zvhcu/js/files_versions','9440ad1f73261b109e3b90648ba56634',12,'files_versions',2,1,16725,1502962341,1502962341,0,0,'599562a672a83',31,''),(45,1,'appdata_oc1tcv5zvhcu/js/files_versions/merged.js','f3e517111a767bf4eb0c04458d5e54fa',44,'merged.js',5,3,12719,1502962341,1502962341,0,0,'31cd20cd2802e189b7415027241a3a37',27,''),(46,1,'appdata_oc1tcv5zvhcu/js/files_versions/merged.js.deps','03a49d46e7268673c5925a5982d97610',44,'merged.js.deps',6,3,424,1502962341,1502962341,0,0,'09e8fc5f58d92ce95609bf3409be8c72',27,''),(47,1,'appdata_oc1tcv5zvhcu/js/files_versions/merged.js.gzip','c004322590a725e313ef36322675271d',44,'merged.js.gzip',7,3,3582,1502962341,1502962341,0,0,'4be3c5e0effae5148285b5102155b2b7',27,''),(48,1,'appdata_oc1tcv5zvhcu/js/gallery','f8e08ef57875a0c2e920a1f0f9d5f90c',12,'gallery',2,1,280769,1502962343,1502962343,0,0,'599562a801f9f',31,''),(49,1,'appdata_oc1tcv5zvhcu/js/gallery/scripts-for-file-app.js','8f7d3bdb2d69c4db7c3544a2478d6438',48,'scripts-for-file-app.js',5,3,225479,1502962343,1502962343,0,0,'897c16d829e4a633562cbf371b18600a',27,''),(50,1,'appdata_oc1tcv5zvhcu/js/gallery/scripts-for-file-app.js.deps','c49e34500c44dd21a69377af9d904052',48,'scripts-for-file-app.js.deps',6,3,856,1502962343,1502962343,0,0,'5cd3da99de838a956e9017c8a853dd0f',27,''),(51,1,'appdata_oc1tcv5zvhcu/js/gallery/scripts-for-file-app.js.gzip','4c8d7ecbfd39a697fb36b084976e7f11',48,'scripts-for-file-app.js.gzip',7,3,54434,1502962343,1502962343,0,0,'96c6d959dc5af330322da004b327b371',27,''),(52,1,'appdata_oc1tcv5zvhcu/js/core/merged.js','f0f5011751a4da5e1140d7f4df85f9a6',13,'merged.js',5,3,20224,1502962346,1502962346,0,0,'3e7f63fe1b227d09c845f7ffbff375ef',27,''),(53,1,'appdata_oc1tcv5zvhcu/js/core/merged.js.deps','6283a84b2d9a309880ae25b8133a980b',13,'merged.js.deps',6,3,508,1502962346,1502962346,0,0,'a5dd50907e36b8674710c6958fa0acf2',27,''),(54,1,'appdata_oc1tcv5zvhcu/js/core/merged.js.gzip','81339bc2adf1bf8bd564cee535277b51',13,'merged.js.gzip',7,3,5365,1502962348,1502962348,0,0,'083b20b44b0a7a2d7a448332e6656e10',27,''),(55,1,'appdata_oc1tcv5zvhcu/js/systemtags','17fe245f3a1caff34e7b80f0540c66a4',12,'systemtags',2,1,23963,1502962364,1502962364,0,0,'599562bd04362',31,''),(56,1,'appdata_oc1tcv5zvhcu/js/systemtags/merged.js','70f9800cd6bde151c86280ff593d7f3c',55,'merged.js',5,3,18161,1502962364,1502962364,0,0,'e66ca60cd793cc2dc09ad141105ce0cc',27,''),(57,1,'appdata_oc1tcv5zvhcu/js/systemtags/merged.js.deps','b40b34b2f586c6ff5f001bf049150cb3',55,'merged.js.deps',6,3,495,1502962364,1502962364,0,0,'7f86f8af4e1775444322a695c972bff0',27,''),(58,1,'appdata_oc1tcv5zvhcu/js/systemtags/merged.js.gzip','a2b462e7ddd1b66eceeec28abebff2d7',55,'merged.js.gzip',7,3,5307,1502962364,1502962364,0,0,'a9b5844448308703fb29a3c7c7147ebc',27,''),(59,1,'appdata_oc1tcv5zvhcu/css','904abdd904a73ba8ef178bfbd5113cb3',2,'css',2,1,169017,1502970184,1502962392,0,0,'599581482c6e1',31,''),(60,1,'appdata_oc1tcv5zvhcu/css/core','ce03c7b301f7c72b94f83851321447e4',59,'core',2,1,132894,1502970184,1502970183,0,0,'599581482c6e1',31,''),(61,1,'appdata_oc1tcv5zvhcu/theming','3e49fd6d0ea416f516c68d4770def7be',2,'theming',2,1,3049,1502970213,1502962392,0,0,'59958165cbc66',31,''),(62,1,'appdata_oc1tcv5zvhcu/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-server.css','79c64d4803cf94bda991d8df74858718',60,'f1727c5f3e441ef9cb6fa766743ef4fc-server.css',9,8,77320,1502962370,1502962370,0,0,'b4fc5db3cee0ad34b21f73aa30dcc757',27,''),(63,1,'appdata_oc1tcv5zvhcu/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-server.css.deps','480e158f004cf44f9cd50a93666cdbba',60,'f1727c5f3e441ef9cb6fa766743ef4fc-server.css.deps',6,3,850,1502962370,1502962370,0,0,'9f6b9fa737dda43af3c3b4a5580ed879',27,''),(64,1,'appdata_oc1tcv5zvhcu/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-server.css.gzip','9c00082b8fc89ca5ce8ccd2858e7fd4b',60,'f1727c5f3e441ef9cb6fa766743ef4fc-server.css.gzip',7,3,13410,1502962370,1502962370,0,0,'d6679757bcbf7bd198a9268de6107389',27,''),(65,1,'appdata_oc1tcv5zvhcu/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-share.css','568c819b175fb5aa901c6287bf7d3207',60,'f1727c5f3e441ef9cb6fa766743ef4fc-share.css',9,8,2848,1502962371,1502962371,0,0,'5008f3bed409db4bbeec2b5b09b96574',27,''),(66,1,'appdata_oc1tcv5zvhcu/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-share.css.deps','0b286cff6c25954579fbb402862a2356',60,'f1727c5f3e441ef9cb6fa766743ef4fc-share.css.deps',6,3,133,1502962371,1502962371,0,0,'5a8cd72a0704f41d1dbe1a9d408be43b',27,''),(67,1,'appdata_oc1tcv5zvhcu/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-share.css.gzip','b3630b2680753faddb1d50889effe255',60,'f1727c5f3e441ef9cb6fa766743ef4fc-share.css.gzip',7,3,994,1502962371,1502962371,0,0,'938428474fd10984f3c8b58e2f9f1223',27,''),(68,1,'appdata_oc1tcv5zvhcu/css/files','80846e4fd0f3a05cd0ef5519fea47fac',59,'files',2,1,25566,1502962373,1502962373,0,0,'599562c5da31d',31,''),(69,1,'appdata_oc1tcv5zvhcu/css/files/f1727c5f3e441ef9cb6fa766743ef4fc-merged.css','91222c1894ff60f428871e31f7ad6379',68,'f1727c5f3e441ef9cb6fa766743ef4fc-merged.css',9,8,20713,1502962373,1502962373,0,0,'76407a87f24233e43de12ad19c734f9d',27,''),(70,1,'appdata_oc1tcv5zvhcu/css/files/f1727c5f3e441ef9cb6fa766743ef4fc-merged.css.deps','6bfd91bac336264639374e3132b3b5fd',68,'f1727c5f3e441ef9cb6fa766743ef4fc-merged.css.deps',6,3,433,1502962373,1502962373,0,0,'02d3dbca409164b01956ad88333e0894',27,''),(71,1,'appdata_oc1tcv5zvhcu/css/files/f1727c5f3e441ef9cb6fa766743ef4fc-merged.css.gzip','4d008ff989468e0aad4fef72fab563a4',68,'f1727c5f3e441ef9cb6fa766743ef4fc-merged.css.gzip',7,3,4420,1502962373,1502962373,0,0,'f0552b241e076c4a7bed7ad66952fcd3',27,''),(72,1,'appdata_oc1tcv5zvhcu/css/files_sharing','1346888c89a7b420ce3010f6674929d9',59,'files_sharing',2,1,3945,1502962376,1502962375,0,0,'599562c86da88',31,''),(73,1,'appdata_oc1tcv5zvhcu/css/files_sharing/f1727c5f3e441ef9cb6fa766743ef4fc-mergedAdditionalStyles.css','5751aa2d986b7ce8709a165b7c677f99',72,'f1727c5f3e441ef9cb6fa766743ef4fc-mergedAdditionalStyles.css',9,8,2727,1502962376,1502962376,0,0,'628fecc126cc25987d40f60ff89712ca',27,''),(74,1,'appdata_oc1tcv5zvhcu/css/files_sharing/f1727c5f3e441ef9cb6fa766743ef4fc-mergedAdditionalStyles.css.deps','47704d635b2f3445e86ba3b6bd36b898',72,'f1727c5f3e441ef9cb6fa766743ef4fc-mergedAdditionalStyles.css.deps',6,3,340,1502962376,1502962376,0,0,'8d79ebb76d6ee7ce84a7b71abe30fa25',27,''),(75,1,'appdata_oc1tcv5zvhcu/css/files_sharing/f1727c5f3e441ef9cb6fa766743ef4fc-mergedAdditionalStyles.css.gzip','a39e87d667b754f70190d0d99e37bc9b',72,'f1727c5f3e441ef9cb6fa766743ef4fc-mergedAdditionalStyles.css.gzip',7,3,878,1502962376,1502962376,0,0,'9b07805885efaa6b4734125c8337d802',27,''),(76,1,'appdata_oc1tcv5zvhcu/css/files_texteditor','1d7585c9c52e2fe28669bbe7d287cdbe',59,'files_texteditor',2,1,5377,1502962379,1502962378,0,0,'599562cbd1bbc',31,''),(77,1,'appdata_oc1tcv5zvhcu/css/files_texteditor/f1727c5f3e441ef9cb6fa766743ef4fc-merged.css','1dd49590994b39fa531e47e0816615ef',76,'f1727c5f3e441ef9cb6fa766743ef4fc-merged.css',9,8,3774,1502962379,1502962379,0,0,'b3ee3f6e543dfd248165f1d65155db2a',27,''),(78,1,'appdata_oc1tcv5zvhcu/css/files_texteditor/f1727c5f3e441ef9cb6fa766743ef4fc-merged.css.deps','b2f06ec4614f08b96439a3f5c386d882',76,'f1727c5f3e441ef9cb6fa766743ef4fc-merged.css.deps',6,3,419,1502962379,1502962379,0,0,'d7f5ad1627977b18737d5282bd8fb693',27,''),(79,1,'appdata_oc1tcv5zvhcu/css/files_texteditor/f1727c5f3e441ef9cb6fa766743ef4fc-merged.css.gzip','ddc046edb18383420400e5ed99b434ba',76,'f1727c5f3e441ef9cb6fa766743ef4fc-merged.css.gzip',7,3,1184,1502962379,1502962379,0,0,'5869eb8b8217e982fe26bd1c2faf585b',27,''),(80,1,'appdata_oc1tcv5zvhcu/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-systemtags.css','720c85079ebd5350c2e0c78c91fdd6c6',60,'f1727c5f3e441ef9cb6fa766743ef4fc-systemtags.css',9,8,1415,1502962389,1502962389,0,0,'7b99e3cf30ae3c827eb4a14d9a1e660a',27,''),(81,1,'appdata_oc1tcv5zvhcu/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-systemtags.css.deps','9a3c4b95d85f2b694e579c16951320b8',60,'f1727c5f3e441ef9cb6fa766743ef4fc-systemtags.css.deps',6,3,138,1502962389,1502962389,0,0,'52813741290ada22cae6a68e35a874f0',27,''),(82,1,'appdata_oc1tcv5zvhcu/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-systemtags.css.gzip','0ba786424851e6bb56bc83c6dbc38387',60,'f1727c5f3e441ef9cb6fa766743ef4fc-systemtags.css.gzip',7,3,389,1502962391,1502962391,0,0,'4093b28c7cd59c211c7e46bcfe4a0892',27,''),(83,1,'appdata_oc1tcv5zvhcu/css/theming','e3fd77f65efdc5cf870a09382a58389a',59,'theming',2,1,1235,1502962395,1502962392,0,0,'599562db7403a',31,''),(84,1,'appdata_oc1tcv5zvhcu/theming/0','e7a2b761b5eda0b78690022206b9aefb',61,'0',2,1,3049,1502970213,1502970213,0,0,'59958165cbc66',31,''),(85,1,'appdata_oc1tcv5zvhcu/css/theming/f1727c5f3e441ef9cb6fa766743ef4fc-theming.css','cc37bca70f6b633d82bf1b0589e53f5a',83,'f1727c5f3e441ef9cb6fa766743ef4fc-theming.css',9,8,780,1502962393,1502962393,0,0,'113d3f96855e9deef214ccccaa5f711e',27,''),(86,1,'appdata_oc1tcv5zvhcu/css/theming/f1727c5f3e441ef9cb6fa766743ef4fc-theming.css.deps','ba797291b72bc55fee6a6cd22d9780f4',83,'f1727c5f3e441ef9cb6fa766743ef4fc-theming.css.deps',6,3,144,1502962393,1502962393,0,0,'4b9015088f2b9b63d8652d4bf944711c',27,''),(87,1,'appdata_oc1tcv5zvhcu/css/theming/f1727c5f3e441ef9cb6fa766743ef4fc-theming.css.gzip','abbba4071d1a81662af7e530f64db2ef',83,'f1727c5f3e441ef9cb6fa766743ef4fc-theming.css.gzip',7,3,311,1502962395,1502962395,0,0,'cdaf6740af722d3fa87e2a409bb6370f',27,''),(88,1,'appdata_oc1tcv5zvhcu/theming/0/favIcon-files','43e70848ebc9111974255fd9f650ae5e',84,'favIcon-files',6,3,505,1502962395,1502962395,0,0,'3c08e6c3d8af20811f20cd32edaa9835',27,''),(89,1,'appdata_oc1tcv5zvhcu/theming/0/icon-core-filetypes_folder.svg','d1a20f5407af1fc9f00fcb65969b630f',84,'icon-core-filetypes_folder.svg',11,10,254,1502962401,1502962401,0,0,'54eb9fc8a09e89f0b440dcd31cdf7df7',27,''),(90,1,'appdata_oc1tcv5zvhcu/theming/0/favIcon-settings','df459d4a2aaa7026e861f0a4c39a9722',84,'favIcon-settings',6,3,1145,1502962491,1502962491,0,0,'594f21ab29652a5a9a50acd278316967',27,''),(91,1,'files_external','c270928b685e7946199afdfb898d27ea',1,'files_external',2,1,0,1502962492,1502962492,0,0,'5995633c443ed',31,''),(92,1,'appdata_oc1tcv5zvhcu/js/core/merged-login.js','f8c0a4569bddd0b0f87d53b9abf59d3d',13,'merged-login.js',5,3,5389,1502962530,1502962530,0,0,'0b0bdf6b35c4cd71083744134eacfbd9',27,''),(93,1,'appdata_oc1tcv5zvhcu/js/core/merged-login.js.deps','5026da85955e6429f015a241e10c7b8a',13,'merged-login.js.deps',6,3,271,1502962530,1502962530,0,0,'1559540de8709dd42266e5702a5b3a02',27,''),(94,1,'appdata_oc1tcv5zvhcu/js/core/merged-login.js.gzip','9f72cc8213ebd399eaac0828c1eea647',13,'merged-login.js.gzip',7,3,1867,1502962531,1502962531,0,0,'dfc32cfec607200dc7fe528ab537bd4d',27,''),(95,1,'appdata_oc1tcv5zvhcu/appstore/categories.json','e66be3c4731a3542f660a177a5026e52',3,'categories.json',4,3,32532,1502962666,1502962666,0,0,'21792b36988cb2d9b169d7b6c0971148',27,''),(96,1,'appdata_oc1tcv5zvhcu/identityproof','94665634a4b6e297fcd65153d0e34f50',2,'identityproof',2,1,4021,1502970153,1502970151,0,0,'59958129a01a1',31,''),(97,1,'appdata_oc1tcv5zvhcu/identityproof/nextcloud','ce27325a7195c3bd5649025c8ad542c8',96,'nextcloud',2,1,4021,1502970153,1502970153,0,0,'59958129a01a1',31,''),(98,1,'appdata_oc1tcv5zvhcu/identityproof/nextcloud/private','5767dc8f59364ae4418ef73c095f1560',97,'private',6,3,3570,1502970153,1502970153,0,0,'e98716c910ef5aee3741a04ea1bbdb03',27,''),(99,1,'appdata_oc1tcv5zvhcu/identityproof/nextcloud/public','7e43e603d09545e74a9d2c188d97ab1c',97,'public',6,3,451,1502970153,1502970153,0,0,'5ee23408e5293927f8515af2055a203e',27,''),(100,1,'appdata_oc1tcv5zvhcu/dav-photocache','869741b1a4acdbb7bf88b9dd69c07def',2,'dav-photocache',2,1,0,1502970177,1502970177,0,0,'59958141ae5f3',31,''),(105,1,'appdata_oc1tcv5zvhcu/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-styles.css','4468503bfaba6544584ab9db68b5e6f8',60,'f1727c5f3e441ef9cb6fa766743ef4fc-styles.css',9,8,20498,1502970182,1502970182,0,0,'793be530a5cb3a3060a83fa16a8b6b20',27,''),(107,1,'appdata_oc1tcv5zvhcu/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-styles.css.deps','780a6ceaa72874b1ab8a29f3ce4e4732',60,'f1727c5f3e441ef9cb6fa766743ef4fc-styles.css.deps',6,3,134,1502970182,1502970182,0,0,'addd919269797d0af9801c78d633bb1d',27,''),(108,1,'appdata_oc1tcv5zvhcu/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-styles.css.gzip','f689df78b26c7e77daa2648096acd239',60,'f1727c5f3e441ef9cb6fa766743ef4fc-styles.css.gzip',7,3,4848,1502970182,1502970182,0,0,'ca7be79a0bc25f29f12ecf16b22a20ef',27,''),(109,1,'appdata_oc1tcv5zvhcu/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-header.css','6bf450f43f51e40b921ceeb107673a94',60,'f1727c5f3e441ef9cb6fa766743ef4fc-header.css',9,8,7910,1502970183,1502970183,0,0,'612b813cc8ab887818b6956926167713',27,''),(110,1,'appdata_oc1tcv5zvhcu/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-header.css.deps','2382c5f408e88d8d1d7c2fd75d43d788',60,'f1727c5f3e441ef9cb6fa766743ef4fc-header.css.deps',6,3,134,1502970184,1502970184,0,0,'a803b27b0a7b5f1ca9d24b27c2e76a72',27,''),(111,1,'appdata_oc1tcv5zvhcu/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-header.css.gzip','c0c873a3a07e7ee69e400b40c12992b2',60,'f1727c5f3e441ef9cb6fa766743ef4fc-header.css.gzip',7,3,1873,1502970184,1502970184,0,0,'608269e9dc65de8ede72125006848773',27,''),(112,1,'appdata_oc1tcv5zvhcu/theming/0/favIcon-core','a1c85d9dba4810d013a84fa33c48d83b',84,'favIcon-core',6,3,1145,1502970213,1502970213,0,0,'f97f9ee2157cdc65af35233648ec0273',27,'');
/*!40000 ALTER TABLE `oc_filecache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_files_trash`
--

DROP TABLE IF EXISTS `oc_files_trash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_files_trash` (
  `auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(250) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timestamp` varchar(12) COLLATE utf8_bin NOT NULL DEFAULT '',
  `location` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` varchar(4) COLLATE utf8_bin DEFAULT NULL,
  `mime` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`auto_id`),
  KEY `id_index` (`id`),
  KEY `timestamp_index` (`timestamp`),
  KEY `user_index` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_files_trash`
--

LOCK TABLES `oc_files_trash` WRITE;
/*!40000 ALTER TABLE `oc_files_trash` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_files_trash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_flow_checks`
--

DROP TABLE IF EXISTS `oc_flow_checks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_flow_checks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(256) COLLATE utf8_bin NOT NULL,
  `operator` varchar(16) COLLATE utf8_bin NOT NULL,
  `value` longtext COLLATE utf8_bin,
  `hash` varchar(32) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `flow_unique_hash` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_flow_checks`
--

LOCK TABLES `oc_flow_checks` WRITE;
/*!40000 ALTER TABLE `oc_flow_checks` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_flow_checks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_flow_operations`
--

DROP TABLE IF EXISTS `oc_flow_operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_flow_operations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(256) COLLATE utf8_bin NOT NULL,
  `name` varchar(256) COLLATE utf8_bin NOT NULL,
  `checks` longtext COLLATE utf8_bin,
  `operation` longtext COLLATE utf8_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_flow_operations`
--

LOCK TABLES `oc_flow_operations` WRITE;
/*!40000 ALTER TABLE `oc_flow_operations` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_flow_operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_group_admin`
--

DROP TABLE IF EXISTS `oc_group_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_group_admin` (
  `gid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`,`uid`),
  KEY `group_admin_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_group_admin`
--

LOCK TABLES `oc_group_admin` WRITE;
/*!40000 ALTER TABLE `oc_group_admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_group_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_group_user`
--

DROP TABLE IF EXISTS `oc_group_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_group_user` (
  `gid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`,`uid`),
  KEY `gu_uid_index` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_group_user`
--

LOCK TABLES `oc_group_user` WRITE;
/*!40000 ALTER TABLE `oc_group_user` DISABLE KEYS */;
INSERT INTO `oc_group_user` VALUES ('admin','nextcloud');
/*!40000 ALTER TABLE `oc_group_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_groups`
--

DROP TABLE IF EXISTS `oc_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_groups` (
  `gid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_groups`
--

LOCK TABLES `oc_groups` WRITE;
/*!40000 ALTER TABLE `oc_groups` DISABLE KEYS */;
INSERT INTO `oc_groups` VALUES ('admin');
/*!40000 ALTER TABLE `oc_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_jobs`
--

DROP TABLE IF EXISTS `oc_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_jobs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `argument` varchar(4000) COLLATE utf8_bin NOT NULL DEFAULT '',
  `last_run` int(11) DEFAULT '0',
  `last_checked` int(11) DEFAULT '0',
  `reserved_at` int(11) DEFAULT '0',
  `execution_duration` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `job_class_index` (`class`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_jobs`
--

LOCK TABLES `oc_jobs` WRITE;
/*!40000 ALTER TABLE `oc_jobs` DISABLE KEYS */;
INSERT INTO `oc_jobs` VALUES (1,'OCA\\UpdateNotification\\Notification\\BackgroundJob','null',1502962400,1502962399,0,0),(2,'OCA\\Files\\BackgroundJob\\ScanFiles','null',1502962491,1502962491,0,0),(3,'OCA\\Files\\BackgroundJob\\DeleteOrphanedItems','null',1502962536,1502962534,0,0),(4,'OCA\\Files\\BackgroundJob\\CleanupFileLocks','null',1502962637,1502962637,0,0),(6,'OCA\\Files_Trashbin\\BackgroundJob\\ExpireTrash','null',1502962980,1502962980,0,0),(7,'OCA\\NextcloudAnnouncements\\Cron\\Crawler','null',0,1502962211,0,0),(8,'OCA\\Activity\\BackgroundJob\\EmailNotification','null',0,1502962218,0,0),(9,'OCA\\Activity\\BackgroundJob\\ExpireActivities','null',0,1502962218,0,0),(10,'OCA\\DAV\\CardDAV\\SyncJob','null',0,1502962226,0,0),(11,'OCA\\Files_Sharing\\DeleteOrphanedSharesJob','null',0,1502962242,0,0),(12,'OCA\\Files_Sharing\\ExpireSharesJob','null',0,1502962242,0,0),(13,'OCA\\Files_Versions\\BackgroundJob\\ExpireVersions','null',0,1502962242,0,0),(14,'OCA\\Federation\\SyncJob','null',0,1502962250,0,0),(15,'\\OC\\Authentication\\Token\\DefaultTokenCleanupJob','null',0,1502962272,0,0),(16,'OCA\\FirstRunWizard\\Notification\\BackgroundJob','{\"uid\":\"nextcloud\"}',0,1502962286,0,0),(17,'OC\\Settings\\BackgroundJobs\\VerifyUserData','{\"verificationCode\":\"\",\"data\":\"postmaster@powermail.mydomainname.com\",\"type\":\"email\",\"uid\":\"nextcloud\",\"try\":0,\"lastRun\":1502970152}',0,1502970152,0,0),(18,'OCA\\LookupServerConnector\\BackgroundJobs\\RetryJob','{\"dataArray\":{\"message\":{\"data\":{\"federationId\":\"nextcloud@live.technomail.in\\/nextcloud\"},\"type\":\"lookupserver\",\"signer\":\"nextcloud@live.technomail.in\\/nextcloud\",\"timestamp\":1502970153},\"signature\":\"FMK1vVd6O9FWYFTkDGysX6dZXtBZOQWs8u\\/IdjoXoOcHezI9Fu8Onm\\/BRd62eT7Hb08UItuRwml4NQ41f4qUXPCCuteeumFLJFnxyLpIo13cgeQldADKuAzLHNUo+NfURL3BjyTzu6fB2pte2yDWHWU3baejYo6Yiw7aSD022I6V0mn75geaiQCnLbif2\\/ZU6pgfCJpAno893pOR22VAeO1qC4JpKrvgKyF2fcJo5VLCXJPQbDKyMn5Mb+bCF9pbLrSwpdaQVVmPRK9MC206gYiDsgDTlS33DRqmBLGdvKDh\\/eOeJ1HPLNyXGU+nmGDW718vPHY9O75Us1tBNLXj8w==\"},\"retryNo\":0}',0,1502970163,0,0),(19,'OCA\\LookupServerConnector\\BackgroundJobs\\RetryJob','{\"dataArray\":{\"message\":{\"data\":{\"federationId\":\"nextcloud@live.technomail.in\\/nextcloud\"},\"type\":\"lookupserver\",\"signer\":\"nextcloud@live.technomail.in\\/nextcloud\",\"timestamp\":1502970153},\"signature\":\"D9JaGsJJAFOMCn4n+S4QjHujwLaa2EjrV9A16j1fI\\/cpdPDP2FHMEU\\/pmAEv+Ua708fcsxIDN4v6VC4YB6wfhgB7+TUGpN3ORY2\\/om4ftwJUQdxA28Xib4AlFNb7dokSNRyTwcQd81FasZOgxDFf0LseLtMm6RRkJA5mbxesx\\/6g22mYqj3vsG5vkbjYdXHgzriKVf+Wja4y3uNu3uCejpzGTMTfBV7cCgRLiLaysK5yFKcLJsA\\/vxRt\\/ESyAGqyDdjgcMFBhE+Ur1Dh0sWZbXqfHXD+zMo6Pv3TukNV\\/cuJ7mqAf32hppc3MEAjIazQRyM8xPoeRqd39jR8OauCAw==\"},\"retryNo\":0}',0,1502970163,0,0),(20,'OCA\\LookupServerConnector\\BackgroundJobs\\RetryJob','{\"dataArray\":{\"message\":{\"data\":{\"federationId\":\"nextcloud@live.technomail.in\\/nextcloud\"},\"type\":\"lookupserver\",\"signer\":\"nextcloud@live.technomail.in\\/nextcloud\",\"timestamp\":1502970153},\"signature\":\"MncDQmtbCF+Mjl+ryFzf7omQQxQ5bP4MLO\\/nE3CDcytj6yP6IGC7NoEPMUfMxuzBooesYkpp+oxH6zcCNVhhZzG22uXEtIRgf2h6tpkovSS\\/YpDX9XC9z7XjmiYt8lDTNt+4T4xC2QQwJ3wc0SKp3SOipaSpLeBnDHNY2MlpiEOQlTqf0s72dpnv0rq\\/YB7fxnbdLvMBCqGd8bkBxoRjgn4oCUO9hiEjIVVovjFEpxSbi+OngotZ3qm83cpLE9B+mSwuqrG4Cnj1S3HyLIc\\/kWq15ra7A9HuD14K2vIeyrdIT2MNmpt+lzADb0tk+LhVUj2pXkZyWIhSaBGGxJ26Dw==\"},\"retryNo\":0}',0,1502970163,0,0),(21,'OC\\Settings\\BackgroundJobs\\VerifyUserData','{\"verificationCode\":\"\",\"data\":\"\",\"type\":\"email\",\"uid\":\"nextcloud\",\"try\":0,\"lastRun\":1502970166}',0,1502970166,0,0),(22,'OC\\Settings\\BackgroundJobs\\VerifyUserData','{\"verificationCode\":\"\",\"data\":\"postmaster@powermail.mydomainname.com\",\"type\":\"email\",\"uid\":\"nextcloud\",\"try\":0,\"lastRun\":1502970166}',0,1502970166,0,0),(23,'OCA\\LookupServerConnector\\BackgroundJobs\\RetryJob','{\"dataArray\":{\"message\":{\"data\":{\"federationId\":\"nextcloud@live.technomail.in\\/nextcloud\"},\"type\":\"lookupserver\",\"signer\":\"nextcloud@live.technomail.in\\/nextcloud\",\"timestamp\":1502970166},\"signature\":\"FLHpB43xQQEUvtvJXtRUT+k6LizQpbeURGHSDiMc+dpkOxDI5Uj6dPKZjaOjt3rzU+87Wn6sTTwL1RKaDyIEzDVF9zt8OfUS0s1x4Snzy1euHi7eOY3+M4yGxXtoHDuRxC6HUTBiZhWvbL7HH7kwhd9qv7oo6CU8UU2aqDL+EHNvNM36zc3ETA0FwmObDVN6ewP2oAgp2V0waE9KUX1LWJHeCGehO4jaHSS1UE6+WCeLTnFTp7aGuhdPvPPCK9pu9DtqRLKxqjGi8TvCK9AexCWwSdoCF6JT\\/xUYZ6e4pCTUpN1sfKxntyy7gn5ru+Tyt2d0yWznnloYD1O5eP1ypw==\"},\"retryNo\":0}',0,1502970176,0,0);
/*!40000 ALTER TABLE `oc_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_mimetypes`
--

DROP TABLE IF EXISTS `oc_mimetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_mimetypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mimetype` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mimetype_id_index` (`mimetype`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_mimetypes`
--

LOCK TABLES `oc_mimetypes` WRITE;
/*!40000 ALTER TABLE `oc_mimetypes` DISABLE KEYS */;
INSERT INTO `oc_mimetypes` VALUES (3,'application'),(5,'application/javascript'),(4,'application/json'),(6,'application/octet-stream'),(7,'application/x-gzip'),(1,'httpd'),(2,'httpd/unix-directory'),(10,'image'),(11,'image/svg+xml'),(8,'text'),(9,'text/css');
/*!40000 ALTER TABLE `oc_mimetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_mounts`
--

DROP TABLE IF EXISTS `oc_mounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_mounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `storage_id` int(11) NOT NULL,
  `root_id` int(11) NOT NULL,
  `user_id` varchar(64) COLLATE utf8_bin NOT NULL,
  `mount_point` varchar(4000) COLLATE utf8_bin NOT NULL,
  `mount_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mounts_user_root_index` (`user_id`,`root_id`),
  KEY `mounts_user_index` (`user_id`),
  KEY `mounts_storage_index` (`storage_id`),
  KEY `mounts_root_index` (`root_id`),
  KEY `mounts_mount_id_index` (`mount_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_mounts`
--

LOCK TABLES `oc_mounts` WRITE;
/*!40000 ALTER TABLE `oc_mounts` DISABLE KEYS */;
INSERT INTO `oc_mounts` VALUES (1,2,6,'nextcloud','/nextcloud/',NULL);
/*!40000 ALTER TABLE `oc_mounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_notes_meta`
--

DROP TABLE IF EXISTS `oc_notes_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_notes_meta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_id` int(11) NOT NULL,
  `user_id` varchar(64) COLLATE utf8_bin NOT NULL,
  `last_update` int(11) NOT NULL,
  `etag` varchar(32) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notes_meta_file_id_user_id_index` (`file_id`,`user_id`),
  KEY `notes_meta_file_id_index` (`file_id`),
  KEY `notes_meta_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_notes_meta`
--

LOCK TABLES `oc_notes_meta` WRITE;
/*!40000 ALTER TABLE `oc_notes_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_notes_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_notifications`
--

DROP TABLE IF EXISTS `oc_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_notifications` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(32) COLLATE utf8_bin NOT NULL,
  `user` varchar(64) COLLATE utf8_bin NOT NULL,
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `object_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `object_id` varchar(64) COLLATE utf8_bin NOT NULL,
  `subject` varchar(64) COLLATE utf8_bin NOT NULL,
  `subject_parameters` longtext COLLATE utf8_bin,
  `message` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `message_parameters` longtext COLLATE utf8_bin,
  `link` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `icon` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `actions` longtext COLLATE utf8_bin,
  PRIMARY KEY (`notification_id`),
  KEY `oc_notifications_app` (`app`),
  KEY `oc_notifications_user` (`user`),
  KEY `oc_notifications_timestamp` (`timestamp`),
  KEY `oc_notifications_object` (`object_type`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_notifications`
--

LOCK TABLES `oc_notifications` WRITE;
/*!40000 ALTER TABLE `oc_notifications` DISABLE KEYS */;
INSERT INTO `oc_notifications` VALUES (1,'survey_client','nextcloud',1502962662,'dummy','23','updated','[]','','[]','','','[{\"label\":\"enable\",\"link\":\"http:\\/\\/live.technomail.in\\/nextcloud\\/ocs\\/v2.php\\/apps\\/survey_client\\/api\\/v1\\/monthly\",\"type\":\"POST\",\"primary\":true},{\"label\":\"disable\",\"link\":\"http:\\/\\/live.technomail.in\\/nextcloud\\/ocs\\/v2.php\\/apps\\/survey_client\\/api\\/v1\\/monthly\",\"type\":\"DELETE\",\"primary\":false}]');
/*!40000 ALTER TABLE `oc_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_notifications_pushtokens`
--

DROP TABLE IF EXISTS `oc_notifications_pushtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_notifications_pushtokens` (
  `uid` varchar(64) COLLATE utf8_bin NOT NULL,
  `token` int(11) NOT NULL DEFAULT '0',
  `deviceidentifier` varchar(128) COLLATE utf8_bin NOT NULL,
  `devicepublickey` varchar(512) COLLATE utf8_bin NOT NULL,
  `devicepublickeyhash` varchar(128) COLLATE utf8_bin NOT NULL,
  `pushtokenhash` varchar(128) COLLATE utf8_bin NOT NULL,
  `proxyserver` varchar(256) COLLATE utf8_bin NOT NULL,
  UNIQUE KEY `oc_notifpushtoken` (`uid`,`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_notifications_pushtokens`
--

LOCK TABLES `oc_notifications_pushtokens` WRITE;
/*!40000 ALTER TABLE `oc_notifications_pushtokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_notifications_pushtokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_oauth2_access_tokens`
--

DROP TABLE IF EXISTS `oc_oauth2_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_oauth2_access_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `token_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `hashed_code` varchar(128) COLLATE utf8_bin NOT NULL,
  `encrypted_token` varchar(786) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth2_access_hash_idx` (`hashed_code`),
  KEY `oauth2_access_client_id_idx` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_oauth2_access_tokens`
--

LOCK TABLES `oc_oauth2_access_tokens` WRITE;
/*!40000 ALTER TABLE `oc_oauth2_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_oauth2_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_oauth2_clients`
--

DROP TABLE IF EXISTS `oc_oauth2_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_oauth2_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `redirect_uri` varchar(2000) COLLATE utf8_bin NOT NULL,
  `client_identifier` varchar(64) COLLATE utf8_bin NOT NULL,
  `secret` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth2_client_id_idx` (`client_identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_oauth2_clients`
--

LOCK TABLES `oc_oauth2_clients` WRITE;
/*!40000 ALTER TABLE `oc_oauth2_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_oauth2_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_preferences`
--

DROP TABLE IF EXISTS `oc_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_preferences` (
  `userid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `appid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configkey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `configvalue` longtext COLLATE utf8_bin,
  PRIMARY KEY (`userid`,`appid`,`configkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_preferences`
--

LOCK TABLES `oc_preferences` WRITE;
/*!40000 ALTER TABLE `oc_preferences` DISABLE KEYS */;
INSERT INTO `oc_preferences` VALUES ('nextcloud','core','lang','en'),('nextcloud','firstrunwizard','show','0'),('nextcloud','login','lastLogin','1502962272'),('nextcloud','settings','email','postmaster@powermail.mydomainname.com');
/*!40000 ALTER TABLE `oc_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_privatedata`
--

DROP TABLE IF EXISTS `oc_privatedata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_privatedata` (
  `keyid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `app` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `key` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`keyid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_privatedata`
--

LOCK TABLES `oc_privatedata` WRITE;
/*!40000 ALTER TABLE `oc_privatedata` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_privatedata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_properties`
--

DROP TABLE IF EXISTS `oc_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `propertypath` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `propertyname` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `propertyvalue` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `property_index` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_properties`
--

LOCK TABLES `oc_properties` WRITE;
/*!40000 ALTER TABLE `oc_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_schedulingobjects`
--

DROP TABLE IF EXISTS `oc_schedulingobjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_schedulingobjects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principaluri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `calendardata` longblob,
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `lastmodified` int(10) unsigned DEFAULT NULL,
  `etag` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `size` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_schedulingobjects`
--

LOCK TABLES `oc_schedulingobjects` WRITE;
/*!40000 ALTER TABLE `oc_schedulingobjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_schedulingobjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_share`
--

DROP TABLE IF EXISTS `oc_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_share` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `share_type` smallint(6) NOT NULL DEFAULT '0',
  `share_with` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `uid_owner` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `uid_initiator` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `item_type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `item_source` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `item_target` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `file_source` int(11) DEFAULT NULL,
  `file_target` varchar(512) COLLATE utf8_bin DEFAULT NULL,
  `permissions` smallint(6) NOT NULL DEFAULT '0',
  `stime` bigint(20) NOT NULL DEFAULT '0',
  `accepted` smallint(6) NOT NULL DEFAULT '0',
  `expiration` datetime DEFAULT NULL,
  `token` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `mail_send` smallint(6) NOT NULL DEFAULT '0',
  `share_name` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_share_type_index` (`item_type`,`share_type`),
  KEY `file_source_index` (`file_source`),
  KEY `token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_share`
--

LOCK TABLES `oc_share` WRITE;
/*!40000 ALTER TABLE `oc_share` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_share` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_share_external`
--

DROP TABLE IF EXISTS `oc_share_external`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_share_external` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `remote` varchar(512) COLLATE utf8_bin NOT NULL COMMENT 'Url of the remove owncloud instance',
  `remote_id` int(11) NOT NULL DEFAULT '-1',
  `share_token` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Public share token',
  `password` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT 'Optional password for the public share',
  `name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Original name on the remote server',
  `owner` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'User that owns the public share on the remote server',
  `user` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Local user which added the external share',
  `mountpoint` varchar(4000) COLLATE utf8_bin NOT NULL COMMENT 'Full path where the share is mounted',
  `mountpoint_hash` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'md5 hash of the mountpoint',
  `accepted` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sh_external_mp` (`user`,`mountpoint_hash`),
  KEY `sh_external_user` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_share_external`
--

LOCK TABLES `oc_share_external` WRITE;
/*!40000 ALTER TABLE `oc_share_external` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_share_external` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_storages`
--

DROP TABLE IF EXISTS `oc_storages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_storages` (
  `id` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `numeric_id` int(11) NOT NULL AUTO_INCREMENT,
  `available` int(11) NOT NULL DEFAULT '1',
  `last_checked` int(11) DEFAULT NULL,
  PRIMARY KEY (`numeric_id`),
  UNIQUE KEY `storages_id_index` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_storages`
--

LOCK TABLES `oc_storages` WRITE;
/*!40000 ALTER TABLE `oc_storages` DISABLE KEYS */;
INSERT INTO `oc_storages` VALUES ('local::/var/www/html/nextcloud/data/',1,1,NULL),('home::nextcloud',2,1,NULL);
/*!40000 ALTER TABLE `oc_storages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_systemtag`
--

DROP TABLE IF EXISTS `oc_systemtag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_systemtag` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `visibility` smallint(6) NOT NULL DEFAULT '1',
  `editable` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag_ident` (`name`,`visibility`,`editable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_systemtag`
--

LOCK TABLES `oc_systemtag` WRITE;
/*!40000 ALTER TABLE `oc_systemtag` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_systemtag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_systemtag_group`
--

DROP TABLE IF EXISTS `oc_systemtag_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_systemtag_group` (
  `systemtagid` int(10) unsigned NOT NULL DEFAULT '0',
  `gid` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`gid`,`systemtagid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_systemtag_group`
--

LOCK TABLES `oc_systemtag_group` WRITE;
/*!40000 ALTER TABLE `oc_systemtag_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_systemtag_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_systemtag_object_mapping`
--

DROP TABLE IF EXISTS `oc_systemtag_object_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_systemtag_object_mapping` (
  `objectid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `objecttype` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `systemtagid` int(10) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `mapping` (`objecttype`,`objectid`,`systemtagid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_systemtag_object_mapping`
--

LOCK TABLES `oc_systemtag_object_mapping` WRITE;
/*!40000 ALTER TABLE `oc_systemtag_object_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_systemtag_object_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_trusted_servers`
--

DROP TABLE IF EXISTS `oc_trusted_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_trusted_servers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(512) COLLATE utf8_bin NOT NULL COMMENT 'Url of trusted server',
  `url_hash` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'sha1 hash of the url without the protocol',
  `token` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT 'token used to exchange the shared secret',
  `shared_secret` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT 'shared secret used to authenticate',
  `status` int(11) NOT NULL DEFAULT '2' COMMENT 'current status of the connection',
  `sync_token` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT 'cardDav sync token',
  PRIMARY KEY (`id`),
  UNIQUE KEY `url_hash` (`url_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_trusted_servers`
--

LOCK TABLES `oc_trusted_servers` WRITE;
/*!40000 ALTER TABLE `oc_trusted_servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_trusted_servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_twofactor_backupcodes`
--

DROP TABLE IF EXISTS `oc_twofactor_backupcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_twofactor_backupcodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `code` varchar(64) COLLATE utf8_bin NOT NULL,
  `used` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `twofactor_backupcodes_uid` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_twofactor_backupcodes`
--

LOCK TABLES `oc_twofactor_backupcodes` WRITE;
/*!40000 ALTER TABLE `oc_twofactor_backupcodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_twofactor_backupcodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_users`
--

DROP TABLE IF EXISTS `oc_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_users` (
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `displayname` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_users`
--

LOCK TABLES `oc_users` WRITE;
/*!40000 ALTER TABLE `oc_users` DISABLE KEYS */;
INSERT INTO `oc_users` VALUES ('nextcloud','Nextcloud Admin','1|$2y$10$loCSOKrWG.CYk9pQsWPXL.thll3Dgy0x.GutbsvtI9mnekDprf.vy');
/*!40000 ALTER TABLE `oc_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_users_external`
--

DROP TABLE IF EXISTS `oc_users_external`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_users_external` (
  `backend` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `displayname` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`uid`,`backend`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_users_external`
--

LOCK TABLES `oc_users_external` WRITE;
/*!40000 ALTER TABLE `oc_users_external` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_users_external` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_vcategory`
--

DROP TABLE IF EXISTS `oc_vcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_vcategory` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `category` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `uid_index` (`uid`),
  KEY `type_index` (`type`),
  KEY `category_index` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_vcategory`
--

LOCK TABLES `oc_vcategory` WRITE;
/*!40000 ALTER TABLE `oc_vcategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_vcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oc_vcategory_to_object`
--

DROP TABLE IF EXISTS `oc_vcategory_to_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oc_vcategory_to_object` (
  `objid` int(10) unsigned NOT NULL DEFAULT '0',
  `categoryid` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`categoryid`,`objid`,`type`),
  KEY `vcategory_objectd_index` (`objid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_vcategory_to_object`
--

LOCK TABLES `oc_vcategory_to_object` WRITE;
/*!40000 ALTER TABLE `oc_vcategory_to_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `oc_vcategory_to_object` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-17 17:16:53
