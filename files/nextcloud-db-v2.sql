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
INSERT INTO `oc_accounts` VALUES ('nextcloudadmin','{\"displayname\":{\"value\":\"nextcloudadmin\",\"scope\":\"contacts\",\"verified\":\"0\"},\"address\":{\"value\":\"\",\"scope\":\"private\",\"verified\":\"0\"},\"website\":{\"value\":\"\",\"scope\":\"private\",\"verified\":\"0\"},\"email\":{\"value\":null,\"scope\":\"contacts\",\"verified\":\"0\"},\"avatar\":{\"scope\":\"contacts\"},\"phone\":{\"value\":\"\",\"scope\":\"private\",\"verified\":\"0\"},\"twitter\":{\"value\":\"\",\"scope\":\"private\",\"verified\":\"0\"}}');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_activity`
--

LOCK TABLES `oc_activity` WRITE;
/*!40000 ALTER TABLE `oc_activity` DISABLE KEYS */;
INSERT INTO `oc_activity` VALUES (1,1501674308,30,'calendar','system','system','dav','calendar_add_self','[\"system\",\"Contact birthdays\"]','','[]','','','calendar',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_addressbookchanges`
--

LOCK TABLES `oc_addressbookchanges` WRITE;
/*!40000 ALTER TABLE `oc_addressbookchanges` DISABLE KEYS */;
INSERT INTO `oc_addressbookchanges` VALUES (1,'Database:nextcloudadmin.vcf',1,1,1);
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
INSERT INTO `oc_addressbooks` VALUES (1,'principals/system/system','system','system','System addressbook which holds all users of this instance',2);
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
INSERT INTO `oc_admin_settings` VALUES (1,'OCA\\Survey_Client\\Settings\\AdminSettings','survey_client',50),(2,'OCA\\ShareByMail\\Settings\\Admin','sharing',40),(3,'OCA\\Theming\\Settings\\Admin','theming',5),(4,'OCA\\Password_Policy\\Settings','security',50),(5,'OCA\\Federation\\Settings\\Admin','sharing',30),(6,'OCA\\Files\\Settings\\Admin','additional',5),(7,'OCA\\FederatedFileSharing\\Settings\\Admin','sharing',20),(8,'OCA\\OAuth2\\Settings\\Admin','security',0),(9,'OCA\\Activity\\Settings\\Admin','activity',55),(10,'OCA\\UpdateNotification\\Controller\\AdminController','server',1),(11,'OCA\\SystemTags\\Settings\\Admin','workflow',70),(12,'OCA\\LogReader\\Settings\\Admin','logging',90),(13,'OCA\\NextcloudAnnouncements\\Settings\\Admin','additional',30),(14,'OCA\\ServerInfo\\Settings\\AdminSettings','serverinfo',0),(15,'OCA\\BruteForceSettings\\Settings\\IPWhitelist','security',50),(16,'OCA\\External\\Settings\\Admin','additional',55);
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
INSERT INTO `oc_appconfig` VALUES ('activity','enabled','yes'),('activity','installed_version','2.5.2'),('activity','types','filesystem'),('admin_notifications','enabled','yes'),('admin_notifications','installed_version','1.0.0'),('admin_notifications','types','logging'),('backgroundjob','lastjob','2'),('bruteforcesettings','enabled','yes'),('bruteforcesettings','installed_version','1.0.2'),('bruteforcesettings','types',''),('calendar','enabled','yes'),('calendar','installed_version','1.5.3'),('calendar','types',''),('comments','enabled','yes'),('comments','installed_version','1.2.0'),('comments','types','logging'),('contacts','enabled','yes'),('contacts','installed_version','1.5.3'),('contacts','types',''),('core','installed.bundles','[\"CoreBundle\"]'),('core','installedat','1501672276.367'),('core','lastcron','1501681562'),('core','lastupdateResult','[]'),('core','lastupdatedat','1501679101'),('core','oc.integritycheck.checker','[]'),('core','public_files','files_sharing/public.php'),('core','public_webdav','dav/appinfo/v1/publicwebdav.php'),('core','scss.variables','e6bfb70ef055b01435065967f59985cd'),('core','shareapi_allow_share_dialog_user_enumeration','no'),('core','vendor','nextcloud'),('dav','enabled','yes'),('dav','installed_version','1.3.0'),('dav','types','filesystem'),('external','enabled','yes'),('external','installed_version','2.0.3'),('external','types',''),('federatedfilesharing','enabled','yes'),('federatedfilesharing','installed_version','1.2.0'),('federatedfilesharing','types',''),('federation','enabled','yes'),('federation','installed_version','1.2.0'),('federation','types','authentication'),('files','cronjob_scan_files','500'),('files','enabled','yes'),('files','installed_version','1.7.2'),('files','types','filesystem'),('files_pdfviewer','enabled','yes'),('files_pdfviewer','installed_version','1.1.1'),('files_pdfviewer','ocsid','166049'),('files_pdfviewer','types',''),('files_sharing','enabled','yes'),('files_sharing','installed_version','1.4.0'),('files_sharing','types','filesystem'),('files_texteditor','enabled','yes'),('files_texteditor','installed_version','2.4.1'),('files_texteditor','ocsid','166051'),('files_texteditor','types',''),('files_trashbin','enabled','yes'),('files_trashbin','installed_version','1.2.0'),('files_trashbin','types','filesystem'),('files_versions','enabled','yes'),('files_versions','installed_version','1.5.0'),('files_versions','types','filesystem'),('files_videoplayer','enabled','yes'),('files_videoplayer','installed_version','1.1.0'),('files_videoplayer','types',''),('firstrunwizard','enabled','yes'),('firstrunwizard','installed_version','2.1'),('firstrunwizard','types','logging'),('gallery','enabled','yes'),('gallery','installed_version','17.0.0'),('gallery','types',''),('logreader','enabled','yes'),('logreader','installed_version','2.0.0'),('logreader','ocsid','170871'),('logreader','types',''),('lookup_server_connector','enabled','yes'),('lookup_server_connector','installed_version','1.0.0'),('lookup_server_connector','types','authentication'),('nextcloud_announcements','enabled','yes'),('nextcloud_announcements','installed_version','1.1'),('nextcloud_announcements','pub_date','Sat, 10 Dec 2016 00:00:00 +0100'),('nextcloud_announcements','types','logging'),('notes','enabled','yes'),('notes','installed_version','2.3.1'),('notes','types',''),('notifications','enabled','yes'),('notifications','installed_version','2.0.0'),('notifications','types','logging'),('oauth2','enabled','yes'),('oauth2','installed_version','1.0.5'),('oauth2','types','authentication'),('password_policy','enabled','yes'),('password_policy','installed_version','1.2.2'),('password_policy','types',''),('provisioning_api','enabled','yes'),('provisioning_api','installed_version','1.2.0'),('provisioning_api','types','prevent_group_restriction'),('quota_warning','enabled','yes'),('quota_warning','installed_version','1.0.1'),('quota_warning','types','filesystem'),('serverinfo','enabled','yes'),('serverinfo','installed_version','1.2.0'),('serverinfo','types',''),('sharebymail','enabled','yes'),('sharebymail','installed_version','1.2.0'),('sharebymail','types','filesystem'),('survey_client','enabled','yes'),('survey_client','installed_version','1.0.0'),('survey_client','types',''),('systemtags','enabled','yes'),('systemtags','installed_version','1.2.0'),('systemtags','types','logging'),('tasks','enabled','yes'),('tasks','installed_version','0.9.5'),('tasks','types',''),('theming','enabled','yes'),('theming','installed_version','1.3.0'),('theming','types','logging'),('twofactor_backupcodes','enabled','yes'),('twofactor_backupcodes','installed_version','1.1.1'),('twofactor_backupcodes','types',''),('updatenotification','enabled','yes'),('updatenotification','installed_version','1.2.0'),('updatenotification','types',''),('updatenotification','update_check_errors','0'),('user_external','enabled','yes'),('user_external','installed_version','0.4'),('user_external','types','authentication,prelogin'),('workflowengine','enabled','yes'),('workflowengine','installed_version','1.2.0'),('workflowengine','types','filesystem');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_cards_properties`
--


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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_file_locks`
--

