-- MySQL dump 10.16  Distrib 10.1.23-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: nextcloud
-- ------------------------------------------------------
-- Server version	10.1.23-MariaDB-9+deb9u1

use nextcloud;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_activity`
--

LOCK TABLES `oc_activity` WRITE;
/*!40000 ALTER TABLE `oc_activity` DISABLE KEYS */;
INSERT INTO `oc_activity` VALUES (1,1502451809,30,'file_deleted','nextcloudadmin','nextcloudadmin','files','deleted_self','[{\"13\":\"\\/Nextcloud Manual.pdf\"}]','','[]','/Nextcloud Manual.pdf','http://live.technomail.in/nextcloud/index.php/apps/files/?dir=/','files',13),(2,1502451809,30,'file_deleted','nextcloudadmin','nextcloudadmin','files','deleted_self','[{\"8\":\"\\/Nextcloud.mp4\"}]','','[]','/Nextcloud.mp4','http://live.technomail.in/nextcloud/index.php/apps/files/?dir=/','files',8),(3,1502451822,30,'file_deleted','nextcloudadmin','nextcloudadmin','files','deleted_self','[{\"15\":\"\\/Documents\\/About.txt\"}]','','[]','/Documents/About.txt','http://live.technomail.in/nextcloud/index.php/apps/files/?dir=/Documents','files',15),(4,1502451822,30,'file_deleted','nextcloudadmin','nextcloudadmin','files','deleted_self','[{\"16\":\"\\/Documents\\/About.odt\"}]','','[]','/Documents/About.odt','http://live.technomail.in/nextcloud/index.php/apps/files/?dir=/Documents','files',16),(5,1502451835,30,'file_deleted','nextcloudadmin','nextcloudadmin','files','deleted_self','[{\"10\":\"\\/Photos\\/Coast.jpg\"}]','','[]','/Photos/Coast.jpg','http://live.technomail.in/nextcloud/index.php/apps/files/?dir=/Photos','files',10),(6,1502451835,30,'file_deleted','nextcloudadmin','nextcloudadmin','files','deleted_self','[{\"12\":\"\\/Photos\\/Nut.jpg\"}]','','[]','/Photos/Nut.jpg','http://live.technomail.in/nextcloud/index.php/apps/files/?dir=/Photos','files',12),(7,1502451835,30,'file_deleted','nextcloudadmin','nextcloudadmin','files','deleted_self','[{\"11\":\"\\/Photos\\/Hummingbird.jpg\"}]','','[]','/Photos/Hummingbird.jpg','http://live.technomail.in/nextcloud/index.php/apps/files/?dir=/Photos','files',11);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_addressbookchanges`
--

