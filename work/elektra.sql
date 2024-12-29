-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Време на генериране: 29 дек 2024 в 18:27
-- Версия на сървъра: 10.4.32-MariaDB
-- Версия на PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данни: `elektra`
--

-- --------------------------------------------------------

--
-- Структура на таблица `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add user profile', 7, 'add_userprofile'),
(26, 'Can change user profile', 7, 'change_userprofile'),
(27, 'Can delete user profile', 7, 'delete_userprofile'),
(28, 'Can view user profile', 7, 'view_userprofile'),
(29, 'Can add Тема', 8, 'add_theme'),
(30, 'Can change Тема', 8, 'change_theme'),
(31, 'Can delete Тема', 8, 'delete_theme'),
(32, 'Can view Тема', 8, 'view_theme'),
(33, 'Can add Тема - точка', 9, 'add_themeitem'),
(34, 'Can change Тема - точка', 9, 'change_themeitem'),
(35, 'Can delete Тема - точка', 9, 'delete_themeitem'),
(36, 'Can view Тема - точка', 9, 'view_themeitem'),
(37, 'Can add Въпрос', 10, 'add_task'),
(38, 'Can change Въпрос', 10, 'change_task'),
(39, 'Can delete Въпрос', 10, 'delete_task'),
(40, 'Can view Въпрос', 10, 'view_task'),
(41, 'Can add Въпрос - опция', 11, 'add_taskitem'),
(42, 'Can change Въпрос - опция', 11, 'change_taskitem'),
(43, 'Can delete Въпрос - опция', 11, 'delete_taskitem'),
(44, 'Can view Въпрос - опция', 11, 'view_taskitem'),
(45, 'Can add school', 12, 'add_school'),
(46, 'Can change school', 12, 'change_school'),
(47, 'Can delete school', 12, 'delete_school'),
(48, 'Can view school', 12, 'view_school'),
(49, 'Can add Действие', 13, 'add_log'),
(50, 'Can change Действие', 13, 'change_log'),
(51, 'Can delete Действие', 13, 'delete_log'),
(52, 'Can view Действие', 13, 'view_log');

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$J3QT1KyzQ9K9TkJS79Jp6c$LYVVRovi/UeB4ZMR6O6BcXzA4AdYHNMZ0nLDofru3Ug=', '2024-12-28 21:45:50.392539', 1, 'superadmin', 'Георги', 'Бориков', 'ggborikov@abv.bg', 1, 1, '2024-12-27 15:18:02.000000'),
(2, 'pbkdf2_sha256$600000$pKOK50wmI1aw66iR8pD8Vz$Ovj60YW99UcFO1f+hasuQrSgz5A4/fAncwrvLc8gUfg=', NULL, 0, 'user', 'Пробен', 'Потребител', 'aa@bb.com', 0, 1, '2024-12-28 20:02:41.000000');

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2024-12-27 15:32:47.395214', '1', 'UserProfile object (1)', 2, '[{\"changed\": {\"fields\": [\"Phone number\", \"Birth date\"]}}]', 7, 1),
(2, '2024-12-27 22:05:49.435103', '1', 'superadmin', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Email address\"]}}]', 4, 1),
(3, '2024-12-27 23:09:51.268371', '1', 'School object (1)', 1, '[{\"added\": {}}]', 12, 1),
(4, '2024-12-28 19:39:27.383506', '1', '(2024-12-28 21:39:25+02:00) Георги Бориков/ ВЛИЗАНЕ В ПЛАТФОРМАТА', 2, '[{\"changed\": {\"fields\": [\"\\u0414\\u0430\\u0442\\u0430 \\u0438 \\u0447\\u0430\\u0441\"]}}]', 13, 1),
(5, '2024-12-28 19:39:40.264333', '1', '(2024-12-28 21:39:38+02:00) Георги Бориков/ ВЛИЗАНЕ В ПЛАТФОРМАТА', 2, '[{\"changed\": {\"fields\": [\"\\u0414\\u0430\\u0442\\u0430 \\u0438 \\u0447\\u0430\\u0441\"]}}]', 13, 1),
(6, '2024-12-28 19:39:50.727883', '1', '(2024-12-28 19:39:38+00:00) Георги Бориков/ ВЛИЗАНЕ В ПЛАТФОРМАТА', 3, '', 13, 1),
(7, '2024-12-28 20:02:41.978048', '2', 'user', 1, '[{\"added\": {}}]', 4, 1),
(8, '2024-12-28 20:03:36.589575', '2', 'user', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Email address\"]}}]', 4, 1),
(9, '2024-12-28 20:03:59.933553', '2', 'Потребител #2: Пробен Потребител', 2, '[{\"changed\": {\"fields\": [\"Phone number\"]}}]', 7, 1);

-- --------------------------------------------------------

--
-- Структура на таблица `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(13, 'main', 'log'),
(12, 'main', 'school'),
(10, 'main', 'task'),
(11, 'main', 'taskitem'),
(8, 'main', 'theme'),
(9, 'main', 'themeitem'),
(7, 'main', 'userprofile'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Структура на таблица `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-12-27 15:17:13.845019'),
(2, 'auth', '0001_initial', '2024-12-27 15:17:14.281605'),
(3, 'admin', '0001_initial', '2024-12-27 15:17:14.417948'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-12-27 15:17:14.425999'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-12-27 15:17:14.433475'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-12-27 15:17:14.480540'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-12-27 15:17:14.539647'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-12-27 15:17:14.550645'),
(9, 'auth', '0004_alter_user_username_opts', '2024-12-27 15:17:14.557674'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-12-27 15:17:14.595214'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-12-27 15:17:14.598215'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-12-27 15:17:14.605215'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-12-27 15:17:14.616946'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-12-27 15:17:14.629498'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-12-27 15:17:14.640031'),
(16, 'auth', '0011_update_proxy_permissions', '2024-12-27 15:17:14.647062'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-12-27 15:17:14.658062'),
(18, 'main', '0001_initial', '2024-12-27 15:17:14.730561'),
(19, 'sessions', '0001_initial', '2024-12-27 15:17:14.755706'),
(20, 'main', '0002_theme_alter_userprofile_options_themeitem', '2024-12-27 21:57:20.479663'),
(21, 'main', '0003_task_taskitem', '2024-12-27 22:29:12.653347'),
(22, 'main', '0004_school_task_themes', '2024-12-27 23:02:39.541204'),
(24, 'main', '0005_log_alter_school_options', '2024-12-29 14:47:56.308901');

-- --------------------------------------------------------

--
-- Структура на таблица `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('hytqjjs8da83nldahh7zzelzbyyemcyg', '.eJxVjMsOwiAQRf-FtSHA8HTp3m8gwwBSNTQp7cr479qkC93ec859sYjb2uI2yhKnzM5MstPvlpAepe8g37HfZk5zX5cp8V3hBx38OufyvBzu30HD0b41aB0EOp-T9aWgrD7VAl6ht4KqDtmik0AuqOpMdaRFgBAyVG3AUFLs_QHmSjfC:1tRed4:B-CvWVbXWl5b264nnOS0RJh6imCPD7bnYCxdvbSLdhg', '2025-01-11 21:45:50.404057'),
('mh1w7ww5ppky99ee8kv2gg796zs6t72y', '.eJxVjMsOwiAQRf-FtSHA8HTp3m8gwwBSNTQp7cr479qkC93ec859sYjb2uI2yhKnzM5MstPvlpAepe8g37HfZk5zX5cp8V3hBx38OufyvBzu30HD0b41aB0EOp-T9aWgrD7VAl6ht4KqDtmik0AuqOpMdaRFgBAyVG3AUFLs_QHmSjfC:1tRJNB:-v8NjQCXAwKoyVj-GufdzId_JaYPXQHamhypzjsGAzg', '2025-01-10 23:04:01.367333'),
('ucr603yzxwlb5ktjmhjbun6b5bbrprfw', '.eJxVjMsOwiAQRf-FtSHA8HTp3m8gwwBSNTQp7cr479qkC93ec859sYjb2uI2yhKnzM5MstPvlpAepe8g37HfZk5zX5cp8V3hBx38OufyvBzu30HD0b41aB0EOp-T9aWgrD7VAl6ht4KqDtmik0AuqOpMdaRFgBAyVG3AUFLs_QHmSjfC:1tRC99:ek07_lxQChuDcjzojrOMcTmLeAkdxL43vrlZDDHQfTI', '2025-01-10 15:21:03.639844');

-- --------------------------------------------------------

--
-- Структура на таблица `main_documents`
--

DROP TABLE IF EXISTS `main_documents`;
CREATE TABLE `main_documents` (
  `id` bigint(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `attachment` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `main_school`
--

DROP TABLE IF EXISTS `main_school`;
CREATE TABLE `main_school` (
  `id` bigint(20) NOT NULL,
  `short_name` varchar(20) NOT NULL,
  `full_name` longtext NOT NULL,
  `city` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `email` varchar(35) NOT NULL,
  `boss` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_school`
--

INSERT INTO `main_school` (`id`, `short_name`, `full_name`, `city`, `address`, `phone_number`, `email`, `boss`) VALUES
(1, 'ПГЕЕ', 'ПРОФЕСИОНАЛНА ГИМНАЗИЯ ПО ЕЛЕКТРОНИКА И ЕНЕРГЕТИКА', 'гр. Банско', '', '', '', '');

-- --------------------------------------------------------

--
-- Структура на таблица `main_specialty`
--

DROP TABLE IF EXISTS `main_specialty`;
CREATE TABLE `main_specialty` (
  `id` bigint(20) NOT NULL,
  `professional_field_num` varchar(3) NOT NULL,
  `professional_field_name` varchar(100) NOT NULL,
  `profession_num` varchar(6) NOT NULL,
  `profession_name` varchar(100) NOT NULL,
  `specialty_num` varchar(8) NOT NULL,
  `specialty_name` varchar(100) NOT NULL,
  `nip` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `main_task`
--

DROP TABLE IF EXISTS `main_task`;
CREATE TABLE `main_task` (
  `id` bigint(20) NOT NULL,
  `num` smallint(5) UNSIGNED NOT NULL CHECK (`num` >= 0),
  `text` longtext NOT NULL,
  `type` smallint(5) UNSIGNED NOT NULL CHECK (`type` >= 0),
  `picture` varchar(100) NOT NULL,
  `group` smallint(5) UNSIGNED NOT NULL CHECK (`group` >= 0),
  `mark_red` tinyint(1) DEFAULT NULL,
  `mark_green` tinyint(1) DEFAULT NULL,
  `mark_yellow` tinyint(1) DEFAULT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `level` smallint(5) UNSIGNED NOT NULL CHECK (`level` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `main_taskitem`
--

DROP TABLE IF EXISTS `main_taskitem`;
CREATE TABLE `main_taskitem` (
  `id` bigint(20) NOT NULL,
  `leading_char` varchar(4) NOT NULL,
  `text` varchar(200) NOT NULL,
  `value` varchar(20) NOT NULL,
  `value_name` varchar(200) NOT NULL,
  `checked` tinyint(1) DEFAULT NULL,
  `checked_t` tinyint(1) DEFAULT NULL,
  `value_t` varchar(20) NOT NULL,
  `task_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `main_theme`
--

DROP TABLE IF EXISTS `main_theme`;
CREATE TABLE `main_theme` (
  `id` bigint(20) NOT NULL,
  `num` smallint(5) UNSIGNED NOT NULL CHECK (`num` >= 0),
  `title` longtext NOT NULL,
  `remark` longtext NOT NULL,
  `tasks_total` smallint(5) UNSIGNED NOT NULL CHECK (`tasks_total` >= 0),
  `tasks_knowledge` smallint(5) UNSIGNED NOT NULL CHECK (`tasks_knowledge` >= 0),
  `tasks_comprehension` smallint(5) UNSIGNED NOT NULL CHECK (`tasks_comprehension` >= 0),
  `tasks_application` smallint(5) UNSIGNED NOT NULL CHECK (`tasks_application` >= 0),
  `tasks_analysis` smallint(5) UNSIGNED NOT NULL CHECK (`tasks_analysis` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `main_themeitem`
--

DROP TABLE IF EXISTS `main_themeitem`;
CREATE TABLE `main_themeitem` (
  `id` bigint(20) NOT NULL,
  `item` smallint(5) UNSIGNED NOT NULL CHECK (`item` >= 0),
  `title` longtext NOT NULL,
  `criterion` longtext NOT NULL,
  `total_points` smallint(5) UNSIGNED NOT NULL CHECK (`total_points` >= 0),
  `knowledge` smallint(5) UNSIGNED NOT NULL CHECK (`knowledge` >= 0),
  `comprehension` smallint(5) UNSIGNED NOT NULL CHECK (`comprehension` >= 0),
  `application` smallint(5) UNSIGNED NOT NULL CHECK (`application` >= 0),
  `analysis` smallint(5) UNSIGNED NOT NULL CHECK (`analysis` >= 0),
  `theme_id_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура на таблица `main_userprofile`
--

DROP TABLE IF EXISTS `main_userprofile`;
CREATE TABLE `main_userprofile` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `access_level` smallint(5) UNSIGNED NOT NULL CHECK (`access_level` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Схема на данните от таблица `main_userprofile`
--

INSERT INTO `main_userprofile` (`id`, `user_id`, `access_level`) VALUES
(1, 1, 5),
(2, 2, 5);

--
-- Indexes for dumped tables
--

--
-- Индекси за таблица `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Индекси за таблица `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Индекси за таблица `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Индекси за таблица `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Индекси за таблица `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Индекси за таблица `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Индекси за таблица `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Индекси за таблица `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Индекси за таблица `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Индекси за таблица `main_documents`
--
ALTER TABLE `main_documents`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `main_school`
--
ALTER TABLE `main_school`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `main_specialty`
--
ALTER TABLE `main_specialty`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `main_task`
--
ALTER TABLE `main_task`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_task_item_id_1d36f96a_fk_main_themeitem_id` (`item_id`);

--
-- Индекси за таблица `main_taskitem`
--
ALTER TABLE `main_taskitem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_taskitem_task_id_396d8f83_fk_main_task_id` (`task_id`);

--
-- Индекси за таблица `main_theme`
--
ALTER TABLE `main_theme`
  ADD PRIMARY KEY (`id`);

--
-- Индекси за таблица `main_themeitem`
--
ALTER TABLE `main_themeitem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_themeitem_theme_id_id_ed7a6412_fk_main_theme_id` (`theme_id_id`);

--
-- Индекси за таблица `main_userprofile`
--
ALTER TABLE `main_userprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `main_documents`
--
ALTER TABLE `main_documents`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_school`
--
ALTER TABLE `main_school`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `main_specialty`
--
ALTER TABLE `main_specialty`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_task`
--
ALTER TABLE `main_task`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_taskitem`
--
ALTER TABLE `main_taskitem`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_theme`
--
ALTER TABLE `main_theme`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_themeitem`
--
ALTER TABLE `main_themeitem`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_userprofile`
--
ALTER TABLE `main_userprofile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения за дъмпнати таблици
--

--
-- Ограничения за таблица `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Ограничения за таблица `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Ограничения за таблица `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ограничения за таблица `main_task`
--
ALTER TABLE `main_task`
  ADD CONSTRAINT `main_task_item_id_1d36f96a_fk_main_themeitem_id` FOREIGN KEY (`item_id`) REFERENCES `main_themeitem` (`id`);

--
-- Ограничения за таблица `main_taskitem`
--
ALTER TABLE `main_taskitem`
  ADD CONSTRAINT `main_taskitem_task_id_396d8f83_fk_main_task_id` FOREIGN KEY (`task_id`) REFERENCES `main_task` (`id`);

--
-- Ограничения за таблица `main_themeitem`
--
ALTER TABLE `main_themeitem`
  ADD CONSTRAINT `main_themeitem_theme_id_id_ed7a6412_fk_main_theme_id` FOREIGN KEY (`theme_id_id`) REFERENCES `main_theme` (`id`);

--
-- Ограничения за таблица `main_userprofile`
--
ALTER TABLE `main_userprofile`
  ADD CONSTRAINT `main_userprofile_user_id_15c416f4_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