LOCK TABLES `oc_file_locks` WRITE;
/*!40000 ALTER TABLE `oc_file_locks` DISABLE KEYS */;
INSERT INTO `oc_file_locks` VALUES (1,0,'files/7867b2b51ee605cf644f3ad19f9300f7',1501679042),(2,0,'files/a808857af235cb35aaa65a94a4ecfb2e',1501679043),(3,0,'files/3d6c9e24a663fdd9b49ad3484a88bac3',1501679043),(4,0,'files/b17acb41e6fbc2dc49caecdb09964ff6',1501676081);
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
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_filecache`
--

LOCK TABLES `oc_filecache` WRITE;
/*!40000 ALTER TABLE `oc_filecache` DISABLE KEYS */;
INSERT INTO `oc_filecache` VALUES (1,1,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,-1,1501681324,1501672481,0,0,'5981d6ace7260',23,''),(2,1,'appdata_oc1fo0fzeauu','f6b34700a10284397763a38962e73f2e',1,'appdata_oc1fo0fzeauu',2,1,2470705,1501681324,1501672371,0,0,'5981d6ace7260',31,''),(3,1,'appdata_oc1fo0fzeauu/appstore','54c19c7831f97a9cd66bf73ddc12228d',2,'appstore',2,1,349126,1501680420,1501674588,0,0,'5981d3257820c',31,''),(4,1,'appdata_oc1fo0fzeauu/appstore/apps.json','b4ef04b67333cc32e05601adc4ba3650',3,'apps.json',4,3,316593,1501680420,1501680420,0,0,'f07853357f450285b06a13121d07f722',27,''),(5,1,'appdata_oc1fo0fzeauu/preview','72e6322c3fe83e2d5c63afb610479bf6',2,'preview',2,1,0,1501672327,1501672327,0,0,'5981b387c791f',31,''),(6,2,'','d41d8cd98f00b204e9800998ecf8427e',-1,'',2,1,6823068,1501673818,1501673818,0,0,'5981b95b7dd13',23,''),(7,2,'files','45b963397aa40d4a0063e0d85e4fe7a1',6,'files',2,1,6823068,1501672339,1501672339,0,0,'5981b3937569a',31,''),(8,2,'files/Nextcloud.mp4','77a79c09b93e57cba23c11eb0e6048a6',7,'Nextcloud.mp4',6,5,462413,1501672335,1501672335,0,0,'eec0f97af06ea5c07265cf0adbb9ee73',27,''),(9,2,'files/Photos','d01bb67e7b71dd49fd06bad922f521c9',7,'Photos',2,1,2360011,1501672337,1501672337,0,0,'5981b3917c420',31,''),(10,2,'files/Photos/Nut.jpg','aa8daeb975e1d39412954fd5cd41adb4',9,'Nut.jpg',8,7,955026,1501672336,1501672336,0,0,'020a3ef1c64be7f78429154f96710c2b',27,''),(11,2,'files/Photos/Hummingbird.jpg','e077463269c404ae0f6f8ea7f2d7a326',9,'Hummingbird.jpg',8,7,585219,1501672337,1501672337,0,0,'efb96b9300eb34af350693fedab36528',27,''),(12,2,'files/Photos/Coast.jpg','a6fe87299d78b207e9b7aba0f0cb8a0a',9,'Coast.jpg',8,7,819766,1501672338,1501672338,0,0,'cafcb5d65cb0788d8ae26c62679133ad',27,''),(13,2,'files/Documents','0ad78ba05b6961d92f7970b2b3922eca',7,'Documents',2,1,78496,1501672339,1501672338,0,0,'5981b39329332',31,''),(14,2,'files/Documents/About.txt','9da7b739e7a65d74793b2881da521169',13,'About.txt',10,9,1074,1501672338,1501672338,0,0,'fe27e2b8fd88f55b76a332d56ade9571',27,''),(15,2,'files/Documents/About.odt','b2ee7d56df9f34a0195d4b611376e885',13,'About.odt',11,3,77422,1501672339,1501672339,0,0,'bfb7305af457a46270d3b9a3aec9cf40',27,''),(16,2,'files/Nextcloud Manual.pdf','2bc58a43566a8edde804a4a97a9c7469',7,'Nextcloud Manual.pdf',12,3,3922148,1501672339,1501672339,0,0,'586ec7c805067864f94c0aa648df3b13',27,''),(17,1,'appdata_oc1fo0fzeauu/avatar','4507f6962f3925c79a600cb93055ffef',2,'avatar',2,1,0,1501672348,1501672348,0,0,'5981b39c72470',31,''),(18,1,'appdata_oc1fo0fzeauu/avatar/nextcloudadmin','dc542278c9fde6caf58e9b5e39ed589e',17,'nextcloudadmin',2,1,0,1501672348,1501672348,0,0,'5981b39c5d690',31,''),(19,1,'appdata_oc1fo0fzeauu/js','d714ec9d4e783d3d02589551855a9ef1',2,'js',2,1,1982162,1501673778,1501672369,0,0,'5981b932e96c2',31,''),(20,1,'appdata_oc1fo0fzeauu/js/core','804a3d59d8518d6b4edf9a27aa839b0a',19,'core',2,1,343719,1501673778,1501673778,0,0,'5981b932e96c2',31,''),(21,1,'appdata_oc1fo0fzeauu/js/core/merged-template-prepend.js','c6d57d182ec2f9f6ab8eb5874a093c0f',20,'merged-template-prepend.js',13,3,142144,1501672350,1501672350,0,0,'530f479a04817d734691aa6a9871cf9d',27,''),(22,1,'appdata_oc1fo0fzeauu/js/core/merged-template-prepend.js.deps','0bb616f8530121163475eca93773031f',20,'merged-template-prepend.js.deps',14,3,1146,1501672350,1501672350,0,0,'dfa2024412d5638717c7b76b09e89116',27,''),(23,1,'appdata_oc1fo0fzeauu/js/core/merged-template-prepend.js.gzip','5cb582a614710549e0d58bd522abf37d',20,'merged-template-prepend.js.gzip',15,3,39023,1501672350,1501672350,0,0,'3918bca496c65f439e66e025d4ae850a',27,''),(24,1,'appdata_oc1fo0fzeauu/js/core/merged-share-backend.js','fe2ebb52faf46432121c2d77c4631fa9',20,'merged-share-backend.js',13,3,104522,1501672353,1501672353,0,0,'c6941f184c668a3ff26acd3aca9f306c',27,''),(25,1,'appdata_oc1fo0fzeauu/js/core/merged-share-backend.js.deps','1128f89133154265dd547703abcbabe2',20,'merged-share-backend.js.deps',14,3,752,1501672353,1501672353,0,0,'eebd8bf5b12f396ae952750ef91bc1b9',27,''),(26,1,'appdata_oc1fo0fzeauu/js/core/merged-share-backend.js.gzip','032ebd52591d3d7e2060b80ab870882b',20,'merged-share-backend.js.gzip',15,3,22508,1501672354,1501672354,0,0,'eea88f81ae0bc2ab7e868624e34ce473',27,''),(27,1,'appdata_oc1fo0fzeauu/js/notifications','0b051263d76d871f3eafbccb94b9b0ce',19,'notifications',2,1,25514,1501672355,1501672354,0,0,'5981b3a3afcc1',31,''),(28,1,'appdata_oc1fo0fzeauu/js/notifications/merged.js','9fcf2ceb35eef61baf57bf67fca0c539',27,'merged.js',13,3,20114,1501672355,1501672355,0,0,'ea70842d79406fb83f176b1ebd2ddcc6',27,''),(29,1,'appdata_oc1fo0fzeauu/js/notifications/merged.js.deps','09d4e92b68f3c17745b3a13c821067bc',27,'merged.js.deps',14,3,330,1501672355,1501672355,0,0,'25ccc453bb21117443d0fbb948cc09a2',27,''),(30,1,'appdata_oc1fo0fzeauu/js/notifications/merged.js.gzip','b2675cb66340ea6fc0ed6c584ece29f6',27,'merged.js.gzip',15,3,5070,1501672355,1501672355,0,0,'14e0d6061100a64ad9c6db9bc34734db',27,''),(31,1,'appdata_oc1fo0fzeauu/js/files','0274a4d8fc98066b612baa32514858de',19,'files',2,1,398160,1501672357,1501672356,0,0,'5981b3a5a16d1',31,''),(32,1,'appdata_oc1fo0fzeauu/js/files/merged-index.js','ae4fe27d7d025ac62bc61e616b12eec1',31,'merged-index.js',13,3,319781,1501672357,1501672357,0,0,'6bd8a22ac82ddfd5e195ac3c754e8a89',27,''),(33,1,'appdata_oc1fo0fzeauu/js/files/merged-index.js.deps','df4231468e5e69ca717927d1b865565f',31,'merged-index.js.deps',14,3,2125,1501672357,1501672357,0,0,'48c3e3ef74c71dc0ee79c3c8a62b48a9',27,''),(34,1,'appdata_oc1fo0fzeauu/js/files/merged-index.js.gzip','19c76a82d8b3e22eee52efe38068713f',31,'merged-index.js.gzip',15,3,76254,1501672357,1501672357,0,0,'4049ae60b4ccc0f6341246311679f8fa',27,''),(35,1,'appdata_oc1fo0fzeauu/js/activity','7b614fad39fb55c754bd75f8a43273a0',19,'activity',2,1,20399,1501672359,1501672358,0,0,'5981b3a75ffa7',31,''),(36,1,'appdata_oc1fo0fzeauu/js/activity/activity-sidebar.js','f87f646db8d69368ec2a950c54675908',35,'activity-sidebar.js',13,3,15755,1501672359,1501672359,0,0,'bb3d6e8c98d3dc2c946a2099b6c62c81',27,''),(37,1,'appdata_oc1fo0fzeauu/js/activity/activity-sidebar.js.deps','0f001d8d428eb06e6908d19844869af4',35,'activity-sidebar.js.deps',14,3,494,1501672359,1501672359,0,0,'49da573a39cd38784041a78b82cee2f8',27,''),(38,1,'appdata_oc1fo0fzeauu/js/activity/activity-sidebar.js.gzip','05227fb7ef86bcfdbb54fcbc19646e96',35,'activity-sidebar.js.gzip',15,3,4150,1501672359,1501672359,0,0,'f3d11ecfb9a61f41842637d63428bfcb',27,''),(39,1,'appdata_oc1fo0fzeauu/js/comments','25ab84b5300583c57518501504cfdde2',19,'comments',2,1,36996,1501672361,1501672360,0,0,'5981b3a918577',31,''),(40,1,'appdata_oc1fo0fzeauu/js/comments/merged.js','a735285c232d95c8549864b640147e73',39,'merged.js',13,3,28929,1501672360,1501672360,0,0,'46c269eb5508f862c0c04ae5e0cc1c7e',27,''),(41,1,'appdata_oc1fo0fzeauu/js/comments/merged.js.deps','6579893753f6dccc1a48d073e5c6fa29',39,'merged.js.deps',14,3,635,1501672360,1501672360,0,0,'2807fa7192625d5e12b1e73bdcc37c7c',27,''),(42,1,'appdata_oc1fo0fzeauu/js/comments/merged.js.gzip','0e79b83b1c171636a7d1c21e6c764d85',39,'merged.js.gzip',15,3,7432,1501672361,1501672361,0,0,'8168218d6ceddeb797bb6cf2391cd162',27,''),(43,1,'appdata_oc1fo0fzeauu/js/files_sharing','a2299112e26bd3e74674b6b1401b4d06',19,'files_sharing',2,1,20226,1501672363,1501672361,0,0,'5981b3ab1d461',31,''),(44,1,'appdata_oc1fo0fzeauu/js/files_sharing/additionalScripts.js','0713cf337e207ff1ad43408e69542eec',43,'additionalScripts.js',13,3,15161,1501672362,1501672362,0,0,'2fc1fe854f45de9101b05a6894c16e06',27,''),(45,1,'appdata_oc1fo0fzeauu/js/files_sharing/additionalScripts.js.deps','de684f5659cfac05e74d1c49597993c8',43,'additionalScripts.js.deps',14,3,340,1501672362,1501672362,0,0,'b6d9b26dd92736fb34689c210e834abc',27,''),(46,1,'appdata_oc1fo0fzeauu/js/files_sharing/additionalScripts.js.gzip','2c9cda37b7a762180754b89b83928bab',43,'additionalScripts.js.gzip',15,3,4725,1501672363,1501672363,0,0,'4bbb7bb9c5acbf62d4a87c96986737c6',27,''),(47,1,'appdata_oc1fo0fzeauu/js/files_texteditor','cb1792ad66ce16c811d919cfa5e54e31',19,'files_texteditor',2,1,820097,1501672364,1501672363,0,0,'5981b3accc564',31,''),(48,1,'appdata_oc1fo0fzeauu/js/files_texteditor/merged.js','e34893420edf17a9d4636719666fbcc1',47,'merged.js',13,3,681977,1501672364,1501672364,0,0,'8eb6792af0d695819f0d3ee98a2c1a7a',27,''),(49,1,'appdata_oc1fo0fzeauu/js/files_texteditor/merged.js.deps','c37bddcf9022c5b2255ddbc457b31a6d',47,'merged.js.deps',14,3,370,1501672364,1501672364,0,0,'4dcd11c692ebf5a83a8fb33ae703703f',27,''),(50,1,'appdata_oc1fo0fzeauu/js/files_texteditor/merged.js.gzip','58bafab6d21b24dfb61de13726895efa',47,'merged.js.gzip',15,3,137750,1501672364,1501672364,0,0,'16a09e387c0495464c93b1b77bf841c5',27,''),(51,1,'appdata_oc1fo0fzeauu/js/files_versions','a159822c249276c82d7f1f2df5eda542',19,'files_versions',2,1,16725,1501672366,1501672365,0,0,'5981b3ae6c6b5',31,''),(52,1,'appdata_oc1fo0fzeauu/js/files_versions/merged.js','5e0c74e3c2052cffef7c6f9129246a82',51,'merged.js',13,3,12719,1501672366,1501672366,0,0,'2fff1824a7786e9eb7e984c6872c9ee4',27,''),(53,1,'appdata_oc1fo0fzeauu/js/files_versions/merged.js.deps','d69165482ef1493a21b210ed14480458',51,'merged.js.deps',14,3,424,1501672366,1501672366,0,0,'44a374b44949faa642a8b60f60473dc5',27,''),(54,1,'appdata_oc1fo0fzeauu/js/files_versions/merged.js.gzip','b8242921e3ac83a171469f4bfbe30ecb',51,'merged.js.gzip',15,3,3582,1501672366,1501672366,0,0,'cbae8fde516fe4a986f3ab23806da0ef',27,''),(55,1,'appdata_oc1fo0fzeauu/js/gallery','48116fd81953e911536f7c72d3bf4835',19,'gallery',2,1,280677,1501672367,1501672367,0,0,'5981b3b0015b0',31,''),(56,1,'appdata_oc1fo0fzeauu/js/gallery/scripts-for-file-app.js','7f7f608bf988c338930e64de8417e019',55,'scripts-for-file-app.js',13,3,225356,1501672367,1501672367,0,0,'87ec40fea183dfd17b00aaf7b3f5c61d',27,''),(57,1,'appdata_oc1fo0fzeauu/js/gallery/scripts-for-file-app.js.deps','1b2719c21e1a71aa4ee3fc15b56caded',55,'scripts-for-file-app.js.deps',14,3,856,1501672367,1501672367,0,0,'a07048328f7f0277c5c7e11d9f28a7f2',27,''),(58,1,'appdata_oc1fo0fzeauu/js/gallery/scripts-for-file-app.js.gzip','5d1ec61a3e87a9fe6f7d0ff293af90d3',55,'scripts-for-file-app.js.gzip',15,3,54465,1501672367,1501672367,0,0,'cd7455877c258177b97d00daffd1e4dc',27,''),(59,1,'appdata_oc1fo0fzeauu/js/core/merged.js','f34168af5431b326a0f472c27fdff2e7',20,'merged.js',13,3,20224,1501672368,1501672368,0,0,'f019a4f24efd459dc8dfda8a6541de79',27,''),(60,1,'appdata_oc1fo0fzeauu/js/core/merged.js.deps','439be78ce5fe007e9b773409f28d08c2',20,'merged.js.deps',14,3,508,1501672368,1501672368,0,0,'8d1a816d2e0e442a783cf182ea5394e5',27,''),(61,1,'appdata_oc1fo0fzeauu/js/core/merged.js.gzip','dc420217b184d108b17f2b572ad66fbb',20,'merged.js.gzip',15,3,5365,1501672368,1501672368,0,0,'6a20eb3b38eaa3102b52e9e446fc4f0c',27,''),(62,1,'appdata_oc1fo0fzeauu/js/systemtags','7c0de20a9cbbd190e96c2fa15cc5bad0',19,'systemtags',2,1,19649,1501672370,1501672370,0,0,'5981b3b2ba78a',31,''),(63,1,'appdata_oc1fo0fzeauu/js/systemtags/merged.js','33128d3e66f597d18815a40109c8992b',62,'merged.js',13,3,14902,1501672370,1501672370,0,0,'1c8448e0ea59992ce4c7592b634035e6',27,''),(64,1,'appdata_oc1fo0fzeauu/js/systemtags/merged.js.deps','a2bf3419e459ca11ef361937aa3a6a52',62,'merged.js.deps',14,3,399,1501672370,1501672370,0,0,'cff741085afd861be779785435db027b',27,''),(65,1,'appdata_oc1fo0fzeauu/js/systemtags/merged.js.gzip','d629612ba62925e50e4fc616e7d1c96b',62,'merged.js.gzip',15,3,4348,1501672370,1501672370,0,0,'391040ca10d1b8df63db7a937ea75226',27,''),(66,1,'appdata_oc1fo0fzeauu/css','02afbd39e90cb1cea50592f610f94884',2,'css',2,1,133006,1501675423,1501673526,0,0,'5981bf9f62d93',31,''),(67,1,'appdata_oc1fo0fzeauu/css/core','442bc31b2ef9b05565373ceadb792fc0',66,'core',2,1,97480,1501675419,1501675417,0,0,'5981bf9c2027c',31,''),(68,1,'appdata_oc1fo0fzeauu/theming','094fc2bd577cd0cefd15aa7a2cbd3701',2,'theming',2,1,6411,1501681324,1501675421,0,0,'5981d6ace7260',31,''),(71,1,'appdata_oc1fo0fzeauu/css/core/server.css.gzip','0c566768cb66ff4007d13a7efbe3246f',67,'server.css.gzip',15,3,13407,1501675402,1501675402,0,0,'5d14cd850a3db04598d1a6463edba231',27,''),(74,1,'appdata_oc1fo0fzeauu/css/core/share.css.gzip','59d1c72ec3da38816f7493b67fdb8e85',67,'share.css.gzip',15,3,994,1501675403,1501675403,0,0,'4b2b3f07302166b87c2051b2b77970aa',27,''),(75,1,'appdata_oc1fo0fzeauu/css/files','1521414be1278f4feab07040abdb7020',66,'files',2,1,24966,1501675405,1501675404,0,0,'5981bf8de89af',31,''),(78,1,'appdata_oc1fo0fzeauu/css/files/merged.css.gzip','d84fa6e093e60d0a2794535bd6d6e8b6',75,'merged.css.gzip',15,3,4283,1501675405,1501675405,0,0,'ef0dc81c937919c2eeb1940a33327ad3',27,''),(79,1,'appdata_oc1fo0fzeauu/css/files_sharing','c371573b74c0700e675fdd5ad8b8283a',66,'files_sharing',2,1,3945,1501675407,1501675406,0,0,'5981bf8f67f7a',31,''),(82,1,'appdata_oc1fo0fzeauu/css/files_sharing/mergedAdditionalStyles.css.gzip','5df535420320ccf821c3dc70d82ced94',79,'mergedAdditionalStyles.css.gzip',15,3,878,1501675407,1501675407,0,0,'983b9ce5c686fa59928fb9d40eed9b7c',27,''),(83,1,'appdata_oc1fo0fzeauu/css/files_texteditor','8558fcd4a4d441299d2c048cdc93a663',66,'files_texteditor',2,1,5377,1501675417,1501675407,0,0,'5981bf991bd7b',31,''),(86,1,'appdata_oc1fo0fzeauu/css/files_texteditor/merged.css.gzip','612cc08ded79cabb2f4ce4bb6dc36da2',83,'merged.css.gzip',15,3,1184,1501675417,1501675417,0,0,'299582dddd0a31c9512ae11045822a98',27,''),(89,1,'appdata_oc1fo0fzeauu/css/core/systemtags.css.gzip','e25cad04499a669c2543682edcf67a9b',67,'systemtags.css.gzip',15,3,389,1501675419,1501675419,0,0,'8684f984b00e626f16f0c62bf8d04d3b',27,''),(90,1,'files_external','c270928b685e7946199afdfb898d27ea',1,'files_external',2,1,0,1501672481,1501672481,0,0,'5981b421580a8',31,''),(91,1,'appdata_oc1fo0fzeauu/css/theming','a718c4d736504446a169f4cca7a46e33',66,'theming',2,1,1238,1501675423,1501675422,0,0,'5981bf9f62d93',31,''),(94,1,'appdata_oc1fo0fzeauu/css/theming/theming.css.gzip','4e484923014d3e8611ff440f6bdf000b',91,'theming.css.gzip',15,3,312,1501675423,1501675423,0,0,'2a3b3403d0031bce0ed4133f15cc20a3',27,''),(95,1,'appdata_oc1fo0fzeauu/js/core/merged-login.js','c21cc101b9d6d23473bd0b05f30e5cd4',20,'merged-login.js',13,3,5389,1501673778,1501673778,0,0,'3e54ea7e279b5dee966a60d6f8f3905f',27,''),(96,1,'appdata_oc1fo0fzeauu/js/core/merged-login.js.deps','6a8a6861f92511c54d631a71b4898193',20,'merged-login.js.deps',14,3,271,1501673778,1501673778,0,0,'a6f2d36fc946a6a6f2cb31890f7acd07',27,''),(97,1,'appdata_oc1fo0fzeauu/js/core/merged-login.js.gzip','66907153a7f6ffdd911708c84cac7219',20,'merged-login.js.gzip',15,3,1867,1501673778,1501673778,0,0,'199f98271e2a2d4568341b8d8e831d01',27,''),(98,2,'cache','0fea6a13c52b4d4725368f24b045ca84',6,'cache',2,1,0,1501673818,1501673818,0,0,'5981b95a8d62a',31,''),(99,1,'appdata_oc1fo0fzeauu/appstore/categories.json','b4f01e723b508b83fef5535da9896f1c',3,'categories.json',4,3,32533,1501679135,1501679135,0,0,'44a926681736714b598767d4aca153ca',27,''),(100,1,'appdata_oc1fo0fzeauu/css/core/server.css','49c70a6c5d22eb20301f6c95bdf74865',67,'server.css',16,9,77306,1501675401,1501675401,0,0,'9e48566e76a4400ee163dd75663595b4',27,''),(101,1,'appdata_oc1fo0fzeauu/css/core/server.css.deps','180b5769cabba83915693b7ee2d7e3e5',67,'server.css.deps',14,3,850,1501675401,1501675401,0,0,'a1c81c11b5c0efe8efbecd64d2595f88',27,''),(102,1,'appdata_oc1fo0fzeauu/css/core/share.css','512066341750e0689dd0f1399d8b019b',67,'share.css',16,9,2848,1501675403,1501675403,0,0,'465885a8cda5626565f507f59febf2d9',27,''),(103,1,'appdata_oc1fo0fzeauu/css/core/share.css.deps','31b8737c202fb00ac7380577fee42335',67,'share.css.deps',14,3,133,1501675403,1501675403,0,0,'fea53d0c9b9d72bae8e4a477d4b50b52',27,''),(104,1,'appdata_oc1fo0fzeauu/css/files/merged.css','686db44918380b48e3b01c8230bfebd6',75,'merged.css',16,9,20250,1501675405,1501675405,0,0,'c5c337ab2c57f89966e4a57381a8c270',27,''),(105,1,'appdata_oc1fo0fzeauu/css/files/merged.css.deps','0e0245f02a479d97481a5b70f540085e',75,'merged.css.deps',14,3,433,1501675405,1501675405,0,0,'df2628ae0218d7f6bb3036fecfc20240',27,''),(106,1,'appdata_oc1fo0fzeauu/css/files_sharing/mergedAdditionalStyles.css','0475fe4980bd39a1cd3f66ed632e86f5',79,'mergedAdditionalStyles.css',16,9,2727,1501675406,1501675406,0,0,'202cd578ecc89c66b7b538c88711c235',27,''),(107,1,'appdata_oc1fo0fzeauu/css/files_sharing/mergedAdditionalStyles.css.deps','7ff82def0e873aedc5da038f98a5b586',79,'mergedAdditionalStyles.css.deps',14,3,340,1501675406,1501675406,0,0,'e9c27e150009e4b841a3c636155c4d42',27,''),(108,1,'appdata_oc1fo0fzeauu/css/files_texteditor/merged.css','6c4ad0aec4339066fb0796ea12f3b9de',83,'merged.css',16,9,3774,1501675413,1501675413,0,0,'dd4b376b92a533f6495ae452c1530f05',27,''),(109,1,'appdata_oc1fo0fzeauu/css/files_texteditor/merged.css.deps','8098cce78a321c88e16046bdf6482e3b',83,'merged.css.deps',14,3,419,1501675416,1501675416,0,0,'2eef18acd5d21076d88dca504e65e8ea',27,''),(110,1,'appdata_oc1fo0fzeauu/css/core/systemtags.css','f9491f7564ad653cebfd635a737c3fd4',67,'systemtags.css',16,9,1415,1501675417,1501675417,0,0,'40e39e52fc4f5827204f21c167eb8c69',27,''),(111,1,'appdata_oc1fo0fzeauu/css/core/systemtags.css.deps','48e0ef8d51d3c858fda404d3f50d0dbb',67,'systemtags.css.deps',14,3,138,1501675417,1501675417,0,0,'da2a61fcf5dd78cbc63eb5674177fdba',27,''),(112,1,'appdata_oc1fo0fzeauu/theming/0','3002df5cdc5e94ee0201830c94bfe640',68,'0',2,1,6411,1501681324,1501681324,0,0,'5981d6ace7260',31,''),(113,1,'appdata_oc1fo0fzeauu/css/theming/theming.css','910c21919989c853855d7283bc3ea18c',91,'theming.css',16,9,782,1501675422,1501675422,0,0,'1b13e564e167abbb4635506b0f526d48',27,''),(114,1,'appdata_oc1fo0fzeauu/css/theming/theming.css.deps','8f20dae46f37179d6dc48c818095a27b',91,'theming.css.deps',14,3,144,1501675423,1501675423,0,0,'940eff5370b5b0b52bfc7ca15b19c33c',27,''),(115,1,'appdata_oc1fo0fzeauu/theming/0/favIcon-files','846002f8bf58fd29c6482b3a9a803d03',112,'favIcon-files',14,3,505,1501675422,1501675422,0,0,'e738725c8092bbf4f39827374baed7f5',27,''),(116,1,'appdata_oc1fo0fzeauu/theming/0/icon-core-filetypes_video.svg','9090611c885adb6b14f481a759247773',112,'icon-core-filetypes_video.svg',17,7,328,1501675451,1501675451,0,0,'6762c411803b3d5e6fdee6ae4580ad5b',27,''),(117,1,'appdata_oc1fo0fzeauu/theming/0/icon-core-filetypes_folder.svg','135768dbe6360a2b94c36c088419c693',112,'icon-core-filetypes_folder.svg',17,7,254,1501675451,1501675451,0,0,'354b2a4e39805acd1bc8ca37163cd613',27,''),(118,1,'appdata_oc1fo0fzeauu/theming/0/icon-core-filetypes_application-pdf.svg','8dc35085902d3ed72f144d3542cc98d2',112,'icon-core-filetypes_application-pdf.svg',17,7,1535,1501675451,1501675451,0,0,'d81177c187818e67c8fd700de47b377f',27,''),(119,1,'appdata_oc1fo0fzeauu/theming/0/favIcon-settings','63c94e189f3ea470d487a2691a38ac8b',112,'favIcon-settings',14,3,1145,1501675475,1501675475,0,0,'663b936c3273e1f0770fae7faaf668fc',27,''),(120,1,'appdata_oc1fo0fzeauu/theming/0/icon-core-filetypes_text.svg','bed1da17a9d53d68ef1d7fc3d5258aa4',112,'icon-core-filetypes_text.svg',17,7,419,1501676110,1501676110,0,0,'b6e69efd9020423e4cfce5768652cbf9',27,''),(121,1,'appdata_oc1fo0fzeauu/theming/0/favIcon-tasks','e0190e50b456663fe31bddaf57e8b6e2',112,'favIcon-tasks',14,3,1080,1501680857,1501680857,0,0,'6ba62f3d53713db9996261fac36e4f28',27,''),(122,1,'appdata_oc1fo0fzeauu/theming/0/favIcon-core','292d60dbbaed8e55b49b00b4ebf7328c',112,'favIcon-core',14,3,1145,1501681324,1501681324,0,0,'601a8a3afd0e27096bbf11694132b8f2',27,'');
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_jobs`
--