LOCK TABLES `oc_addressbookchanges` WRITE;
/*!40000 ALTER TABLE `oc_addressbookchanges` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_addressbooks`
--

LOCK TABLES `oc_addressbooks` WRITE;
/*!40000 ALTER TABLE `oc_addressbooks` DISABLE KEYS */;
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
INSERT INTO `oc_admin_sections` VALUES ('activity','OCA\\Activity\\Settings\\Section',55),('logging','OCA\\LogReader\\Settings\\Section',90),('serverinfo','OCA\\ServerInfo\\Settings\\AdminSection',0),('survey_client','OCA\\Survey_Client\\Settings\\AdminSection',80),('theming','OCA\\Theming\\Settings\\Section',30),('workflow','OCA\\WorkflowEngine\\Settings\\Section',55);
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
INSERT INTO `oc_admin_settings` VALUES (1,'OCA\\LogReader\\Settings\\Admin','logging',90),(2,'OCA\\Theming\\Settings\\Admin','theming',5),(3,'OCA\\ServerInfo\\Settings\\AdminSettings','serverinfo',0),(4,'OCA\\UpdateNotification\\Controller\\AdminController','server',1),(5,'OCA\\ShareByMail\\Settings\\Admin','sharing',40),(6,'OCA\\Files\\Settings\\Admin','additional',5),(7,'OCA\\Survey_Client\\Settings\\AdminSettings','survey_client',50),(8,'OCA\\NextcloudAnnouncements\\Settings\\Admin','additional',30),(9,'OCA\\SystemTags\\Settings\\Admin','workflow',70),(10,'OCA\\OAuth2\\Settings\\Admin','security',0),(11,'OCA\\Activity\\Settings\\Admin','activity',55),(12,'OCA\\FederatedFileSharing\\Settings\\Admin','sharing',20),(13,'OCA\\Federation\\Settings\\Admin','sharing',30),(14,'OCA\\Password_Policy\\Settings','security',50),(15,'OCA\\BruteForceSettings\\Settings\\IPWhitelist','security',50),(16,'OCA\\External\\Settings\\Admin','additional',55);
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
INSERT INTO `oc_appconfig` VALUES ('activity','enabled','yes'),('activity','installed_version','2.5.2'),('activity','types','filesystem'),('admin_notifications','enabled','yes'),('admin_notifications','installed_version','1.0.0'),('admin_notifications','types','logging'),('backgroundjob','lastjob','7'),('bruteforcesettings','enabled','yes'),('bruteforcesettings','installed_version','1.0.2'),('bruteforcesettings','types',''),('calendar','enabled','yes'),('calendar','installed_version','1.5.3'),('calendar','types',''),('comments','enabled','yes'),('comments','installed_version','1.2.0'),('comments','types','logging'),('contacts','enabled','yes'),('contacts','installed_version','1.5.3'),('contacts','types',''),('core','backgroundjobs_mode','cron'),('core','installed.bundles','[\"CoreBundle\"]'),('core','installedat','1502451515.9924'),('core','lastcron','1502452992'),('core','lastupdatedat','1502451516.0489'),('core','oc.integritycheck.checker','[]'),('core','public_files','files_sharing/public.php'),('core','public_webdav','dav/appinfo/v1/publicwebdav.php'),('core','scss.variables','4f934a62f0926c3e21b395e2613cd414'),('core','shareapi_allow_group_sharing','no'),('core','shareapi_allow_public_upload','no'),('core','shareapi_allow_resharing','no'),('core','shareapi_allow_share_dialog_user_enumeration','no'),('core','shareapi_default_expire_date','yes'),('core','vendor','nextcloud'),('dav','enabled','yes'),('dav','installed_version','1.3.0'),('dav','types','filesystem'),('external','enabled','yes'),('external','installed_version','2.0.3'),('external','types',''),('federatedfilesharing','enabled','yes'),('federatedfilesharing','installed_version','1.2.0'),('federatedfilesharing','types',''),('federation','enabled','yes'),('federation','installed_version','1.2.0'),('federation','types','authentication'),('files','cronjob_scan_files','500'),('files','enabled','yes'),('files','installed_version','1.7.2'),('files','types','filesystem'),('files_downloadactivity','enabled','yes'),('files_downloadactivity','installed_version','1.1.1'),('files_downloadactivity','types','filesystem'),('files_pdfviewer','enabled','yes'),('files_pdfviewer','installed_version','1.1.1'),('files_pdfviewer','ocsid','166049'),('files_pdfviewer','types',''),('files_sharing','enabled','yes'),('files_sharing','incoming_server2server_share_enabled','no'),('files_sharing','installed_version','1.4.0'),('files_sharing','lookupServerUploadEnabled','no'),('files_sharing','outgoing_server2server_share_enabled','no'),('files_sharing','types','filesystem'),('files_texteditor','enabled','yes'),('files_texteditor','installed_version','2.4.1'),('files_texteditor','ocsid','166051'),('files_texteditor','types',''),('files_trashbin','enabled','yes'),('files_trashbin','installed_version','1.2.0'),('files_trashbin','types','filesystem'),('files_versions','enabled','yes'),('files_versions','installed_version','1.5.0'),('files_versions','types','filesystem'),('files_videoplayer','enabled','yes'),('files_videoplayer','installed_version','1.1.0'),('files_videoplayer','types',''),('firstrunwizard','enabled','yes'),('firstrunwizard','installed_version','2.1'),('firstrunwizard','types','logging'),('gallery','enabled','yes'),('gallery','installed_version','17.0.0'),('gallery','types',''),('logreader','enabled','yes'),('logreader','installed_version','2.0.0'),('logreader','ocsid','170871'),('logreader','types',''),('lookup_server_connector','enabled','yes'),('lookup_server_connector','installed_version','1.0.0'),('lookup_server_connector','types','authentication'),('nextcloud_announcements','enabled','yes'),('nextcloud_announcements','installed_version','1.1'),('nextcloud_announcements','pub_date','Sat, 10 Dec 2016 00:00:00 +0100'),('nextcloud_announcements','types','logging'),('notes','enabled','yes'),('notes','installed_version','2.3.1'),('notes','types',''),('notifications','enabled','yes'),('notifications','installed_version','2.0.0'),('notifications','types','logging'),('oauth2','enabled','yes'),('oauth2','installed_version','1.0.5'),('oauth2','types','authentication'),('password_policy','enabled','yes'),('password_policy','installed_version','1.2.2'),('password_policy','types',''),('provisioning_api','enabled','yes'),('provisioning_api','installed_version','1.2.0'),('provisioning_api','types','prevent_group_restriction'),('quota_warning','enabled','yes'),('quota_warning','installed_version','1.0.1'),('quota_warning','types','filesystem'),('serverinfo','enabled','yes'),('serverinfo','installed_version','1.2.0'),('serverinfo','types',''),('sharebymail','enabled','yes'),('sharebymail','installed_version','1.2.0'),('sharebymail','types','filesystem'),('survey_client','enabled','yes'),('survey_client','installed_version','1.0.0'),('survey_client','types',''),('systemtags','enabled','yes'),('systemtags','installed_version','1.2.0'),('systemtags','types','logging'),('tasks','enabled','yes'),('tasks','installed_version','0.9.5'),('tasks','types',''),('theming','enabled','yes'),('theming','installed_version','1.3.0'),('theming','types','logging'),('twofactor_backupcodes','enabled','yes'),('twofactor_backupcodes','installed_version','1.1.1'),('twofactor_backupcodes','types',''),('updatenotification','enabled','yes'),('updatenotification','installed_version','1.2.0'),('updatenotification','types',''),('user_external','enabled','yes'),('user_external','installed_version','0.4'),('user_external','types','authentication,prelogin'),('workflowengine','enabled','yes'),('workflowengine','installed_version','1.2.0'),('workflowengine','types','filesystem');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_bruteforce_attempts`
--

LOCK TABLES `oc_bruteforce_attempts` WRITE;
/*!40000 ALTER TABLE `oc_bruteforce_attempts` DISABLE KEYS */;
INSERT INTO `oc_bruteforce_attempts` VALUES (1,'login',1502452858,'120.61.5.95','120.61.5.95/32','[]'),(2,'login',1502452871,'120.61.5.95','120.61.5.95/32','[]');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_calendars`
--

