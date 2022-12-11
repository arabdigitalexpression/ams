-- MySQL dump 10.13  Distrib 8.0.31, for Linux (x86_64)
--
-- Host: localhost    Database: AMS
-- ------------------------------------------------------
-- Server version	8.0.31-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (2,'Accountant'),(1,'Admin'),(3,'Viewer');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'إضافة قيد',7,'add_accountingentry'),(28,'عرض بيانات قيد',7,'view_accountingentry'),(29,'إضافة حساب',8,'add_accounttype'),(30,'تغيير بيانات حساب',8,'change_accounttype'),(31,'حذف حساب',8,'delete_accounttype'),(32,'عرض بيانات حساب',8,'view_accounttype'),(37,'إضافة مشروع',10,'add_project'),(38,'تغيير بيانات مشروع',10,'change_project'),(39,'حذف مشروع',10,'delete_project'),(40,'عرض بيانات مشروع',10,'view_project'),(41,'إضافة بند',11,'add_entryitem'),(44,'عرض بيانات بند',11,'view_entryitem'),(49,'إضافة عملة',13,'add_currency'),(50,'تغيير بيانات عملة',13,'change_currency'),(51,'حذف عملة',13,'delete_currency'),(52,'عرض بيانات عملة',13,'view_currency'),(53,'إضافة مستخدم',14,'add_user'),(54,'تغيير بيانات مستخدم',14,'change_user'),(55,'حذف مستخدم',14,'delete_user'),(56,'عرض بيانات مستخدم',14,'view_user'),(70,'إضافة مجموعة',3,'add_group'),(71,'تغيير بيانات مجموعة',3,'change_group'),(72,'حذف مجموعة',3,'delete_group'),(73,'عرض بيانات مجموعة',3,'view_group'),(74,'إضافة صلاحية',2,'add_permission'),(75,'تغيير بيانات صلاحية',2,'change_permission'),(76,'حذف صلاحية',2,'delete_permission'),(77,'عرض بيانات صلاحية',2,'view_permission'),(78,'Can change accounting entry',7,'change_accountingentry'),(79,'Can delete accounting entry',7,'delete_accountingentry'),(80,'Can change entry item',11,'change_entryitem'),(81,'Can delete entry item',11,'delete_entryitem');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `main_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(5,'contenttypes','contenttype'),(7,'main','accountingentry'),(8,'main','accounttype'),(13,'main','currency'),(11,'main','entryitem'),(10,'main','project'),(14,'main','user'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (72,'contenttypes','0001_initial','2022-11-20 18:27:56.255534'),(73,'contenttypes','0002_remove_content_type_name','2022-11-20 18:27:56.383960'),(74,'auth','0001_initial','2022-11-20 18:27:56.613103'),(75,'auth','0002_alter_permission_name_max_length','2022-11-20 18:27:56.792907'),(76,'auth','0003_alter_user_email_max_length','2022-11-20 18:27:56.911023'),(77,'auth','0004_alter_user_username_opts','2022-11-20 18:27:57.053085'),(78,'auth','0005_alter_user_last_login_null','2022-11-20 18:27:57.128274'),(79,'auth','0006_require_contenttypes_0002','2022-11-20 18:27:57.220359'),(80,'auth','0007_alter_validators_add_error_messages','2022-11-20 18:27:57.412409'),(81,'auth','0008_alter_user_username_max_length','2022-11-20 18:27:57.604761'),(82,'auth','0009_alter_user_last_name_max_length','2022-11-20 18:27:57.796628'),(83,'auth','0010_alter_group_name_max_length','2022-11-20 18:27:57.938541'),(84,'auth','0011_update_proxy_permissions','2022-11-20 18:27:58.047222'),(85,'auth','0012_alter_user_first_name_max_length','2022-11-20 18:27:58.180566'),(86,'main','0001_initial','2022-11-20 18:27:58.347761'),(87,'sessions','0001_initial','2022-11-20 18:27:58.431276'),(88,'main','0002_alter_user_options_user_is_reset_password_and_more','2022-11-20 18:29:09.584205'),(90,'main','0003_auto_20221207_1023','2022-12-07 13:24:03.487113');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('4erpcvky24scdnzq4h72j7m0craubamz','.eJxVjMsOwiAURP-FtSE8Sisu3fsN5DLcStVAUtqV8d9tky50OXPOzFsEWpcc1sZzmJK4CCtOv10kPLnsID2o3KtELcs8Rbkr8qBN3mri1_Vw_w4ytbyt0UfnO6e8d_0QFTQx24hxy2w1dwBZd4ZBgiKvFXtjYDkORCqNGuLzBe_JOLQ:1owpIh:uscouSzuKtxIHn3YzcKl2N3juKqhVom1q3xUGelv0r8','2022-12-04 18:44:19.140104'),('4z0tncsw8znvsteym3ho1xl21aussay4','.eJxVjEsOwjAMRO-SNYqSyCExS_acIbIdhxZQK_WzQtydVuoCdqN5b-ZtCq1LV9ZZp9JXczHenH47JnnqsIP6oOE-WhmHZerZ7oo96GxvY9XX9XD_Djqau22dKFNlj4mCSqsxSUCHzL4Jh6hNReGMQIDOBcwBHLYtOhCImTyYzxcC4TfQ:1oumml:npvtC7BT3Oij3pne3w3uftkI-btbML0T58g_5snnv8c','2022-11-29 03:38:55.770620'),('72jeer3wdeqe3al57f2pnnex0wkmbhpg','.eJxVjEsOwjAMRO-SNYqSyCExS_acIbIdhxZQK_WzQtydVuoCdqN5b-ZtCq1LV9ZZp9JXczHenH47JnnqsIP6oOE-WhmHZerZ7oo96GxvY9XX9XD_Djqau22dKFNlj4mCSqsxSUCHzL4Jh6hNReGMQIDOBcwBHLYtOhCImTyYzxcC4TfQ:1owpMA:19BtEvunIAcDZt1hzoDt4Ify6aFsE3Yi91zueG7TbTw','2022-12-04 18:47:54.737348'),('7od8k3e2t1aqtlz8zxoacmaybiphqi7v','.eJxVjEsOwjAMRO-SNYqSyCExS_acIbIdhxZQK_WzQtydVuoCdqN5b-ZtCq1LV9ZZp9JXczHenH47JnnqsIP6oOE-WhmHZerZ7oo96GxvY9XX9XD_Djqau22dKFNlj4mCSqsxSUCHzL4Jh6hNReGMQIDOBcwBHLYtOhCImTyYzxcC4TfQ:1owiP3:5qTboPFyebeVPc9T7ELIBNW9jhE4riKVEyqQS3dkoF8','2022-12-04 11:22:25.749387'),('cxihpzv635bwoim5pkzwk1pp22v4xzb1','.eJxVjDsOwjAQBe_iGlmOF7xeSnrOYO36gwPIkeKkQtwdIqWA9s3Me6nA61LD2vMcxqTOyqrD7yYcH7ltIN253SYdp7bMo-hN0Tvt-jql_Lzs7t9B5V6_NTnw0fNwQqGhWDAgTIa4YIqCIMUjFETj0WbyBcQKkrNGjrYYh1m9P9IoN10:1owjnZ:puKr9RWD-wYUxCHjJfU2mPVuse6rNELccUWyE9rDiZ8','2022-12-04 12:51:49.511603'),('dj2weayz4o2vt803gqfgyo34kkuzfai1','.eJxVjEsOwjAMRO-SNYqSyCExS_acIbIdhxZQK_WzQtydVuoCdqN5b-ZtCq1LV9ZZp9JXczHenH47JnnqsIP6oOE-WhmHZerZ7oo96GxvY9XX9XD_Djqau22dKFNlj4mCSqsxSUCHzL4Jh6hNReGMQIDOBcwBHLYtOhCImTyYzxcC4TfQ:1oujYY:Rh8QBeaxS2ooFRexbxHtptPvqtlOGjQh4rWvjkCGFcc','2022-11-29 00:12:02.514968'),('e2q6sienyrfpj0ojs5dmk5qm4agnhydh','.eJxVjEsOwjAMRO-SNYqSyCExS_acIbIdhxZQK_WzQtydVuoCdqN5b-ZtCq1LV9ZZp9JXczHenH47JnnqsIP6oOE-WhmHZerZ7oo96GxvY9XX9XD_Djqau22dKFNlj4mCSqsxSUCHzL4Jh6hNReGMQIDOBcwBHLYtOhCImTyYzxcC4TfQ:1onhax:l0ce-fHs8SwGMq5TASI-NqqqYGhchKiY5zFb5lDLDe8','2022-11-09 14:41:27.871179'),('i49so012wqkgp9enoyn4t3jz9jw2ctb3','.eJxVjEsOwjAMRO-SNYqSyCExS_acIbIdhxZQK_WzQtydVuoCdqN5b-ZtCq1LV9ZZp9JXczHenH47JnnqsIP6oOE-WhmHZerZ7oo96GxvY9XX9XD_Djqau22dKFNlj4mCSqsxSUCHzL4Jh6hNReGMQIDOBcwBHLYtOhCImTyYzxcC4TfQ:1oumcU:_tgu25RqKOKNSFh8wugA6IPeAkd7Mb67s2GKDpqzErY','2022-11-29 03:28:18.881833'),('jvq6rdnu6yxh8jn086xqgc4fjzsl5rcz','.eJxVjMsOwiAURP-FtSE8Sisu3fsN5DLcStVAUtqV8d9tky50OXPOzFsEWpcc1sZzmJK4CCtOv10kPLnsID2o3KtELcs8Rbkr8qBN3mri1_Vw_w4ytbyt0UfnO6e8d_0QFTQx24hxy2w1dwBZd4ZBgiKvFXtjYDkORCqNGuLzBe_JOLQ:1owpHV:SvqmAreAagm-MtNQ1t8cJW5GEYyH2ac1gZV4kZiZSGk','2022-12-04 18:43:05.352308'),('lwyeowieaalmoofvjpwe7yy61fcu0mwy','.eJxVjDsOwjAQBe_iGlmOF7xeSnrOYO36gwPIkeKkQtwdIqWA9s3Me6nA61LD2vMcxqTOyqrD7yYcH7ltIN253SYdp7bMo-hN0Tvt-jql_Lzs7t9B5V6_NTnw0fNwQqGhWDAgTIa4YIqCIMUjFETj0WbyBcQKkrNGjrYYh1m9P9IoN10:1owjXV:bPpRL6HIDYlTXhObM5GHI1EeDPjZXiVBkWbOBZEbvgE','2022-12-04 12:35:13.357902'),('mn8mqzgjkko8bmf3tpbcpj9wy0mox2mn','.eJxVjEEOwiAQRe_C2hCgUMCl-56BzAyjVA0kpV0Z765NutDtf-_9l0iwrSVtnZc0Z3EWRpx-NwR6cN1BvkO9NUmtrsuMclfkQbucWubn5XD_Dgr08q2RgopBWVIeNTtrXLgqzdYFrwcmxzaiNhEjRR6yh5FMHsADsQ8jghLvD88LN9U:1owjNb:QxF7TAJGPVFscHcAeWo6APYjjo7JvYiGAWbzb771KnM','2022-12-04 12:24:59.078881'),('nma2nm2aup547vz8vshu9s6nhdbb61zx','.eJxVjEsOwjAMRO-SNYqSyCExS_acIbIdhxZQK_WzQtydVuoCdqN5b-ZtCq1LV9ZZp9JXczHenH47JnnqsIP6oOE-WhmHZerZ7oo96GxvY9XX9XD_Djqau22dKFNlj4mCSqsxSUCHzL4Jh6hNReGMQIDOBcwBHLYtOhCImTyYzxcC4TfQ:1onhBC:nsdQsfIzqlaCST97N92bAEZ3tRThqxjAdVUjJ3EUudw','2022-11-09 14:14:50.027735'),('rhlyhj71rdoimwbxp155z22ibz5pfvsb','.eJxVjMsOwiAURP-FtSE8Sisu3fsN5DLcStVAUtqV8d9tky50OXPOzFsEWpcc1sZzmJK4CCtOv10kPLnsID2o3KtELcs8Rbkr8qBN3mri1_Vw_w4ytbyt0UfnO6e8d_0QFTQx24hxy2w1dwBZd4ZBgiKvFXtjYDkORCqNGuLzBe_JOLQ:1owpDb:Yq5RZ5_3X7i1_l9r0FLuzjSNNXQUTeTM3lmDn3jj4So','2022-12-04 18:39:03.636176'),('rtmfhp4cshu5af4ba8x144c44muhkilt','.eJxVjEsOwjAMRO-SNYqSyCExS_acIbIdhxZQK_WzQtydVuoCdqN5b-ZtCq1LV9ZZp9JXczHenH47JnnqsIP6oOE-WhmHZerZ7oo96GxvY9XX9XD_Djqau22dKFNlj4mCSqsxSUCHzL4Jh6hNReGMQIDOBcwBHLYtOhCImTyYzxcC4TfQ:1onh3z:IijDuHobUW1ZPlpQoA8GamYPfGeHV4rb3Wl361T8Rz0','2022-11-09 14:07:23.227025'),('xomep0irfq8qh31o1cmjxvlutb2pcf49','.eJxVjEsOwjAMRO-SNYqSyCExS_acIbIdhxZQK_WzQtydVuoCdqN5b-ZtCq1LV9ZZp9JXczHenH47JnnqsIP6oOE-WhmHZerZ7oo96GxvY9XX9XD_Djqau22dKFNlj4mCSqsxSUCHzL4Jh6hNReGMQIDOBcwBHLYtOhCImTyYzxcC4TfQ:1p2uLg:0mpT8wBk-MdCwv1yA6UBJ2kuS4GESKMyy48p-WNo7hk','2022-12-21 13:20:32.674190');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_accountingentry`
--