LOCK TABLES `oc_jobs` WRITE;
/*!40000 ALTER TABLE `oc_jobs` DISABLE KEYS */;
INSERT INTO `oc_jobs` VALUES (2,'OCA\\Files_Trashbin\\BackgroundJob\\ExpireTrash','null',1501681562,1501681561,0,0),(3,'OCA\\Federation\\SyncJob','null',1501673533,1501675442,0,0),(4,'OCA\\Files\\BackgroundJob\\ScanFiles','null',1501675478,1501675478,0,0),(5,'OCA\\Files\\BackgroundJob\\DeleteOrphanedItems','null',1501673786,1501675505,0,0),(6,'OCA\\Files\\BackgroundJob\\CleanupFileLocks','null',1501675679,1501675679,0,0),(7,'OCA\\Activity\\BackgroundJob\\EmailNotification','null',1501675883,1501675883,0,0),(8,'OCA\\Activity\\BackgroundJob\\ExpireActivities','null',1501673963,1501676075,0,0),(9,'OCA\\UpdateNotification\\Notification\\BackgroundJob','null',1501674187,1501676106,0,5),(10,'OCA\\NextcloudAnnouncements\\Cron\\Crawler','null',1501674202,1501676391,0,2),(11,'OCA\\Files_Sharing\\DeleteOrphanedSharesJob','null',1501676407,1501676407,0,0),(12,'OCA\\Files_Sharing\\ExpireSharesJob','null',1501674279,1501679110,0,0),(13,'OCA\\Files_Versions\\BackgroundJob\\ExpireVersions','null',1501679133,1501679133,0,0),(14,'OCA\\DAV\\CardDAV\\SyncJob','null',1501674302,1501680864,0,6),(15,'\\OC\\Authentication\\Token\\DefaultTokenCleanupJob','null',1501681327,1501681327,0,0),(17,'OCA\\QuotaWarning\\Job\\User','{\"uid\":\"nextcloudadmin\"}',0,1501679712,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_mimetypes`
--

LOCK TABLES `oc_mimetypes` WRITE;
/*!40000 ALTER TABLE `oc_mimetypes` DISABLE KEYS */;
INSERT INTO `oc_mimetypes` VALUES (3,'application'),(13,'application/javascript'),(4,'application/json'),(14,'application/octet-stream'),(12,'application/pdf'),(11,'application/vnd.oasis.opendocument.text'),(15,'application/x-gzip'),(1,'httpd'),(2,'httpd/unix-directory'),(7,'image'),(8,'image/jpeg'),(17,'image/svg+xml'),(9,'text'),(16,'text/css'),(10,'text/plain'),(5,'video'),(6,'video/mp4');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oc_notifications`
--

LOCK TABLES `oc_notifications` WRITE;
/*!40000 ALTER TABLE `oc_notifications` DISABLE KEYS */;
INSERT INTO `oc_notifications` VALUES (2,'firstrunwizard','nextcloudadmin',1501674571,'user','nextcloudadmin','profile','[]','','[]','','','[]');
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
INSERT INTO `oc_preferences` VALUES ('nextcloudadmin','core','lang','en'),('nextcloudadmin','core','timezone','Asia/Kolkata'),('nextcloudadmin','firstrunwizard','show','0'),('nextcloudadmin','login','lastLogin','1501673816'),('nextcloudadmin','tasks','show_all','2'),('nextcloudadmin','tasks','show_completed','2'),('nextcloudadmin','tasks','show_current','2'),('nextcloudadmin','tasks','show_starred','2'),('nextcloudadmin','tasks','show_today','2'),('nextcloudadmin','tasks','show_week','2');
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
INSERT INTO `oc_users` VALUES ('nextcloudadmin',NULL,'1|$2y$10$OCkmv5MGFqo.z6fr3k56m.YXJf68ItbNoPS8RX3ASUOPtA2AVahCu');
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

-- Dump completed on 2017-08-02 19:18:00
