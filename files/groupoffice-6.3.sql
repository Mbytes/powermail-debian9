-- MySQL dump 10.16  Distrib 10.1.37-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: groupoffice
-- ------------------------------------------------------
-- Server version	10.1.37-MariaDB-0+deb9u1

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
-- Table structure for table `ab_addressbooks`
--

DROP TABLE IF EXISTS `ab_addressbooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_addressbooks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `default_salutation` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `files_folder_id` int(11) NOT NULL DEFAULT '0',
  `users` tinyint(1) NOT NULL DEFAULT '0',
  `create_folder` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_addressbooks`
--

LOCK TABLES `ab_addressbooks` WRITE;
/*!40000 ALTER TABLE `ab_addressbooks` DISABLE KEYS */;
INSERT INTO `ab_addressbooks` VALUES (1,1,'Prospects',15,'Dear {first_name}',7,0,0),(2,1,'Suppliers',16,'Dear {first_name}',8,0,0),(3,1,'Customers',17,'Dear {first_name}',9,0,0);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_addresslist_contacts`
--

LOCK TABLES `ab_addresslist_contacts` WRITE;
/*!40000 ALTER TABLE `ab_addresslist_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_addresslist_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_addresslist_group`
--

DROP TABLE IF EXISTS `ab_addresslist_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_addresslist_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_addresslist_group`
--

LOCK TABLES `ab_addresslist_group` WRITE;
/*!40000 ALTER TABLE `ab_addresslist_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_addresslist_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_addresslists`
--

DROP TABLE IF EXISTS `ab_addresslists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_addresslists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `addresslist_group_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_salutation` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ctime` int(11) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `name2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `address` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `address_no` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `zip` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `state` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `country` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `post_address` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `post_address_no` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `post_latitude` decimal(10,8) DEFAULT NULL,
  `post_longitude` decimal(11,8) DEFAULT NULL,
  `post_city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `post_state` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `post_country` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `post_zip` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `phone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `fax` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `email` varchar(75) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `homepage` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `comment` text COLLATE utf8mb4_unicode_ci,
  `bank_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `bank_bic` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `vat_no` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `invoice_email` varchar(75) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `ctime` int(11) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `muser_id` int(11) NOT NULL DEFAULT '0',
  `email_allowed` tinyint(1) NOT NULL DEFAULT '1',
  `files_folder_id` int(11) NOT NULL DEFAULT '0',
  `crn` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `iban` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `color` char(6) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '000000',
  PRIMARY KEY (`id`),
  KEY `addressbook_id` (`addressbook_id`),
  KEY `addressbook_id_2` (`addressbook_id`),
  KEY `link_id` (`link_id`),
  KEY `link_id_2` (`link_id`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `middle_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `initials` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `suffix` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `sex` enum('M','F') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'M',
  `birthday` date DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `email2` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `email3` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `company_id` int(11) NOT NULL DEFAULT '0',
  `department` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `function` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `home_phone` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `work_phone` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `fax` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `work_fax` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `cellular` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `cellular2` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `homepage` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `state` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `city` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `zip` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `address` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `address_no` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `ctime` int(11) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `muser_id` int(11) NOT NULL DEFAULT '0',
  `salutation` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `email_allowed` tinyint(1) NOT NULL DEFAULT '1',
  `files_folder_id` int(11) NOT NULL DEFAULT '0',
  `go_user_id` int(11) NOT NULL DEFAULT '0',
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `action_date` int(11) NOT NULL DEFAULT '0',
  `url_linkedin` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_facebook` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_twitter` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `skype_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` char(6) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '000000',
  PRIMARY KEY (`id`),
  KEY `addressbook_id` (`addressbook_id`),
  KEY `email` (`email`),
  KEY `email2` (`email2`),
  KEY `email3` (`email3`),
  KEY `last_name` (`last_name`),
  KEY `go_user_id` (`go_user_id`),
  KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_contacts`
--

LOCK TABLES `ab_contacts` WRITE;
/*!40000 ALTER TABLE `ab_contacts` DISABLE KEYS */;
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `parameters` varchar(1023) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `value` varchar(1023) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `contact_id` (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `content` longblob NOT NULL,
  `extension` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_email_templates`
--

LOCK TABLES `ab_email_templates` WRITE;
/*!40000 ALTER TABLE `ab_email_templates` DISABLE KEYS */;
INSERT INTO `ab_email_templates` VALUES (1,1,0,'Default',18,'Message-ID: <db66cbf99a67dafeafb09c21609d683d@powermail.mydomainname.com>\r\nDate: Tue, 09 Apr 2019 08:02:40 +0000\r\nFrom: \r\nMIME-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary=\"_=_swift_1554796960_ea8742544161defc920e8290733d22ac_=_\"\r\n\r\n\r\n--_=_swift_1554796960_ea8742544161defc920e8290733d22ac_=_\r\nContent-Type: text/plain; charset=UTF-8\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n{salutation},\r\n\r\n{body}\r\n\r\nBest regards\r\n\r\n\r\n{user:name}\r\n{usercompany:name}\r\n\r\n--_=_swift_1554796960_ea8742544161defc920e8290733d22ac_=_\r\nContent-Type: text/html; charset=UTF-8\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n{salutation},<br />\r\n<br />\r\n{body}<br />\r\n<br />\r\nBest regards<br />\r\n<br />\r\n<br />\r\n{user:name}<br />\r\n{usercompany:name}<br />\r\n\r\n--_=_swift_1554796960_ea8742544161defc920e8290733d22ac_=_--\r\n',''),(2,1,1,'Letter',19,'PK\0\0�D�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0_rels/.rels��MKA���C��l+����\"Bo\"�������3i���A\n�P��Ǽy���m���N���AêiAq0Ѻ0jx�=/`�/�W>��J�\\*�ބ�aI���L�41q��!fOR�<b\"���qݶ��2��1��j�[���H�76z�$�&f^�\\��8.Nyd�`�y�q�j4�x]h�{�8��S4G�A�y�Y8X���(�[Fw�i4o|˼�l�^�͢����PK��#�\0\0\0=\0\0PK\0\0�D�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/_rels/document.xml.rels��M\n�0���\"�ަU��nDp+�\01���6	�(z{�Z(����}�1/__��]�m��,I��Q�Ҧp(��%��I��NR\\	�v���Dn�yP-�2$֡����^R,}ÝT\'� ����O&�U��ʀ�7���m]k���=\Z\Z���n�H��A��>.?��|m\r������������?@��������I��wPK�/0��\0\0\0\0\0PK\0\0�D�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/settings.xmlE�K�0D��\"�X�H���Bk�RbG����	+��73z�yb����r�� �<�t�p>�[0�������v��\ZA��SH���]57�J�d���+���r��!�Q�NS�+��6������d�&c鑴�8���G�S��s�<C��q����PKvՎ��\0\0\0�\0\0\0PK\0\0�D�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/fontTable.xmlŐ�N�0��<E�;K�M��i���x��FJ�*-}{��;Q��&qK������ݧ�����|!V��5UƟ\n�~x��H�|�<r@���n��5��\"�{�C!��\\)�\r:���S��� �o8)�k���C�:�U@1��1-�٭�ƭ�P��42���N~���N���B�C/؋Wr0	t����2ˤ\Z��;\\�a����D�\\�G�疚`ߠo�;�]d�o��\'�2jq-�\r�QW�rs�[��߿�~u����PK�I��\0\0w\0\0PK\0\0�D�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/styles.xml�V[o�0~߯����B�MM+Ƅ@B����!^۲���g����d	c���>�������6!�3\Z�޵k[��,�t�?�&W}ے\nh�Q�;$��/w�P�A���T�����CǑa��׌#���L$��Tl����\")��	q|��:	`jߗZ�8�;�Ѐ���q}7<ηSH�� ��\r�!%�Z\Z\r�ɗ�V���A��?\n3d8b٘Q%)����B[���s�*6��QY�R\"-61m�5a�cJC�q�9\\%�a�o3��1��@�P\Z��gj-�J#B �Hb8Y�GTts!#L����7*(��R�-%��f/#@7Z�>�u��:����:�\\-����S8��{^�M�x��=�H}�G��^��y��ɛ��۠��@�_e�\r��(;�@�ݾ�c�3TH���Q-�HYsL��\\{�_(��$��EX�-M�L�6q�Oڅu��/�=�V1�ժg��B��\'1���`�m�k����ҥ��v� m�U)��A�������?�D����5�����W����2���n��߄�KU���*���&�,�ʚb\Z�.4!0�tr���+�n]Z�\"MV��i�9�����N�����c:�T=�-ޮF\rҌFh�޲�����(h�F��D��i䐾���k:���X[�ܖL�����T��=Z�;eS~���PKT̓�\0\0E\0\0PK\0\0�D�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/document.xml�W[o�0~�WDy^�tE�5P\r���b���Ib�%�O��i�;����6n�`}�{|>��Ή�����H��X��,�a\0�j�U>?]��^��E�Z�,\\�\r��g�u�4�$(��&zVF%� �IN��:��2�Y�)tM؍0��@,�(����e�H��4y��w\\�IO#���k^�~��}�+)z\\��ZV\ZM�Z�)Z^I�\Z����3�(����(w��[g���/5[��l�4W��Ɋ�Yh��Qz\Z\r������z�I��=o�n_4�1}M%5�\n8Z�\Z�`a4�(ڣར���8�c��\\���Ed\0�G�9�&� �Qp�a�5z�>Ɵt�3\",��.7�n�>6%��]�D�E$��S�k)�o��L3n5�d�+G�Q���g7ڜ $�bB��v���9�!@s\Z,u���̸��}q(���t�����|����pv��B�n������=�����/�\rX��0������,���j%Y�h���������rP��$�fe~�W�L_N\\UR���x�*���b1F�һ&�=*�\Z��\Z�7�\n7F�\r��7�ϋ-u��e%�[��t8�K\"Z����o�_�i�\r4����\\/[�+��Μ��\\����kr�bڄ+��G�R0�6�}�<yF*�]��\\F}�mJ��;PKm�Ø\0\0�\r\0\0PK\0\0�D�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0docProps/app.xml��=k�0ཿ��טd���)�n�f霨XH�����-4�;������b��1�:��)�)��;v�.7�H(���wБ$�w�5�\0\r�\".u���&u+S�c���G+1��H�8\ZO^�Қ���4�2���Wܞ���_z�/!{����b}_sz�C�Q��bo^~<�T���z�7n^��M;�Mq�0侟��6�Y�z�ͤ�L�z�^�$�\0PKI���\0\0\0j\0\0PK\0\0�D�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0docProps/core.xml}��N� ��}�����M�v��]����w��mh�p��^�[un����C1ݪ&ـu��%�A	h��R�J�����8�u͛VC�v�д�(�a���h[�KpIiǄ)��{�0vb\r��,:4��U܇Ү��⃯\0_r�x^s�q/L�`D{e-���M�C\n�w�f��J����+�_���Y8vr��@u]�uy�B~�_�O���U	@U�W3a�{�� `������~1CUpLRr��тNX>ft��V�?������jV���׆Q����g�p��a�K	���?E��j����4O�(F&,��\ZG>8b�?��Ҹ�P���U_PKt�G\0\0�\0\0PK\0\0�D�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0[Content_Types].xml��1O�0�����+JBI: 1B�0#c_�Ķ|����sh#���X���}�瓋�f�5x�֔�<�YFZ�M[���6�b�jQ�[���`ɺ�5�(;fց����A���;!�E�\"�/��&�	i��*�	終d%|���?z�gqe��{Ad�L8�k)��k�>��)V�\Z��30�=��z��)+_e$�74B�\\�П�l�h	S��漕�H~t���l����x���&��>�mх�w���O`:�6�r�p�CN��c��*���8�A��Ė��b�������\rPKc�a*\0\0^\0\0PK\0\0\0�D�B��#�\0\0\0=\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0_rels/.relsPK\0\0\0�D�B�/0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/_rels/document.xml.relsPK\0\0\0�D�BvՎ��\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0!\0\0word/settings.xmlPK\0\0\0�D�B�I��\0\0w\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/fontTable.xmlPK\0\0\0�D�BT̓�\0\0E\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0H\0\0word/styles.xmlPK\0\0\0�D�Bm�Ø\0\0�\r\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0)\0\0word/document.xmlPK\0\0\0�D�BI���\0\0\0j\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0docProps/app.xmlPK\0\0\0�D�Bt�G\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\"\0\0docProps/core.xmlPK\0\0\0�D�Bc�a*\0\0^\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0[Content_Types].xmlPK\0\0\0\0	\0	\0<\0\0\0\0\0\0','docx');
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
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sql` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `companies` (`companies`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `error_description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`sent_mailing_id`,`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `error_description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`sent_mailing_id`,`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `subject` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
  `temp_pass` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_sent_mailings`