DROP TABLE IF EXISTS `main_accountingentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_accountingentry` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `number` int NOT NULL,
  `total` double NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `created_by_id` int DEFAULT NULL,
  `reverse_entry_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `main_accountingentry_created_by_id_b268cef7_fk_auth_user_id` (`created_by_id`),
  KEY `main_accountingentry_reverse_entry_id_543d9997_fk_main_acco` (`reverse_entry_id`),
  CONSTRAINT `main_accountingentry_created_by_id_b268cef7_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `main_user` (`id`),
  CONSTRAINT `main_accountingentry_reverse_entry_id_543d9997_fk_main_acco` FOREIGN KEY (`reverse_entry_id`) REFERENCES `main_accountingentry` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_accountingentry`
--

LOCK TABLES `main_accountingentry` WRITE;
/*!40000 ALTER TABLE `main_accountingentry` DISABLE KEYS */;
/*!40000 ALTER TABLE `main_accountingentry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_accounttype`
--

DROP TABLE IF EXISTS `main_accounttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_accounttype` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `balance_type` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_archived` tinyint(1) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `level_type` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `parent_account_id` bigint DEFAULT NULL,
  `currency_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `main_accounttype_parent_account_id_f534a17e_fk_main_acco` (`parent_account_id`),
  KEY `main_accounttype_currency_id_7fc4127c_fk_main_currency_id` (`currency_id`),
  CONSTRAINT `main_accounttype_currency_id_7fc4127c_fk_main_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `main_currency` (`id`),
  CONSTRAINT `main_accounttype_parent_account_id_f534a17e_fk_main_acco` FOREIGN KEY (`parent_account_id`) REFERENCES `main_accounttype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_accounttype`