LOCK TABLES `oc_calendars` WRITE;
/*!40000 ALTER TABLE `oc_calendars` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_cards`
--

LOCK TABLES `oc_cards` WRITE;
/*!40000 ALTER TABLE `oc_cards` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_cards_properties`
--

LOCK TABLES `oc_cards_properties` WRITE;
/*!40000 ALTER TABLE `oc_cards_properties` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_file_locks`
--

LOCK TABLES `oc_file_locks` WRITE;
/*!40000 ALTER TABLE `oc_file_locks` DISABLE KEYS */;
INSERT INTO `oc_file_locks` VALUES (1,0,'files/7867b2b51ee605cf644f3ad19f9300f7',1502455290),(2,0,'files/a808857af235cb35aaa65a94a4ecfb2e',1502455486),(3,0,'files/3d6c9e24a663fdd9b49ad3484a88bac3',1502455419),(4,0,'files/2e75f9517d2b4907f7f2a17d43ff5018',1502455415),(5,0,'files/c658f5c9b0933660f3db9f0271ae32a9',1502455415),(6,0,'files/65233bdf23b1e07b89a2c3c4a5bc72a1',1502455413),(7,0,'files/c9561223c4a1b5f7eb600f241121f9cb',1502455424),(8,0,'files/0c20abd0185b9ef46022aedc7d194bd0',1502455422),(9,0,'files/22010cc00856da3b0d67e44f6574c20d',1502455424),(10,0,'files/d73d41fdfeed38b29d47e3e2641ccfb2',1502455440),(11,0,'files/28e5116956ad34f71d54d1a1994cefd8',1502455440),(12,0,'files/f2e2ea3c8ee8683c20f924394f3856cd',1502455440),(13,0,'files/d18a5a28b561559a5207150726fbb4af',1502455435),(14,0,'files/b17acb41e6fbc2dc49caecdb09964ff6',1502455486);
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
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_filecache`
--

LOCK TABLES `oc_filecache` WRITE;
/*!40000 ALTER TABLE `oc_filecache` DISABLE KEYS */;
INSERT INTO `oc_filecache` VALUES (1,1,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,4240403,1502452538,1502451886,0,0,'598d9b3a56723',23,''),(2,1,'appdata_ocncwqyc84l2','8bf2536f0a785e64d86a8937e50f7db1',1,'appdata_ocncwqyc84l2',2,1,4240403,1502452538,1502451649,0,0,'598d9b3a56723',31,''),(3,1,'appdata_ocncwqyc84l2/appstore','f76c63c765ddea8a03e9ade531674828',2,'appstore',2,1,360921,1502452196,1502451884,0,0,'598d99e438e19',31,''),(4,1,'appdata_ocncwqyc84l2/appstore/apps.json','ed66c3294ea450840bd8a209add4013c',3,'apps.json',4,3,328389,1502452196,1502452196,0,0,'6f0d4219a44f4d1df98e4c6480a50bea',27,''),(5,1,'appdata_ocncwqyc84l2/preview','39ecceff66ccd4df1d09dfd04076dd70',2,'preview',2,1,1748620,1502451857,1502451851,0,0,'598d9891bec06',31,''),(6,2,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,0,1502452929,1502452929,0,0,'598d9cc1a93b2',23,''),(7,2,'files','45b963397aa40d4a0063e0d85e4fe7a1',6,'files',2,1,0,1502451839,1502451814,0,0,'598d987fbad81',31,''),(9,2,'files/Photos','d01bb67e7b71dd49fd06bad922f521c9',7,'Photos',2,1,0,1502451839,1502451836,0,0,'598d987fbad81',31,''),(14,2,'files/Documents','0ad78ba05b6961d92f7970b2b3922eca',7,'Documents',2,1,0,1502451824,1502451823,0,0,'598d9870bc402',31,''),(17,1,'appdata_ocncwqyc84l2/avatar','cfd3cb325d6108f13ec611e6b9bed8cc',2,'avatar',2,1,0,1502451585,1502451585,0,0,'598d9781a8e05',31,''),(18,1,'appdata_ocncwqyc84l2/avatar/nextcloudadmin','d13c77bbc2d5fcd55e3ac084894e9a00',17,'nextcloudadmin',2,1,0,1502451585,1502451585,0,0,'598d97819511b',31,''),(19,1,'appdata_ocncwqyc84l2/js','bd63ab9231accc89b1b74c6f835ea29f',2,'js',2,1,1991116,1502452536,1502451646,0,0,'598d9b3944a41',31,''),(20,1,'appdata_ocncwqyc84l2/js/core','2bad9bfc53fb0e7ec82d4c7f42567080',19,'core',2,1,346165,1502452536,1502452535,0,0,'598d9b3944a41',31,''),(21,1,'appdata_ocncwqyc84l2/js/core/merged-template-prepend.js','c896d93c48d8989d179063622e14acab',20,'merged-template-prepend.js',13,3,144020,1502451588,1502451588,0,0,'6ff825a8031ed2b45fd96b2a7395f32b',27,''),(22,1,'appdata_ocncwqyc84l2/js/core/merged-template-prepend.js.deps','4b3b5d0db74e6f1429c08aa0a9395382',20,'merged-template-prepend.js.deps',14,3,1222,1502451588,1502451588,0,0,'7805f5c7ece188f97820a41f4f4e7276',27,''),(23,1,'appdata_ocncwqyc84l2/js/core/merged-template-prepend.js.gzip','c38351f0e52508b274d2212aa65aa899',20,'merged-template-prepend.js.gzip',15,3,39517,1502451588,1502451588,0,0,'07c786e5b3d6af7081a33d4a69321519',27,''),(24,1,'appdata_ocncwqyc84l2/js/core/merged-share-backend.js','3d922dbcc6e63762be4af9437498a822',20,'merged-share-backend.js',13,3,104526,1502451592,1502451592,0,0,'a73583a7ce2ab73bfc84ee5d1a32c6ac',27,''),(25,1,'appdata_ocncwqyc84l2/js/core/merged-share-backend.js.deps','eb683b30b73f48a3e8d2f665efefa39e',20,'merged-share-backend.js.deps',14,3,752,1502451593,1502451593,0,0,'2c8c8a1effe321811a5b910ff37a671a',27,''),(26,1,'appdata_ocncwqyc84l2/js/core/merged-share-backend.js.gzip','a2cdbcd147dad8b2cc6ca29af83b8c02',20,'merged-share-backend.js.gzip',15,3,22504,1502451593,1502451593,0,0,'83f318ea144d147ee28f44c020fac613',27,''),(27,1,'appdata_ocncwqyc84l2/js/notifications','4f953c80aeadf722a6240be4884cf677',19,'notifications',2,1,25923,1502451595,1502451594,0,0,'598d978b5d393',31,''),(28,1,'appdata_ocncwqyc84l2/js/notifications/merged.js','515dd6e702f1e5157953465a19d8c09f',27,'merged.js',13,3,20454,1502451594,1502451594,0,0,'348af092471378489b80bcecd12321f4',27,''),(29,1,'appdata_ocncwqyc84l2/js/notifications/merged.js.deps','91ba8dd4094cfdee12d8b2902e8a8af6',27,'merged.js.deps',14,3,330,1502451595,1502451595,0,0,'fa587608ef587811032aa1631faa1e15',27,''),(30,1,'appdata_ocncwqyc84l2/js/notifications/merged.js.gzip','1f51ab541090dee8fa1d80a9ee51ab97',27,'merged.js.gzip',15,3,5139,1502451595,1502451595,0,0,'259d2bf47a83f816eb02f319c18f4f42',27,''),(31,1,'appdata_ocncwqyc84l2/js/files','c872bc07981b02a84875819349d74985',19,'files',2,1,399537,1502451600,1502451599,0,0,'598d979097f08',31,''),(32,1,'appdata_ocncwqyc84l2/js/files/merged-index.js','c9941b99edc31318cbedda73d74579b5',31,'merged-index.js',13,3,320876,1502451600,1502451600,0,0,'244d00a626bb0c76aafcd2c71fe53c5c',27,''),(33,1,'appdata_ocncwqyc84l2/js/files/merged-index.js.deps','c13f0e4a92372c9c2dfeece53424078f',31,'merged-index.js.deps',14,3,2125,1502451600,1502451600,0,0,'04441294ff034ca191484aed5f6b9cab',27,''),(34,1,'appdata_ocncwqyc84l2/js/files/merged-index.js.gzip','3ea18d38ef7ff2d9b846a3c487b8dba2',31,'merged-index.js.gzip',15,3,76536,1502451600,1502451600,0,0,'18e6a9a60302367b8792f7b81b45d3ee',27,''),(35,1,'appdata_ocncwqyc84l2/js/activity','0b31a6747f56f0f4d40df3fce5d1ee2a',19,'activity',2,1,20399,1502451610,1502451603,0,0,'598d979a549bc',31,''),(36,1,'appdata_ocncwqyc84l2/js/activity/activity-sidebar.js','a789d703f37525fc4cb1ef89f552e979',35,'activity-sidebar.js',13,3,15755,1502451603,1502451603,0,0,'424a9d9d8e3de7f69b8a89337075e767',27,''),(37,1,'appdata_ocncwqyc84l2/js/activity/activity-sidebar.js.deps','b8db835df98398cfb2d2c8a4448e077f',35,'activity-sidebar.js.deps',14,3,494,1502451605,1502451605,0,0,'85c66636651c073c914bee90f9f400d5',27,''),(38,1,'appdata_ocncwqyc84l2/js/activity/activity-sidebar.js.gzip','872be412e0c2e4b2afcf23b6fcc4226a',35,'activity-sidebar.js.gzip',15,3,4150,1502451610,1502451610,0,0,'ca558c4262b5f32f5ada3f8f37991a4f',27,''),(39,1,'appdata_ocncwqyc84l2/js/comments','25c1acbf870070c870888abd116b7cf9',19,'comments',2,1,36996,1502451616,1502451616,0,0,'598d97a0e8754',31,''),(40,1,'appdata_ocncwqyc84l2/js/comments/merged.js','b6904996a064469f8de3963d0bca9d59',39,'merged.js',13,3,28929,1502451616,1502451616,0,0,'44daafeb5186ab0d82ee6063ebc9dd9f',27,''),(41,1,'appdata_ocncwqyc84l2/js/comments/merged.js.deps','b13a80567e23632c61520b60e1e907e3',39,'merged.js.deps',14,3,635,1502451616,1502451616,0,0,'d80e03bc5ea224d0adcea4636b05f89d',27,''),(42,1,'appdata_ocncwqyc84l2/js/comments/merged.js.gzip','97b0cba871595dd1577821eab3aef257',39,'merged.js.gzip',15,3,7432,1502451616,1502451616,0,0,'fe43d4631138af2d5251bca2ff26c2a9',27,''),(43,1,'appdata_ocncwqyc84l2/js/files_sharing','3a89344d5be1e4846614f43ce9e1f041',19,'files_sharing',2,1,20226,1502451622,1502451618,0,0,'598d97a645f97',31,''),(44,1,'appdata_ocncwqyc84l2/js/files_sharing/additionalScripts.js','72dd35e61747e7a70075de2f6240f4c8',43,'additionalScripts.js',13,3,15161,1502451621,1502451621,0,0,'1ca03e08240e5d0a818b6ba152ad401c',27,''),(45,1,'appdata_ocncwqyc84l2/js/files_sharing/additionalScripts.js.deps','e87f1bd6433c8026cacd939af1810c8c',43,'additionalScripts.js.deps',14,3,340,1502451621,1502451621,0,0,'e4ec4247ef02e4a136b3be93d179e435',27,''),(46,1,'appdata_ocncwqyc84l2/js/files_sharing/additionalScripts.js.gzip','88cdf3ea6ca38ced3498b3a9dfb4693a',43,'additionalScripts.js.gzip',15,3,4725,1502451622,1502451622,0,0,'94e531f28a3c7f3f0dc676220f191d85',27,''),(47,1,'appdata_ocncwqyc84l2/js/files_texteditor','88d241da7f373972eeffe48cd89a7c5e',19,'files_texteditor',2,1,820413,1502451624,1502451623,0,0,'598d97a84bed9',31,''),(48,1,'appdata_ocncwqyc84l2/js/files_texteditor/merged.js','37d7d7f9493d1b1296489d30fca98f99',47,'merged.js',13,3,682245,1502451623,1502451623,0,0,'17926d2e4c784aaf4bea2b4964539beb',27,''),(49,1,'appdata_ocncwqyc84l2/js/files_texteditor/merged.js.deps','c99d31a7727c70f7968821cecbc5a048',47,'merged.js.deps',14,3,370,1502451623,1502451623,0,0,'17c2ee25087810c054555aefe08532bf',27,''),(50,1,'appdata_ocncwqyc84l2/js/files_texteditor/merged.js.gzip','ba332a6934cf514da4aa16ba460a588c',47,'merged.js.gzip',15,3,137798,1502451624,1502451624,0,0,'0015f2f725e8a3aae3846df54d3440fb',27,''),(51,1,'appdata_ocncwqyc84l2/js/files_versions','ad51333a21ac04a82eb13f6d49f6c582',19,'files_versions',2,1,16725,1502451625,1502451625,0,0,'598d97a9e99e4',31,''),(52,1,'appdata_ocncwqyc84l2/js/files_versions/merged.js','23285c55c1685b9cda4a2806a773049d',51,'merged.js',13,3,12719,1502451625,1502451625,0,0,'3f63f53e2721d2ba7e8a59cb20134ce8',27,''),(53,1,'appdata_ocncwqyc84l2/js/files_versions/merged.js.deps','8c476bf13c4367611b553221dc552b27',51,'merged.js.deps',14,3,424,1502451625,1502451625,0,0,'976dedfc2c05c9167aaf6eba122139df',27,''),(54,1,'appdata_ocncwqyc84l2/js/files_versions/merged.js.gzip','ab08162c6361fbbee4d2c2e14587c9f5',51,'merged.js.gzip',15,3,3582,1502451625,1502451625,0,0,'4443eec9715868c0e11725c5e21dd650',27,''),(55,1,'appdata_ocncwqyc84l2/js/gallery','3f7a755757d2390e61983097063abc6b',19,'gallery',2,1,280769,1502451642,1502451639,0,0,'598d97bce2af6',31,''),(56,1,'appdata_ocncwqyc84l2/js/gallery/scripts-for-file-app.js','417e668c9ebe4e318726e7ae1ec62f8f',55,'scripts-for-file-app.js',13,3,225479,1502451640,1502451640,0,0,'4f74b2e50c21b4860c91a7f2ca557394',27,''),(57,1,'appdata_ocncwqyc84l2/js/gallery/scripts-for-file-app.js.deps','465af32ad16acb09ad0884464eff5086',55,'scripts-for-file-app.js.deps',14,3,856,1502451640,1502451640,0,0,'2f3902840374179b08b855dfab364f31',27,''),(58,1,'appdata_ocncwqyc84l2/js/gallery/scripts-for-file-app.js.gzip','610529c692d96276295b00913c713257',55,'scripts-for-file-app.js.gzip',15,3,54434,1502451642,1502451642,0,0,'359904f2dc830005e2531936c638bad5',27,''),(59,1,'appdata_ocncwqyc84l2/js/core/merged.js','ee6f4c080922fbf6368d95627c7ce4ea',20,'merged.js',13,3,20224,1502451645,1502451645,0,0,'8f3e1d5b348fa8a8efc42efe394d2be5',27,''),(60,1,'appdata_ocncwqyc84l2/js/core/merged.js.deps','a53371619f8c897f4910f2d2e8e6c772',20,'merged.js.deps',14,3,508,1502451646,1502451646,0,0,'c46a8f8944ceee8b7f860691c4317173',27,''),(61,1,'appdata_ocncwqyc84l2/js/core/merged.js.gzip','332cef3b58c96c8db00b7475b489cc09',20,'merged.js.gzip',15,3,5365,1502451646,1502451646,0,0,'5ffd73426d84c0f994ee44c688fd9b74',27,''),(62,1,'appdata_ocncwqyc84l2/js/systemtags','859798a32912e0eb5efeaca7d452126d',19,'systemtags',2,1,23963,1502451649,1502451647,0,0,'598d97c150035',31,''),(63,1,'appdata_ocncwqyc84l2/js/systemtags/merged.js','1dc466cd631548f6c840cb969bf86c97',62,'merged.js',13,3,18161,1502451648,1502451648,0,0,'20e563d47e18529e3fbbbb863046f1ab',27,''),(64,1,'appdata_ocncwqyc84l2/js/systemtags/merged.js.deps','0f31d012f82274aef5cedc0b2d12c21d',62,'merged.js.deps',14,3,495,1502451649,1502451649,0,0,'445d9941295e0da850bd811471bcd1af',27,''),(65,1,'appdata_ocncwqyc84l2/js/systemtags/merged.js.gzip','e4b4ad21cb464dc2a5bba270cf309f5c',62,'merged.js.gzip',15,3,5307,1502451649,1502451649,0,0,'827a70f8a7dfad5665100e33ae4b8ba1',27,''),(66,1,'appdata_ocncwqyc84l2/css','b141c4d23734bbffa2dbadc9c6ad3da9',2,'css',2,1,133620,1502451689,1502451673,0,0,'598d97ea04a87',31,''),(67,1,'appdata_ocncwqyc84l2/css/core','71588e1120caf1019a22dfd456a02b00',66,'core',2,1,97497,1502451672,1502451671,0,0,'598d97d8847d2',31,''),(68,1,'appdata_ocncwqyc84l2/theming','29655d50d6c07666d4421102a5da3930',2,'theming',2,1,6126,1502452538,1502451673,0,0,'598d9b3a56723',31,''),(69,1,'appdata_ocncwqyc84l2/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-server.css','a3d551bbfdbc81494ae25352358a1841',67,'f1727c5f3e441ef9cb6fa766743ef4fc-server.css',16,10,77320,1502451652,1502451652,0,0,'0f451e9fc7fbdb54baab69e1fa5b4239',27,''),(70,1,'appdata_ocncwqyc84l2/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-server.css.deps','fc916effdbcae9ff31ed55fdb0c3ba3a',67,'f1727c5f3e441ef9cb6fa766743ef4fc-server.css.deps',14,3,850,1502451652,1502451652,0,0,'46cabd0a1280ff0ee3c6b59876633875',27,''),(71,1,'appdata_ocncwqyc84l2/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-server.css.gzip','e3d381baad4b1c709a5376a33cc7b141',67,'f1727c5f3e441ef9cb6fa766743ef4fc-server.css.gzip',15,3,13410,1502451652,1502451652,0,0,'8b4b88d90e779a087be90df970d5d6e7',27,''),(72,1,'appdata_ocncwqyc84l2/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-share.css','04c67e12a8b8c421506ffc3a77d694e4',67,'f1727c5f3e441ef9cb6fa766743ef4fc-share.css',16,10,2848,1502451655,1502451655,0,0,'eb622bf3e05a48dfa0fb002c01df52eb',27,''),(73,1,'appdata_ocncwqyc84l2/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-share.css.deps','17fa60bda8e83f7dc69aed04d49af8bd',67,'f1727c5f3e441ef9cb6fa766743ef4fc-share.css.deps',14,3,133,1502451655,1502451655,0,0,'b6acd15e6fdbea15b671a36190973c30',27,''),(74,1,'appdata_ocncwqyc84l2/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-share.css.gzip','455488389620bc35a395b7922f85a442',67,'f1727c5f3e441ef9cb6fa766743ef4fc-share.css.gzip',15,3,994,1502451655,1502451655,0,0,'c8f01da3fc1afbc79a4768e9181cb749',27,''),(75,1,'appdata_ocncwqyc84l2/css/files','4884e164a2cd691df2c10e72a29ed469',66,'files',2,1,25566,1502451664,1502451662,0,0,'598d97d064c20',31,''),(76,1,'appdata_ocncwqyc84l2/css/files/f1727c5f3e441ef9cb6fa766743ef4fc-merged.css','fbef59ed38b72b732f60159c757a0082',75,'f1727c5f3e441ef9cb6fa766743ef4fc-merged.css',16,10,20713,1502451663,1502451663,0,0,'4b150a58a67583604e61db3d79234cb6',27,''),(77,1,'appdata_ocncwqyc84l2/css/files/f1727c5f3e441ef9cb6fa766743ef4fc-merged.css.deps','f43ac3b6b4da0f7205c2b20ee92f19d5',75,'f1727c5f3e441ef9cb6fa766743ef4fc-merged.css.deps',14,3,433,1502451664,1502451664,0,0,'94637a6fae9cb4a24dfcdc61e92112b7',27,''),(78,1,'appdata_ocncwqyc84l2/css/files/f1727c5f3e441ef9cb6fa766743ef4fc-merged.css.gzip','50379788afb203579a7acbc529df2e4f',75,'f1727c5f3e441ef9cb6fa766743ef4fc-merged.css.gzip',15,3,4420,1502451664,1502451664,0,0,'c791e45c6c1e74f9d34cc83f40d3d03c',27,''),(79,1,'appdata_ocncwqyc84l2/css/files_sharing','769257873e35b92ba11dc97d557808ff',66,'files_sharing',2,1,3945,1502451667,1502451666,0,0,'598d97d35e27b',31,''),(80,1,'appdata_ocncwqyc84l2/css/files_sharing/f1727c5f3e441ef9cb6fa766743ef4fc-mergedAdditionalStyles.css','2fdb63e630297021177570a95fd96161',79,'f1727c5f3e441ef9cb6fa766743ef4fc-mergedAdditionalStyles.css',16,10,2727,1502451667,1502451667,0,0,'faf1a49235792c1882c065b582784ca2',27,''),(81,1,'appdata_ocncwqyc84l2/css/files_sharing/f1727c5f3e441ef9cb6fa766743ef4fc-mergedAdditionalStyles.css.deps','572a09787bb8b83224ddaf5aabb0e3c1',79,'f1727c5f3e441ef9cb6fa766743ef4fc-mergedAdditionalStyles.css.deps',14,3,340,1502451667,1502451667,0,0,'0b64198f316eeacfe32cc3be26deb5bb',27,''),(82,1,'appdata_ocncwqyc84l2/css/files_sharing/f1727c5f3e441ef9cb6fa766743ef4fc-mergedAdditionalStyles.css.gzip','f75d9c44832e713245c59565159f0ec3',79,'f1727c5f3e441ef9cb6fa766743ef4fc-mergedAdditionalStyles.css.gzip',15,3,878,1502451667,1502451667,0,0,'6755458e1634fd599a50829de1f1fce2',27,''),(83,1,'appdata_ocncwqyc84l2/css/files_texteditor','47f16770dd6d5b7e1fd0dc15530ad4c2',66,'files_texteditor',2,1,5377,1502451669,1502451668,0,0,'598d97d614294',31,''),(84,1,'appdata_ocncwqyc84l2/css/files_texteditor/f1727c5f3e441ef9cb6fa766743ef4fc-merged.css','1822e15aa9dc956788c4283a1113895e',83,'f1727c5f3e441ef9cb6fa766743ef4fc-merged.css',16,10,3774,1502451668,1502451668,0,0,'4db86f5f902c0081c17fac339388f45c',27,''),(85,1,'appdata_ocncwqyc84l2/css/files_texteditor/f1727c5f3e441ef9cb6fa766743ef4fc-merged.css.deps','3e2cd8540a5bcb99cb48f423d8ac2057',83,'f1727c5f3e441ef9cb6fa766743ef4fc-merged.css.deps',14,3,419,1502451669,1502451669,0,0,'e08f5c41136fbb1267ce3393164798de',27,''),(86,1,'appdata_ocncwqyc84l2/css/files_texteditor/f1727c5f3e441ef9cb6fa766743ef4fc-merged.css.gzip','fbf840cc670d993a77be27b9aab888a1',83,'f1727c5f3e441ef9cb6fa766743ef4fc-merged.css.gzip',15,3,1184,1502451669,1502451669,0,0,'41892d6f373c4c27d0a1f2c8c4f4c2cd',27,''),(87,1,'appdata_ocncwqyc84l2/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-systemtags.css','1e2ea204340acf22b8c9a93037e82dbb',67,'f1727c5f3e441ef9cb6fa766743ef4fc-systemtags.css',16,10,1415,1502451671,1502451671,0,0,'27e869a57899699130366fb7485432c2',27,''),(88,1,'appdata_ocncwqyc84l2/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-systemtags.css.deps','cdbc85a0bfad39eb330e6cac2c8ee505',67,'f1727c5f3e441ef9cb6fa766743ef4fc-systemtags.css.deps',14,3,138,1502451672,1502451672,0,0,'6c8e0014be1d5827f25dc5883a8ba7bc',27,''),(89,1,'appdata_ocncwqyc84l2/css/core/f1727c5f3e441ef9cb6fa766743ef4fc-systemtags.css.gzip','d34fe3dc39f5e5cd87224184b73a85d8',67,'f1727c5f3e441ef9cb6fa766743ef4fc-systemtags.css.gzip',15,3,389,1502451672,1502451672,0,0,'dfcc22f48a5f83532e77eadcafbc550e',27,''),(90,1,'appdata_ocncwqyc84l2/css/theming','ce679babbefe64ab098f669a1354c784',66,'theming',2,1,1235,1502451689,1502451682,0,0,'598d97ea04a87',31,''),(91,1,'appdata_ocncwqyc84l2/theming/0','ba9efdc46230de0fa5ff67cef02b6580',68,'0',2,1,6126,1502452538,1502452538,0,0,'598d9b3a56723',31,''),(92,1,'appdata_ocncwqyc84l2/css/theming/f1727c5f3e441ef9cb6fa766743ef4fc-theming.css','90baa789f17af8427aec0a8d975ceffa',90,'f1727c5f3e441ef9cb6fa766743ef4fc-theming.css',16,10,780,1502451684,1502451684,0,0,'3cace31f95f6f61f3aef5af5d624a582',27,''),(93,1,'appdata_ocncwqyc84l2/css/theming/f1727c5f3e441ef9cb6fa766743ef4fc-theming.css.deps','a554eb69b33ce2c4b40ae3b7478cf7fc',90,'f1727c5f3e441ef9cb6fa766743ef4fc-theming.css.deps',14,3,144,1502451684,1502451684,0,0,'060bde5a6eaa438abd6efda9f3ffd8b8',27,''),(94,1,'appdata_ocncwqyc84l2/theming/0/favIcon-files','36a364a5a35c0fa4db7ef82b749df4a2',91,'favIcon-files',14,3,505,1502451682,1502451682,0,0,'8c5b6404f5bc6bf26e9d08cd6d4ae0c9',27,''),(95,1,'appdata_ocncwqyc84l2/css/theming/f1727c5f3e441ef9cb6fa766743ef4fc-theming.css.gzip','8007693512188d5cdd269a2c035eeee2',90,'f1727c5f3e441ef9cb6fa766743ef4fc-theming.css.gzip',15,3,311,1502451689,1502451689,0,0,'0ce072fe54850dfc32b6d5f651b2962e',27,''),(96,1,'appdata_ocncwqyc84l2/theming/0/icon-core-filetypes_video.svg','8a904cb48541d8db4316f1b8a2f9c504',91,'icon-core-filetypes_video.svg',17,7,328,1502451695,1502451695,0,0,'fff2efe6d90c08280be6b1288a270bdf',27,''),(97,1,'appdata_ocncwqyc84l2/theming/0/icon-core-filetypes_folder.svg','317d989a260ad2c055881845cfd9a0fa',91,'icon-core-filetypes_folder.svg',17,7,254,1502451693,1502451693,0,0,'c41a758f8b6222bae263624e0208aa9f',27,''),(98,1,'appdata_ocncwqyc84l2/theming/0/icon-core-filetypes_application-pdf.svg','fd2c1d7ae3fd6decb813d12b05c29607',91,'icon-core-filetypes_application-pdf.svg',17,7,1535,1502451693,1502451693,0,0,'649156b1fa9cc7bb381e3ffa835f6aa7',27,''),(104,1,'appdata_ocncwqyc84l2/theming/0/icon-core-filetypes_x-office-document.svg','7ff82e950cef565408efaa12c2fb1a16',91,'icon-core-filetypes_x-office-document.svg',17,7,419,1502451819,1502451819,0,0,'65836b87b1af1176284d6071635c46ac',27,''),(105,1,'appdata_ocncwqyc84l2/theming/0/icon-core-filetypes_text.svg','2f550bc8610c7ef3cca6186d1f1e7161',91,'icon-core-filetypes_text.svg',17,7,419,1502451819,1502451819,0,0,'8e8d013e778d62bf3e31415831baf3af',27,''),(110,1,'appdata_ocncwqyc84l2/theming/0/icon-core-filetypes_image.svg','7a57946606a5e5a193f3cde06c752178',91,'icon-core-filetypes_image.svg',17,7,376,1502451832,1502451832,0,0,'938759827933dc4307cdf36d0eee4687',27,''),(118,1,'appdata_ocncwqyc84l2/preview/11','7b315660760ff4be9c6c4a8f149c5d12',5,'11',2,1,574268,1502451857,1502451854,0,0,'598d98919266f',31,''),(119,1,'appdata_ocncwqyc84l2/preview/12','e1a8546b2f74e27a2ce6cd7206c02c3f',5,'12',2,1,792166,1502451857,1502451854,0,0,'598d98919267b',31,''),(120,1,'appdata_ocncwqyc84l2/preview/10','3af991550e3c780ae1d628a8b624a1a2',5,'10',2,1,310893,1502451857,1502451854,0,0,'598d98917af23',31,''),(121,1,'appdata_ocncwqyc84l2/preview/15','117d9e7b127335ad93b6149a18ff83f1',5,'15',2,1,71293,1502451857,1502451857,0,0,'598d9891bec06',31,''),(122,1,'appdata_ocncwqyc84l2/preview/11/2000-1333-max.png','1d2a842b3a8d3e5723ab77767677a116',118,'2000-1333-max.png',20,7,570843,1502451852,1502451852,0,0,'99d39493936cc722c4b1cd1d3c96e0b0',27,''),(123,1,'appdata_ocncwqyc84l2/preview/12/2000-1333-max.png','b8606140d4d339e6e7459773b4400642',119,'2000-1333-max.png',20,7,789237,1502451852,1502451852,0,0,'e9f380f239b4413f77f6e2d43a33f8cf',27,''),(124,1,'appdata_ocncwqyc84l2/preview/10/1100-734-max.png','0a48a2a20d25da6101a8a7da70503878',120,'1100-734-max.png',20,7,308351,1502451852,1502451852,0,0,'8aaa7feaf71420b12c7a75337a442f33',27,''),(125,1,'appdata_ocncwqyc84l2/preview/15/2048-2048-max.png','6bfec4d1eaf5ddb015acc41931883b48',121,'2048-2048-max.png',20,7,66449,1502451856,1502451856,0,0,'4c8f7576c108906d249793ad78e50342',27,''),(126,1,'appdata_ocncwqyc84l2/preview/10/64-64-crop.png','920d3b22ad4f450993e60e6691e003bf',120,'64-64-crop.png',20,7,2542,1502451857,1502451857,0,0,'90878041420599d7d71adeb74666b57b',27,''),(127,1,'appdata_ocncwqyc84l2/preview/12/64-64-crop.png','f7fef9c9dab5a9771404fd679539f12a',119,'64-64-crop.png',20,7,2929,1502451857,1502451857,0,0,'5fb6731edf5bcaeed42b4110993c03d9',27,''),(128,1,'appdata_ocncwqyc84l2/preview/11/64-64-crop.png','8f4e8b091edb9982a4f013a3a7037c2d',118,'64-64-crop.png',20,7,3425,1502451857,1502451857,0,0,'7057d59e8d23006cee5a1d2463373581',27,''),(129,1,'appdata_ocncwqyc84l2/preview/15/64-64-crop.png','68b298fad6f5f4cb3d22935c376a1798',121,'64-64-crop.png',20,7,4844,1502451857,1502451857,0,0,'5ee199cb92e3e15492fe56d0d4f27c2e',27,''),(130,2,'files_trashbin','fb66dca5f27af6f15c1d1d81e6f8d28b',6,'files_trashbin',2,1,0,1502451857,1502451857,0,0,'598d9892093d0',31,''),(131,2,'files_trashbin/files','3014a771cbe30761f2e9ff3272110dbf',130,'files',2,1,0,1502451857,1502451857,0,0,'598d9891c79a7',31,''),(132,1,'appdata_ocncwqyc84l2/theming/0/favIcon-settings','519a1a00dfa000fcd1b8482b3f52bcf5',91,'favIcon-settings',14,3,1145,1502451881,1502451881,0,0,'9ed1e507780752d452b43942988d34d5',27,''),(133,1,'appdata_ocncwqyc84l2/appstore/categories.json','d6dca5999332262de96ca9082e329599',3,'categories.json',4,3,32532,1502451888,1502451888,0,0,'d28b7c86d7476c47e622f401cd9153c3',27,''),(134,1,'files_external','c270928b685e7946199afdfb898d27ea',1,'files_external',2,1,0,1502451886,1502451886,0,0,'598d98af1d0d2',31,''),(135,1,'appdata_ocncwqyc84l2/js/core/merged-login.js','dded1b7e1b2cd447599d985faa0b2385',20,'merged-login.js',13,3,5389,1502452536,1502452536,0,0,'f856603b1d8ae1b173f26b3eda2c1422',27,''),(136,1,'appdata_ocncwqyc84l2/js/core/merged-login.js.deps','38cab451c142373c3716eff1a8215bf8',20,'merged-login.js.deps',14,3,271,1502452536,1502452536,0,0,'e4afad768117fbd2f602b3cc86e595dc',27,''),(137,1,'appdata_ocncwqyc84l2/js/core/merged-login.js.gzip','dd52b941cf8462405c1b67f555b014b6',20,'merged-login.js.gzip',15,3,1867,1502452536,1502452536,0,0,'3e9309c17fbe1e193c2c5355ffdc7bd8',27,''),(138,1,'appdata_ocncwqyc84l2/theming/0/favIcon-core','728b84e33d88d8c411083d1ca46b6433',91,'favIcon-core',14,3,1145,1502452538,1502452538,0,0,'1e031f1871929c4a401f685b083839a9',27,''),(139,2,'cache','0fea6a13c52b4d4725368f24b045ca84',6,'cache',2,1,0,1502452929,1502452929,0,0,'598d9cc18e0f4',31,'');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
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
INSERT INTO `oc_group_user` VALUES ('admin','nextcloudadmin');
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_jobs`
--