--

LOCK TABLES `ab_sent_mailings` WRITE;
/*!40000 ALTER TABLE `ab_sent_mailings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_sent_mailings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_settings`
--

DROP TABLE IF EXISTS `ab_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_settings` (
  `user_id` int(11) NOT NULL,
  `default_addressbook_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_settings`
--

LOCK TABLES `ab_settings` WRITE;
/*!40000 ALTER TABLE `ab_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_settings` ENABLE KEYS */;
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
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `public_icon` tinyint(1) NOT NULL DEFAULT '1',
  `open_extern` tinyint(1) NOT NULL DEFAULT '1',
  `behave_as_module` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `show_in_startmenu` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `show_in_startmenu` (`show_in_startmenu`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bm_categories`
--

LOCK TABLES `bm_categories` WRITE;
/*!40000 ALTER TABLE `bm_categories` DISABLE KEYS */;
INSERT INTO `bm_categories` VALUES (1,1,21,'General',0);
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
  `color` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`,`calendar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_hour` tinyint(4) NOT NULL DEFAULT '0',
  `end_hour` tinyint(4) NOT NULL DEFAULT '0',
  `background` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_interval` int(11) NOT NULL DEFAULT '1800',
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `shared_acl` tinyint(1) NOT NULL DEFAULT '0',
  `show_bdays` tinyint(1) NOT NULL DEFAULT '0',
  `show_completed_tasks` tinyint(1) NOT NULL DEFAULT '1',
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `project_id` int(11) NOT NULL DEFAULT '0',
  `tasklist_id` int(11) NOT NULL DEFAULT '0',
  `files_folder_id` int(11) NOT NULL DEFAULT '0',
  `show_holidays` tinyint(1) NOT NULL DEFAULT '1',
  `enable_ics_import` tinyint(1) NOT NULL DEFAULT '0',
  `ics_import_url` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `tooltip` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `project_id` (`project_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cal_calendars`
--

LOCK TABLES `cal_calendars` WRITE;
/*!40000 ALTER TABLE `cal_calendars` DISABLE KEYS */;
INSERT INTO `cal_calendars` VALUES (1,1,1,36,'System Administrator',0,0,NULL,1800,0,0,0,1,'',0,0,2,1,0,'','',1);
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` char(6) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EBF1E2',
  `calendar_id` int(11) NOT NULL,
  `acl_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `calendar_id` (`calendar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `timezone` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `all_day_event` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `location` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `repeat_end_time` int(11) NOT NULL DEFAULT '0',
  `reminder` int(11) DEFAULT NULL,
  `ctime` int(11) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `muser_id` int(11) NOT NULL DEFAULT '0',
  `busy` tinyint(1) NOT NULL DEFAULT '1',
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NEEDS-ACTION',
  `resource_event_id` int(11) NOT NULL DEFAULT '0',
  `private` tinyint(1) NOT NULL DEFAULT '0',
  `rrule` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `background` char(6) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ebf1e2',
  `files_folder_id` int(11) NOT NULL,
  `read_only` tinyint(1) NOT NULL DEFAULT '0',
  `category_id` int(11) DEFAULT NULL,
  `exception_for_event_id` int(11) NOT NULL DEFAULT '0',
  `recurrence_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `uid` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`uid`,`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fields` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `show_not_as_busy` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `contact_id` int(11) NOT NULL DEFAULT '0',
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NEEDS-ACTION',
  `last_modified` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `is_organizer` tinyint(1) NOT NULL DEFAULT '0',
  `role` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `reminder` int(11) DEFAULT NULL,
  `background` char(6) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EBF1E2',
  `calendar_id` int(11) NOT NULL DEFAULT '0',
  `show_statuses` tinyint(1) NOT NULL DEFAULT '1',
  `check_conflict` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`),
  KEY `calendar_id` (`calendar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cal_settings`
--

LOCK TABLES `cal_settings` WRITE;
/*!40000 ALTER TABLE `cal_settings` DISABLE KEYS */;
INSERT INTO `cal_settings` VALUES (1,NULL,'EBF1E2',1,1,1);
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
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_interval` int(11) NOT NULL DEFAULT '1800',
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `merge` tinyint(1) NOT NULL DEFAULT '0',
  `owncolor` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `background` char(6) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CCFFCC',
  PRIMARY KEY (`view_id`,`calendar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `field_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `extends_model` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_index` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `type` (`extends_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `model_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`model_id`,`model_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `model_type_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`block_id`,`model_id`,`model_type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `model_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`model_id`,`model_name`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datatype` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'GO_Customfields_Customfieldtype_Text',
  `sort_index` int(11) NOT NULL DEFAULT '0',
  `function` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `validation_regex` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `helptext` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `multiselect` tinyint(1) NOT NULL DEFAULT '0',
  `max` int(11) NOT NULL DEFAULT '0',
  `nesting_level` tinyint(4) NOT NULL DEFAULT '0',
  `treemaster_field_id` int(11) NOT NULL DEFAULT '0',
  `exclude_from_grid` tinyint(1) NOT NULL DEFAULT '0',
  `height` int(11) NOT NULL DEFAULT '0',
  `number_decimals` tinyint(4) NOT NULL DEFAULT '2',
  `unique_values` tinyint(1) NOT NULL DEFAULT '0',
  `max_length` int(5) NOT NULL DEFAULT '50',
  `addressbook_ids` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `extra_options` text COLLATE utf8mb4_unicode_ci,
  `prefix` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `suffix` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `type` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cf_fs_folders`
--

LOCK TABLES `cf_fs_folders` WRITE;
/*!40000 ALTER TABLE `cf_fs_folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `cf_fs_folders` ENABLE KEYS */;
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
  `text` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `comments` mediumtext COLLATE utf8mb4_unicode_ci,
  `category_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `link_id` (`model_id`,`model_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_comments`
--

LOCK TABLES `co_comments` WRITE;
/*!40000 ALTER TABLE `co_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_acl`
--

DROP TABLE IF EXISTS `core_acl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_acl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ownedBy` int(11) NOT NULL,
  `usedIn` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modifiedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_acl`
--

LOCK TABLES `core_acl` WRITE;
/*!40000 ALTER TABLE `core_acl` DISABLE KEYS */;
INSERT INTO `core_acl` VALUES (1,1,'core_group.aclId','2019-04-09 08:06:12'),(2,1,'core_group.aclId','2019-04-09 08:06:12'),(3,1,'core_group.aclId','2019-04-09 08:06:12'),(4,1,'core_group.aclId','2019-04-09 08:06:12'),(5,1,'core_module.aclId','2019-04-09 08:06:12'),(6,1,'core_module.aclId','2019-04-09 08:06:12'),(7,1,'core_module.aclId','2019-04-09 08:06:12'),(8,1,'core_module.aclId','2019-04-09 08:06:12'),(9,1,'core_module.aclId','2019-04-09 08:06:12'),(10,1,'core_module.aclId','2019-04-09 08:06:12'),(11,1,'core_module.aclId','2019-04-09 08:06:12'),(12,1,'core_module.aclId','2019-04-09 08:06:12'),(13,1,'core_module.aclId','2019-04-09 08:06:12'),(14,1,'core_module.aclId','2019-04-09 08:06:12'),(15,1,'ab_addressbooks.acl_id','2019-04-09 08:06:12'),(16,1,'ab_addressbooks.acl_id','2019-04-09 08:06:12'),(17,1,'ab_addressbooks.acl_id','2019-04-09 08:06:12'),(18,1,'ab_email_templates.acl_id','2019-04-09 08:06:12'),(19,1,'ab_email_templates.acl_id','2019-04-09 08:06:12'),(20,1,'core_module.aclId','2019-04-09 08:06:12'),(21,1,'bm_categories.acl_id','2019-04-09 08:06:12'),(22,1,'core_module.aclId','2019-04-09 08:06:12'),(23,1,'core_module.aclId','2019-04-09 08:06:12'),(24,1,'core_module.aclId','2019-04-09 08:06:12'),(26,1,'core_module.aclId','2019-04-09 08:06:12'),(27,1,'core_module.aclId','2019-04-09 08:06:12'),(28,1,'fs_templates.acl_id','2019-04-09 08:06:12'),(29,1,'fs_templates.acl_id','2019-04-09 08:06:12'),(30,1,'core_module.aclId','2019-04-09 08:06:12'),(31,1,'core_module.aclId','2019-04-09 08:06:12'),(32,1,'core_module.aclId','2019-04-09 08:06:12'),(33,1,'core_module.aclId','2019-04-09 08:06:12'),(34,1,'core_module.aclId','2019-04-09 08:06:12'),(35,1,'go_settings','2019-04-09 08:03:18'),(36,1,'cal_calendars.acl_id','2019-04-09 08:06:12'),(37,1,'core_module.aclId','2019-04-09 08:06:12'),(38,1,'core_module.aclId','2019-04-09 08:06:12'),(39,1,'core_module.aclId','2019-04-09 08:06:12'),(40,1,'core_module.aclId','2019-04-09 08:06:12'),(41,1,'core_module.aclId','2019-04-09 08:06:12'),(42,1,'core_module.aclId','2019-04-09 08:06:12'),(43,1,'core_module.aclId','2019-04-09 08:06:12'),(44,1,'core_module.aclId','2019-04-09 08:06:12'),(45,1,'core_module.aclId','2019-04-09 08:06:12'),(46,1,'fb_acl','2019-04-09 08:05:46'),(47,1,'readonly','2019-04-09 08:06:12'),(48,1,'fs_folders.acl_id','2019-04-09 08:06:12'),(49,1,'fs_folders.acl_id','2019-04-09 08:06:12'),(50,1,'fs_folders.acl_id','2019-04-09 08:06:12');
/*!40000 ALTER TABLE `core_acl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_acl_group`
--

DROP TABLE IF EXISTS `core_acl_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_acl_group` (
  `aclId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL DEFAULT '0',
  `level` tinyint(4) NOT NULL DEFAULT '10',
  PRIMARY KEY (`aclId`,`groupId`),
  KEY `level` (`level`),
  KEY `groupId` (`groupId`),
  CONSTRAINT `core_acl_group_ibfk_1` FOREIGN KEY (`groupId`) REFERENCES `core_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_acl_group_ibfk_2` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_acl_group`
--

LOCK TABLES `core_acl_group` WRITE;
/*!40000 ALTER TABLE `core_acl_group` DISABLE KEYS */;
INSERT INTO `core_acl_group` VALUES (2,2,10),(3,3,10),(4,4,10),(12,3,10),(13,3,10),(14,3,10),(18,3,10),(19,3,10),(20,3,10),(21,3,10),(22,3,10),(23,3,10),(26,3,10),(27,3,10),(28,3,10),(29,3,10),(30,3,10),(31,3,10),(32,3,10),(33,3,10),(37,3,10),(38,3,10),(39,3,10),(40,3,10),(42,3,10),(43,3,10),(44,3,10),(47,2,10),(15,3,30),(16,3,30),(17,3,30),(1,1,50),(2,1,50),(3,1,50),(4,1,50),(5,1,50),(6,1,50),(7,1,50),(8,1,50),(9,1,50),(10,1,50),(11,1,50),(12,1,50),(13,1,50),(14,1,50),(15,1,50),(16,1,50),(17,1,50),(18,1,50),(19,1,50),(20,1,50),(21,1,50),(22,1,50),(23,1,50),(24,1,50),(26,1,50),(27,1,50),(28,1,50),(29,1,50),(30,1,50),(31,1,50),(32,1,50),(33,1,50),(34,1,50),(35,1,50),(36,1,50),(37,1,50),(38,1,50),(39,1,50),(40,1,50),(41,1,50),(42,1,50),(43,1,50),(44,1,50),(45,1,50),(46,1,50),(48,1,50),(49,1,50),(50,1,50);
/*!40000 ALTER TABLE `core_acl_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_acl_group_changes`
--

DROP TABLE IF EXISTS `core_acl_group_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_acl_group_changes` (
  `aclId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `grantModSeq` int(11) NOT NULL,
  `revokeModSeq` int(11) DEFAULT NULL,
  PRIMARY KEY (`aclId`,`groupId`),
  KEY `groupId` (`groupId`),
  CONSTRAINT `core_acl_group_changes_ibfk_1` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_acl_group_changes_ibfk_2` FOREIGN KEY (`groupId`) REFERENCES `core_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_acl_group_changes`
--

LOCK TABLES `core_acl_group_changes` WRITE;
/*!40000 ALTER TABLE `core_acl_group_changes` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_acl_group_changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_auth_method`
--

DROP TABLE IF EXISTS `core_auth_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_auth_method` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `moduleId` int(11) NOT NULL,
  `sortOrder` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `moduleId_sortOrder` (`moduleId`,`sortOrder`),
  KEY `moduleId` (`moduleId`),
  CONSTRAINT `core_auth_method_ibfk_1` FOREIGN KEY (`moduleId`) REFERENCES `core_module` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_auth_method`
--

LOCK TABLES `core_auth_method` WRITE;
/*!40000 ALTER TABLE `core_auth_method` DISABLE KEYS */;
INSERT INTO `core_auth_method` VALUES ('password',7,1),('googleauthenticator',9,2),('imap',31,3);
/*!40000 ALTER TABLE `core_auth_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_auth_password`
--

DROP TABLE IF EXISTS `core_auth_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_auth_password` (
  `userId` int(11) NOT NULL,
  `password` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `digest` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `core_auth_password_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_auth_password`
--

LOCK TABLES `core_auth_password` WRITE;
/*!40000 ALTER TABLE `core_auth_password` DISABLE KEYS */;
INSERT INTO `core_auth_password` VALUES (1,'$2y$10$6i2j5HdkDMfR1NcKgVuDSutnA1GlFlhqhCoRnOBAaUNFDOm7PAHoO','cc7f75334c20784e4d146a80c14b7768');
/*!40000 ALTER TABLE `core_auth_password` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_auth_token`
--

DROP TABLE IF EXISTS `core_auth_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_auth_token` (
  `loginToken` varchar(100) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `accessToken` varchar(100) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `expiresAt` datetime NOT NULL,
  `lastActiveAt` datetime NOT NULL,
  `remoteIpAddress` varchar(100) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `userAgent` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `passedMethods` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`loginToken`),
  KEY `userId` (`userId`),
  KEY `accessToken` (`accessToken`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_auth_token`
--

LOCK TABLES `core_auth_token` WRITE;
/*!40000 ALTER TABLE `core_auth_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_auth_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_blob`
--

DROP TABLE IF EXISTS `core_blob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_blob` (
  `id` binary(40) NOT NULL,
  `type` varchar(129) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` bigint(20) NOT NULL DEFAULT '0',
  `modified` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_blob`
--

LOCK TABLES `core_blob` WRITE;
/*!40000 ALTER TABLE `core_blob` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_blob` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_change`
--

DROP TABLE IF EXISTS `core_change`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_change` (
  `entityId` int(11) NOT NULL,
  `entityTypeId` int(11) NOT NULL,
  `modSeq` int(11) NOT NULL,
  `aclId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `destroyed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`entityId`,`entityTypeId`),
  KEY `aclId` (`aclId`),
  KEY `entityTypeId` (`entityTypeId`),
  CONSTRAINT `core_change_ibfk_1` FOREIGN KEY (`entityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_change_ibfk_2` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_change`
--

LOCK TABLES `core_change` WRITE;
/*!40000 ALTER TABLE `core_change` DISABLE KEYS */;
INSERT INTO `core_change` VALUES (1,7,1,36,'2019-04-09 08:03:18',0),(1,8,2,11,'2019-04-09 08:05:46',0),(2,7,1,36,'2019-04-09 08:03:18',0),(3,7,2,27,'2019-04-09 08:05:46',0),(3,21,2,45,'2019-04-09 08:08:12',0),(4,7,2,27,'2019-04-09 08:05:46',0),(5,7,3,47,'2019-04-09 10:06:19',0),(6,7,3,48,'2019-04-09 10:06:19',0),(7,7,3,15,'2019-04-09 10:06:19',0),(8,7,3,16,'2019-04-09 10:06:19',0),(9,7,3,17,'2019-04-09 10:06:19',0),(10,7,3,27,'2019-04-09 10:06:19',0),(11,7,3,49,'2019-04-09 10:06:19',0),(12,7,3,50,'2019-04-09 10:06:19',0),(13,7,4,27,'2019-04-09 10:06:32',0),(14,7,4,27,'2019-04-09 10:06:32',0),(15,7,4,27,'2019-04-09 10:06:32',0),(31,6,1,45,'2019-04-09 08:04:47',0);
/*!40000 ALTER TABLE `core_change` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_cron_job`
--

DROP TABLE IF EXISTS `core_cron_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_cron_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `moduleId` int(11) NOT NULL,
  `description` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expression` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `nextRunAt` datetime DEFAULT NULL,
  `lastRunAt` datetime DEFAULT NULL,
  `runningSince` datetime DEFAULT NULL,
  `lastError` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `description` (`description`),
  KEY `moduleId` (`moduleId`),
  CONSTRAINT `core_cron_job_ibfk_1` FOREIGN KEY (`moduleId`) REFERENCES `core_module` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_cron_job`
--

LOCK TABLES `core_cron_job` WRITE;
/*!40000 ALTER TABLE `core_cron_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_cron_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_customfields_field`
--

DROP TABLE IF EXISTS `core_customfields_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_customfields_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldSetId` int(11) NOT NULL,
  `modSeq` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `modifiedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `databaseName` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datatype` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'GO_Customfields_Customfieldtype_Text',
  `sortOrder` int(11) NOT NULL DEFAULT '0',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `helptext` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `exclude_from_grid` tinyint(1) NOT NULL DEFAULT '0',
  `unique_values` tinyint(1) NOT NULL DEFAULT '0',
  `prefix` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `suffix` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `options` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `type` (`fieldSetId`),
  KEY `modSeq` (`modSeq`),
  CONSTRAINT `core_customfields_field_ibfk_1` FOREIGN KEY (`fieldSetId`) REFERENCES `core_customfields_field_set` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_customfields_field`
--

LOCK TABLES `core_customfields_field` WRITE;
/*!40000 ALTER TABLE `core_customfields_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_customfields_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_customfields_field_set`
--

DROP TABLE IF EXISTS `core_customfields_field_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_customfields_field_set` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modSeq` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `modifiedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `entityId` int(11) NOT NULL,
  `aclId` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sortOrder` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entityId` (`entityId`),
  KEY `aclId` (`aclId`),
  KEY `modSeq` (`modSeq`),
  CONSTRAINT `core_customfields_field_set_ibfk_1` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_customfields_field_set_ibfk_2` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_customfields_field_set`
--

LOCK TABLES `core_customfields_field_set` WRITE;
/*!40000 ALTER TABLE `core_customfields_field_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_customfields_field_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_entity`
--

DROP TABLE IF EXISTS `core_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_entity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `moduleId` int(11) DEFAULT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `clientName` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `highestModSeq` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clientName` (`clientName`),
  UNIQUE KEY `name` (`name`,`moduleId`) USING BTREE,
  KEY `moduleId` (`moduleId`),
  CONSTRAINT `core_entity_ibfk_1` FOREIGN KEY (`moduleId`) REFERENCES `core_module` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_entity`
--

LOCK TABLES `core_entity` WRITE;
/*!40000 ALTER TABLE `core_entity` DISABLE KEYS */;
INSERT INTO `core_entity` VALUES (1,1,'CronJobSchedule','CronJobSchedule',NULL),(2,2,'Field','Field',NULL),(3,2,'FieldSet','FieldSet',NULL),(4,3,'Group','Group',NULL),(5,4,'Link','Link',NULL),(6,5,'Module','Module',1),(7,6,'Search','Search',4),(8,7,'User','User',2),(9,7,'Method','Method',NULL),(10,7,'Token','Token',NULL),(11,1,'Blob','Blob',NULL),(12,8,'Note','Note',NULL),(13,8,'NoteBook','NoteBook',NULL),(14,10,'Company','Company',NULL),(15,10,'Contact','Contact',NULL),(16,12,'Calendar','Calendar',NULL),(17,12,'Event','Event',NULL),(18,17,'File','File',NULL),(19,17,'Folder','Folder',NULL),(20,21,'Task','Task',NULL),(21,31,'Server','ImapAuthServer',2),(22,10,'Addresslist','Addresslist',NULL),(23,13,'Comment','Comment',NULL);
/*!40000 ALTER TABLE `core_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_group`
--

DROP TABLE IF EXISTS `core_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdBy` int(11) NOT NULL,
  `aclId` int(11) DEFAULT NULL,
  `isUserGroupFor` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `isUserGroupFor` (`isUserGroupFor`),
  KEY `aclId` (`aclId`),
  CONSTRAINT `core_group_ibfk_1` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`),
  CONSTRAINT `core_group_ibfk_2` FOREIGN KEY (`isUserGroupFor`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_group`
--

LOCK TABLES `core_group` WRITE;
/*!40000 ALTER TABLE `core_group` DISABLE KEYS */;
INSERT INTO `core_group` VALUES (1,'Admins',1,1,NULL),(2,'Everyone',1,2,NULL),(3,'Internal',1,3,NULL),(4,'groupofficeadmin',1,4,1);
/*!40000 ALTER TABLE `core_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_group_default_group`
--

DROP TABLE IF EXISTS `core_group_default_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_group_default_group` (
  `groupId` int(11) NOT NULL,
  PRIMARY KEY (`groupId`),
  CONSTRAINT `core_group_default_group_ibfk_1` FOREIGN KEY (`groupId`) REFERENCES `core_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_group_default_group`
--

LOCK TABLES `core_group_default_group` WRITE;
/*!40000 ALTER TABLE `core_group_default_group` DISABLE KEYS */;
INSERT INTO `core_group_default_group` VALUES (2);
/*!40000 ALTER TABLE `core_group_default_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_link`
--

DROP TABLE IF EXISTS `core_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fromEntityTypeId` int(11) NOT NULL,
  `fromId` int(11) NOT NULL,
  `toEntityTypeId` int(11) NOT NULL,
  `toId` int(11) NOT NULL,
  `description` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `modSeq` int(11) DEFAULT NULL,
  `folderId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fromEntityId` (`fromEntityTypeId`,`fromId`,`toEntityTypeId`,`toId`) USING BTREE,
  KEY `toEntity` (`toEntityTypeId`),
  CONSTRAINT `fromEntity` FOREIGN KEY (`fromEntityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `toEntity` FOREIGN KEY (`toEntityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_link`
--

LOCK TABLES `core_link` WRITE;
/*!40000 ALTER TABLE `core_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_module`
--

DROP TABLE IF EXISTS `core_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `package` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version` int(11) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `admin_menu` tinyint(1) NOT NULL DEFAULT '0',
  `aclId` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `modifiedAt` datetime DEFAULT NULL,
  `modSeq` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `aclId` (`aclId`),
  CONSTRAINT `acl` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_module`
--

LOCK TABLES `core_module` WRITE;
/*!40000 ALTER TABLE `core_module` DISABLE KEYS */;
INSERT INTO `core_module` VALUES (1,'core','core',62,0,0,5,1,NULL,NULL,NULL),(2,'customfields','core',0,0,0,6,1,NULL,NULL,NULL),(3,'groups','core',0,0,0,7,1,NULL,NULL,NULL),(4,'links','core',0,0,0,8,1,NULL,NULL,NULL),(5,'modules','core',0,0,0,9,1,NULL,NULL,NULL),(6,'search','core',0,0,0,10,1,NULL,NULL,NULL),(7,'users','core',5,0,0,11,1,NULL,NULL,NULL),(8,'notes','community',35,0,0,12,1,NULL,NULL,NULL),(9,'googleauthenticator','community',0,0,0,13,1,NULL,NULL,NULL),(10,'addressbook',NULL,307,9,0,14,1,'2019-04-09 08:02:39',NULL,NULL),(11,'bookmarks',NULL,19,10,0,20,1,'2019-04-09 08:02:40',NULL,NULL),(12,'calendar',NULL,175,11,0,22,1,'2019-04-09 08:02:40',NULL,NULL),(13,'comments',NULL,14,12,0,23,1,'2019-04-09 08:02:40',NULL,NULL),(14,'cron',NULL,0,13,1,24,1,'2019-04-09 08:02:40',NULL,NULL),(16,'email',NULL,97,15,0,26,1,'2019-04-09 08:02:40',NULL,NULL),(17,'files',NULL,115,16,0,27,1,'2019-04-09 08:02:40',NULL,NULL),(18,'sieve',NULL,0,17,0,30,1,'2019-04-09 08:02:41',NULL,NULL),(19,'summary',NULL,17,18,0,31,1,'2019-04-09 08:02:41',NULL,NULL),(20,'sync',NULL,43,19,0,32,1,'2019-04-09 08:02:41',NULL,NULL),(21,'tasks',NULL,55,20,0,33,1,'2019-04-09 08:02:41',NULL,NULL),(22,'tools',NULL,0,21,1,34,1,'2019-04-09 08:02:41',NULL,NULL),(23,'dav',NULL,1,21,0,37,1,'2019-04-09 08:04:14',NULL,NULL),(24,'caldav',NULL,30,22,0,38,1,'2019-04-09 08:03:52',NULL,NULL),(25,'calendarexport',NULL,0,23,0,39,1,'2019-04-09 08:03:57',NULL,NULL),(26,'carddav',NULL,5,24,0,40,1,'2019-04-09 08:04:02',NULL,NULL),(27,'customcss',NULL,0,25,1,41,1,'2019-04-09 08:04:09',NULL,NULL),(28,'freebusypermissions',NULL,4,26,0,42,1,'2019-04-09 08:04:20',NULL,NULL),(29,'reminders',NULL,0,27,0,43,1,'2019-04-09 08:04:27',NULL,NULL),(30,'smime',NULL,6,28,0,44,1,'2019-04-09 08:04:33',NULL,NULL),(31,'imapauthenticator','community',1,0,0,45,1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `core_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_search`
--

DROP TABLE IF EXISTS `core_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_search` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entityId` int(11) NOT NULL,
  `moduleId` int(11) DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `entityTypeId` int(11) NOT NULL,
  `keywords` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `modifiedAt` datetime DEFAULT NULL,
  `aclId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entityId` (`entityId`,`entityTypeId`),
  KEY `acl_id` (`aclId`),
  KEY `name` (`name`),
  KEY `moduleId` (`moduleId`),
  KEY `keywords` (`keywords`(191)),
  KEY `entityTypeId` (`entityTypeId`),
  CONSTRAINT `core_search_ibfk_1` FOREIGN KEY (`entityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_search`
--

LOCK TABLES `core_search` WRITE;
/*!40000 ALTER TABLE `core_search` DISABLE KEYS */;
INSERT INTO `core_search` VALUES (1,1,17,'calendar','calendar',19,'Folder,calendar','2019-04-09 08:03:18',36),(2,2,17,'System Administrator','calendar/System Administrator',19,'Folder,System Administrator,calendar/System Administrator','2019-04-09 08:03:18',36),(3,3,17,'public','public',19,'Folder,public','2019-04-09 08:05:46',27),(4,4,17,'customcss','public/customcss',19,'Folder,customcss,public/customcss','2019-04-09 08:05:46',27),(5,5,17,'addressbook','addressbook',19,'Folder,addressbook','2019-04-09 08:06:12',47),(6,6,17,'photos','addressbook/photos',19,'Folder,photos,addressbook/photos','2019-04-09 08:06:12',48),(7,7,17,'Prospects','addressbook/Prospects',19,'Folder,Prospects,addressbook/Prospects','2019-04-09 08:06:12',15),(8,8,17,'Suppliers','addressbook/Suppliers',19,'Folder,Suppliers,addressbook/Suppliers','2019-04-09 08:06:12',16),(9,9,17,'Customers','addressbook/Customers',19,'Folder,Customers,addressbook/Customers','2019-04-09 08:06:12',17),(10,10,17,'users','users',19,'Folder,users','2019-04-09 08:06:12',27),(11,11,17,'groupofficeadmin','users/groupofficeadmin',19,'Folder,groupofficeadmin,users/groupofficeadmin','2019-04-09 08:06:12',49),(12,12,17,'log','log',19,'Folder,log','2019-04-09 08:06:12',50),(13,13,17,'projects2','projects2',19,'Folder,projects2','2019-04-09 08:06:32',27),(14,14,17,'notes','notes',19,'Folder,notes','2019-04-09 08:06:32',27),(15,15,17,'tickets','tickets',19,'Folder,tickets','2019-04-09 08:06:32',27);
/*!40000 ALTER TABLE `core_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_setting`
--

DROP TABLE IF EXISTS `core_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_setting` (
  `moduleId` int(11) NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`moduleId`,`name`),
  CONSTRAINT `module` FOREIGN KEY (`moduleId`) REFERENCES `core_module` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_setting`
--

LOCK TABLES `core_setting` WRITE;
/*!40000 ALTER TABLE `core_setting` DISABLE KEYS */;
INSERT INTO `core_setting` VALUES (0,'databaseVersion',NULL),(0,'debugEmail',NULL),(0,'defaultAuthenticationDomain',NULL),(0,'language','en'),(0,'locale',NULL),(0,'loginMessage',NULL),(0,'loginMessageEnabled',''),(0,'logoId',NULL),(0,'maintenanceMode',''),(0,'passwordMinLength','6'),(0,'primaryColor',NULL),(0,'smtpEncryption','tls'),(0,'smtpEncryptionVerifyCertificate','1'),(0,'smtpHost','localhost'),(0,'smtpPassword',NULL),(0,'smtpPort','587'),(0,'smtpUsername',NULL),(0,'systemEmail','root@powermail.mydomainname.com'),(0,'title','Group-Office'),(0,'URL','http://powermail.mydomainname.com/groupoffice/'),(1,'databaseVersion','6.3.69'),(1,'debugEmail',NULL),(1,'defaultAuthenticationDomain',NULL),(1,'language','en'),(1,'locale','C.UTF-8'),(1,'loginMessage',NULL),(1,'loginMessageEnabled',''),(1,'logoId',NULL),(1,'maintenanceMode',''),(1,'passwordMinLength','6'),(1,'primaryColor',NULL),(1,'smtpEncryption','tls'),(1,'smtpEncryptionVerifyCertificate','1'),(1,'smtpHost','localhost'),(1,'smtpPassword',NULL),(1,'smtpPort','587'),(1,'smtpUsername',NULL),(1,'systemEmail','root@powermail.mydomainname.com'),(1,'title','Group-Office'),(1,'URL','http://powermail.mydomainname.com/groupoffice/');
/*!40000 ALTER TABLE `core_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_user`
--

DROP TABLE IF EXISTS `core_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `displayName` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `avatarId` binary(40) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `recoveryEmail` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `recoveryHash` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recoverySendAt` datetime DEFAULT NULL,
  `lastLogin` datetime DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `modifiedAt` datetime DEFAULT NULL,
  `dateFormat` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'd-m-Y',
  `shortDateInList` tinyint(1) NOT NULL DEFAULT '1',
  `timeFormat` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'G:i',
  `thousandsSeparator` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '.',
  `decimalSeparator` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ',',
  `currency` char(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `loginCount` int(11) NOT NULL DEFAULT '0',
  `max_rows_list` tinyint(4) NOT NULL DEFAULT '20',
  `timezone` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Asia/Kolkata',
  `start_module` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'summary',
  `language` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `theme` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Default',
  `firstWeekday` tinyint(4) NOT NULL DEFAULT '1',
  `sort_name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'first_name',
  `muser_id` int(11) NOT NULL DEFAULT '0',
  `mute_sound` tinyint(1) NOT NULL DEFAULT '0',
  `mute_reminder_sound` tinyint(1) NOT NULL DEFAULT '0',
  `mute_new_mail_sound` tinyint(1) NOT NULL DEFAULT '0',
  `show_smilies` tinyint(1) NOT NULL DEFAULT '1',
  `auto_punctuation` tinyint(1) NOT NULL DEFAULT '0',
  `listSeparator` char(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ';',
  `textSeparator` char(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '"',
  `files_folder_id` int(11) NOT NULL DEFAULT '0',
  `disk_quota` bigint(20) DEFAULT NULL,
  `disk_usage` bigint(20) NOT NULL DEFAULT '0',
  `mail_reminders` tinyint(1) NOT NULL DEFAULT '0',
  `popup_reminders` tinyint(1) NOT NULL DEFAULT '0',
  `popup_emails` tinyint(1) NOT NULL DEFAULT '0',
  `holidayset` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_email_addresses_by_time` tinyint(1) NOT NULL DEFAULT '0',
  `no_reminders` tinyint(1) NOT NULL DEFAULT '0',
  `last_password_change` int(11) NOT NULL DEFAULT '0',
  `force_password_change` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `fk_user_avatar_id_idx` (`avatarId`),
  CONSTRAINT `fk_user_avatar_id` FOREIGN KEY (`avatarId`) REFERENCES `core_blob` (`id`) ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_user`
--

LOCK TABLES `core_user` WRITE;
/*!40000 ALTER TABLE `core_user` DISABLE KEYS */;
INSERT INTO `core_user` VALUES (1,'groupofficeadmin','System Administrator',NULL,1,'root@powermail.mydomainname.com','root@powermail.mydomainname.com',NULL,NULL,'2019-04-09 08:05:46','2019-04-09 08:02:38','2019-04-09 08:05:46','d-m-Y',1,'G:i','.',',','€',2,20,'Asia/Kolkata','summary','en','Default',1,'first_name',0,0,0,0,1,0,';','\"',0,NULL,0,0,0,0,NULL,0,0,0,0);
/*!40000 ALTER TABLE `core_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_user_custom_fields`
--

DROP TABLE IF EXISTS `core_user_custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_user_custom_fields` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `core_user_custom_fields_ibfk_1` FOREIGN KEY (`id`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_user_custom_fields`
--

LOCK TABLES `core_user_custom_fields` WRITE;
/*!40000 ALTER TABLE `core_user_custom_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_user_custom_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_user_default_group`
--

DROP TABLE IF EXISTS `core_user_default_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_user_default_group` (
  `groupId` int(11) NOT NULL,
  PRIMARY KEY (`groupId`),
  CONSTRAINT `core_user_default_group_ibfk_1` FOREIGN KEY (`groupId`) REFERENCES `core_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_user_default_group`
--

LOCK TABLES `core_user_default_group` WRITE;
/*!40000 ALTER TABLE `core_user_default_group` DISABLE KEYS */;
INSERT INTO `core_user_default_group` VALUES (2);
/*!40000 ALTER TABLE `core_user_default_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_user_group`
--

DROP TABLE IF EXISTS `core_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_user_group` (
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`groupId`,`userId`),
  KEY `userId` (`userId`),
  CONSTRAINT `core_user_group_ibfk_1` FOREIGN KEY (`groupId`) REFERENCES `core_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_user_group_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_user_group`
--

LOCK TABLES `core_user_group` WRITE;
/*!40000 ALTER TABLE `core_user_group` DISABLE KEYS */;
INSERT INTO `core_user_group` VALUES (1,1),(2,1),(4,1);
/*!40000 ALTER TABLE `core_user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dav_calendar_changes`
--

DROP TABLE IF EXISTS `dav_calendar_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dav_calendar_changes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varbinary(200) NOT NULL,
  `synctoken` int(11) unsigned NOT NULL,
  `calendarid` int(11) unsigned NOT NULL,
  `operation` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `calendarid_synctoken` (`calendarid`,`synctoken`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dav_calendar_changes`
--

LOCK TABLES `dav_calendar_changes` WRITE;
/*!40000 ALTER TABLE `dav_calendar_changes` DISABLE KEYS */;
/*!40000 ALTER TABLE `dav_calendar_changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dav_contacts`
--

DROP TABLE IF EXISTS `dav_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dav_contacts` (
  `id` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `uri` varchar(190) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `uri` (`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dav_contacts`
--

LOCK TABLES `dav_contacts` WRITE;
/*!40000 ALTER TABLE `dav_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `dav_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dav_events`
--

DROP TABLE IF EXISTS `dav_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dav_events` (
  `id` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `uri` varchar(190) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `uri` (`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dav_events`
--

LOCK TABLES `dav_events` WRITE;
/*!40000 ALTER TABLE `dav_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `dav_events` ENABLE KEYS */;
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
-- Table structure for table `dav_tasks`
--

DROP TABLE IF EXISTS `dav_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dav_tasks` (
  `id` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `uri` varchar(190) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `uri` (`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dav_tasks`
--

LOCK TABLES `dav_tasks` WRITE;
/*!40000 ALTER TABLE `dav_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `dav_tasks` ENABLE KEYS */;
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
  `type` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `host` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `port` int(11) NOT NULL DEFAULT '0',
  `deprecated_use_ssl` tinyint(1) NOT NULL DEFAULT '0',
  `novalidate_cert` tinyint(1) NOT NULL DEFAULT '0',
  `username` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imap_encryption` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `imap_allow_self_signed` tinyint(1) NOT NULL DEFAULT '1',
  `mbroot` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `sent` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'Sent',
  `drafts` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'Drafts',
  `trash` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Trash',
  `spam` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Spam',
  `smtp_host` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_port` int(11) NOT NULL,
  `smtp_encryption` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `smtp_allow_self_signed` tinyint(1) NOT NULL DEFAULT '0',
  `smtp_username` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_password` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `password_encrypted` tinyint(4) NOT NULL DEFAULT '0',
  `ignore_sent_folder` tinyint(1) NOT NULL DEFAULT '0',
  `sieve_port` int(11) NOT NULL,
  `sieve_usetls` tinyint(1) NOT NULL DEFAULT '1',
  `check_mailboxes` text COLLATE utf8mb4_unicode_ci,
  `do_not_mark_as_read` tinyint(1) NOT NULL DEFAULT '0',
  `signature_below_reply` tinyint(1) NOT NULL DEFAULT '0',
  `full_reply_headers` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `signature` text COLLATE utf8mb4_unicode_ci,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `field` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keyword` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `folder` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority` int(11) NOT NULL DEFAULT '0',
  `mark_as_read` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscribed` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `delimiter` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `sort_order` tinyint(4) NOT NULL DEFAULT '0',
  `msgcount` int(11) NOT NULL DEFAULT '0',
  `unseen` int(11) NOT NULL DEFAULT '0',
  `auto_check` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `can_have_children` tinyint(1) NOT NULL,
  `no_select` tinyint(1) DEFAULT NULL,
  `sort` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `flag` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_id` int(11) NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `from` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to` text COLLATE utf8mb4_unicode_ci,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` int(11) NOT NULL DEFAULT '0',
  `path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  `mtime` int(11) NOT NULL DEFAULT '0',
  `muser_id` int(11) NOT NULL DEFAULT '0',
  `acl_id` int(11) NOT NULL,
  `uid` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `account_id` (`user_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `new` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` int(11) NOT NULL,
  `udate` int(11) NOT NULL,
  `attachments` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL,
  `flagged` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL,
  `answered` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL,
  `forwarded` tinyint(1) NOT NULL,
  `priority` tinyint(4) NOT NULL,
  `to` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serialized_message_object` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`folder_id`,`uid`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `folder_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  PRIMARY KEY (`account_id`,`folder_name`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_folders`
--

LOCK TABLES `emp_folders` WRITE;
/*!40000 ALTER TABLE `emp_folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `emp_folders` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fb_acl`
--

LOCK TABLES `fb_acl` WRITE;
/*!40000 ALTER TABLE `fb_acl` DISABLE KEYS */;
INSERT INTO `fb_acl` VALUES (1,46);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `extension` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cls` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`,`extension`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `locked_user_id` int(11) NOT NULL DEFAULT '0',
  `status_id` int(11) NOT NULL DEFAULT '0',
  `ctime` int(11) NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `muser_id` int(11) NOT NULL DEFAULT '0',
  `size` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `extension` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_time` int(11) NOT NULL DEFAULT '0',
  `random_code` char(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delete_when_expired` tinyint(1) NOT NULL DEFAULT '0',
  `content_expire_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `folder_id_2` (`folder_id`,`name`),
  KEY `folder_id` (`folder_id`),
  KEY `name` (`name`),
  KEY `extension` (`extension`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '0',
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `comment` text COLLATE utf8mb4_unicode_ci,
  `thumbs` tinyint(1) NOT NULL DEFAULT '1',
  `ctime` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  `muser_id` int(11) NOT NULL DEFAULT '0',
  `quota_user_id` int(11) NOT NULL DEFAULT '0',
  `readonly` tinyint(1) NOT NULL DEFAULT '0',
  `cm_state` text COLLATE utf8mb4_unicode_ci,
  `apply_state` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `parent_id_3` (`parent_id`,`name`),
  KEY `name` (`name`),
  KEY `parent_id` (`parent_id`),
  KEY `visible` (`visible`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_folders`
--

LOCK TABLES `fs_folders` WRITE;
/*!40000 ALTER TABLE `fs_folders` DISABLE KEYS */;
INSERT INTO `fs_folders` VALUES (1,1,0,'calendar',0,36,NULL,1,1554796998,1554796998,1,1,1,NULL,0),(1,2,1,'System Administrator',0,36,NULL,1,1554796998,1554796998,1,1,1,NULL,0),(1,3,0,'public',0,27,NULL,1,1554797146,1554797146,1,1,1,NULL,0),(1,4,3,'customcss',0,0,NULL,1,1554797146,1554797146,1,1,0,NULL,0),(1,5,0,'addressbook',0,47,NULL,1,1554797172,1554797172,1,1,1,NULL,0),(1,6,5,'photos',0,48,NULL,1,1554797172,1554797172,1,1,1,NULL,0),(1,7,5,'Prospects',0,15,NULL,1,1554797172,1554797172,1,1,1,NULL,0),(1,8,5,'Suppliers',0,16,NULL,1,1554797172,1554797172,1,1,1,NULL,0),(1,9,5,'Customers',0,17,NULL,1,1554797172,1554797172,1,1,1,NULL,0),(1,10,0,'users',0,27,NULL,1,1554797172,1554797172,1,1,1,NULL,0),(1,11,10,'groupofficeadmin',1,49,NULL,1,1554797172,1554797172,1,1,1,NULL,0),(1,12,0,'log',0,50,NULL,1,1554797172,1554797172,1,1,1,NULL,0),(1,13,0,'projects2',0,27,NULL,1,1554797192,1554797192,1,1,1,NULL,0),(1,14,0,'notes',0,27,NULL,1,1554797192,1554797192,1,1,1,NULL,0),(1,15,0,'tickets',0,27,NULL,1,1554797192,1554797192,1,1,1,NULL,0);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `arg1` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `arg2` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mtime` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`,`folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `comments` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `link_id` (`link_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acl_id` int(11) NOT NULL,
  `content` mediumblob NOT NULL,
  `extension` char(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_templates`
--

LOCK TABLES `fs_templates` WRITE;
/*!40000 ALTER TABLE `fs_templates` DISABLE KEYS */;
INSERT INTO `fs_templates` VALUES (1,1,'Microsoft Word document',28,'PK\0\0H�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0_rels/.rels��MKA���C��l+����\"Bo\"�������3i���A\n�P��Ǽy���m���N���AêiAq0Ѻ0jx�=/`�/�W>��J�\\*�ބ�aI���L�41q��!fOR�<b\"���qݶ��2��1��j�[���H�76z�$�&f^�\\��8.Nyd�`�y�q�j4�x]h�{�8��S4G�A�y�Y8X���(�[Fw�i4o|˼�l�^�͢����PK��#�\0\0\0=\0\0PK\0\0H�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/_rels/document.xml.rels��M\n�0���\"�ަU��nDp+�\01���6	�(z{�Z(����}�1/__��]�m��,I��Q�Ҧp(��%��I��NR\\	�v���Dn�yP-�2$֡����^R,}ÝT\'� ����O&�U��ʀ�7���m]k���=\Z\Z���n�H��A��>.?��|m\r������������?@��������I��wPK�/0��\0\0\0\0\0PK\0\0H�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/settings.xmlE�K�0D��\"����S����Bk�RbG����	+��73z��+E��\"#��f�� �<�t�p>�0��������l7����%�>�����jn����)Ȃ3ReW.)h��f\'.C.ܣH��h�έl\n#AW/?��Lm��#i�i��\ZQO�rTε����m��]�/PKe��\"�\0\0\0�\0\0\0PK\0\0H�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/fontTable.xml���N�0��<E�;K�Mպ		q�\0���]#%q���=Y۝(�@�%��������Y�c`C���B\n��j�O��8��o���K+9 ���n�ʆ|d��=���m�]����:���Pp�7�5���L�ӡ�j]�*����ܚ��얮qK�.�F����ρ�r7����r�q���x#�@�Ϛl%�B�q��å\ZF���L���C0p�xn�	��>�#�E��֬�,YF-���0�u�-77���-�������7PK��Z]\0\0\0\0PK\0\0H�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/styles.xml�TQo�0~߯��Nh�5T��	��н�A�9��s\Z诟�j��x������;���6�\Z�JF�s�f�X%\\n\"��|l�Y@dBI���=���;��xI�\"b��z����(��ݭ�����ل�2�6*F\"�>a���pɆu Z�I�ʍ+�؝v��``c@�����{����\\C.l��,,�qk��*Qi׿�_\n��b��5J�nkTES��qu�r�&;����˚�t\n�r�jyt�P�yĖ<s�̱�T��)b3�rL�L�7!���΃H��Hґ,ey����������u�֖1��	�g[�ĥOyk:?��5m�KS������@�J�Ӓu�5�l��l_�\n���`���������g�WC�Kx��h\\Gw�Z�kD��k�uA9��[�a|���p���}/Z��h�3��5�~�9������F��t����	�\'{\Zl\r�#���О��p�d�&\0Ơ����?��l3.q�g+7��������wL�g���5�v*�^��]f�l�zG�PKՔq�\0\0�\0\0PK\0\0H�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/document.xml�R�n�0��+\"���T�F.��VH�0�&�d{#{!Я�M�K�ś�̾&��\\�N��B���4e	X���Uξ�%K<	[�rv�6�U�(O,%������l�e\rF��Qҡǒ&M�e�$��.g5Q�q�\'M�����x���{��4]pZP��ת�C����F����-��q(��`��]_#����\'�uƌ�΅�C˿�l;����G,�16�g�naOW\rI���Ι� e|�⣢{�7��\"R$uJ�6c%ډ\nb� ��?��ù,��pm4u6{O��S�$�H�&R�*	�_O#�Nt5�b\ZJ�\'9U����A���dݨ�	��2Bwl4v理=J�}����ʅu�!\r�v�c��`����_�PK���ly\0\06\0\0PK\0\0H�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0docProps/app.xml��=k�0ཿ��TcL�BC�h�t3�tN��sp�}�����xx��v�Sq���wy�)�)��;v�)פH(���wБ+$��-�\0\r�\".u�6�&u+S�c���G+1��H�8\Z�^�Қ���4�2���W�\\���_��!{�����qz�S�Q��bo^4�T���z�7n^��u;�Mq�0�gPH�,[�f3�������#�PK(��\0\0\0h\0\0PK\0\0H�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0docProps/core.xmlm�[O�0���Kﷶ D�m\\h���D���������2���&\Z���}��𖋽�8/��-�@�H�V�u���P��\r\n��E}S\n˄q��$�,��g�Vh�e{��}	��qt-�\\|����9Vx��I��шN�F�J��A�(��cZP��*��8�t\0��UxHFr��H�}_�Ӂ����}��2<5�:}�\0T�\'5x�&�v��9y�><����:��,��5%lv�ncdS���<���W���ҹ.V��1K�8��TiMJ|9����PK��i\0\0\0\0PK\0\0H�B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0[Content_Types].xml��1O�0�����+JBI: 1B�0#c_�Ķ|����sh#���X���}�瓋�f�5x�֔�<�YFZ�M[���6�b�jQ�[���`ɺ�5�(;fց����A���;!�E�\"�/��&�	i��*�	終d%|���?z�gqe��{Ad�L8�k)��k�>��)V�\Z��30�=��z��)+_e$�74B�\\�П�l�h	S��漕�H~t���l����x���&��>�mх�w���O`:�6�r�p�CN��c��*���8�A��Ė��b�������\rPKc�a*\0\0^\0\0PK\0\0\0H�B��#�\0\0\0=\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0_rels/.relsPK\0\0\0H�B�/0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/_rels/document.xml.relsPK\0\0\0H�Be��\"�\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0!\0\0word/settings.xmlPK\0\0\0H�B��Z]\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/fontTable.xmlPK\0\0\0H�BՔq�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0F\0\0word/styles.xmlPK\0\0\0H�B���ly\0\06\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0word/document.xmlPK\0\0\0H�B(��\0\0\0h\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0S\0\0docProps/app.xmlPK\0\0\0H�B��i\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0s	\0\0docProps/core.xmlPK\0\0\0H�Bc�a*\0\0^\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\n\0\0[Content_Types].xmlPK\0\0\0\0	\0	\0<\0\0<\0\0\0\0','docx'),(2,1,'Open-Office Text document',29,'PK\0\0\0\0\0K;\Z9^�2\'\0\0\0\'\0\0\0\0\0\0mimetypeapplication/vnd.oasis.opendocument.textPK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\Z\0\0\0Configurations2/statusbar/PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\'\0\0\0Configurations2/accelerator/current.xml\0PK\0\0\0\0\0\0\0\0\0\0\0PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/floater/PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\Z\0\0\0Configurations2/popupmenu/PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/progressbar/PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/menubar/PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/toolbar/PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/images/Bitmaps/PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0content.xml�V�n!��+F,�c\']$S��JQ�JIMZuK��iyL���_�1N2	�7���s��s/ov�[�\rS���TbE�\\������\nܬ>,U�0L+�p\'��%VҺ�±���l\r:-+�3�D����J�T�*EWa�1vϳ���-��\\�Ǟp�S�����F}.�c��)�Q���e���E�=�bǙ�[���ma����r��\Z.���a��#��4(�!��/f�b��VP�r��ش$ى\'���A�p�l���]OH�7Hg�F\0��{I��$)W ����\n޻��qw�-r�����fm�6#:�+��R=!�P��|�	�q��߄��Y�8~�ǣ�J�&��-�C�t��tl|/�� \\�8=�\r�L����o�@G0{\\2i,�Ge\ZF��0�F^�]K5�6 �4�Q�q)�T���љ9��`5\\��B�@��A���bnV�x��pǾ�\Z<�2L���%��;?T0���G�*��.Aq����5�no�e}�wD��bw�H3y�vi_��R��^��̘s���Я�x@�L*�`2�0{c�x�&8e�!�:�T��!Ob��\"�q���2<o����>&z,B�0�r�/Ug�AK�N��k�0e��yg�v(��=+���󲸟g\'���qp`Z�6R��e$>�#O�&�wQ|x���˴�PK�\0=@�\0\0s	\0\0PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0styles.xml�YK��6��W*�m˻����E�����׀�h�	E\n$e�����D˒W�H�=, �p��<���7��MvD**�]O�ф�D��o�?��n�7�?��\rM�*I����F�6s�rĻ��|%��j�qN�J\'+Q�7�B�U�V����-s�[���������-s�;��\Z����M��1v�^1�(y�5��3ʿ�E���j6��jZ]M�����r9��p���d�+Mf��L��i<�9�x,>�B�e�&r�i��\'^U����mL�dX��\r�|�ޫt�{��po�u6����; ��޶� �I���t��~!D�lp	j�.�������앤�Ȁ=9˞`�4y�р/�\";�Ѥ.!Aي�{_�6��\'�$a�����fy⾍�,5yO��?\"�<�@0y֜��]�3.������ɑhÏ��I�Ȳ��rT\';,��$��<�߀��\0��êUE�z��?�g�_9���\Z�H�3�\Z�4��4ra�Ǟ�\r.Y݋��\Z�V�\"�I�y�oTH�A�)8�T��p**��hͧW	��!:D\r�Au%H8�ڎ2!�W���a]ܞe��)+$�X�\'�=2k�08GEu�\\��`��((���B�}��#\\jat@hДǊY�a���XK��)\r.מbʁ����3���((O��R�Vƃ�����E�L��n�\r�Ӕ����U�&�OiYB}��Hѯ�4^ڮ1̷%��gv!%�������DC�C_������DP���V��M��ǋ�ԯ��\'Պ<��#�t>F�pGhC��Ь�֬Gy5&�\Z?Dg\nL���phԂ#��lf����6\'wE�]:���}����(�RHOn����M�f�q�`�6e�_������@��G�q}��Qj7�vV�K�rj��n�I�cʑ��� \\�0��:,�H��+\Z#a��ZH�&蠐C1\\(��U���:�a���_)�[�3s�7���P���O)�i4X(��V\n�A2��u*�/�� ���B�8E�P��ې�#,|Z�?�Ez��PI˱�z&+L׽^خۮ����V\r9^�$kcۍ��ƘU���-Aᨯ��rq����2�W�c3�i�@�3>���C��IH~�����>}ܷ�i�r�31ʌ��s���c|�;.L)|A�J��Xm�%���Ƀ�H���[�����|8�z�[s�*\nwqx[�5�њ��m��}���^��n�A�Q+��^��\n_+Y�ڽ!z��VwG�,���5�92�%�9�ɯzk��95��5P�$�o�$i�kq���.���⺹P\\�.�/���Bq-/W<����B�\\h����\rݖ�>�&\rխm#�6�}��y�Q��Ҡ��F�\n���Ci;/���g\nF�˛�GHx:����EZ}j������rَG��Si���F�4�ih251��Zi��<9A&M�\'������ݣ�M��QO�Ng)M��2��t��	��̼��Wg�X+j$$�����B��{q��v���Ne\rih���\0D9�7�1ϖv�_3(Rxq�\Z��<�m���Ck\'���\'��=<xc�N},8�\\*��b��KHV��1����8�Q8��s�?TF��؏Yx�`�TPy��Vr�\Z��z�H:;�1�!\Z|G������oPK�E�}\0\0�\0\0PK\0\0\0\0\0K;\Z9�g��\0\0\0\0\0\0\0meta.xml<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<office:document-meta xmlns:office=\"urn:oasis:names:tc:opendocument:xmlns:office:1.0\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:meta=\"urn:oasis:names:tc:opendocument:xmlns:meta:1.0\" xmlns:ooo=\"http://openoffice.org/2004/office\" office:version=\"1.1\"><office:meta><meta:generator>OpenOffice.org/2.4$Linux OpenOffice.org_project/680m17$Build-9310</meta:generator><meta:initial-creator>Merijn Schering</meta:initial-creator><meta:creation-date>2008-08-26T09:26:02</meta:creation-date><meta:editing-cycles>0</meta:editing-cycles><meta:editing-duration>PT0S</meta:editing-duration><meta:user-defined meta:name=\"Info 1\"/><meta:user-defined meta:name=\"Info 2\"/><meta:user-defined meta:name=\"Info 3\"/><meta:user-defined meta:name=\"Info 4\"/><meta:document-statistic meta:table-count=\"0\" meta:image-count=\"0\" meta:object-count=\"0\" meta:page-count=\"1\" meta:paragraph-count=\"0\" meta:word-count=\"0\" meta:character-count=\"0\"/></office:meta></office:document-meta>PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Thumbnails/thumbnail.png��s���b``���p	�[8؀������{�8�T�y{i#\'�ρ\r|?�?���t�C��Ûw��~�2��9K&xrrV��o�ʓ����Ԏ_y2cTpTp�����3\n�*L���~.��\0PK�׃�|\0\0\0�\0\0PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0settings.xml�YQs�8~�_��;Jo�ʴ��챥����7��ձ2�S�ߟ�N�K	~�Mlɒ�믫����T��~^��@Fb~�=N������?�q6�h��1]Q�5-Qg�]�f���K�h\"S�j\n�jꠉ	�Ͷ���M�,{��x��Z\'�ju�\\�/�(�����Uվ�,\rP̢�����oU!�\"�!;�UvQ�]V������o\\S�Z?l�o]�\n��J�!6�9����x������k^Ѿ�{~�z_�`�m��uBo\"��V�+�p�}��\"��z�^����(ԋ\"ᗍ�Ɵ�d��|Qx�z��H��.GR�Ag��Ԗ�)\"&���)��\'��\n�1�}�g����Wb�T\"�\n�]_G��C�!ׇy�nUiI��L0_����Q����\'S�Uє��\\��O��V�h_�4\Z��/�D�Qk���_�8ٿ�	Iڎ���}a�vY�Q��׎�Sc�h�����&��y�/ b9����d���3���I6a\n�N��C�=û��?�A�{��T���o<Ti<��1%���ryLB����%�-N�z��p�\\��n$�&3�G(tO�t񯤬��8��L�url���~�t��J���xW�A�p��Q�Y���N����P�[��f.|e�0�(���n(QlS<��z[S��	&�^��#[tp���]��D{��~�1QGa�A�2�N�C�A��\'o1�7�F勰͙xV�t�tƃ�[zt������p$����#`!\n��AS��?A��.n�t}[�u��d��z�O�~T o�f��5%�˄���\r)��Q����U����|�b\nt�Swt߾���\"Щ�4�y4�c��U����o�ã�W�e�/�m�$-�]�����TJ�&���S�`M����������J��l9���°���[T���EY����nw�?��.[�BL���V�I�d ȭ�.�R��1pV�����D��^�ȍ�L���M�[�I߶Ӿk*�N�W�6����ɂ��W0��ZKSTQ��E\'W�uAUB5�+���_���D��9.��D;L�p�{*��:f\",h�����H��fk�6�)ҋ{&R��س�P#0u�L0O8�f��M��&}rt6��oY��bkL������	\nyj�T�\\Nu�Q��,x�KL���ީ����2��F����t��нXQ��$R�����j;o��|���L��PKt����\0\0h\0\0PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0META-INF/manifest.xml��Kj�0@�=���V�U1q-��&���f��W��6��X;	��F#�h��[S�0���Oͣ��)�k7v�c�^����aa����Ӡ�����HѵHS��\"��Z��^%��ۯ��ɴ|�.�A���x�.2�5�|�	�h��;�7GWs�h�,.��dL����B�%�My�n�c�� �Y\'�@,���`��(U�q:b�bqW�`<0�R�O �G?F�r7=�^�ޛbpmaD���-*긓��_PrS�4I7�Z��O�HN�z����b��K|0H�c-2��x��d7�!ɧa�87|��\"s�ϩ]����PK5b�9>\0\0J\0\0PK\0\0\0\0\0\0K;\Z9^�2\'\0\0\0\'\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0mimetypePK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\Z\0\0\0\0\0\0\0\0\0\0\0\0\0M\0\0\0Configurations2/statusbar/PK\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\'\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0Configurations2/accelerator/current.xmlPK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0Configurations2/floater/PK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\Z\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/popupmenu/PK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0J\0\0Configurations2/progressbar/PK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0Configurations2/menubar/PK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0Configurations2/toolbar/PK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0Configurations2/images/Bitmaps/PK\0\0\0\0K;\Z9�\0=@�\0\0s	\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0-\0\0content.xmlPK\0\0\0\0K;\Z9�E�}\0\0�\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0styles.xmlPK\0\0\0\0\0\0K;\Z9�g��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0meta.xmlPK\0\0\0\0K;\Z9�׃�|\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0Thumbnails/thumbnail.pngPK\0\0\0\0K;\Z9t����\0\0h\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0settings.xmlPK\0\0\0\0K;\Z95b�9>\0\0J\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0META-INF/manifest.xmlPK\0\0\0\0\0\0�\0\07\0\0\0\0','odt');
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
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `size_bytes` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `file_id` (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_versions`
--

LOCK TABLES `fs_versions` WRITE;
/*!40000 ALTER TABLE `fs_versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `fs_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_address_format`
--

DROP TABLE IF EXISTS `go_address_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_address_format` (
  `id` int(11) NOT NULL,
  `format` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `acl_id` int(11) NOT NULL DEFAULT '0',
  `data` text COLLATE utf8mb4_unicode_ci,
  `model_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `key` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `mtime` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`key`),
  KEY `mtime` (`mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_cf_setting_tabs`
--

LOCK TABLES `go_cf_setting_tabs` WRITE;
/*!40000 ALTER TABLE `go_cf_setting_tabs` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_cf_setting_tabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_clients`
--

DROP TABLE IF EXISTS `go_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `footprint` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  `last_active` int(11) NOT NULL,
  `in_use` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_footprint` (`footprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_clients`
--

LOCK TABLES `go_clients` WRITE;
/*!40000 ALTER TABLE `go_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_countries`
--

DROP TABLE IF EXISTS `go_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_countries` (
  `id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iso_code_2` char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `iso_code_3` char(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `minutes` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `hours` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `monthdays` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '*',
  `months` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '*',
  `weekdays` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '*',
  `years` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '*',
  `job` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `runonce` tinyint(1) NOT NULL DEFAULT '0',
  `nextrun` int(11) NOT NULL DEFAULT '0',
  `lastrun` int(11) NOT NULL DEFAULT '0',
  `completedat` int(11) NOT NULL DEFAULT '0',
  `error` text COLLATE utf8mb4_unicode_ci,
  `autodestroy` tinyint(1) NOT NULL DEFAULT '0',
  `params` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `nextrun_active` (`nextrun`,`active`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_cron`
--

LOCK TABLES `go_cron` WRITE;
/*!40000 ALTER TABLE `go_cron` DISABLE KEYS */;
INSERT INTO `go_cron` VALUES (1,'Calendar publisher',1,'0','*','*','*','*','*','GO\\Calendar\\Cron\\CalendarPublisher',0,1554800400,0,0,NULL,0,'[]'),(2,'Email Reminders',1,'*/5','*','*','*','*','*','GO\\Base\\Cron\\EmailReminders',0,1554797700,1554797402,1554797402,NULL,0,'[]'),(3,'Calculate disk usage',1,'0','0','*','*','*','*','GO\\Base\\Cron\\CalculateDiskUsage',0,1554854400,0,0,NULL,0,'[]');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_cron_users`
--

LOCK TABLES `go_cron_users` WRITE;
/*!40000 ALTER TABLE `go_cron_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_cron_users` ENABLE KEYS */;
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
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `region` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `free_day` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `region` (`region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `description` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `link_id` (`model_id`,`model_type_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_link_folders`
--

LOCK TABLES `go_link_folders` WRITE;
/*!40000 ALTER TABLE `go_link_folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_link_folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_links_ab_addresslists`
--

DROP TABLE IF EXISTS `go_links_ab_addresslists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_links_ab_addresslists` (
  `id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `model_type_id` int(11) NOT NULL,
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_links_ab_addresslists`
--

LOCK TABLES `go_links_ab_addresslists` WRITE;
/*!40000 ALTER TABLE `go_links_ab_addresslists` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_links_ab_addresslists` ENABLE KEYS */;
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
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_links_fs_folders`
--

LOCK TABLES `go_links_fs_folders` WRITE;
/*!40000 ALTER TABLE `go_links_fs_folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_links_fs_folders` ENABLE KEYS */;
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
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `model` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `model_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ctime` int(11) NOT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `controller_route` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `action` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `jsonData` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_log`
--

LOCK TABLES `go_log` WRITE;
/*!40000 ALTER TABLE `go_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_log` ENABLE KEYS */;
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
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` int(11) NOT NULL,
  `vtime` int(11) NOT NULL DEFAULT '0',
  `snooze_time` int(11) NOT NULL,
  `manual` tinyint(1) NOT NULL DEFAULT '0',
  `text` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  PRIMARY KEY (`reminder_id`,`user_id`),
  KEY `user_id_time` (`user_id`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `class_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `view` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `export_columns` text COLLATE utf8mb4_unicode_ci,
  `orientation` enum('V','H') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'V',
  `include_column_names` tinyint(1) NOT NULL DEFAULT '1',
  `use_db_column_names` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sql` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_saved_search_queries`
--

LOCK TABLES `go_saved_search_queries` WRITE;
/*!40000 ALTER TABLE `go_saved_search_queries` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_saved_search_queries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `go_search_sync`
--

DROP TABLE IF EXISTS `go_search_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `go_search_sync` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `module` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `last_sync_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `value` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`user_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_settings`
--

LOCK TABLES `go_settings` WRITE;
/*!40000 ALTER TABLE `go_settings` DISABLE KEYS */;
INSERT INTO `go_settings` VALUES (0,'cron_last_run','1554797402'),(0,'go_addressbook_export','35'),(0,'readonly_acl_id','47'),(1,'email_always_request_notification','0'),(1,'email_always_respond_to_notifications','0'),(1,'email_font_size','14px'),(1,'email_show_bcc','0'),(1,'email_show_cc','0'),(1,'email_skip_unknown_recipients','0'),(1,'email_sort_email_addresses_by_time','0'),(1,'email_use_plain_text_markup','0');
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
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `value` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`user_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_state`
--

LOCK TABLES `go_state` WRITE;
/*!40000 ALTER TABLE `go_state` DISABLE KEYS */;
INSERT INTO `go_state` VALUES (1,'go-module-panel-modules','o%3Acolumns%3Da%253Ao%25253Aid%25253Ds%2525253Aname%25255Ewidth%25253Dn%2525253A968%255Eo%25253Aid%25253Dn%2525253A1%25255Ewidth%25253Dn%2525253A100%255Eo%25253Aid%25253Ds%2525253Asort_order%25255Ewidth%25253Dn%2525253A100%255Eo%25253Aid%25253Dn%2525253A3%25255Ewidth%25253Dn%2525253A100%255Eo%25253Aid%25253Ds%2525253Apackage%25255Ewidth%25253Dn%2525253A100%25255Ehidden%25253Db%2525253A1%5Esort%3Do%253Afield%253Ds%25253Aname%255Edirection%253Ds%25253AASC%5Egroup%3Ds%253Apackage'),(1,'open-modules','a%3As%253Anotes%5Es%253Amodules%5Es%253Aaddressbook%5Es%253Abookmarks%5Es%253Acalendar%5Es%253Aemail%5Es%253Afiles%5Es%253Asummary%5Es%253Atasks%5Es%253Atools'),(1,'su-tasks-grid','o%3Acolumns%3Da%253Ao%25253Aid%25253Dn%2525253A0%25255Ewidth%25253Dn%2525253A40%255Eo%25253Aid%25253Ds%2525253Atask-portlet-name-col%25255Ewidth%25253Dn%2525253A487%255Eo%25253Aid%25253Dn%2525253A2%25255Ewidth%25253Dn%2525253A100%255Eo%25253Aid%25253Dn%2525253A3%25255Ewidth%25253Dn%2525253A150%25255Ehidden%25253Db%2525253A1%255Eo%25253Aid%25253Dn%2525253A4%25255Ewidth%25253Dn%2525253A50%25255Ehidden%25253Db%2525253A1%5Esort%3Do%253Afield%253Ds%25253Adue_time%255Edirection%253Ds%25253AASC%5Egroup%3Ds%253Atasklist_name');
/*!40000 ALTER TABLE `go_state` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_working_weeks`
--

LOCK TABLES `go_working_weeks` WRITE;
/*!40000 ALTER TABLE `go_working_weeks` DISABLE KEYS */;
/*!40000 ALTER TABLE `go_working_weeks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `googleauth_secret`
--

DROP TABLE IF EXISTS `googleauth_secret`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `googleauth_secret` (
  `userId` int(11) NOT NULL,
  `secret` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime NOT NULL,
  PRIMARY KEY (`userId`),
  KEY `user` (`userId`),
  CONSTRAINT `googleauth_secret_user` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `googleauth_secret`
--

LOCK TABLES `googleauth_secret` WRITE;
/*!40000 ALTER TABLE `googleauth_secret` DISABLE KEYS */;
/*!40000 ALTER TABLE `googleauth_secret` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imapauth_server`
--

DROP TABLE IF EXISTS `imapauth_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imapauth_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imapHostname` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `imapPort` int(11) NOT NULL DEFAULT '143',
  `imapEncryption` enum('tls','ssl') COLLATE utf8mb4_unicode_ci DEFAULT 'tls',
  `imapValidateCertificate` tinyint(1) NOT NULL DEFAULT '1',
  `removeDomainFromUsername` tinyint(1) NOT NULL DEFAULT '0',
  `smtpHostname` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `smtpPort` int(11) NOT NULL DEFAULT '587',
  `smtpUsername` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtpPassword` varchar(512) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `smtpUseUserCredentials` tinyint(1) NOT NULL DEFAULT '0',
  `smtpEncryption` enum('tls','ssl') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtpValidateCertificate` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imapauth_server`
--

LOCK TABLES `imapauth_server` WRITE;
/*!40000 ALTER TABLE `imapauth_server` DISABLE KEYS */;
INSERT INTO `imapauth_server` VALUES (3,'127.0.0.1',143,'tls',0,0,'127.0.0.1',587,'','{GOCRYPT2}def502006a6913b9e7b1466473b8521a1b20ea20733cf5aee91016c3b8f22e016468b969a2df5454afc1810e555d594909d8fb6a625ea93a876784c850e3ed2a54b621686b322348aec98ba38102d3179093ca82',1,'tls',0);
/*!40000 ALTER TABLE `imapauth_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imapauth_server_domain`
--

DROP TABLE IF EXISTS `imapauth_server_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imapauth_server_domain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverId` int(11) NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `serverId` (`serverId`),
  CONSTRAINT `imapauth_server_domain_ibfk_1` FOREIGN KEY (`serverId`) REFERENCES `imapauth_server` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imapauth_server_domain`
--

LOCK TABLES `imapauth_server_domain` WRITE;
/*!40000 ALTER TABLE `imapauth_server_domain` DISABLE KEYS */;
INSERT INTO `imapauth_server_domain` VALUES (3,3,'powermail.mydomainname.com');
/*!40000 ALTER TABLE `imapauth_server_domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imapauth_server_group`
--

DROP TABLE IF EXISTS `imapauth_server_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imapauth_server_group` (
  `serverId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  PRIMARY KEY (`serverId`,`groupId`),
  KEY `groupId` (`groupId`),
  CONSTRAINT `imapauth_server_group_ibfk_1` FOREIGN KEY (`serverId`) REFERENCES `imapauth_server` (`id`) ON DELETE CASCADE,
  CONSTRAINT `imapauth_server_group_ibfk_2` FOREIGN KEY (`groupId`) REFERENCES `core_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imapauth_server_group`
--

LOCK TABLES `imapauth_server_group` WRITE;
/*!40000 ALTER TABLE `imapauth_server_group` DISABLE KEYS */;
INSERT INTO `imapauth_server_group` VALUES (3,3);
/*!40000 ALTER TABLE `imapauth_server_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes_note`
--

DROP TABLE IF EXISTS `notes_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `noteBookId` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `modifiedBy` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `filesFolderId` int(11) DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `createdAt` datetime DEFAULT NULL,
  `modifiedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`createdBy`),
  KEY `category_id` (`noteBookId`),
  CONSTRAINT `notes_note_ibfk_1` FOREIGN KEY (`noteBookId`) REFERENCES `notes_note_book` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes_note`
--

LOCK TABLES `notes_note` WRITE;
/*!40000 ALTER TABLE `notes_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes_note_book`
--

DROP TABLE IF EXISTS `notes_note_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes_note_book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deletedAt` datetime DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `aclId` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileFolderId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `aclId` (`aclId`),
  CONSTRAINT `notes_note_book_ibfk_1` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes_note_book`
--

LOCK TABLES `notes_note_book` WRITE;
/*!40000 ALTER TABLE `notes_note_book` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes_note_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes_note_custom_fields`
--

DROP TABLE IF EXISTS `notes_note_custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes_note_custom_fields` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `notes_note_custom_fields_ibfk_1` FOREIGN KEY (`id`) REFERENCES `notes_note` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes_note_custom_fields`
--

LOCK TABLES `notes_note_custom_fields` WRITE;
/*!40000 ALTER TABLE `notes_note_custom_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes_note_custom_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smi_certs`
--

DROP TABLE IF EXISTS `smi_certs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smi_certs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cert` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smi_certs`
--

LOCK TABLES `smi_certs` WRITE;
/*!40000 ALTER TABLE `smi_certs` DISABLE KEYS */;
/*!40000 ALTER TABLE `smi_certs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smi_pkcs12`
--

DROP TABLE IF EXISTS `smi_pkcs12`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smi_pkcs12` (
  `account_id` int(11) NOT NULL,
  `cert` blob,
  `always_sign` tinyint(1) NOT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smi_pkcs12`
--

LOCK TABLES `smi_pkcs12` WRITE;
/*!40000 ALTER TABLE `smi_pkcs12` DISABLE KEYS */;
/*!40000 ALTER TABLE `smi_pkcs12` ENABLE KEYS */;
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
  `title` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `due_time` (`due_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `text` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `summary` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `su_visible_lists`
--

LOCK TABLES `su_visible_lists` WRITE;
/*!40000 ALTER TABLE `su_visible_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `su_visible_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync_addressbook_user`
--

DROP TABLE IF EXISTS `sync_addressbook_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_addressbook_user` (
  `addressbook_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `default_addressbook` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`addressbook_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_addressbook_user`
--

LOCK TABLES `sync_addressbook_user` WRITE;
/*!40000 ALTER TABLE `sync_addressbook_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_addressbook_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync_calendar_user`
--

DROP TABLE IF EXISTS `sync_calendar_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_calendar_user` (
  `calendar_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `default_calendar` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`calendar_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_calendar_user`
--

LOCK TABLES `sync_calendar_user` WRITE;
/*!40000 ALTER TABLE `sync_calendar_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_calendar_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync_devices`
--

DROP TABLE IF EXISTS `sync_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_devices` (
  `id` int(11) NOT NULL DEFAULT '0',
  `manufacturer` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `software_version` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `uri` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `UTC` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL,
  `vcalendar_version` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_devices`
--

LOCK TABLES `sync_devices` WRITE;
/*!40000 ALTER TABLE `sync_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync_note_categories_user`
--

DROP TABLE IF EXISTS `sync_note_categories_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_note_categories_user` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `default_category` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`category_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_note_categories_user`
--

LOCK TABLES `sync_note_categories_user` WRITE;
/*!40000 ALTER TABLE `sync_note_categories_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_note_categories_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync_settings`
--

DROP TABLE IF EXISTS `sync_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_settings` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `addressbook_id` int(11) NOT NULL DEFAULT '0',
  `calendar_id` int(11) NOT NULL DEFAULT '0',
  `tasklist_id` int(11) NOT NULL DEFAULT '0',
  `note_category_id` int(11) NOT NULL DEFAULT '0',
  `account_id` int(11) NOT NULL DEFAULT '0',
  `server_is_master` tinyint(1) NOT NULL DEFAULT '1',
  `max_days_old` tinyint(4) NOT NULL DEFAULT '0',
  `delete_old_events` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_settings`
--

LOCK TABLES `sync_settings` WRITE;
/*!40000 ALTER TABLE `sync_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync_tasklist_user`
--

DROP TABLE IF EXISTS `sync_tasklist_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_tasklist_user` (
  `tasklist_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `default_tasklist` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tasklist_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_tasklist_user`
--

LOCK TABLES `sync_tasklist_user` WRITE;
/*!40000 ALTER TABLE `sync_tasklist_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_tasklist_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync_user_note_book`
--

DROP TABLE IF EXISTS `sync_user_note_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_user_note_book` (
  `noteBookId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `isDefault` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`noteBookId`,`userId`),
  KEY `user` (`userId`),
  CONSTRAINT `sync_user_note_book_user` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_user_note_book`
--

LOCK TABLES `sync_user_note_book` WRITE;
/*!40000 ALTER TABLE `sync_user_note_book` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_user_note_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ta_categories`
--

DROP TABLE IF EXISTS `ta_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ta_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_portlet_tasklists`
--

LOCK TABLES `ta_portlet_tasklists` WRITE;
/*!40000 ALTER TABLE `ta_portlet_tasklists` DISABLE KEYS */;
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
  `reminder_time` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `remind` tinyint(1) NOT NULL DEFAULT '0',
  `default_tasklist_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_settings`
--

LOCK TABLES `ta_settings` WRITE;
/*!40000 ALTER TABLE `ta_settings` DISABLE KEYS */;
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
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `acl_id` int(11) NOT NULL,
  `files_folder_id` int(11) NOT NULL DEFAULT '0',
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_tasklists`
--

LOCK TABLES `ta_tasklists` WRITE;
/*!40000 ALTER TABLE `ta_tasklists` DISABLE KEYS */;
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `repeat_end_time` int(11) NOT NULL DEFAULT '0',
  `reminder` int(11) NOT NULL DEFAULT '0',
  `rrule` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `files_folder_id` int(11) NOT NULL DEFAULT '0',
  `category_id` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '1',
  `percentage_complete` tinyint(4) NOT NULL DEFAULT '0',
  `project_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `list_id` (`tasklist_id`),
  KEY `rrule` (`rrule`),
  KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_tasks`
--

LOCK TABLES `ta_tasks` WRITE;
/*!40000 ALTER TABLE `ta_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `ta_tasks` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-09 13:40:50