--

LOCK TABLES `main_accounttype` WRITE;
/*!40000 ALTER TABLE `main_accounttype` DISABLE KEYS */;
INSERT INTO `main_accounttype` VALUES (4,'أصول','2022-11-15 00:23:52.140449','D',0,1,'M',NULL,1),(5,'التزامات','2022-11-15 00:23:54.866209','D',0,1,'M',NULL,1),(6,'حقوق الملكية','2022-11-15 00:23:57.228202','D',0,1,'M',NULL,1),(7,'الإرادات','2022-11-15 00:23:59.916535','C',0,1,'M',NULL,1),(8,'المصروفات','2022-11-15 00:24:03.484743','C',0,1,'M',NULL,1),(10,'أصول ثابتة','2022-11-15 02:52:42.795130','D',0,0,'M',4,1),(11,'أثاث','2022-11-15 05:56:49.287107','D',0,0,'S',10,2),(13,'التزامات طويلة الأجل','2022-11-15 05:57:43.011534','C',0,0,'M',5,1);
/*!40000 ALTER TABLE `main_accounttype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_currency`
--

DROP TABLE IF EXISTS `main_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_currency` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `symbol` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_primary` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `symbol` (`symbol`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_currency`
--

LOCK TABLES `main_currency` WRITE;
/*!40000 ALTER TABLE `main_currency` DISABLE KEYS */;
INSERT INTO `main_currency` VALUES (1,'جنيه مصري','E£','EGP',1,'2022-11-15 00:17:31.895969'),(2,'دولار أمريكي','$','USD',0,'2022-11-15 00:17:34.640840');
/*!40000 ALTER TABLE `main_currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_entryitem`
--

DROP TABLE IF EXISTS `main_entryitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_entryitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `credit_amount` double NOT NULL,
  `entry_id` bigint NOT NULL,
  `project_id` bigint DEFAULT NULL,
  `credit_account_id` bigint DEFAULT NULL,
  `debit_account_id` bigint DEFAULT NULL,
  `debit_amount` double NOT NULL,
  `exchange_rate` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `main_entryitem_entry_id_06c78e17_fk_main_accountingentry_id` (`entry_id`),
  KEY `main_entryitem_project_id_00cdf95b_fk_main_project_id` (`project_id`),
  KEY `main_entryitem_credit_account_id_ffa9decd_fk_main_accounttype_id` (`credit_account_id`),
  KEY `main_entryitem_debit_account_id_1e384be8_fk_main_accounttype_id` (`debit_account_id`),
  CONSTRAINT `main_entryitem_credit_account_id_ffa9decd_fk_main_accounttype_id` FOREIGN KEY (`credit_account_id`) REFERENCES `main_accounttype` (`id`),
  CONSTRAINT `main_entryitem_debit_account_id_1e384be8_fk_main_accounttype_id` FOREIGN KEY (`debit_account_id`) REFERENCES `main_accounttype` (`id`),
  CONSTRAINT `main_entryitem_entry_id_06c78e17_fk_main_accountingentry_id` FOREIGN KEY (`entry_id`) REFERENCES `main_accountingentry` (`id`),
  CONSTRAINT `main_entryitem_project_id_00cdf95b_fk_main_project_id` FOREIGN KEY (`project_id`) REFERENCES `main_project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_entryitem`
--

LOCK TABLES `main_entryitem` WRITE;
/*!40000 ALTER TABLE `main_entryitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `main_entryitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_project`
--

DROP TABLE IF EXISTS `main_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_project` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_project`
--

LOCK TABLES `main_project` WRITE;
/*!40000 ALTER TABLE `main_project` DISABLE KEYS */;
INSERT INTO `main_project` VALUES (1,'lmaooo84','2022-11-14 17:16:05.992571');
/*!40000 ALTER TABLE `main_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_user`
--

DROP TABLE IF EXISTS `main_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `is_reset_password` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_user`
--

LOCK TABLES `main_user` WRITE;
/*!40000 ALTER TABLE `main_user` DISABLE KEYS */;
INSERT INTO `main_user` VALUES (1,'pbkdf2_sha256$390000$RbsaSK04cHISbEpOPdBOCd$xbbAB//mw/Vcrdo35/0fG5e7mV2rNolLFBN2q5aMaoY=','2022-12-07 13:20:32.513949',1,'aramadan','','','askme557@gmail.com',1,1,'2022-09-10 21:30:57.168619',0);
/*!40000 ALTER TABLE `main_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_user_groups`
--

DROP TABLE IF EXISTS `main_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `main_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_user_groups`
--

LOCK TABLES `main_user_groups` WRITE;
/*!40000 ALTER TABLE `main_user_groups` DISABLE KEYS */;
INSERT INTO `main_user_groups` VALUES (1,1,1);
/*!40000 ALTER TABLE `main_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_user_user_permissions`
--

DROP TABLE IF EXISTS `main_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `main_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `main_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_user_user_permissions`
--

LOCK TABLES `main_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `main_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `main_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-07 15:24:12
