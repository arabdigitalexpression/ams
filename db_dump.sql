-- MariaDB dump 10.19  Distrib 10.5.16-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: AMS
-- ------------------------------------------------------
-- Server version	10.5.16-MariaDB

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add accounting entry',7,'add_accountingentry'),(26,'Can change accounting entry',7,'change_accountingentry'),(27,'Can delete accounting entry',7,'delete_accountingentry'),(28,'Can view accounting entry',7,'view_accountingentry'),(29,'Can add account type',8,'add_accounttype'),(30,'Can change account type',8,'change_accounttype'),(31,'Can delete account type',8,'delete_accounttype'),(32,'Can view account type',8,'view_accounttype'),(33,'Can add label',9,'add_label'),(34,'Can change label',9,'change_label'),(35,'Can delete label',9,'delete_label'),(36,'Can view label',9,'view_label'),(37,'Can add project',10,'add_project'),(38,'Can change project',10,'change_project'),(39,'Can delete project',10,'delete_project'),(40,'Can view project',10,'view_project'),(41,'Can add entry item',11,'add_entryitem'),(42,'Can change entry item',11,'change_entryitem'),(43,'Can delete entry item',11,'delete_entryitem'),(44,'Can view entry item',11,'view_entryitem');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$390000$RbsaSK04cHISbEpOPdBOCd$xbbAB//mw/Vcrdo35/0fG5e7mV2rNolLFBN2q5aMaoY=','2022-10-26 14:41:27.791507',1,'aramadan','','','askme557@gmail.com',1,1,'2022-09-10 21:30:57.168619');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_520_nopad_ci DEFAULT NULL,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'main','accountingentry'),(8,'main','accounttype'),(11,'main','entryitem'),(9,'main','label'),(10,'main','project'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2022-09-10 21:29:47.733304'),(2,'auth','0001_initial','2022-09-10 21:29:54.067062'),(3,'admin','0001_initial','2022-09-10 21:29:55.522180'),(4,'admin','0002_logentry_remove_auto_add','2022-09-10 21:29:55.561732'),(5,'admin','0003_logentry_add_action_flag_choices','2022-09-10 21:29:55.603942'),(6,'contenttypes','0002_remove_content_type_name','2022-09-10 21:29:56.157381'),(7,'auth','0002_alter_permission_name_max_length','2022-09-10 21:29:56.844864'),(8,'auth','0003_alter_user_email_max_length','2022-09-10 21:29:57.000606'),(9,'auth','0004_alter_user_username_opts','2022-09-10 21:29:57.069661'),(10,'auth','0005_alter_user_last_login_null','2022-09-10 21:29:57.477930'),(11,'auth','0006_require_contenttypes_0002','2022-09-10 21:29:57.523333'),(12,'auth','0007_alter_validators_add_error_messages','2022-09-10 21:29:57.592276'),(13,'auth','0008_alter_user_username_max_length','2022-09-10 21:29:57.699095'),(14,'auth','0009_alter_user_last_name_max_length','2022-09-10 21:29:57.845646'),(15,'auth','0010_alter_group_name_max_length','2022-09-10 21:29:57.989875'),(16,'auth','0011_update_proxy_permissions','2022-09-10 21:29:58.063661'),(17,'auth','0012_alter_user_first_name_max_length','2022-09-10 21:29:58.198745'),(18,'main','0001_initial','2022-09-10 21:30:03.111239'),(19,'sessions','0001_initial','2022-09-10 21:30:03.597105');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('e2q6sienyrfpj0ojs5dmk5qm4agnhydh','.eJxVjEsOwjAMRO-SNYqSyCExS_acIbIdhxZQK_WzQtydVuoCdqN5b-ZtCq1LV9ZZp9JXczHenH47JnnqsIP6oOE-WhmHZerZ7oo96GxvY9XX9XD_Djqau22dKFNlj4mCSqsxSUCHzL4Jh6hNReGMQIDOBcwBHLYtOhCImTyYzxcC4TfQ:1onhax:l0ce-fHs8SwGMq5TASI-NqqqYGhchKiY5zFb5lDLDe8','2022-11-09 14:41:27.871179'),('nma2nm2aup547vz8vshu9s6nhdbb61zx','.eJxVjEsOwjAMRO-SNYqSyCExS_acIbIdhxZQK_WzQtydVuoCdqN5b-ZtCq1LV9ZZp9JXczHenH47JnnqsIP6oOE-WhmHZerZ7oo96GxvY9XX9XD_Djqau22dKFNlj4mCSqsxSUCHzL4Jh6hNReGMQIDOBcwBHLYtOhCImTyYzxcC4TfQ:1onhBC:nsdQsfIzqlaCST97N92bAEZ3tRThqxjAdVUjJ3EUudw','2022-11-09 14:14:50.027735'),('rtmfhp4cshu5af4ba8x144c44muhkilt','.eJxVjEsOwjAMRO-SNYqSyCExS_acIbIdhxZQK_WzQtydVuoCdqN5b-ZtCq1LV9ZZp9JXczHenH47JnnqsIP6oOE-WhmHZerZ7oo96GxvY9XX9XD_Djqau22dKFNlj4mCSqsxSUCHzL4Jh6hNReGMQIDOBcwBHLYtOhCImTyYzxcC4TfQ:1onh3z:IijDuHobUW1ZPlpQoA8GamYPfGeHV4rb3Wl361T8Rz0','2022-11-09 14:07:23.227025');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_accountingentry`
--

DROP TABLE IF EXISTS `main_accountingentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_accountingentry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `number` int(11) NOT NULL,
  `total` double NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `reverse_entry_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `main_accountingentry_created_by_id_b268cef7_fk_auth_user_id` (`created_by_id`),
  KEY `main_accountingentry_reverse_entry_id_543d9997_fk_main_acco` (`reverse_entry_id`),
  CONSTRAINT `main_accountingentry_created_by_id_b268cef7_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `main_accountingentry_reverse_entry_id_543d9997_fk_main_acco` FOREIGN KEY (`reverse_entry_id`) REFERENCES `main_accountingentry` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_accountingentry`
--

LOCK TABLES `main_accountingentry` WRITE;
/*!40000 ALTER TABLE `main_accountingentry` DISABLE KEYS */;
INSERT INTO `main_accountingentry` VALUES (6,1,2000,'sad','2022-09-17 20:53:29.528701',1,NULL);
/*!40000 ALTER TABLE `main_accountingentry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_accounttype`
--

DROP TABLE IF EXISTS `main_accounttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_accounttype` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_accounttype`
--

LOCK TABLES `main_accounttype` WRITE;
/*!40000 ALTER TABLE `main_accounttype` DISABLE KEYS */;
INSERT INTO `main_accounttype` VALUES (1,'account 1','2022-09-12 14:52:04.136743'),(2,'account 1','2022-09-12 14:52:14.449033'),(3,'account 4','2022-09-17 20:51:58.353688');
/*!40000 ALTER TABLE `main_accounttype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_entryitem`
--

DROP TABLE IF EXISTS `main_entryitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_entryitem` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_debit` tinyint(1) NOT NULL,
  `amount` double NOT NULL,
  `entry_id` bigint(20) NOT NULL,
  `label_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `type_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `main_entryitem_entry_id_06c78e17_fk_main_accountingentry_id` (`entry_id`),
  KEY `main_entryitem_label_id_64e1be8a_fk_main_label_id` (`label_id`),
  KEY `main_entryitem_project_id_00cdf95b_fk_main_project_id` (`project_id`),
  KEY `main_entryitem_type_id_c9f23248_fk_main_accounttype_id` (`type_id`),
  CONSTRAINT `main_entryitem_entry_id_06c78e17_fk_main_accountingentry_id` FOREIGN KEY (`entry_id`) REFERENCES `main_accountingentry` (`id`),
  CONSTRAINT `main_entryitem_label_id_64e1be8a_fk_main_label_id` FOREIGN KEY (`label_id`) REFERENCES `main_label` (`id`),
  CONSTRAINT `main_entryitem_project_id_00cdf95b_fk_main_project_id` FOREIGN KEY (`project_id`) REFERENCES `main_project` (`id`),
  CONSTRAINT `main_entryitem_type_id_c9f23248_fk_main_accounttype_id` FOREIGN KEY (`type_id`) REFERENCES `main_accounttype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_entryitem`
--

LOCK TABLES `main_entryitem` WRITE;
/*!40000 ALTER TABLE `main_entryitem` DISABLE KEYS */;
INSERT INTO `main_entryitem` VALUES (3,1,1000,6,1,1,1),(4,0,1000,6,1,1,2);
/*!40000 ALTER TABLE `main_entryitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_label`
--

DROP TABLE IF EXISTS `main_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_label` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_label`
--

LOCK TABLES `main_label` WRITE;
/*!40000 ALTER TABLE `main_label` DISABLE KEYS */;
INSERT INTO `main_label` VALUES (1,'label lamooo','2022-09-12 14:51:16.641162');
/*!40000 ALTER TABLE `main_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_project`
--

DROP TABLE IF EXISTS `main_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_project` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_520_nopad_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_nopad_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_project`
--

LOCK TABLES `main_project` WRITE;
/*!40000 ALTER TABLE `main_project` DISABLE KEYS */;
INSERT INTO `main_project` VALUES (1,'lmaooo','2022-09-12 14:50:32.930999'),(2,'test','2022-10-18 15:33:13.802428'),(3,'test lol','2022-10-18 15:36:42.437191');
/*!40000 ALTER TABLE `main_project` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-26 16:44:05
