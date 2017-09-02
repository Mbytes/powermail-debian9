-- MySQL dump 10.13  Distrib 5.5.53, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: godb
-- ------------------------------------------------------
-- Server version	5.5.53-0+deb8u1

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
-- Table structure for table `ab_addressbooks`
--

DROP TABLE IF EXISTS `ab_addressbooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_addressbooks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(100) DEFAULT NULL,
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `default_salutation` varchar(255) NOT NULL,
  `files_folder_id` int(11) NOT NULL DEFAULT '0',
  `users` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_addressbooks`
--

LOCK TABLES `ab_addressbooks` WRITE;
/*!40000 ALTER TABLE `ab_addressbooks` DISABLE KEYS */;
INSERT INTO `ab_addressbooks` VALUES (4,1,'Users',32,'Dear [Mr./Mrs.] {middle_name} {last_name}',2,1);
/*!40000 ALTER TABLE `ab_addressbooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_addresslist_companies`
--

DROP TABLE IF EXISTS `ab_addresslist_companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_addresslist_companies` (
  `addresslist_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`addresslist_id`,`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_addresslist_companies`
--

LOCK TABLES `ab_addresslist_companies` WRITE;
/*!40000 ALTER TABLE `ab_addresslist_companies` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_addresslist_companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_addresslist_contacts`
--

DROP TABLE IF EXISTS `ab_addresslist_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_addresslist_contacts` (
  `addresslist_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`addresslist_id`,`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_addresslist_contacts`
--

LOCK TABLES `ab_addresslist_contacts` WRITE;
/*!40000 ALTER TABLE `ab_addresslist_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_addresslist_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_addresslists`
--

DROP TABLE IF EXISTS `ab_addresslists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_addresslists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `default_salutation` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_addresslists`
--

LOCK TABLES `ab_addresslists` WRITE;
/*!40000 ALTER TABLE `ab_addresslists` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_addresslists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_companies`
--

DROP TABLE IF EXISTS `ab_companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `addressbook_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(100) DEFAULT '',
  `name2` varchar(100) DEFAULT '',
  `address` varchar(100) DEFAULT '',
  `address_no` varchar(100) DEFAULT '',
  `zip` varchar(10) DEFAULT '',
  `city` varchar(50) DEFAULT '',
  `state` varchar(50) DEFAULT '',
  `country` varchar(50) DEFAULT '',
  `post_address` varchar(100) DEFAULT '',
  `post_address_no` varchar(100) DEFAULT '',
  `post_city` varchar(50) DEFAULT '',
  `post_state` varchar(50) DEFAULT '',
  `post_country` varchar(50) DEFAULT '',
  `post_zip` varchar(10) DEFAULT '',
  `phone` varchar(30) DEFAULT '',
  `fax` varchar(30) DEFAULT '',
  `email` varchar(75) DEFAULT '',
  `homepage` varchar(100) DEFAULT '',
  `comment` text,
  `bank_no` varchar(50) DEFAULT '',
  `bank_bic` varchar(11) DEFAULT '',
  `vat_no` varchar(30) DEFAULT '',
  `invoice_email` varchar(75) DEFAULT '',
  `ctime` int(11) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `muser_id` int(11) NOT NULL DEFAULT '0',
  `email_allowed` tinyint(1) NOT NULL DEFAULT '1',
  `files_folder_id` int(11) NOT NULL DEFAULT '0',
  `crn` varchar(50) DEFAULT '',
  `iban` varchar(100) DEFAULT '',
  `photo` varchar(255) NOT NULL DEFAULT '',
  `color` char(6) NOT NULL DEFAULT '000000',
  PRIMARY KEY (`id`),
  KEY `addressbook_id` (`addressbook_id`),
  KEY `addressbook_id_2` (`addressbook_id`),
  KEY `link_id` (`link_id`),
  KEY `link_id_2` (`link_id`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_companies`
--

LOCK TABLES `ab_companies` WRITE;
/*!40000 ALTER TABLE `ab_companies` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_contacts`
--

DROP TABLE IF EXISTS `ab_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(190) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `addressbook_id` int(11) NOT NULL DEFAULT '0',
  `first_name` varchar(50) NOT NULL DEFAULT '',
  `middle_name` varchar(50) NOT NULL DEFAULT '',
  `last_name` varchar(50) NOT NULL DEFAULT '',
  `initials` varchar(10) NOT NULL DEFAULT '',
  `title` varchar(50) NOT NULL DEFAULT '',
  `suffix` varchar(50) NOT NULL DEFAULT '',
  `sex` enum('M','F') NOT NULL DEFAULT 'M',
  `birthday` date DEFAULT NULL,
  `email` varchar(100) NOT NULL DEFAULT '',
  `email2` varchar(100) NOT NULL DEFAULT '',
  `email3` varchar(100) NOT NULL DEFAULT '',
  `company_id` int(11) NOT NULL DEFAULT '0',
  `department` varchar(100) NOT NULL DEFAULT '',
  `function` varchar(50) NOT NULL DEFAULT '',
  `home_phone` varchar(30) NOT NULL DEFAULT '',
  `work_phone` varchar(30) NOT NULL DEFAULT '',
  `fax` varchar(30) NOT NULL DEFAULT '',
  `work_fax` varchar(30) NOT NULL DEFAULT '',
  `cellular` varchar(30) NOT NULL DEFAULT '',
  `cellular2` varchar(30) NOT NULL DEFAULT '',
  `homepage` varchar(255) DEFAULT NULL,
  `country` varchar(50) NOT NULL DEFAULT '',
  `state` varchar(50) NOT NULL DEFAULT '',
  `city` varchar(50) NOT NULL DEFAULT '',
  `zip` varchar(10) NOT NULL DEFAULT '',
  `address` varchar(100) NOT NULL DEFAULT '',
  `address_no` varchar(100) NOT NULL DEFAULT '',
  `comment` text,
  `ctime` int(11) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `muser_id` int(11) NOT NULL DEFAULT '0',
  `salutation` varchar(100) NOT NULL DEFAULT '',
  `email_allowed` tinyint(1) NOT NULL DEFAULT '1',
  `files_folder_id` int(11) NOT NULL DEFAULT '0',
  `go_user_id` int(11) NOT NULL DEFAULT '0',
  `photo` varchar(255) NOT NULL DEFAULT '',
  `action_date` int(11) NOT NULL DEFAULT '0',
  `url_linkedin` varchar(100) DEFAULT NULL,
  `url_facebook` varchar(100) DEFAULT NULL,
  `url_twitter` varchar(100) DEFAULT NULL,
  `skype_name` varchar(100) DEFAULT NULL,
  `color` char(6) NOT NULL DEFAULT '000000',
  PRIMARY KEY (`id`),
  KEY `addressbook_id` (`addressbook_id`),
  KEY `email` (`email`),
  KEY `email2` (`email2`),
  KEY `email3` (`email3`),
  KEY `last_name` (`last_name`),
  KEY `go_user_id` (`go_user_id`),
  KEY `uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_contacts`
--

LOCK TABLES `ab_contacts` WRITE;
/*!40000 ALTER TABLE `ab_contacts` DISABLE KEYS */;
INSERT INTO `ab_contacts` VALUES (1,'af28c6e1-45c2-5581-949f-d601a29249bd',1,4,'System','','Administrator','','','','M',NULL,'support@technoinfotech.com','','',0,'','','','','','','','',NULL,'','','','','','',NULL,1482907222,1482907222,1,'Dear Mr. Administrator',1,0,1,'',0,NULL,NULL,NULL,NULL,'000000');
/*!40000 ALTER TABLE `ab_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_contacts_vcard_props`
--

DROP TABLE IF EXISTS `ab_contacts_vcard_props`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_contacts_vcard_props` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `parameters` varchar(1023) NOT NULL DEFAULT '',
  `value` varchar(1023) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `contact_id` (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_contacts_vcard_props`
--

LOCK TABLES `ab_contacts_vcard_props` WRITE;
/*!40000 ALTER TABLE `ab_contacts_vcard_props` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_contacts_vcard_props` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_default_email_account_templates`
--

DROP TABLE IF EXISTS `ab_default_email_account_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_default_email_account_templates` (
  `account_id` int(11) NOT NULL,
  `template_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_id`),
  KEY `template_id` (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_default_email_account_templates`
--

LOCK TABLES `ab_default_email_account_templates` WRITE;
/*!40000 ALTER TABLE `ab_default_email_account_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_default_email_account_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_default_email_templates`
--

DROP TABLE IF EXISTS `ab_default_email_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_default_email_templates` (
  `user_id` int(11) NOT NULL,
  `template_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `template_id` (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_default_email_templates`
--

LOCK TABLES `ab_default_email_templates` WRITE;
/*!40000 ALTER TABLE `ab_default_email_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_default_email_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_email_templates`
--

DROP TABLE IF EXISTS `ab_email_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_email_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `name` varchar(100) DEFAULT NULL,
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `content` longblob NOT NULL,
  `extension` varchar(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_email_templates`
--

LOCK TABLES `ab_email_templates` WRITE;
/*!40000 ALTER TABLE `ab_email_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_email_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_portlet_birthdays`
--

DROP TABLE IF EXISTS `ab_portlet_birthdays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_portlet_birthdays` (
  `user_id` int(11) NOT NULL,
  `addressbook_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`addressbook_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_portlet_birthdays`
--

LOCK TABLES `ab_portlet_birthdays` WRITE;
/*!40000 ALTER TABLE `ab_portlet_birthdays` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_portlet_birthdays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_search_queries`
--

DROP TABLE IF EXISTS `ab_search_queries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_search_queries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `companies` tinyint(1) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `sql` text,
  PRIMARY KEY (`id`),
  KEY `companies` (`companies`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_search_queries`
--

LOCK TABLES `ab_search_queries` WRITE;
/*!40000 ALTER TABLE `ab_search_queries` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_search_queries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_sent_mailing_companies`
--

DROP TABLE IF EXISTS `ab_sent_mailing_companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_sent_mailing_companies` (
  `sent_mailing_id` int(11) NOT NULL DEFAULT '0',
  `company_id` int(11) NOT NULL DEFAULT '0',
  `sent` tinyint(1) NOT NULL DEFAULT '0',
  `campaigns_opened` tinyint(1) NOT NULL DEFAULT '0',
  `has_error` tinyint(1) NOT NULL DEFAULT '0',
  `error_description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`sent_mailing_id`,`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_sent_mailing_companies`
--

LOCK TABLES `ab_sent_mailing_companies` WRITE;
/*!40000 ALTER TABLE `ab_sent_mailing_companies` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_sent_mailing_companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_sent_mailing_contacts`
--

DROP TABLE IF EXISTS `ab_sent_mailing_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_sent_mailing_contacts` (
  `sent_mailing_id` int(11) NOT NULL DEFAULT '0',
  `contact_id` int(11) NOT NULL DEFAULT '0',
  `sent` tinyint(1) NOT NULL DEFAULT '0',
  `campaigns_opened` tinyint(1) NOT NULL DEFAULT '0',
  `has_error` tinyint(1) NOT NULL DEFAULT '0',
  `error_description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`sent_mailing_id`,`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_sent_mailing_contacts`
--

LOCK TABLES `ab_sent_mailing_contacts` WRITE;
/*!40000 ALTER TABLE `ab_sent_mailing_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_sent_mailing_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_sent_mailings`
--

DROP TABLE IF EXISTS `ab_sent_mailings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_sent_mailings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `message_path` varchar(255) DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  `addresslist_id` int(11) NOT NULL,
  `alias_id` int(11) NOT NULL,
  `status` tinyint(4) DEFAULT '0',
  `total` int(11) DEFAULT '0',
  `sent` int(11) DEFAULT '0',
  `errors` int(11) DEFAULT '0',
  `opened` int(11) DEFAULT '0',
  `campaign_id` int(11) NOT NULL DEFAULT '0',
  `campaigns_status_id` int(11) NOT NULL DEFAULT '0',
  `temp_pass` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_sent_mailings`
--

LOCK TABLES `ab_sent_mailings` WRITE;
/*!40000 ALTER TABLE `ab_sent_mailings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_sent_mailings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bm_bookmarks`
--

DROP TABLE IF EXISTS `bm_bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bm_bookmarks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL,
  `content` text NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `public_icon` tinyint(1) NOT NULL DEFAULT '1',
  `open_extern` tinyint(1) NOT NULL DEFAULT '1',
  `behave_as_module` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bm_bookmarks`
--

LOCK TABLES `bm_bookmarks` WRITE;
/*!40000 ALTER TABLE `bm_bookmarks` DISABLE KEYS */;
/*!40000 ALTER TABLE `bm_bookmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bm_categories`
--

DROP TABLE IF EXISTS `bm_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bm_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `acl_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `show_in_startmenu` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bm_categories`
--

LOCK TABLES `bm_categories` WRITE;
/*!40000 ALTER TABLE `bm_categories` DISABLE KEYS */;
INSERT INTO `bm_categories` VALUES (1,1,12,'General',0);
/*!40000 ALTER TABLE `bm_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cal_calendar_user_colors`
--

DROP TABLE IF EXISTS `cal_calendar_user_colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_calendar_user_colors` (
  `user_id` int(11) NOT NULL,
  `calendar_id` int(11) NOT NULL,
  `color` varchar(6) NOT NULL,
  PRIMARY KEY (`user_id`,`calendar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cal_calendar_user_colors`
--

LOCK TABLES `cal_calendar_user_colors` WRITE;
/*!40000 ALTER TABLE `cal_calendar_user_colors` DISABLE KEYS */;
/*!40000 ALTER TABLE `cal_calendar_user_colors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cal_calendars`
--

DROP TABLE IF EXISTS `cal_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_calendars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL DEFAULT '1',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(100) DEFAULT NULL,
  `start_hour` tinyint(4) NOT NULL DEFAULT '0',
  `end_hour` tinyint(4) NOT NULL DEFAULT '0',
  `background` varchar(6) DEFAULT NULL,
  `time_interval` int(11) NOT NULL DEFAULT '1800',
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `shared_acl` tinyint(1) NOT NULL DEFAULT '0',
  `show_bdays` tinyint(1) NOT NULL DEFAULT '0',
  `show_completed_tasks` tinyint(1) NOT NULL DEFAULT '1',
  `comment` varchar(255) NOT NULL DEFAULT '',
  `project_id` int(11) NOT NULL DEFAULT '0',
  `tasklist_id` int(11) NOT NULL DEFAULT '0',
  `files_folder_id` int(11) NOT NULL DEFAULT '0',
  `show_holidays` tinyint(1) NOT NULL DEFAULT '1',
  `enable_ics_import` tinyint(1) NOT NULL DEFAULT '0',
  `ics_import_url` varchar(512) NOT NULL DEFAULT '',
  `tooltip` varchar(127) NOT NULL DEFAULT '',
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cal_calendars`
--

LOCK TABLES `cal_calendars` WRITE;
/*!40000 ALTER TABLE `cal_calendars` DISABLE KEYS */;
INSERT INTO `cal_calendars` VALUES (1,1,1,34,'System Administrator',0,0,NULL,1800,0,0,0,1,'',0,0,6,1,0,'','',1);
/*!40000 ALTER TABLE `cal_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cal_categories`
--

DROP TABLE IF EXISTS `cal_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `color` char(6) NOT NULL DEFAULT 'EBF1E2',
  `calendar_id` int(11) NOT NULL,
  `acl_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `calendar_id` (`calendar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cal_categories`
--

LOCK TABLES `cal_categories` WRITE;
/*!40000 ALTER TABLE `cal_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `cal_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cal_events`
--

DROP TABLE IF EXISTS `cal_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(190) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
  `calendar_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `start_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `timezone` varchar(64) NOT NULL DEFAULT '',
  `all_day_event` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(150) NOT NULL,
  `description` text,
  `location` varchar(100) NOT NULL DEFAULT '',
  `repeat_end_time` int(11) NOT NULL DEFAULT '0',
  `reminder` int(11) NOT NULL DEFAULT '0',
  `ctime` int(11) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `muser_id` int(11) NOT NULL DEFAULT '0',
  `busy` tinyint(1) NOT NULL DEFAULT '1',
  `status` varchar(20) NOT NULL DEFAULT 'NEEDS-ACTION',
  `resource_event_id` int(11) NOT NULL DEFAULT '0',
  `private` tinyint(1) NOT NULL DEFAULT '0',
  `rrule` varchar(100) NOT NULL DEFAULT '',
  `background` char(6) NOT NULL DEFAULT 'ebf1e2',
  `files_folder_id` int(11) NOT NULL,
  `read_only` tinyint(1) NOT NULL DEFAULT '0',
  `category_id` int(11) DEFAULT NULL,
  `exception_for_event_id` int(11) NOT NULL DEFAULT '0',
  `recurrence_id` varchar(20) NOT NULL DEFAULT '',
  `is_organizer` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `repeat_end_time` (`repeat_end_time`),
  KEY `rrule` (`rrule`),
  KEY `calendar_id` (`calendar_id`),
  KEY `busy` (`busy`),
  KEY `category_id` (`category_id`),
  KEY `uuid` (`uuid`),
  KEY `resource_event_id` (`resource_event_id`),
  KEY `recurrence_id` (`recurrence_id`),
  KEY `exception_for_event_id` (`exception_for_event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cal_events`
--

LOCK TABLES `cal_events` WRITE;
/*!40000 ALTER TABLE `cal_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `cal_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cal_events_declined`
--

DROP TABLE IF EXISTS `cal_events_declined`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_events_declined` (
  `uid` varchar(190) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`uid`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cal_events_declined`
--

LOCK TABLES `cal_events_declined` WRITE;
/*!40000 ALTER TABLE `cal_events_declined` DISABLE KEYS */;
/*!40000 ALTER TABLE `cal_events_declined` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cal_exceptions`
--

DROP TABLE IF EXISTS `cal_exceptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_exceptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL DEFAULT '0',
  `time` int(11) NOT NULL DEFAULT '0',
  `exception_event_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `muser_id` int(11) NOT NULL DEFAULT '0',
  `ctime` int(11) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cal_exceptions`
--

LOCK TABLES `cal_exceptions` WRITE;
/*!40000 ALTER TABLE `cal_exceptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `cal_exceptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cal_group_admins`
--

DROP TABLE IF EXISTS `cal_group_admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_group_admins` (
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`group_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cal_group_admins`
--

LOCK TABLES `cal_group_admins` WRITE;
/*!40000 ALTER TABLE `cal_group_admins` DISABLE KEYS */;
/*!40000 ALTER TABLE `cal_group_admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cal_groups`
--

DROP TABLE IF EXISTS `cal_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `fields` varchar(255) NOT NULL DEFAULT '',
  `show_not_as_busy` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cal_groups`
--

LOCK TABLES `cal_groups` WRITE;
/*!40000 ALTER TABLE `cal_groups` DISABLE KEYS */;
INSERT INTO `cal_groups` VALUES (1,1,'Calendars','',0);
/*!40000 ALTER TABLE `cal_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cal_participants`
--

DROP TABLE IF EXISTS `cal_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_participants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `contact_id` int(11) NOT NULL DEFAULT '0',
  `status` varchar(50) NOT NULL DEFAULT 'NEEDS-ACTION',
  `last_modified` varchar(20) NOT NULL DEFAULT '',
  `is_organizer` tinyint(1) NOT NULL DEFAULT '0',
  `role` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cal_participants`
--

LOCK TABLES `cal_participants` WRITE;
/*!40000 ALTER TABLE `cal_participants` DISABLE KEYS */;
/*!40000 ALTER TABLE `cal_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cal_settings`
--

DROP TABLE IF EXISTS `cal_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_settings` (
  `user_id` int(11) NOT NULL,
  `reminder` int(11) NOT NULL DEFAULT '0',
  `background` char(6) NOT NULL DEFAULT 'EBF1E2',
  `calendar_id` int(11) NOT NULL DEFAULT '0',
  `show_statuses` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`),
  KEY `calendar_id` (`calendar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cal_settings`
--

LOCK TABLES `cal_settings` WRITE;
/*!40000 ALTER TABLE `cal_settings` DISABLE KEYS */;
INSERT INTO `cal_settings` VALUES (1,0,'EBF1E2',1,1);
/*!40000 ALTER TABLE `cal_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cal_views`
--

DROP TABLE IF EXISTS `cal_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_views` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `time_interval` int(11) NOT NULL DEFAULT '1800',
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `merge` tinyint(1) NOT NULL DEFAULT '0',
  `owncolor` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cal_views`
--

LOCK TABLES `cal_views` WRITE;
/*!40000 ALTER TABLE `cal_views` DISABLE KEYS */;
/*!40000 ALTER TABLE `cal_views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cal_views_calendars`
--

DROP TABLE IF EXISTS `cal_views_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_views_calendars` (
  `view_id` int(11) NOT NULL DEFAULT '0',
  `calendar_id` int(11) NOT NULL DEFAULT '0',
  `background` char(6) NOT NULL DEFAULT 'CCFFCC',
  PRIMARY KEY (`view_id`,`calendar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cal_views_calendars`
--

LOCK TABLES `cal_views_calendars` WRITE;
/*!40000 ALTER TABLE `cal_views_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `cal_views_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cal_views_groups`
--

DROP TABLE IF EXISTS `cal_views_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_views_groups` (
  `view_id` int(11) NOT NULL,
  `group_id` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`view_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cal_views_groups`
--

LOCK TABLES `cal_views_groups` WRITE;
/*!40000 ALTER TABLE `cal_views_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `cal_views_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cal_visible_tasklists`
--

DROP TABLE IF EXISTS `cal_visible_tasklists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_visible_tasklists` (
  `calendar_id` int(11) NOT NULL,
  `tasklist_id` int(11) NOT NULL,
  PRIMARY KEY (`calendar_id`,`tasklist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cal_visible_tasklists`
--

LOCK TABLES `cal_visible_tasklists` WRITE;
/*!40000 ALTER TABLE `cal_visible_tasklists` DISABLE KEYS */;
/*!40000 ALTER TABLE `cal_visible_tasklists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_ab_companies`
--

DROP TABLE IF EXISTS `cf_ab_companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_ab_companies` (
  `model_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_ab_companies`
--

LOCK TABLES `cf_ab_companies` WRITE;
/*!40000 ALTER TABLE `cf_ab_companies` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_ab_companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_ab_contacts`
--

DROP TABLE IF EXISTS `cf_ab_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_ab_contacts` (
  `model_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_ab_contacts`
--

LOCK TABLES `cf_ab_contacts` WRITE;
/*!40000 ALTER TABLE `cf_ab_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_ab_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_blocks`
--

DROP TABLE IF EXISTS `cf_blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_blocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `field_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_blocks`
--

LOCK TABLES `cf_blocks` WRITE;
/*!40000 ALTER TABLE `cf_blocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_blocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_cal_calendars`
--

DROP TABLE IF EXISTS `cf_cal_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_cal_calendars` (
  `model_id` int(11) NOT NULL,
  PRIMARY KEY (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_cal_calendars`
--

LOCK TABLES `cf_cal_calendars` WRITE;
/*!40000 ALTER TABLE `cf_cal_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_cal_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_cal_events`
--

DROP TABLE IF EXISTS `cf_cal_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_cal_events` (
  `model_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_cal_events`
--

LOCK TABLES `cf_cal_events` WRITE;
/*!40000 ALTER TABLE `cf_cal_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_cal_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_categories`
--

DROP TABLE IF EXISTS `cf_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `extends_model` varchar(50) NOT NULL DEFAULT '0',
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `sort_index` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `type` (`extends_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_categories`
--

LOCK TABLES `cf_categories` WRITE;
/*!40000 ALTER TABLE `cf_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_disable_categories`
--

DROP TABLE IF EXISTS `cf_disable_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_disable_categories` (
  `model_id` int(11) NOT NULL,
  `model_name` varchar(100) NOT NULL,
  PRIMARY KEY (`model_id`,`model_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_disable_categories`
--

LOCK TABLES `cf_disable_categories` WRITE;
/*!40000 ALTER TABLE `cf_disable_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_disable_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_enabled_blocks`
--

DROP TABLE IF EXISTS `cf_enabled_blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_enabled_blocks` (
  `block_id` int(11) NOT NULL DEFAULT '0',
  `model_id` int(11) NOT NULL DEFAULT '0',
  `model_type_name` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`block_id`,`model_id`,`model_type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_enabled_blocks`
--

LOCK TABLES `cf_enabled_blocks` WRITE;
/*!40000 ALTER TABLE `cf_enabled_blocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_enabled_blocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_enabled_categories`
--

DROP TABLE IF EXISTS `cf_enabled_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_enabled_categories` (
  `model_id` int(11) NOT NULL,
  `model_name` varchar(100) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`model_id`,`model_name`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_enabled_categories`
--

LOCK TABLES `cf_enabled_categories` WRITE;
/*!40000 ALTER TABLE `cf_enabled_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_enabled_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_fields`
--

DROP TABLE IF EXISTS `cf_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `datatype` varchar(100) NOT NULL DEFAULT 'GO_Customfields_Customfieldtype_Text',
  `sort_index` int(11) NOT NULL DEFAULT '0',
  `function` varchar(255) DEFAULT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `validation_regex` varchar(255) NOT NULL DEFAULT '',
  `helptext` varchar(100) NOT NULL DEFAULT '',
  `multiselect` tinyint(1) NOT NULL DEFAULT '0',
  `max` int(11) NOT NULL DEFAULT '0',
  `nesting_level` tinyint(4) NOT NULL DEFAULT '0',
  `treemaster_field_id` int(11) NOT NULL DEFAULT '0',
  `exclude_from_grid` tinyint(1) NOT NULL DEFAULT '0',
  `height` int(11) NOT NULL DEFAULT '0',
  `number_decimals` tinyint(4) NOT NULL DEFAULT '2',
  `unique_values` tinyint(1) NOT NULL DEFAULT '0',
  `max_length` int(5) NOT NULL DEFAULT '50',
  `addressbook_ids` varchar(255) NOT NULL DEFAULT '',
  `extra_options` text,
  `prefix` varchar(32) NOT NULL DEFAULT '',
  `suffix` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `type` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_fields`
--

LOCK TABLES `cf_fields` WRITE;
/*!40000 ALTER TABLE `cf_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_fs_files`
--

DROP TABLE IF EXISTS `cf_fs_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_fs_files` (
  `model_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_fs_files`
--

LOCK TABLES `cf_fs_files` WRITE;
/*!40000 ALTER TABLE `cf_fs_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_fs_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_fs_folders`
--

DROP TABLE IF EXISTS `cf_fs_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_fs_folders` (
  `model_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_fs_folders`
--

LOCK TABLES `cf_fs_folders` WRITE;
/*!40000 ALTER TABLE `cf_fs_folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_fs_folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_go_users`
--

DROP TABLE IF EXISTS `cf_go_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_go_users` (
  `model_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_go_users`
--

LOCK TABLES `cf_go_users` WRITE;
/*!40000 ALTER TABLE `cf_go_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_go_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_no_notes`
--

DROP TABLE IF EXISTS `cf_no_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_no_notes` (
  `model_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_no_notes`
--

LOCK TABLES `cf_no_notes` WRITE;
/*!40000 ALTER TABLE `cf_no_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_no_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_select_options`
--

DROP TABLE IF EXISTS `cf_select_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_select_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_id` int(11) NOT NULL DEFAULT '0',
  `text` varchar(255) DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_select_options`
--

LOCK TABLES `cf_select_options` WRITE;
/*!40000 ALTER TABLE `cf_select_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_select_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_select_tree_options`
--

DROP TABLE IF EXISTS `cf_select_tree_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_select_tree_options` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_select_tree_options`
--

LOCK TABLES `cf_select_tree_options` WRITE;
/*!40000 ALTER TABLE `cf_select_tree_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_select_tree_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_ta_tasks`
--

DROP TABLE IF EXISTS `cf_ta_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_ta_tasks` (
  `model_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_ta_tasks`
--

LOCK TABLES `cf_ta_tasks` WRITE;
/*!40000 ALTER TABLE `cf_ta_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_ta_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cf_tree_select_options`
--

DROP TABLE IF EXISTS `cf_tree_select_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cf_tree_select_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_tree_select_options`
--

LOCK TABLES `cf_tree_select_options` WRITE;
/*!40000 ALTER TABLE `cf_tree_select_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_tree_select_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_categories`
--

DROP TABLE IF EXISTS `co_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `co_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(127) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_categories`
--

LOCK TABLES `co_categories` WRITE;
/*!40000 ALTER TABLE `co_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_comments`
--

DROP TABLE IF EXISTS `co_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `co_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) NOT NULL,
  `model_type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ctime` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  `comments` text,
  `category_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `link_id` (`model_id`,`model_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_comments`
--

LOCK TABLES `co_comments` WRITE;
/*!40000 ALTER TABLE `co_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dav_locks`
--

DROP TABLE IF EXISTS `dav_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dav_locks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `owner` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timeout` int(10) unsigned DEFAULT NULL,
  `created` int(11) DEFAULT NULL,
  `token` varbinary(100) DEFAULT NULL,
  `scope` tinyint(4) DEFAULT NULL,
  `depth` tinyint(4) DEFAULT NULL,
  `uri` varbinary(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `token` (`token`),
  KEY `uri` (`uri`(100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dav_locks`
--

LOCK TABLES `dav_locks` WRITE;
/*!40000 ALTER TABLE `dav_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `dav_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_accounts`
--

DROP TABLE IF EXISTS `em_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `em_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `type` varchar(4) DEFAULT NULL,
  `host` varchar(100) DEFAULT NULL,
  `port` int(11) NOT NULL DEFAULT '0',
  `deprecated_use_ssl` tinyint(1) NOT NULL DEFAULT '0',
  `novalidate_cert` tinyint(1) NOT NULL DEFAULT '0',
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `imap_encryption` char(3) NOT NULL,
  `imap_allow_self_signed` tinyint(1) NOT NULL DEFAULT '1',
  `mbroot` varchar(30) NOT NULL DEFAULT '',
  `sent` varchar(100) DEFAULT 'Sent',
  `drafts` varchar(100) DEFAULT 'Drafts',
  `trash` varchar(100) NOT NULL DEFAULT 'Trash',
  `spam` varchar(100) NOT NULL DEFAULT 'Spam',
  `smtp_host` varchar(100) DEFAULT NULL,
  `smtp_port` int(11) NOT NULL,
  `smtp_encryption` char(3) NOT NULL,
  `smtp_allow_self_signed` tinyint(1) NOT NULL DEFAULT '0',
  `smtp_username` varchar(50) DEFAULT NULL,
  `smtp_password` varchar(255) NOT NULL DEFAULT '',
  `password_encrypted` tinyint(4) NOT NULL DEFAULT '0',
  `ignore_sent_folder` tinyint(1) NOT NULL DEFAULT '0',
  `sieve_port` int(11) NOT NULL,
  `sieve_usetls` tinyint(1) NOT NULL DEFAULT '1',
  `check_mailboxes` text,
  `do_not_mark_as_read` tinyint(1) NOT NULL DEFAULT '0',
  `signature_below_reply` tinyint(1) NOT NULL DEFAULT '0',
  `full_reply_headers` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_accounts`
--

LOCK TABLES `em_accounts` WRITE;
/*!40000 ALTER TABLE `em_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `em_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_accounts_collapsed`
--

DROP TABLE IF EXISTS `em_accounts_collapsed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `em_accounts_collapsed` (
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`account_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_accounts_collapsed`
--

LOCK TABLES `em_accounts_collapsed` WRITE;
/*!40000 ALTER TABLE `em_accounts_collapsed` DISABLE KEYS */;
/*!40000 ALTER TABLE `em_accounts_collapsed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_accounts_sort`
--

DROP TABLE IF EXISTS `em_accounts_sort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `em_accounts_sort` (
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order` int(11) NOT NULL,
  PRIMARY KEY (`account_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_accounts_sort`
--

LOCK TABLES `em_accounts_sort` WRITE;
/*!40000 ALTER TABLE `em_accounts_sort` DISABLE KEYS */;
/*!40000 ALTER TABLE `em_accounts_sort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_aliases`
--

DROP TABLE IF EXISTS `em_aliases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `em_aliases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `signature` text,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_aliases`
--

LOCK TABLES `em_aliases` WRITE;
/*!40000 ALTER TABLE `em_aliases` DISABLE KEYS */;
/*!40000 ALTER TABLE `em_aliases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_contacts_last_mail_times`
--

DROP TABLE IF EXISTS `em_contacts_last_mail_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `em_contacts_last_mail_times` (
  `contact_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `last_mail_time` int(11) NOT NULL,
  PRIMARY KEY (`contact_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_contacts_last_mail_times`
--

LOCK TABLES `em_contacts_last_mail_times` WRITE;
/*!40000 ALTER TABLE `em_contacts_last_mail_times` DISABLE KEYS */;
/*!40000 ALTER TABLE `em_contacts_last_mail_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_filters`
--

DROP TABLE IF EXISTS `em_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `em_filters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL DEFAULT '0',
  `field` varchar(20) DEFAULT NULL,
  `keyword` varchar(100) DEFAULT NULL,
  `folder` varchar(100) DEFAULT NULL,
  `priority` int(11) NOT NULL DEFAULT '0',
  `mark_as_read` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_filters`
--

LOCK TABLES `em_filters` WRITE;
/*!40000 ALTER TABLE `em_filters` DISABLE KEYS */;
/*!40000 ALTER TABLE `em_filters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_folders`
--

DROP TABLE IF EXISTS `em_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `em_folders` (
  `id` int(11) NOT NULL DEFAULT '0',
  `account_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `subscribed` enum('0','1') NOT NULL DEFAULT '0',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `delimiter` char(1) NOT NULL DEFAULT '',
  `sort_order` tinyint(4) NOT NULL DEFAULT '0',
  `msgcount` int(11) NOT NULL DEFAULT '0',
  `unseen` int(11) NOT NULL DEFAULT '0',
  `auto_check` enum('0','1') NOT NULL DEFAULT '0',
  `can_have_children` tinyint(1) NOT NULL,
  `no_select` tinyint(1) DEFAULT NULL,
  `sort` longtext,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_folders`
--

LOCK TABLES `em_folders` WRITE;
/*!40000 ALTER TABLE `em_folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `em_folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_folders_expanded`
--

DROP TABLE IF EXISTS `em_folders_expanded`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `em_folders_expanded` (
  `folder_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`folder_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_folders_expanded`
--

LOCK TABLES `em_folders_expanded` WRITE;
/*!40000 ALTER TABLE `em_folders_expanded` DISABLE KEYS */;
/*!40000 ALTER TABLE `em_folders_expanded` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_labels`
--

DROP TABLE IF EXISTS `em_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `em_labels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `flag` varchar(100) NOT NULL,
  `color` varchar(6) NOT NULL,
  `account_id` int(11) NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_labels`
--

LOCK TABLES `em_labels` WRITE;
/*!40000 ALTER TABLE `em_labels` DISABLE KEYS */;
/*!40000 ALTER TABLE `em_labels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_links`
--

DROP TABLE IF EXISTS `em_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `em_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `from` varchar(255) DEFAULT NULL,
  `to` text,
  `subject` varchar(255) DEFAULT NULL,
  `time` int(11) NOT NULL DEFAULT '0',
  `path` varchar(255) DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  `mtime` int(11) NOT NULL DEFAULT '0',
  `muser_id` int(11) NOT NULL DEFAULT '0',
  `acl_id` int(11) NOT NULL,
  `uid` varchar(190) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `account_id` (`user_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_links`
--

LOCK TABLES `em_links` WRITE;
/*!40000 ALTER TABLE `em_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `em_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_messages_cache`
--

DROP TABLE IF EXISTS `em_messages_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `em_messages_cache` (
  `folder_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `new` enum('0','1') NOT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `from` varchar(100) DEFAULT NULL,
  `size` int(11) NOT NULL,
  `udate` int(11) NOT NULL,
  `attachments` enum('0','1') NOT NULL,
  `flagged` enum('0','1') NOT NULL,
  `answered` enum('0','1') NOT NULL,
  `forwarded` tinyint(1) NOT NULL,
  `priority` tinyint(4) NOT NULL,
  `to` varchar(255) DEFAULT NULL,
  `serialized_message_object` mediumtext NOT NULL,
  PRIMARY KEY (`folder_id`,`uid`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_messages_cache`
--

LOCK TABLES `em_messages_cache` WRITE;
/*!40000 ALTER TABLE `em_messages_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `em_messages_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_portlet_folders`
--

DROP TABLE IF EXISTS `em_portlet_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `em_portlet_folders` (
  `account_id` int(11) NOT NULL,
  `folder_name` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  PRIMARY KEY (`account_id`,`folder_name`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_portlet_folders`
--

LOCK TABLES `em_portlet_folders` WRITE;
/*!40000 ALTER TABLE `em_portlet_folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `em_portlet_folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_folders`
--

DROP TABLE IF EXISTS `emp_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emp_folders` (
  `folder_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  PRIMARY KEY (`folder_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_folders`
--

LOCK TABLES `emp_folders` WRITE;
/*!40000 ALTER TABLE `emp_folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `emp_folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fav_addressbook`
--

DROP TABLE IF EXISTS `fav_addressbook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fav_addressbook` (
  `user_id` int(11) NOT NULL,
  `addressbook_id` int(11) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fav_addressbook`
--

LOCK TABLES `fav_addressbook` WRITE;
/*!40000 ALTER TABLE `fav_addressbook` DISABLE KEYS */;
/*!40000 ALTER TABLE `fav_addressbook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fav_calendar`
--

DROP TABLE IF EXISTS `fav_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fav_calendar` (
  `user_id` int(11) NOT NULL,
  `calendar_id` int(11) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fav_calendar`
--

LOCK TABLES `fav_calendar` WRITE;
/*!40000 ALTER TABLE `fav_calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `fav_calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fav_tasklist`
--

DROP TABLE IF EXISTS `fav_tasklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fav_tasklist` (
  `user_id` int(11) NOT NULL,
  `tasklist_id` int(11) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fav_tasklist`
--

LOCK TABLES `fav_tasklist` WRITE;
/*!40000 ALTER TABLE `fav_tasklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `fav_tasklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fb_acl`
--

DROP TABLE IF EXISTS `fb_acl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fb_acl` (
  `user_id` int(11) NOT NULL,
  `acl_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`acl_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fb_acl`
--

LOCK TABLES `fb_acl` WRITE;
/*!40000 ALTER TABLE `fb_acl` DISABLE KEYS */;
INSERT INTO `fb_acl` VALUES (1,44);
/*!40000 ALTER TABLE `fb_acl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fs_bookmarks`
--

DROP TABLE IF EXISTS `fs_bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fs_bookmarks` (
  `folder_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`folder_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_bookmarks`
--

LOCK TABLES `fs_bookmarks` WRITE;
/*!40000 ALTER TABLE `fs_bookmarks` DISABLE KEYS */;
/*!40000 ALTER TABLE `fs_bookmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fs_filehandlers`
--

DROP TABLE IF EXISTS `fs_filehandlers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fs_filehandlers` (
  `user_id` int(11) NOT NULL,
  `extension` varchar(20) NOT NULL,
  `cls` varchar(100) NOT NULL,
  PRIMARY KEY (`user_id`,`extension`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_filehandlers`
--

LOCK TABLES `fs_filehandlers` WRITE;
/*!40000 ALTER TABLE `fs_filehandlers` DISABLE KEYS */;
/*!40000 ALTER TABLE `fs_filehandlers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fs_files`
--

DROP TABLE IF EXISTS `fs_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fs_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `folder_id` int(11) NOT NULL,
  `name` varchar(190) NOT NULL,
  `locked_user_id` int(11) NOT NULL DEFAULT '0',
  `status_id` int(11) NOT NULL DEFAULT '0',
  `ctime` int(11) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `muser_id` int(11) NOT NULL DEFAULT '0',
  `size` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text,
  `extension` varchar(20) NOT NULL,
  `expire_time` int(11) NOT NULL DEFAULT '0',
  `random_code` char(11) DEFAULT NULL,
  `delete_when_expired` tinyint(1) NOT NULL DEFAULT '0',
  `content_expire_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `folder_id` (`folder_id`),
  KEY `name` (`name`),
  KEY `extension` (`extension`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_files`
--

LOCK TABLES `fs_files` WRITE;
/*!40000 ALTER TABLE `fs_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `fs_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fs_folder_pref`
--

DROP TABLE IF EXISTS `fs_folder_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fs_folder_pref` (
  `folder_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `thumbs` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`folder_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_folder_pref`
--

LOCK TABLES `fs_folder_pref` WRITE;
/*!40000 ALTER TABLE `fs_folder_pref` DISABLE KEYS */;
/*!40000 ALTER TABLE `fs_folder_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fs_folders`
--

DROP TABLE IF EXISTS `fs_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fs_folders` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `name` varchar(190) NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '0',
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `comment` text,
  `thumbs` tinyint(1) NOT NULL DEFAULT '1',
  `ctime` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  `muser_id` int(11) NOT NULL DEFAULT '0',
  `quota_user_id` int(11) NOT NULL DEFAULT '0',
  `readonly` tinyint(1) NOT NULL DEFAULT '0',
  `cm_state` text,
  `apply_state` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `parent_id` (`parent_id`),
  KEY `parent_id_2` (`parent_id`,`name`),
  KEY `visible` (`visible`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_folders`
--

LOCK TABLES `fs_folders` WRITE;
/*!40000 ALTER TABLE `fs_folders` DISABLE KEYS */;
INSERT INTO `fs_folders` VALUES (1,1,0,'addressbook',0,32,NULL,1,1482907222,1482907222,1,1,1,NULL,0),(1,2,1,'Users',0,32,NULL,1,1482907222,1482907222,1,1,1,NULL,0),(1,3,0,'tasks',0,33,NULL,1,1482907222,1482907222,1,1,1,NULL,0),(1,4,3,'System Administrator',0,33,NULL,1,1482907222,1482907222,1,1,1,NULL,0),(1,5,0,'calendar',0,34,NULL,1,1482907222,1482907222,1,1,1,NULL,0),(1,6,5,'System Administrator',0,34,NULL,1,1482907222,1482907222,1,1,1,NULL,0),(1,7,0,'users',0,27,NULL,1,1482907222,1482907222,1,1,1,NULL,0),(1,8,7,'groupofficeadmin',0,0,NULL,1,1482907222,1482907222,1,1,0,NULL,0),(1,9,8,'Public',1,35,NULL,1,1482907222,1482907222,1,1,0,NULL,0);
/*!40000 ALTER TABLE `fs_folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fs_new_files`
--

DROP TABLE IF EXISTS `fs_new_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fs_new_files` (
  `file_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  KEY `file_id` (`file_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_new_files`
--

LOCK TABLES `fs_new_files` WRITE;
/*!40000 ALTER TABLE `fs_new_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `fs_new_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fs_notification_messages`
--

DROP TABLE IF EXISTS `fs_notification_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fs_notification_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `modified_user_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `arg1` varchar(255) NOT NULL,
  `arg2` varchar(255) NOT NULL,
  `mtime` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_notification_messages`
--

LOCK TABLES `fs_notification_messages` WRITE;
/*!40000 ALTER TABLE `fs_notification_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `fs_notification_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fs_notifications`
--

DROP TABLE IF EXISTS `fs_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fs_notifications` (
  `folder_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`folder_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_notifications`
--

LOCK TABLES `fs_notifications` WRITE;
/*!40000 ALTER TABLE `fs_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `fs_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fs_shared_cache`
--

DROP TABLE IF EXISTS `fs_shared_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fs_shared_cache` (
  `user_id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `path` text NOT NULL,
  PRIMARY KEY (`user_id`,`folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_shared_cache`
--

LOCK TABLES `fs_shared_cache` WRITE;
/*!40000 ALTER TABLE `fs_shared_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `fs_shared_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fs_shared_root_folders`
--

DROP TABLE IF EXISTS `fs_shared_root_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fs_shared_root_folders` (
  `user_id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_shared_root_folders`
--

LOCK TABLES `fs_shared_root_folders` WRITE;
/*!40000 ALTER TABLE `fs_shared_root_folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `fs_shared_root_folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fs_status_history`
--

DROP TABLE IF EXISTS `fs_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fs_status_history` (
  `id` int(11) NOT NULL DEFAULT '0',
  `link_id` int(11) NOT NULL DEFAULT '0',
  `status_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `ctime` int(11) NOT NULL DEFAULT '0',
  `comments` text,
  PRIMARY KEY (`id`),
  KEY `link_id` (`link_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_status_history`
--

LOCK TABLES `fs_status_history` WRITE;
/*!40000 ALTER TABLE `fs_status_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `fs_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fs_statuses`
--

DROP TABLE IF EXISTS `fs_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fs_statuses` (
  `id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_statuses`
--

LOCK TABLES `fs_statuses` WRITE;
/*!40000 ALTER TABLE `fs_statuses` DISABLE KEYS */;
/*!40000 ALTER TABLE `fs_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fs_templates`
--

DROP TABLE IF EXISTS `fs_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fs_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `acl_id` int(11) NOT NULL,
  `content` mediumblob NOT NULL,
  `extension` char(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_templates`
--

LOCK TABLES `fs_templates` WRITE;
/*!40000 ALTER TABLE `fs_templates` DISABLE KEYS */;
INSERT INTO `fs_templates` VALUES (1,1,'Microsoft Word document',28,'PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0_rels/.rels≠íMKAÜÔ˝CÓ›l+à»Œˆ\"Bo\"ıÑôÏÓ–Œ3i≠ˇﬁA\n∫Pä†«ºyÛ“mŒ˛†NúããA√™iAq0—∫0jx€=/`”/∫W>ê‘Jô\\*™ﬁÑ¢aIèà≈LÏ©41q®õ!fOR«<b\"≥ßëq›∂˜ò2†ü1’÷j»[ªµ˚H¸76z≤$Ñ&f^¶\\Ø≥8.Nyd—`£y©q˘j4ïx]h˝{°8ŒS4GœAÆyÒY8X∂∑ï(•[Fwˇi4o|Àº«l—^‚ãÕ¢√ŸÙüPKË–#Ÿ\0\0\0=\0\0PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/_rels/document.xml.rels≠ëM\n¬0Ö˜û\"Ãﬁ¶Uë¶nDp+ı\01ù∂¡6	…(z{äZ(‚¬Â¸}Ô1/__˚é]–mçÄ,IÅ°Q∂“¶p(∑”%¨ãIæ«NR\\	≠vÅ≈¥Dn≈yP-ˆ2$÷°âì⁄˙^R,}√ùT\'Ÿ ü•ÈÇ˚O&€U¸Æ Äï7áø∞m]kÖ´Œ=\Z\Zë‡ÅnÜHîæA®ì»>.?˚ß|m\rïÚÿ·€¡´ıÕƒ¸Ø?@¢òÂÁûùßÖIŒ·wPK˘/0¿≈\0\0\0\0\0PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/settings.xmlEéK¬0D˜ú\"Úí≤‡Së≤„¿Bk†RbG±°¿È	+ñ£73zª˝+EÛƒ\"#ìáf·¿ ı<åtÛp>Ê0¢ÅÜô–√ˆ›l7µÇ™µ%¶>ê¥ìáªjn≠ï˛é)»Ç3ReW.)hçÂf\'.C.‹£Hù¶hóŒ≠l\n#AW/?Ã…Lm∆“#i’iÿ\ZQO·rTŒµÚ—√⁄mÿ˛]∫/PKe˙÷\"•\0\0\0–\0\0\0PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/fontTable.xml≠ê¡N√0ÜÔ<Eî;KŸM’∫		q‰\0„º‘]#%qáÜæ=Y€ù(“@ª%ˆÔˇ˚ÌÌ˛ÀY—c`Cæí´B\nÙöj„Oï¸8º‹o§‡æK+9 À˝Ónõ Ü|dë«=ó°ímå]©Îä:Ùπ◊PpÛ7ú5ç—¯L˙”°èj]è*†Öò—‹öéÂÏñÆqKÍ.êFÊú’Ÿ…œÅÒr7ß©Ù‡rËÉq»‚ìx#ì@∑œöl%ãB™qú±√•\ZF˘ÿËL‘Ì•ﬁC0p¥xn©	ˆ˙>∏#ŸE÷˙÷¨ß,YF-Æ≈…0ˇu≈-77øÂØ˚-£˛¥ﬂ¸‡›7PKëàZ]\0\0\0\0PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/styles.xml•TQo⁄0~ﬂØà¸Nh£5Tå©	±©–Ω…Aº9∂Âs\ZËØüíj¥†xâÌÛ›ÂæÔ;ﬂ˝√6¡\Z‚JF¨s”f X%\\n\"ˆº|lıY@dBIåÿâ=ø‹≤;Å∏xIÉ\"b©µzÜßò›(ç“›≠ï…¿∫£ŸÑÖ2â6*F\"ó>a∑›ÓÖp…Üu¬†ZßIƒ ç+®ÿùvˇ÷``c@ß•ªÑÃ{øÄàÿ\\C.l∞,,ØqkÎÎ*Qi◊øå_\nû®b¨§5J‘nkTESÆµquér´&;ù¢§⁄Àöºt\nﬂrôjytÈºPÃyƒñ<s¸Ã±ûT“„à)b3ïrL∏L∏7!ê‚¸ŒÉHÚÈH“ë,ey± ‘Å´±™˙µ∂uø÷ñ1Ω∑	êg[Òƒ•Oyk:?¨„5mçKSÖ≤ıº®ñ@√J°”íuæ5—lÇ‡ªl_”\nìüÚò`ÑÏÙî¸ã®ÁŒgèWCÃKx∞∂h\\GwÀZ°kDÙ¥k•uA9à≈[»a|™Ô»p™∫è}/Zˇàh˝3πÔ5·~È9˝Æí›’ÏF¯•tüÅ¯∂	‚\'{\Zl\rÍ#⁄€ˇ–ûÓà˜pûd˝&\0∆†≠õ—÷?¨öl3.qûg+7˙Ωº˙Â·©˝wLçgÿ‹ﬁ5·v*‹^¿Ï]fØlözG√PK’îqË\0\0´\0\0PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/document.xmlçRÀn¬0º˜+\"ﬂ¡°TàF.®∑VH–0Œ&±d{#{!–ØØM–K≈≈õ—Ãæ&ª⁄\\åNŒ‡ºBõ≥Ÿ4e	XâÖ≤UŒæì%K<	[çrvœ6ÎóUõ(O,%°ÇıÊÏ‰lÊe\rF¯âQ“°«í&MÜe©$ÙÅı.g5Qìqﬁ\'M±∏ù†´xó≤Ì{Ò◊4]pZPò◊◊™ÒCµÛ˝œF∫ˆôÆ-∫¢q(¡˚`Ñ—]_#îÀÃ“\'éu∆åÊôŒÖÌCÀøÉl;í≠É˝G,Æ16∑gÁnaOW\rIõùÖŒôè e|Ω‚£¢{‚7àù\"R$uJ∫6c%⁄â\nb≠ ¨ˆ?Å©√π,ñÛpm4u6{OÉ‡S∏$éHÑ&RÛ∑®*	¬_O#®Nt5àb\ZJ∫\'9U’ê∞ÈAﬂÍÎd›®•	∫§2Bwl4vÁêÜ=J°}øÖï∂ Öu√!\rºvácÔ◊`úÊ˜ã_ˇPKó˙Åly\0\06\0\0PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0docProps/app.xmlù–=k√0‡Ωø¬à¨∂TcL≤BCÈh∑t3ätN¨§sp˛}’öÃè˜xxÔ¯v±SqÅòåwy¨)¿)Øç;v‰Ω)◊§H(ùñìw–ë+$≤¸-˙\0\r§\".u‰Ñ6î&u+Sïcóì—G+1èÒH˝8\Zœ^Õ“ö±ñ¬Ç‡4Ë2¸Å‰W‹\\ø®ˆÍª_˙ËØ!{Ç˜Â‘Çqz¯SìQÛÒbo^4⁄T¨™´zµ7n^Üœu;¥Mq∑0‰∂gPH∆,[Ìf3È≤ÊÙﬁ„Ùˆ#ÒPK(Îõ‚\0\0\0h\0\0PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0docProps/core.xmlmë[O¬0ÜÔ˝KÔ∑∂ Dõm\\h∏íƒDåÜª¶˚’ıê∂2¯˜∂&\ZÓ˙Â}˙ÙñãΩÍ≤8/çÆ- @”H›VËuΩÃÔPÊ◊\rÔåÜ\n¿£E}S\nÀÑqÏå$¯,ä¥g¬VhÇe{±≈}	√„qt-∂\\|ÒÑê9Vx√«Iò€—àN FåJ˚Ì∫A–(–¡cZP¸À*ÆÓ8át\0ß¸UxHFrÔÂHı}_Ù”Åã˜ß¯}ıÙ2<5ó:}ï\0Tó\'5xÄ&ãvºÿ9yõ><Æó®û:Õ…,ßÛ5%lvœncdS‚ä‰<Æç´W‡‰ßŒ“π.Vï‡1K›8ÿ…TiMJ|9”ﬂ‚ÍPKø¬i\0\0\0\0PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0[Content_Types].xmlΩî1O√0Ö˜˛ä»+JBI: 1Bá0#c_ãƒ∂|¶¥ˇûsh#®¥∞X≤¸Ó}œÁìãÂfËì5x‘÷îÏ<ÀYFZ•M[≤á˙6ΩbÀjQ‘[òê÷`…∫‹5Á(;f÷Å°ì∆˙A⁄˙ñ;!üE¸\"œ/π¥&Ä	ià¨*Ó	ÁµÇd%|∏îå?zËëgqe…Õ{AdñL8◊k)Â„k£>—“)Vé\ZÏ¥√30˛=È’zµ√)+_e$ˇ74B‘\\å–üÒl”h	SËËÊºïÄH~tÉΩÛlÑÜ†µxÍ·Ù&Î˘>Ñm—Ö—wˇÒÌO`:Ñ6árêpÂ≠CN¿£c¿Ü*®î≤8AÓ¡ƒñ÷ˇbˆ£´øˇãÍ\rPKcÓ§a*\0\0^\0\0PK\0\0\0H∞BË–#Ÿ\0\0\0=\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0_rels/.relsPK\0\0\0H∞B˘/0¿≈\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/_rels/document.xml.relsPK\0\0\0H∞Be˙÷\"•\0\0\0–\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0!\0\0word/settings.xmlPK\0\0\0H∞BëàZ]\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/fontTable.xmlPK\0\0\0H∞B’îqË\0\0´\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0F\0\0word/styles.xmlPK\0\0\0H∞Bó˙Åly\0\06\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0õ\0\0word/document.xmlPK\0\0\0H∞B(Îõ‚\0\0\0h\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0S\0\0docProps/app.xmlPK\0\0\0H∞Bø¬i\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0s	\0\0docProps/core.xmlPK\0\0\0H∞BcÓ§a*\0\0^\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0—\n\0\0[Content_Types].xmlPK\0\0\0\0	\0	\0<\0\0<\0\0\0\0','docx'),(2,1,'Open-Office Text document',29,'PK\0\0\0\0\0K;\Z9^∆2\'\0\0\0\'\0\0\0\0\0\0mimetypeapplication/vnd.oasis.opendocument.textPK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\Z\0\0\0Configurations2/statusbar/PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\'\0\0\0Configurations2/accelerator/current.xml\0PK\0\0\0\0\0\0\0\0\0\0\0PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/floater/PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\Z\0\0\0Configurations2/popupmenu/PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/progressbar/PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/menubar/PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/toolbar/PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/images/Bitmaps/PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0content.xml•VÀn!›˜+F,∫c\']$Sè£JQ•JIMZuKÄ±iyLÅÒÿ_û1N2	í7∂πúsπús/ovÇ[™\rS≤ãŸTbEò\\◊‡Á„◊Ú\n‹¨>,U”0L+¢p\'®¥%V“∫Ô¬±•©‚l\r:-+Ö3ïDÇö ‚JµT¨*EWa≠1vœ≥Èú≤-›Ÿ\\≤«ûp—S˛ ú≤âF}.Ÿcù®)ΩQπ‰ù·e£úÍ¢Eñ=´b«ô¸[Éçµmaﬂ˜≥˛r¶Ù\Z.ÆØØaò∆#ÆÌ4(Ç!Â‘/f‡b∂ÄVPãrÎÛÿ¥$Ÿâ\'™≥•AΩp’l◊Ÿ±]OHÉ7Hg˜F\0ü⁄{IÚÌΩ$)W ªô‰\nﬁª…qwÏ-r◊Úÿ©∞fmˆ6#:Â+•∆R=!–PÓ≈|˛	∆qÇÓﬂÑ˜öY™8~é«£‚Jº&ö√-†CîtÎ€tl|/Ñô \\¿8=Ç\rôL˝˚˛Óo®@G0{\\2i,íGe\ZF˘–0„F^–]K5Û6 Ó4ÒõQ§q)úT™≠í—ô9πô`5\\√—B«@„Æ„≤AòñÑbnVÀxú∆p«æî\Z<∫2LÒùˆ≈%êÖ;?T0æØ¡G‘*Û˘.Aqí⁄„À5ïnoŒe}»wD¥Ãbw∂H3y¯vi_åøR–ü^⁄ÙÃòsñæ•–ØÆx@“L*í`2‘0{c©xØ&8e·!é:ÎTµó!Ob˙ì\"˚q‡∂’2<oÜ˛Î‹>&z,Bà0”r¥/Ug›AKÓNØÅkæ0e˘∆yg¨v(ÈÀ=+Ÿ„∞ÈÛ≤∏üg\'πçœqp`Zµ6RÇÚe$>∏#Oê&©wQ|x‚ú¯À¥˙PK’\0=@ê\0\0s	\0\0PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0styles.xmlÕYKè€6æ˜W*⁄mÀªõÆ›ÏEã¢íö¥◊Äñhã	E\n$eŸ˘ıí¢DÀíW˚H·=, ŒpÊ„<…ÒÎ7˚úMvD**¯]OÁ—ÑD§îoÔ¢?˛ân£7˜?ºõ\rM»*IôÆë“F‘6sµrƒª®î|%∞¢j≈qN‘J\'+QÓ7≠BÓïUÂV¨∞±€-s∏[ìΩªŸÌ≈ÎÒö-s∏;ï∏\ZªŸÇM√Ì1vÛ^1¥(yÅ5Ì†ÿ3 ø‹Eô÷≈j6´™jZ]MÖ‹Œ‚Âr9≥‘p“•dñ+MfÑ£LÕ‚i<Ûº9—x,>√B‚eæ&r¥i∞∆\'^UªÌËàÿmLìdXéé\rÀ|Ïﬁ´tº{Ø“poéu6‡ì€Ÿ; ⁄Ôﬁ∂± Û±∫Ôë©Iã—«t‹·~!D’lp	j·.ÊÛÎô˚∏´≥Ïï§ö»Ä=9Àû`ñ4yü—Ä/û\";¶—§.!AŸä£{_£6Í”\'•$aÍ˛µã≠fy‚æççÓ¢è,5yO™…?\"«<ö@0y÷ú≤√]Ù3.Ñ˙µ√Á£…ëh√è∂ÑI·»≤ñ◊rT\';,©©$—Ï<¥ﬂÄçı\0ÚÎ√™UEïzéÍ?»g¸_9˘Äπ\Z¥H¿3¬\ZÍ†4…¬4raΩÓ∫é«ûí\r.Y›ãº‰\Z„V‚\"£I‰yÎoTHàA©)8”T‰ï p**Ú—hÕßW	‡Ï!:D\rÂAu%H8Å⁄é2!ÈWÄéôa]‹ûeﬁ…)+$ÏX©\'¨=2k≥08GEuÜ\\∑‹`¶Ç((∞ƒ÷B°}…#\\jat@h–î«äYëaØ¿¬XKÇ°)\r.◊ûb Å¡ñã∂3âÙ˙((Oâ©RÊV∆ÉÙ°˚ÇßE°Lú√nÿ\rÓì”îäÄ∏Ò™Uû&†OiYB}€áH—ØÄ4^⁄Æ1Ã∑%ﬁ¬gv!%◊¬·˝€Ê¯DCÕC_à‰∫ú“»DPõ±©VÛÈM—ÿ«ã˜‘Ø˚Ω\'’ä<Öﬁ#‘t>FˆpGhCÌ€–¨‡÷¨Gy5&Ÿ\Z?Dg\nLóäåph‘Ç#Ü”lf—‡˝ú6\'wE…]:Åê°}¿—¡¶(îRHOnîƒ”≈M‹fÕqË`œ6eû_ÅÁöœ˜å@£“G“q}ˇŒQj7±vVıK≈rjƒín¸Iíc ëπˆ˘ \\ú0• :,œH˚Ç+\Z#aπ∆ZHì&Ë†êC1\\(—œUå§®: a•ì°_)ê[¢3sÉ7¯ê‚P°ÏêO)ñi4X(º˚V\n‡A2µ©u*Ô/Ç” ß≈¡BÛ8E˝P∏…€ê·#,|ZÃ?≠EzËÉıPIÀ±Ñz&+L◊Ω^ÿÆ€ÆØÖ÷ÊV\r9^‘$kc€çπÌ∆òU¯†™-A·®ØÄùrq›ÊÃ”2æW¿c3◊iÊÅ@È3>î„Ç·C‡ûIH~éÛüÏ◊Û>}‹∑–iûré31 å»Ås‰Ë≈c|Ù;.L)|A˚JâôXmˆ%ñùÌ∏…ÉΩH™¶[äΩ¯¡ƒ|8Ÿz∞[sÉ*\nwqx[ú5Ô—ö§¶mÓÌ}¡ˆÜ^Ìøø·nΩAÔQ+Ô¨˜^»è\n_+Yî⁄Ω!z÷ŸVwG√,Ä∏¶5î92≥%π9ü…Øzk˜Ä95óÿ5P⁄$ºo„∫$iâkq°∏Æ.◊ıÖ‚∫πP\\Ø.◊/äÎˆBq-/W<ˇˇÅìB¥\\h¢†âÚ\r›ñ“>Ó&\r’≠m#Ñ6ﬂ}¿„∫yπQﬁ≥“†™˝FÖ\n°®∂Ci;/˜∏ég\nFûÀõçGHx:êˆÙ‚çEZ}j˚µÄ⁄ÁÕrŸéG˙¨Si≠¿»F◊4 ih251òˆZiÌê◊<9A&Mê\'¯õ∆ºç‡›£˚Më«QOÁNg)MÕœ2ã˘tÈ‚	°€ÃºÓó”WgéX+j$$Ö£‡⁄◊B¬ïñÍ®{q∏¥vñçëNe\rih’•∫\0D9ﬁ7ß1œñv–_3(RxqŒ\ZÛÈ<æmï¯îCk\'∑¸Ü\'û«=<xcÜN},8˝\\*ÌºÌb¿≠KHVÔÜõü⁄1éùì˝8∑Q8‚Ìs®?TF∞ïÿèYx“`ÒTPyß°Vr¨\Zç∂z—H:;Ì1∑!\Z|G˙¨ˇ«ı˚oPKÍÑE—}\0\0ú\0\0PK\0\0\0\0\0K;\Z9ëgä≤\0\0\0\0\0\0\0meta.xml<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<office:document-meta xmlns:office=\"urn:oasis:names:tc:opendocument:xmlns:office:1.0\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:meta=\"urn:oasis:names:tc:opendocument:xmlns:meta:1.0\" xmlns:ooo=\"http://openoffice.org/2004/office\" office:version=\"1.1\"><office:meta><meta:generator>OpenOffice.org/2.4$Linux OpenOffice.org_project/680m17$Build-9310</meta:generator><meta:initial-creator>Merijn Schering</meta:initial-creator><meta:creation-date>2008-08-26T09:26:02</meta:creation-date><meta:editing-cycles>0</meta:editing-cycles><meta:editing-duration>PT0S</meta:editing-duration><meta:user-defined meta:name=\"Info 1\"/><meta:user-defined meta:name=\"Info 2\"/><meta:user-defined meta:name=\"Info 3\"/><meta:user-defined meta:name=\"Info 4\"/><meta:document-statistic meta:table-count=\"0\" meta:image-count=\"0\" meta:object-count=\"0\" meta:page-count=\"1\" meta:paragraph-count=\"0\" meta:word-count=\"0\" meta:character-count=\"0\"/></office:meta></office:document-meta>PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Thumbnails/thumbnail.pngÎsÁÂí‚b``‡ıÙp	“[8ÿÄ¨Ø Ê∑òˆ{∫8ÜTÃy{i#\'ÉœÅ\r|?ˇ?˝“Èt–Cº‚√õwçì~ 2¨ü9K&xrrVëèoﬂ ìÜ¶ñÀ‘é_y2cTpTp¿≈œÂ≤˝3\nˇ*L—ûÆ~.Îúö\0PKÑ◊É£|\0\0\0¯\0\0PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0settings.xmlµYQs‚8~ø_—…;JoÔ ¥Ï∫Ï±•Ö∫ù€7ì»’±2∂S‡ﬂüÏÑN°K	~¢Ml…í•ÔìîÎØ´òüΩÄTäØ~^ÛŒ@Fb~„=N∫ïøΩØ≠?Æq6ãhÜ§1]Q†5-Qg¥]®fˆ˙∆K•h\"Sëj\nÉjÍ†â	àÕ∂Ê€’M´,{≤‚ëxæÒZ\'Õjuπ\\û/Á(Á’˙’’U’æ›,\rPÃ¢˘°™≤’oU!‚´\"≥!;åUvQ´]V≥ˇΩ≥¸êo\\S˜Z?lÃo]Á\n≤üJ§!6æ9Àõ£›x§≤˘¡Ú’k^—æ˜{~“z_õ`‚mﬁËuBo\"°ΩVÌ∫∫+·p©}òÈ\"±ïz≠^˚´úÏß(‘ã\"·óçã∆üÂdˇ—|QxÚãz˝ÍH·„.GRêAg¡ƒ‘ñÇ)\"&ºññ)ß£\'⁄ó\nÓ1Ñ}“gå´É≈WbñT\"¬\n¬]_Gò›Cπ!◊áyºnUiI·ÎµL0_ì˚¢ØQ´ïê∫\'S U—îÉõ\\±¢Où‹VËh_ä4\Zıã/•D∑Qkå˜•_„8Ÿø„	I⁄éµ „}aÑvY†Qã≠◊é‹Sc‡hªíëÀﬂ&Êæ◊yÆ/ b9úä≤©döàÌ3ú‰á·êI6a\n„ÑNéîCÇ=√ª∞ç?«AÂ{˘ÉT§Ôì˛o<Ti<˘Å1%¥ı©ryLB¶ãêã%ı-NÙz»‹p÷\\†Ñn$ï&3†G(tO∏tÒØ§¨Ÿ¡8ë†LÈurl∞éì~‡tØ„Jòë›xW∞Aúp˙€QûY“ËÉN∑π‰ñP [úÃf.|eÌ0Î(äÛ n(QlS<›¡z[SÂ≤	&◊^ı¿#[tpﬁ¸†]î€D{™”~™1QGaŸA‚2‰NºC‚AÜ˚\'o1É7∫FÂã∞ÕôxV‰tÉt∆Éî[ztæ®≠Ü˝ºp$ºıëÖ#`!\næËßAS‰¸?Aõ‡.nõt}[—u∆˚dëìz√Oæ~T oôfßﬂ5%ÜÀÑ≥¯ô\r)¢√Qù¶ø‹UÚù„îÒ€|æb\nt–Swtﬂæäò¶\"–©´4Ùy4ºcç…UÙëö„oß√£ƒWØeç/ mü$-ï]æ∂‰Í¬èùTJ∫&‘ÕÔSÏ`M÷“Äó∑¯Ä∫√ùJ∏ïl9ò˛ß¬∞∂É„[T·Ú¿EYì”»√nw∏?¨å.[ïBL©¢‰V˙I≤d »≠é.äRÊñﬂ1pVœŸÑ´∂DıŸ^Å»çßL˘∂¯M£[ûIﬂ∂”æk*–NÔ¥Wì6Åñ∏±…Çƒ®W0¶˘ZKSTQÀÿE\'WïuAUB5≥+˘ﬂ…_ã≤•DÒ¡9.≠ÍD;L¿p–{*†÷:f\",h´ÀÌ≈ˇHïéfkì6Í)“ã{&R∆€ÿ≥éP#0u˙L0O8Ãfä±M©‡&}rt6∂òoY¶ŒbkL∑Õ⁄Ã·≥	\nyjŒTÜ\\NuÚQ≈⁄,xûKL≈ﬁ¡ﬁ©£ºªõ2«ŒF›Ù±‘tœù–ΩXQ‹$Rıõ˛ÈìÛj;oÆÓ|≠Ó˚L‹˙PKtëá€\0\0h\0\0PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0META-INF/manifest.xmlµïKj√0@˜=Ö—ﬁV€U1q-ÙÈ&ÚÿËáfí€W‰”6î¶X;	§˜F#Õh±⁄[SÌ0íˆÆOÕ£®–)ﬂk7v‚c˝^øà’Úaa¡Èâ€”† ˚ùßùH—µHSÎ¿\"µ¨Z–ı^%ãé€ØÎ€…¥|®.‡A¨Û¬x®.2Ï5‘|ÿ	¡hú„î;◊7GWs≠h˜,.ªádLÄ∑ùêBﬁ%ªMyÛn–cä« ËY\'⁄@,É•–`û˙(Uäq:bŒbqW¡`<0ÇR»O ¬G?F§r7=Ö^ŒﬁõbpmaDíØö-*Í∏ì˝Ω_PrSı4I7ÍZ∑ÓîOùHNµzû˝¸øb˛ùK|0H≥c-2Ã÷x÷€d7¥!…ßa‹87|ﬁƒ\"s˛œ©]»ˇ·ÚPK5b◊9>\0\0J\0\0PK\0\0\0\0\0\0K;\Z9^∆2\'\0\0\0\'\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0mimetypePK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\Z\0\0\0\0\0\0\0\0\0\0\0\0\0M\0\0\0Configurations2/statusbar/PK\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\'\0\0\0\0\0\0\0\0\0\0\0\0\0Ö\0\0\0Configurations2/accelerator/current.xmlPK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0‹\0\0\0Configurations2/floater/PK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\Z\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/popupmenu/PK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0J\0\0Configurations2/progressbar/PK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Ñ\0\0Configurations2/menubar/PK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0∫\0\0Configurations2/toolbar/PK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/images/Bitmaps/PK\0\0\0\0K;\Z9’\0=@ê\0\0s	\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0-\0\0content.xmlPK\0\0\0\0K;\Z9ÍÑE—}\0\0ú\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0ˆ\0\0styles.xmlPK\0\0\0\0\0\0K;\Z9ëgä≤\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0´\0\0meta.xmlPK\0\0\0\0K;\Z9Ñ◊É£|\0\0\0¯\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ﬂ\0\0Thumbnails/thumbnail.pngPK\0\0\0\0K;\Z9tëá€\0\0h\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0°\0\0settings.xmlPK\0\0\0\0K;\Z95b◊9>\0\0J\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0∂\0\0META-INF/manifest.xmlPK\0\0\0\0\0\0Ó\0\07\0\0\0\0','odt');
/*!40000 ALTER TABLE `fs_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fs_versions`
--

DROP TABLE IF EXISTS `fs_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fs_versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_id` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `path` varchar(255) NOT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `size_bytes` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `file_id` (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_versions`
--

LOCK TABLES `fs_versions` WRITE;
/*!40000 ALTER TABLE `fs_versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `fs_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_acl`
--

DROP TABLE IF EXISTS `go_acl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_acl` (
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '0',
  `level` tinyint(4) NOT NULL DEFAULT '10',
  PRIMARY KEY (`acl_id`,`user_id`,`group_id`),
  KEY `acl_id` (`acl_id`,`user_id`),
  KEY `acl_id_2` (`acl_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_acl`
--

LOCK TABLES `go_acl` WRITE;
/*!40000 ALTER TABLE `go_acl` DISABLE KEYS */;
INSERT INTO `go_acl` VALUES (1,0,1,50),(1,1,0,50),(2,0,1,50),(2,0,2,10),(2,1,0,50),(3,0,1,50),(3,0,3,10),(3,1,0,50),(4,0,1,50),(4,1,0,50),(5,0,1,50),(5,0,3,10),(5,1,0,50),(6,0,1,50),(6,0,3,10),(6,1,0,50),(7,0,1,50),(7,0,2,10),(7,1,0,50),(9,0,1,50),(9,1,0,50),(10,0,1,50),(10,0,3,10),(10,1,0,50),(11,0,1,50),(11,0,3,10),(11,1,0,50),(12,0,1,50),(12,0,3,10),(12,1,0,50),(13,0,1,50),(13,1,0,50),(14,0,1,50),(14,0,3,10),(14,1,0,50),(15,0,1,50),(15,0,3,10),(15,1,0,50),(16,0,1,50),(16,0,3,10),(16,1,0,50),(17,0,1,50),(17,0,3,10),(17,1,0,50),(23,0,1,50),(23,0,3,10),(23,1,0,50),(24,0,1,50),(24,0,3,10),(24,1,0,50),(25,0,1,50),(25,1,0,50),(26,0,1,50),(26,1,0,50),(27,0,1,50),(27,0,3,10),(27,1,0,50),(28,0,1,50),(28,0,3,10),(28,1,0,50),(29,0,1,50),(29,0,3,10),(29,1,0,50),(30,0,1,50),(30,0,3,10),(30,1,0,50),(31,0,1,50),(31,0,3,50),(31,1,0,50),(32,0,1,50),(32,1,0,50),(33,0,1,50),(33,1,0,50),(34,0,1,50),(34,1,0,50),(35,0,1,50),(35,0,2,40),(35,1,0,50),(36,0,1,50),(36,1,0,50),(37,0,1,50),(37,0,3,10),(37,1,0,50),(38,0,1,50),(38,0,3,10),(38,1,0,50),(39,0,1,50),(39,0,3,10),(39,1,0,50),(40,0,1,50),(40,0,3,10),(40,1,0,50),(41,0,1,50),(41,1,0,50),(42,0,1,50),(42,0,3,10),(42,1,0,50),(43,0,1,50),(43,0,3,10),(43,1,0,50),(44,0,1,50),(44,1,0,50);
/*!40000 ALTER TABLE `go_acl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_acl_items`
--

DROP TABLE IF EXISTS `go_acl_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_acl_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `description` varchar(50) DEFAULT NULL,
  `mtime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_acl_items`
--

LOCK TABLES `go_acl_items` WRITE;
/*!40000 ALTER TABLE `go_acl_items` DISABLE KEYS */;
INSERT INTO `go_acl_items` VALUES (1,1,'go_groups.acl_id',1482907222),(2,1,'go_groups.acl_id',1482907222),(3,1,'go_groups.acl_id',1482907222),(4,1,'go_modules.acl_id',1482907222),(5,1,'go_modules.acl_id',1482907222),(6,1,'go_modules.acl_id',1482907222),(7,1,'no_categories.acl_id',1482907222),(9,1,'go_modules.acl_id',1482907222),(10,1,'go_modules.acl_id',1482907222),(11,1,'go_modules.acl_id',1482907222),(12,1,'bm_categories.acl_id',1482907222),(13,1,'go_modules.acl_id',1482907222),(14,1,'go_modules.acl_id',1482907222),(15,1,'go_modules.acl_id',1482907222),(16,1,'go_modules.acl_id',1482907222),(17,1,'go_modules.acl_id',1482907222),(23,1,'go_modules.acl_id',1482907222),(24,1,'go_modules.acl_id',1482907222),(25,1,'go_modules.acl_id',1482907222),(26,1,'go_modules.acl_id',1482907222),(27,1,'go_modules.acl_id',1482907222),(28,1,'fs_templates.acl_id',1482907222),(29,1,'fs_templates.acl_id',1482907222),(30,1,'go_modules.acl_id',1482907222),(31,1,'go_users.acl_id',1482907222),(32,1,'ab_addressbooks.acl_id',1482907887),(33,1,'ta_tasklists.acl_id',1482907222),(34,1,'cal_calendars.acl_id',1482907222),(35,1,'fs_folders.acl_id',1482907222),(36,1,'addressbook_export',1482907270),(37,1,'go_modules.acl_id',1482907287),(38,1,'go_modules.acl_id',1482907303),(39,1,'go_modules.acl_id',1482907309),(40,1,'go_modules.acl_id',1482907319),(41,1,'go_modules.acl_id',1482907383),(42,1,'go_modules.acl_id',1482907417),(43,1,'go_modules.acl_id',1482907610),(44,1,'fb_acl',1482907811);
/*!40000 ALTER TABLE `go_acl_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_address_format`
--

DROP TABLE IF EXISTS `go_address_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_address_format` (
  `id` int(11) NOT NULL,
  `format` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_address_format`
--

LOCK TABLES `go_address_format` WRITE;
/*!40000 ALTER TABLE `go_address_format` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_address_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_advanced_searches`
--

DROP TABLE IF EXISTS `go_advanced_searches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_advanced_searches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `data` text,
  `model_name` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_advanced_searches`
--

LOCK TABLES `go_advanced_searches` WRITE;
/*!40000 ALTER TABLE `go_advanced_searches` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_advanced_searches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_cache`
--

DROP TABLE IF EXISTS `go_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_cache` (
  `user_id` int(11) NOT NULL,
  `key` varchar(190) NOT NULL DEFAULT '',
  `content` longtext,
  `mtime` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`key`),
  KEY `mtime` (`mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_cache`
--

LOCK TABLES `go_cache` WRITE;
/*!40000 ALTER TABLE `go_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_cf_setting_tabs`
--

DROP TABLE IF EXISTS `go_cf_setting_tabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_cf_setting_tabs` (
  `cf_category_id` int(11) NOT NULL,
  PRIMARY KEY (`cf_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_cf_setting_tabs`
--

LOCK TABLES `go_cf_setting_tabs` WRITE;
/*!40000 ALTER TABLE `go_cf_setting_tabs` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_cf_setting_tabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_countries`
--

DROP TABLE IF EXISTS `go_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_countries` (
  `id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(64) DEFAULT NULL,
  `iso_code_2` char(2) NOT NULL DEFAULT '',
  `iso_code_3` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_countries`
--

LOCK TABLES `go_countries` WRITE;
/*!40000 ALTER TABLE `go_countries` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_cron`
--

DROP TABLE IF EXISTS `go_cron`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_cron` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `minutes` varchar(100) NOT NULL DEFAULT '1',
  `hours` varchar(100) NOT NULL DEFAULT '1',
  `monthdays` varchar(100) NOT NULL DEFAULT '*',
  `months` varchar(100) NOT NULL DEFAULT '*',
  `weekdays` varchar(100) NOT NULL DEFAULT '*',
  `years` varchar(100) NOT NULL DEFAULT '*',
  `job` varchar(255) NOT NULL,
  `runonce` tinyint(1) NOT NULL DEFAULT '0',
  `nextrun` int(11) NOT NULL DEFAULT '0',
  `lastrun` int(11) NOT NULL DEFAULT '0',
  `completedat` int(11) NOT NULL DEFAULT '0',
  `error` text,
  `autodestroy` tinyint(1) NOT NULL DEFAULT '0',
  `params` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_cron`
--

LOCK TABLES `go_cron` WRITE;
/*!40000 ALTER TABLE `go_cron` DISABLE KEYS */;
INSERT INTO `go_cron` VALUES (1,'Calendar publisher',1,'0','*','*','*','*','*','GO\\Calendar\\Cron\\CalendarPublisher',0,1482910200,0,0,NULL,0,'[]'),(2,'Email Reminders',1,'*/5','*','*','*','*','*','GO\\Base\\Cron\\EmailReminders',0,1482907500,0,0,NULL,0,'[]'),(3,'Calculate disk usage',1,'0','0','*','*','*','*','GO\\Base\\Cron\\CalculateDiskUsage',0,1482949800,0,0,NULL,0,'[]');
/*!40000 ALTER TABLE `go_cron` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_cron_groups`
--

DROP TABLE IF EXISTS `go_cron_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_cron_groups` (
  `cronjob_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`cronjob_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_cron_groups`
--

LOCK TABLES `go_cron_groups` WRITE;
/*!40000 ALTER TABLE `go_cron_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_cron_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_cron_users`
--

DROP TABLE IF EXISTS `go_cron_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_cron_users` (
  `cronjob_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`cronjob_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_cron_users`
--

LOCK TABLES `go_cron_users` WRITE;
/*!40000 ALTER TABLE `go_cron_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_cron_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_db_sequence`
--

DROP TABLE IF EXISTS `go_db_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_db_sequence` (
  `seq_name` varchar(50) NOT NULL DEFAULT '',
  `nextid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`seq_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_db_sequence`
--

LOCK TABLES `go_db_sequence` WRITE;
/*!40000 ALTER TABLE `go_db_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_db_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_groups`
--

DROP TABLE IF EXISTS `go_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `acl_id` int(11) NOT NULL,
  `admin_only` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_groups`
--

LOCK TABLES `go_groups` WRITE;
/*!40000 ALTER TABLE `go_groups` DISABLE KEYS */;
INSERT INTO `go_groups` VALUES (1,'Admins',1,1,0),(2,'Everyone',1,2,0),(3,'Internal',1,3,0);
/*!40000 ALTER TABLE `go_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_holidays`
--

DROP TABLE IF EXISTS `go_holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_holidays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `region` varchar(10) NOT NULL DEFAULT '',
  `free_day` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `region` (`region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_holidays`
--

LOCK TABLES `go_holidays` WRITE;
/*!40000 ALTER TABLE `go_holidays` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_holidays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_link_descriptions`
--

DROP TABLE IF EXISTS `go_link_descriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_link_descriptions` (
  `id` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_link_descriptions`
--

LOCK TABLES `go_link_descriptions` WRITE;
/*!40000 ALTER TABLE `go_link_descriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_link_descriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_link_folders`
--

DROP TABLE IF EXISTS `go_link_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_link_folders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `model_id` int(11) NOT NULL DEFAULT '0',
  `model_type_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `link_id` (`model_id`,`model_type_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_link_folders`
--

LOCK TABLES `go_link_folders` WRITE;
/*!40000 ALTER TABLE `go_link_folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_link_folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_links_ab_companies`
--

DROP TABLE IF EXISTS `go_links_ab_companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_links_ab_companies` (
  `id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `model_type_id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_links_ab_companies`
--

LOCK TABLES `go_links_ab_companies` WRITE;
/*!40000 ALTER TABLE `go_links_ab_companies` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_links_ab_companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_links_ab_contacts`
--

DROP TABLE IF EXISTS `go_links_ab_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_links_ab_contacts` (
  `id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `model_type_id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_links_ab_contacts`
--

LOCK TABLES `go_links_ab_contacts` WRITE;
/*!40000 ALTER TABLE `go_links_ab_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_links_ab_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_links_cal_events`
--

DROP TABLE IF EXISTS `go_links_cal_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_links_cal_events` (
  `id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `model_type_id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_links_cal_events`
--

LOCK TABLES `go_links_cal_events` WRITE;
/*!40000 ALTER TABLE `go_links_cal_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_links_cal_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_links_em_links`
--

DROP TABLE IF EXISTS `go_links_em_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_links_em_links` (
  `id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `model_type_id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_links_em_links`
--

LOCK TABLES `go_links_em_links` WRITE;
/*!40000 ALTER TABLE `go_links_em_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_links_em_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_links_fs_files`
--

DROP TABLE IF EXISTS `go_links_fs_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_links_fs_files` (
  `id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `model_type_id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_links_fs_files`
--

LOCK TABLES `go_links_fs_files` WRITE;
/*!40000 ALTER TABLE `go_links_fs_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_links_fs_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_links_fs_folders`
--

DROP TABLE IF EXISTS `go_links_fs_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_links_fs_folders` (
  `id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `model_type_id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_links_fs_folders`
--

LOCK TABLES `go_links_fs_folders` WRITE;
/*!40000 ALTER TABLE `go_links_fs_folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_links_fs_folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_links_go_users`
--

DROP TABLE IF EXISTS `go_links_go_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_links_go_users` (
  `id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `model_type_id` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_links_go_users`
--

LOCK TABLES `go_links_go_users` WRITE;
/*!40000 ALTER TABLE `go_links_go_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_links_go_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_links_no_notes`
--

DROP TABLE IF EXISTS `go_links_no_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_links_no_notes` (
  `id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `model_type_id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_links_no_notes`
--

LOCK TABLES `go_links_no_notes` WRITE;
/*!40000 ALTER TABLE `go_links_no_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_links_no_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_links_ta_tasks`
--

DROP TABLE IF EXISTS `go_links_ta_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_links_ta_tasks` (
  `id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `model_type_id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_links_ta_tasks`
--

LOCK TABLES `go_links_ta_tasks` WRITE;
/*!40000 ALTER TABLE `go_links_ta_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_links_ta_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_log`
--

DROP TABLE IF EXISTS `go_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL DEFAULT '',
  `model` varchar(255) NOT NULL DEFAULT '',
  `model_id` varchar(255) NOT NULL DEFAULT '',
  `ctime` int(11) NOT NULL,
  `user_agent` varchar(255) NOT NULL DEFAULT '',
  `ip` varchar(45) NOT NULL DEFAULT '',
  `controller_route` varchar(255) NOT NULL DEFAULT '',
  `action` varchar(20) NOT NULL DEFAULT '',
  `message` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_log`
--

LOCK TABLES `go_log` WRITE;
/*!40000 ALTER TABLE `go_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_mail_counter`
--

DROP TABLE IF EXISTS `go_mail_counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_mail_counter` (
  `host` varchar(100) NOT NULL DEFAULT '',
  `date` date NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`host`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_mail_counter`
--

LOCK TABLES `go_mail_counter` WRITE;
/*!40000 ALTER TABLE `go_mail_counter` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_mail_counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_model_types`
--

DROP TABLE IF EXISTS `go_model_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_model_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_model_types`
--

LOCK TABLES `go_model_types` WRITE;
/*!40000 ALTER TABLE `go_model_types` DISABLE KEYS */;
INSERT INTO `go_model_types` VALUES (1,'GO\\Files\\Model\\Folder'),(2,'GO\\Addressbook\\Model\\Contact'),(3,'GO\\Base\\Model\\User');
/*!40000 ALTER TABLE `go_model_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_modules`
--

DROP TABLE IF EXISTS `go_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_modules` (
  `id` varchar(20) NOT NULL DEFAULT '',
  `version` int(11) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `admin_menu` tinyint(1) NOT NULL DEFAULT '0',
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_modules`
--

LOCK TABLES `go_modules` WRITE;
/*!40000 ALTER TABLE `go_modules` DISABLE KEYS */;
INSERT INTO `go_modules` VALUES ('addressbook',295,11,0,17,1),('bookmarks',18,6,0,11,1),('calendar',163,8,0,14,1),('calendarexport',0,17,0,37,1),('comments',13,17,0,30,1),('cron',0,14,1,25,1),('customfields',99,9,0,15,1),('dav',1,22,0,42,1),('email',92,12,0,23,1),('favorites',8,23,0,43,1),('files',108,16,0,27,1),('freebusypermissions',4,18,0,38,1),('groups',0,15,1,26,1),('imapauth',0,19,0,39,1),('ipwhitelist',4,21,1,41,1),('modules',0,4,1,9,1),('notes',27,2,0,6,1),('reminders',0,20,0,40,1),('search',0,10,0,16,1),('sieve',0,1,0,5,1),('summary',17,13,0,24,1),('tasks',55,5,0,10,1),('tools',0,7,1,13,1),('users',0,0,1,4,1);
/*!40000 ALTER TABLE `go_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_reminders`
--

DROP TABLE IF EXISTS `go_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_reminders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) NOT NULL,
  `model_type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `time` int(11) NOT NULL,
  `vtime` int(11) NOT NULL DEFAULT '0',
  `snooze_time` int(11) NOT NULL,
  `manual` tinyint(1) NOT NULL DEFAULT '0',
  `text` text,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_reminders`
--

LOCK TABLES `go_reminders` WRITE;
/*!40000 ALTER TABLE `go_reminders` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_reminders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_reminders_users`
--

DROP TABLE IF EXISTS `go_reminders_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_reminders_users` (
  `reminder_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `mail_sent` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`reminder_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_reminders_users`
--

LOCK TABLES `go_reminders_users` WRITE;
/*!40000 ALTER TABLE `go_reminders_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_reminders_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_saved_exports`
--

DROP TABLE IF EXISTS `go_saved_exports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_saved_exports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `class_name` varchar(255) NOT NULL,
  `view` varchar(255) NOT NULL,
  `export_columns` text,
  `orientation` enum('V','H') NOT NULL DEFAULT 'V',
  `include_column_names` tinyint(1) NOT NULL DEFAULT '1',
  `use_db_column_names` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_saved_exports`
--

LOCK TABLES `go_saved_exports` WRITE;
/*!40000 ALTER TABLE `go_saved_exports` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_saved_exports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_saved_search_queries`
--

DROP TABLE IF EXISTS `go_saved_search_queries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_saved_search_queries` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sql` text NOT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_saved_search_queries`
--

LOCK TABLES `go_saved_search_queries` WRITE;
/*!40000 ALTER TABLE `go_saved_search_queries` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_saved_search_queries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_search_cache`
--

DROP TABLE IF EXISTS `go_search_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_search_cache` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `model_id` int(11) NOT NULL DEFAULT '0',
  `module` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `model_type_id` int(11) NOT NULL DEFAULT '0',
  `model_name` varchar(100) DEFAULT NULL,
  `keywords` varchar(255) NOT NULL DEFAULT '',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `acl_id` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`model_id`,`model_type_id`),
  KEY `acl_id` (`acl_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_search_cache`
--

LOCK TABLES `go_search_cache` WRITE;
/*!40000 ALTER TABLE `go_search_cache` DISABLE KEYS */;
INSERT INTO `go_search_cache` VALUES (1,1,'files','addressbook','addressbook',1,'GO\\Files\\Model\\Folder','Folder,addressbook,,',1482907222,32,'Folder'),(1,1,'addressbook','System Administrator (Users)','',2,'GO\\Addressbook\\Model\\Contact','Contact,af28c6e1-45c2-5581-949f-d601a29249bd,System,Administrator,M,support@technoinfotech.com,Dear Mr. Administrator,000000,,',1482907222,32,'Contact'),(1,1,'base','Administrator, System','',3,'GO\\Base\\Model\\User','User,groupofficeadmin,$2y$10$LQKH4WavnkG1r/KV9BTlrOV4UD9/RAziUtRKjLanqUSR3CbA/3Ywi,cfa2436b0f6df9e9905009e3bfca6f51,System,Administrator,support@technoinfotech.com,dmY,-,H:i,,,.,Rs,Asia/Kolkata,summary,en,Group-Office,last_name,;,\",crypt,,',1482908027,31,'User'),(1,2,'files','Users','addressbook/Users',1,'GO\\Files\\Model\\Folder','Folder,Users,,',1482907222,32,'Folder'),(1,3,'files','tasks','tasks',1,'GO\\Files\\Model\\Folder','Folder,tasks,,',1482907222,33,'Folder'),(1,4,'files','System Administrator','tasks/System Administrator',1,'GO\\Files\\Model\\Folder','Folder,System Administrator,,',1482907222,33,'Folder'),(1,5,'files','calendar','calendar',1,'GO\\Files\\Model\\Folder','Folder,calendar,,',1482907222,34,'Folder'),(1,6,'files','System Administrator','calendar/System Administrator',1,'GO\\Files\\Model\\Folder','Folder,System Administrator,,',1482907222,34,'Folder'),(1,7,'files','users','users',1,'GO\\Files\\Model\\Folder','Folder,users,,',1482907222,27,'Folder'),(1,8,'files','groupofficeadmin','users/groupofficeadmin',1,'GO\\Files\\Model\\Folder','Folder,groupofficeadmin,,',1482907222,27,'Folder'),(1,9,'files','Public','users/groupofficeadmin/Public',1,'GO\\Files\\Model\\Folder','Folder,Public,,',1482907222,35,'Folder');
/*!40000 ALTER TABLE `go_search_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_search_sync`
--

DROP TABLE IF EXISTS `go_search_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_search_sync` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `module` varchar(50) NOT NULL DEFAULT '',
  `last_sync_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_search_sync`
--

LOCK TABLES `go_search_sync` WRITE;
/*!40000 ALTER TABLE `go_search_sync` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_search_sync` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_settings`
--

DROP TABLE IF EXISTS `go_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_settings` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT '',
  `value` longtext,
  PRIMARY KEY (`user_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_settings`
--

LOCK TABLES `go_settings` WRITE;
/*!40000 ALTER TABLE `go_settings` DISABLE KEYS */;
INSERT INTO `go_settings` VALUES (0,'go_addressbook_export','36'),(0,'upgrade_mtime','20161216'),(0,'uuid_namespace','d4d431da-e698-4bc4-a15b-7cc40ea4d280'),(0,'version','268'),(1,'ms_books','4'),(1,'ms_calendars','1'),(1,'ms_ta-taskslists','1');
/*!40000 ALTER TABLE `go_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_state`
--

DROP TABLE IF EXISTS `go_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_state` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `value` text,
  PRIMARY KEY (`user_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_state`
--

LOCK TABLES `go_state` WRITE;
/*!40000 ALTER TABLE `go_state` DISABLE KEYS */;
INSERT INTO `go_state` VALUES (1,'go-module-panel-modules','o%3Acolumns%3Da%253Ao%25253Aid%25253Ds%2525253Aname%25255Ewidth%25253Dn%2525253A1000%255Eo%25253Aid%25253Dn%2525253A1%25255Ewidth%25253Dn%2525253A100%255Eo%25253Aid%25253Ds%2525253Asort_order%25255Ewidth%25253Dn%2525253A100%255Eo%25253Aid%25253Ds%2525253Apackage%25255Ewidth%25253Dn%2525253A100%25255Ehidden%25253Db%2525253A1%5Esort%3Do%253Afield%253Ds%25253Aname%255Edirection%253Ds%25253AASC%5Egroup%3Ds%253Apackage'),(1,'open-modules','a%3As%253Anotes%5Es%253Atasks%5Es%253Amodules%5Es%253Abookmarks%5Es%253Acalendar%5Es%253Aaddressbook%5Es%253Aemail%5Es%253Asummary%5Es%253Afiles%5Es%253Agroups'),(1,'su-tasks-grid','o%3Acolumns%3Da%253Ao%25253Aid%25253Dn%2525253A0%25255Ewidth%25253Dn%2525253A30%255Eo%25253Aid%25253Ds%2525253Atask-portlet-name-col%25255Ewidth%25253Dn%2525253A772%255Eo%25253Aid%25253Dn%2525253A2%25255Ewidth%25253Dn%2525253A100%255Eo%25253Aid%25253Dn%2525253A3%25255Ewidth%25253Dn%2525253A150%25255Ehidden%25253Db%2525253A1%255Eo%25253Aid%25253Dn%2525253A4%25255Ewidth%25253Dn%2525253A50%25255Ehidden%25253Db%2525253A1%5Esort%3Do%253Afield%253Ds%25253Adue_time%255Edirection%253Ds%25253AASC%5Egroup%3Ds%253Atasklist_name');
/*!40000 ALTER TABLE `go_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_users`
--

DROP TABLE IF EXISTS `go_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `digest` varchar(255) NOT NULL DEFAULT '',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL DEFAULT '',
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `email2` varchar(100) DEFAULT NULL,
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `date_format` varchar(20) NOT NULL DEFAULT 'dmY',
  `date_separator` char(1) NOT NULL DEFAULT '-',
  `time_format` varchar(10) NOT NULL DEFAULT 'G:i',
  `thousands_separator` varchar(1) NOT NULL DEFAULT '.',
  `decimal_separator` varchar(1) NOT NULL DEFAULT ',',
  `currency` char(3) NOT NULL DEFAULT '',
  `logins` int(11) NOT NULL DEFAULT '0',
  `lastlogin` int(11) NOT NULL DEFAULT '0',
  `ctime` int(11) NOT NULL DEFAULT '0',
  `max_rows_list` tinyint(4) NOT NULL DEFAULT '20',
  `timezone` varchar(50) NOT NULL DEFAULT 'Europe/Amsterdam',
  `start_module` varchar(50) NOT NULL DEFAULT 'summary',
  `language` varchar(20) NOT NULL DEFAULT 'en',
  `theme` varchar(20) NOT NULL DEFAULT 'Default',
  `first_weekday` tinyint(4) NOT NULL DEFAULT '0',
  `sort_name` varchar(20) NOT NULL DEFAULT 'first_name',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `muser_id` int(11) NOT NULL DEFAULT '0',
  `mute_sound` tinyint(1) NOT NULL DEFAULT '0',
  `mute_reminder_sound` tinyint(1) NOT NULL DEFAULT '0',
  `mute_new_mail_sound` tinyint(1) NOT NULL DEFAULT '0',
  `show_smilies` tinyint(1) NOT NULL DEFAULT '1',
  `auto_punctuation` tinyint(1) NOT NULL DEFAULT '0',
  `list_separator` char(3) NOT NULL DEFAULT ';',
  `text_separator` char(3) NOT NULL DEFAULT '"',
  `files_folder_id` int(11) NOT NULL DEFAULT '0',
  `disk_quota` bigint(20) DEFAULT NULL,
  `disk_usage` bigint(20) NOT NULL DEFAULT '0',
  `mail_reminders` tinyint(1) NOT NULL DEFAULT '0',
  `popup_reminders` tinyint(1) NOT NULL DEFAULT '0',
  `popup_emails` tinyint(1) NOT NULL DEFAULT '0',
  `password_type` varchar(20) NOT NULL DEFAULT 'crypt',
  `holidayset` varchar(10) DEFAULT NULL,
  `sort_email_addresses_by_time` tinyint(1) NOT NULL DEFAULT '0',
  `no_reminders` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_users`
--

LOCK TABLES `go_users` WRITE;
/*!40000 ALTER TABLE `go_users` DISABLE KEYS */;
INSERT INTO `go_users` VALUES (1,'groupofficeadmin','$2y$10$LQKH4WavnkG1r/KV9BTlrOV4UD9/RAziUtRKjLanqUSR3CbA/3Ywi','cfa2436b0f6df9e9905009e3bfca6f51',1,'System','','Administrator','support@technoinfotech.com',NULL,31,'dmY','-','H:i',',','.','Rs',3,1482908027,1482907222,30,'Asia/Kolkata','summary','en','Group-Office',1,'last_name',1482908027,1,0,0,0,1,0,';','\"',0,1000,0,0,0,0,'crypt','en',0,0);
/*!40000 ALTER TABLE `go_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_users_groups`
--

DROP TABLE IF EXISTS `go_users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_users_groups` (
  `group_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_users_groups`
--

LOCK TABLES `go_users_groups` WRITE;
/*!40000 ALTER TABLE `go_users_groups` DISABLE KEYS */;
INSERT INTO `go_users_groups` VALUES (1,1),(2,1),(3,1);
/*!40000 ALTER TABLE `go_users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_working_weeks`
--

DROP TABLE IF EXISTS `go_working_weeks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_working_weeks` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `mo_work_hours` double NOT NULL DEFAULT '8',
  `tu_work_hours` double NOT NULL DEFAULT '8',
  `we_work_hours` double NOT NULL DEFAULT '8',
  `th_work_hours` double NOT NULL DEFAULT '8',
  `fr_work_hours` double NOT NULL DEFAULT '8',
  `sa_work_hours` double NOT NULL DEFAULT '0',
  `su_work_hours` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_working_weeks`
--

LOCK TABLES `go_working_weeks` WRITE;
/*!40000 ALTER TABLE `go_working_weeks` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_working_weeks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `no_categories`
--

DROP TABLE IF EXISTS `no_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `no_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `acl_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `files_folder_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `no_categories`
--

LOCK TABLES `no_categories` WRITE;
/*!40000 ALTER TABLE `no_categories` DISABLE KEYS */;
INSERT INTO `no_categories` VALUES (1,1,7,'General',0);
/*!40000 ALTER TABLE `no_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `no_notes`
--

DROP TABLE IF EXISTS `no_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `no_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `ctime` int(11) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `muser_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(100) DEFAULT NULL,
  `content` text,
  `files_folder_id` int(11) NOT NULL DEFAULT '0',
  `password` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `no_notes`
--

LOCK TABLES `no_notes` WRITE;
/*!40000 ALTER TABLE `no_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `no_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `su_announcements`
--

DROP TABLE IF EXISTS `su_announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `su_announcements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `acl_id` int(11) NOT NULL,
  `due_time` int(11) NOT NULL DEFAULT '0',
  `ctime` int(11) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `title` varchar(50) DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`id`),
  KEY `due_time` (`due_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `su_announcements`
--

LOCK TABLES `su_announcements` WRITE;
/*!40000 ALTER TABLE `su_announcements` DISABLE KEYS */;
/*!40000 ALTER TABLE `su_announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `su_latest_read_announcement_records`
--

DROP TABLE IF EXISTS `su_latest_read_announcement_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `su_latest_read_announcement_records` (
  `user_id` int(11) NOT NULL,
  `announcement_id` int(11) NOT NULL DEFAULT '0',
  `announcement_ctime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `su_latest_read_announcement_records`
--

LOCK TABLES `su_latest_read_announcement_records` WRITE;
/*!40000 ALTER TABLE `su_latest_read_announcement_records` DISABLE KEYS */;
INSERT INTO `su_latest_read_announcement_records` VALUES (1,0,0);
/*!40000 ALTER TABLE `su_latest_read_announcement_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `su_notes`
--

DROP TABLE IF EXISTS `su_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `su_notes` (
  `user_id` int(11) NOT NULL,
  `text` text,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `su_notes`
--

LOCK TABLES `su_notes` WRITE;
/*!40000 ALTER TABLE `su_notes` DISABLE KEYS */;
INSERT INTO `su_notes` VALUES (1,NULL);
/*!40000 ALTER TABLE `su_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `su_rss_feeds`
--

DROP TABLE IF EXISTS `su_rss_feeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `su_rss_feeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `summary` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `su_rss_feeds`
--

LOCK TABLES `su_rss_feeds` WRITE;
/*!40000 ALTER TABLE `su_rss_feeds` DISABLE KEYS */;
/*!40000 ALTER TABLE `su_rss_feeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `su_visible_calendars`
--

DROP TABLE IF EXISTS `su_visible_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `su_visible_calendars` (
  `user_id` int(11) NOT NULL,
  `calendar_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`calendar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `su_visible_calendars`
--

LOCK TABLES `su_visible_calendars` WRITE;
/*!40000 ALTER TABLE `su_visible_calendars` DISABLE KEYS */;
INSERT INTO `su_visible_calendars` VALUES (1,1);
/*!40000 ALTER TABLE `su_visible_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `su_visible_lists`
--

DROP TABLE IF EXISTS `su_visible_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `su_visible_lists` (
  `user_id` int(11) NOT NULL,
  `tasklist_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`tasklist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `su_visible_lists`
--

LOCK TABLES `su_visible_lists` WRITE;
/*!40000 ALTER TABLE `su_visible_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `su_visible_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ta_categories`
--

DROP TABLE IF EXISTS `ta_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ta_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_categories`
--

LOCK TABLES `ta_categories` WRITE;
/*!40000 ALTER TABLE `ta_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `ta_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ta_portlet_tasklists`
--

DROP TABLE IF EXISTS `ta_portlet_tasklists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ta_portlet_tasklists` (
  `user_id` int(11) NOT NULL,
  `tasklist_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`tasklist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_portlet_tasklists`
--

LOCK TABLES `ta_portlet_tasklists` WRITE;
/*!40000 ALTER TABLE `ta_portlet_tasklists` DISABLE KEYS */;
INSERT INTO `ta_portlet_tasklists` VALUES (1,1);
/*!40000 ALTER TABLE `ta_portlet_tasklists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ta_settings`
--

DROP TABLE IF EXISTS `ta_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ta_settings` (
  `user_id` int(11) NOT NULL,
  `reminder_days` int(11) NOT NULL DEFAULT '0',
  `reminder_time` varchar(10) NOT NULL DEFAULT '0',
  `remind` tinyint(1) NOT NULL DEFAULT '0',
  `default_tasklist_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_settings`
--

LOCK TABLES `ta_settings` WRITE;
/*!40000 ALTER TABLE `ta_settings` DISABLE KEYS */;
INSERT INTO `ta_settings` VALUES (1,0,'0',0,1);
/*!40000 ALTER TABLE `ta_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ta_tasklists`
--

DROP TABLE IF EXISTS `ta_tasklists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ta_tasklists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `acl_id` int(11) NOT NULL,
  `files_folder_id` int(11) NOT NULL DEFAULT '0',
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_tasklists`
--

LOCK TABLES `ta_tasklists` WRITE;
/*!40000 ALTER TABLE `ta_tasklists` DISABLE KEYS */;
INSERT INTO `ta_tasklists` VALUES (1,'System Administrator',1,33,4,1);
/*!40000 ALTER TABLE `ta_tasklists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ta_tasks`
--

DROP TABLE IF EXISTS `ta_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ta_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(190) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
  `tasklist_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ctime` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  `muser_id` int(11) NOT NULL DEFAULT '0',
  `start_time` int(11) NOT NULL,
  `due_time` int(11) NOT NULL,
  `completion_time` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `status` varchar(20) DEFAULT NULL,
  `repeat_end_time` int(11) NOT NULL DEFAULT '0',
  `reminder` int(11) NOT NULL DEFAULT '0',
  `rrule` varchar(100) NOT NULL DEFAULT '',
  `files_folder_id` int(11) NOT NULL DEFAULT '0',
  `category_id` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '1',
  `percentage_complete` tinyint(4) NOT NULL DEFAULT '0',
  `project_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `list_id` (`tasklist_id`),
  KEY `rrule` (`rrule`),
  KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_tasks`
--

LOCK TABLES `ta_tasks` WRITE;
/*!40000 ALTER TABLE `ta_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `ta_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wl_enabled_groups`
--

DROP TABLE IF EXISTS `wl_enabled_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wl_enabled_groups` (
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wl_enabled_groups`
--

LOCK TABLES `wl_enabled_groups` WRITE;
/*!40000 ALTER TABLE `wl_enabled_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `wl_enabled_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wl_ip_addresses`
--

DROP TABLE IF EXISTS `wl_ip_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wl_ip_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `ip_address` varchar(64) NOT NULL,
  `description` varchar(64) NOT NULL,
  `ctime` int(11) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `muser_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `user_id` (`user_id`),
  KEY `muser_id` (`muser_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wl_ip_addresses`
--

LOCK TABLES `wl_ip_addresses` WRITE;
/*!40000 ALTER TABLE `wl_ip_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `wl_ip_addresses` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-28  6:54:33