LOCK TABLES `oc_jobs` WRITE;
/*!40000 ALTER TABLE `oc_jobs` DISABLE KEYS */;
INSERT INTO `oc_jobs` VALUES (1,'OCA\\UpdateNotification\\Notification\\BackgroundJob','null',1502451690,1502451690,0,0),(2,'OCA\\Files\\BackgroundJob\\ScanFiles','null',1502451886,1502451884,0,0),(3,'OCA\\Files\\BackgroundJob\\DeleteOrphanedItems','null',1502452540,1502452540,0,0),(4,'OCA\\Files\\BackgroundJob\\CleanupFileLocks','null',1502452862,1502452861,0,0),(6,'OCA\\Files_Trashbin\\BackgroundJob\\ExpireTrash','null',1502452938,1502452937,0,0),(7,'OCA\\NextcloudAnnouncements\\Cron\\Crawler','null',1502452990,1502452990,0,2),(8,'OCA\\Activity\\BackgroundJob\\EmailNotification','null',0,1502451532,0,0),(9,'OCA\\Activity\\BackgroundJob\\ExpireActivities','null',0,1502451532,0,0),(10,'OCA\\DAV\\CardDAV\\SyncJob','null',0,1502451549,0,0),(11,'OCA\\Files_Sharing\\DeleteOrphanedSharesJob','null',0,1502451551,0,0),(12,'OCA\\Files_Sharing\\ExpireSharesJob','null',0,1502451551,0,0),(13,'OCA\\Files_Versions\\BackgroundJob\\ExpireVersions','null',0,1502451551,0,0),(14,'OCA\\Federation\\SyncJob','null',0,1502451555,0,0),(15,'\\OC\\Authentication\\Token\\DefaultTokenCleanupJob','null',0,1502451576,0,0),(16,'OCA\\FirstRunWizard\\Notification\\BackgroundJob','{\"uid\":\"nextcloudadmin\"}',0,1502451585,0,0),(17,'OC\\Command\\CommandJob','\"O:33:\\\"OCA\\\\Files_Trashbin\\\\Command\\\\Expire\\\":1:{s:39:\\\"\\u0000OCA\\\\Files_Trashbin\\\\Command\\\\Expire\\u0000user\\\";s:14:\\\"nextcloudadmin\\\";}\"',0,1502451815,0,0),(18,'OC\\Command\\CommandJob','\"O:33:\\\"OCA\\\\Files_Trashbin\\\\Command\\\\Expire\\\":1:{s:39:\\\"\\u0000OCA\\\\Files_Trashbin\\\\Command\\\\Expire\\u0000user\\\";s:14:\\\"nextcloudadmin\\\";}\"',0,1502451815,0,0),(19,'OCA\\QuotaWarning\\Job\\User','{\"uid\":\"nextcloudadmin\"}',0,1502451997,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_mimetypes`
--

LOCK TABLES `oc_mimetypes` WRITE;
/*!40000 ALTER TABLE `oc_mimetypes` DISABLE KEYS */;
INSERT INTO `oc_mimetypes` VALUES (3,'application'),(13,'application/javascript'),(4,'application/json'),(14,'application/octet-stream'),(9,'application/pdf'),(12,'application/vnd.oasis.opendocument.text'),(15,'application/x-gzip'),(1,'httpd'),(2,'httpd/unix-directory'),(7,'image'),(8,'image/jpeg'),(20,'image/png'),(17,'image/svg+xml'),(10,'text'),(16,'text/css'),(11,'text/plain'),(5,'video'),(6,'video/mp4');
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
INSERT INTO `oc_mounts` VALUES (1,2,6,'nextcloudadmin','/nextcloudadmin/',NULL);
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
INSERT INTO `oc_preferences` VALUES ('nextcloudadmin','core','lang','en'),('nextcloudadmin','core','timezone','Asia/Kolkata'),('nextcloudadmin','firstrunwizard','show','0'),('nextcloudadmin','login','lastLogin','1502452929');
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
INSERT INTO `oc_storages` VALUES ('local::/var/www/nextcloud-data/',1,1,NULL),('home::nextcloudadmin',2,1,NULL);
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
INSERT INTO `oc_users` VALUES ('nextcloudadmin',NULL,'1|$2y$10$M/Q4PKIV1rTPTG204yHoF.an44qJ2sEB/9Cg2yOZ8HdnNSEHL.wo6');
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

-- Dump completed on 2017-08-11 17:38:59
