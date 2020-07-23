--
-- Скрипт сгенерирован Devart dbForge Studio 2019 for MySQL, Версия 8.1.22.0
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/mysql/studio
-- Дата скрипта: 09.06.2019 22:32:26
-- Версия сервера: 5.5.5-10.3.14-MariaDB
-- Версия клиента: 4.1
--

-- 
-- Отключение внешних ключей
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Установить режим SQL (SQL mode)
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Установка кодировки, с использованием которой клиент будет посылать запросы на сервер
--
SET NAMES 'utf8mb4';

--
-- Установка базы данных по умолчанию
--
USE academikplan;

--
-- Удалить таблицу `practs`
--
DROP TABLE IF EXISTS practs;

--
-- Удалить таблицу `pract_types`
--
DROP TABLE IF EXISTS pract_types;

--
-- Удалить таблицу `state_sertification`
--
DROP TABLE IF EXISTS state_sertification;

--
-- Удалить таблицу `sertification_types`
--
DROP TABLE IF EXISTS sertification_types;

--
-- Удалить таблицу `sub_subject`
--
DROP TABLE IF EXISTS sub_subject;

--
-- Удалить процедуру `creditCount`
--
DROP PROCEDURE IF EXISTS creditCount;

--
-- Удалить процедуру `examCount`
--
DROP PROCEDURE IF EXISTS examCount;

--
-- Удалить процедуру `sumAud`
--
DROP PROCEDURE IF EXISTS sumAud;

--
-- Удалить процедуру `sumBSR`
--
DROP PROCEDURE IF EXISTS sumBSR;

--
-- Удалить процедуру `sumPart`
--
DROP PROCEDURE IF EXISTS sumPart;

--
-- Удалить процедуру `sumSelf`
--
DROP PROCEDURE IF EXISTS sumSelf;

--
-- Удалить процедуру `sumZE`
--
DROP PROCEDURE IF EXISTS sumZE;

--
-- Удалить таблицу `subjects`
--
DROP TABLE IF EXISTS subjects;

--
-- Удалить процедуру `kpCount`
--
DROP PROCEDURE IF EXISTS kpCount;

--
-- Удалить таблицу `partes`
--
DROP TABLE IF EXISTS partes;

--
-- Удалить таблицу `cycles`
--
DROP TABLE IF EXISTS cycles;

--
-- Удалить таблицу `names`
--
DROP TABLE IF EXISTS names;

--
-- Удалить таблицу `aud_weeks`
--
DROP TABLE IF EXISTS aud_weeks;

--
-- Удалить таблицу `physical`
--
DROP TABLE IF EXISTS physical;

--
-- Удалить таблицу `study_shedules`
--
DROP TABLE IF EXISTS study_shedules;

--
-- Удалить таблицу `time_budgets`
--
DROP TABLE IF EXISTS time_budgets;

--
-- Удалить таблицу `version_control`
--
DROP TABLE IF EXISTS version_control;

--
-- Удалить таблицу `titles`
--
DROP TABLE IF EXISTS titles;

--
-- Удалить таблицу `users`
--
DROP TABLE IF EXISTS users;

--
-- Удалить таблицу `departments`
--
DROP TABLE IF EXISTS departments;

--
-- Удалить таблицу `faculties`
--
DROP TABLE IF EXISTS faculties;

--
-- Удалить таблицу `roles`
--
DROP TABLE IF EXISTS roles;

--
-- Удалить таблицу `physical_types`
--
DROP TABLE IF EXISTS physical_types;

--
-- Удалить таблицу `directions`
--
DROP TABLE IF EXISTS directions;

--
-- Удалить таблицу `group_direction`
--
DROP TABLE IF EXISTS group_direction;

--
-- Удалить таблицу `plan_types`
--
DROP TABLE IF EXISTS plan_types;

--
-- Удалить таблицу `profiles`
--
DROP TABLE IF EXISTS profiles;

--
-- Установка базы данных по умолчанию
--
USE academikplan;

--
-- Создать таблицу `profiles`
--
CREATE TABLE profiles (
  idProfile int(11) NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  PRIMARY KEY (idProfile)
)
ENGINE = INNODB,
AUTO_INCREMENT = 7,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать таблицу `plan_types`
--
CREATE TABLE plan_types (
  idPlan int(11) NOT NULL AUTO_INCREMENT,
  shortName varchar(1) NOT NULL,
  name varchar(50) NOT NULL,
  PRIMARY KEY (idPlan)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать таблицу `group_direction`
--
CREATE TABLE group_direction (
  idGroupDirection int(11) NOT NULL AUTO_INCREMENT,
  number varchar(8) NOT NULL,
  name varchar(120) NOT NULL,
  PRIMARY KEY (idGroupDirection)
)
ENGINE = INNODB,
AUTO_INCREMENT = 8,
AVG_ROW_LENGTH = 5461,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать таблицу `directions`
--
CREATE TABLE directions (
  idDirection int(11) NOT NULL AUTO_INCREMENT,
  number varchar(8) NOT NULL,
  name varchar(120) NOT NULL,
  PRIMARY KEY (idDirection)
)
ENGINE = INNODB,
AUTO_INCREMENT = 6,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать таблицу `physical_types`
--
CREATE TABLE physical_types (
  idPhysicalType int(11) NOT NULL,
  name varchar(80) NOT NULL,
  PRIMARY KEY (idPhysicalType)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать таблицу `roles`
--
CREATE TABLE roles (
  idRole int(11) NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  PRIMARY KEY (idRole)
)
ENGINE = INNODB,
AUTO_INCREMENT = 5,
AVG_ROW_LENGTH = 4096,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать таблицу `faculties`
--
CREATE TABLE faculties (
  idFaculty int(11) NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  shortName varchar(10) NOT NULL,
  visible int(1) NOT NULL,
  PRIMARY KEY (idFaculty)
)
ENGINE = INNODB,
AUTO_INCREMENT = 11,
AVG_ROW_LENGTH = 2730,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать таблицу `departments`
--
CREATE TABLE departments (
  idDepartment int(11) NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  shortName varchar(10) NOT NULL,
  idFaculty int(11) NOT NULL,
  visible int(1) NOT NULL,
  PRIMARY KEY (idDepartment)
)
ENGINE = INNODB,
AUTO_INCREMENT = 44,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать внешний ключ
--
ALTER TABLE departments
ADD CONSTRAINT FK_departments_idFaculty FOREIGN KEY (idFaculty)
REFERENCES faculties (idFaculty) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Создать таблицу `users`
--
CREATE TABLE users (
  idUser int(11) NOT NULL AUTO_INCREMENT,
  login varchar(20) NOT NULL,
  password varchar(20) NOT NULL,
  idFaculty int(11) DEFAULT NULL,
  idDepartment int(11) NOT NULL,
  idRole int(11) NOT NULL,
  visible int(1) NOT NULL,
  PRIMARY KEY (idUser)
)
ENGINE = INNODB,
AUTO_INCREMENT = 46,
AVG_ROW_LENGTH = 5461,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать индекс `FK_users_role` для объекта типа таблица `users`
--
ALTER TABLE users
ADD INDEX FK_users_role (idRole);

--
-- Создать внешний ключ
--
ALTER TABLE users
ADD CONSTRAINT FK_users_idDepartment FOREIGN KEY (idDepartment)
REFERENCES departments (idDepartment) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Создать внешний ключ
--
ALTER TABLE users
ADD CONSTRAINT FK_users_idFaculty FOREIGN KEY (idFaculty)
REFERENCES faculties (idFaculty) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Создать внешний ключ
--
ALTER TABLE users
ADD CONSTRAINT FK_users_idRole FOREIGN KEY (idRole)
REFERENCES roles (idRole) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Создать таблицу `titles`
--
CREATE TABLE titles (
  idTitle int(11) NOT NULL AUTO_INCREMENT,
  name varchar(15) NOT NULL,
  yearReception int(4) DEFAULT NULL,
  yearCreation int(4) NOT NULL,
  qualification varchar(20) NOT NULL,
  studyTime int(1) NOT NULL,
  studyLevel varchar(40) NOT NULL,
  formEducation varchar(20) DEFAULT NULL,
  idGroupDirection int(11) DEFAULT NULL,
  idDirection int(11) DEFAULT NULL,
  idProfile int(11) DEFAULT NULL,
  idPlan int(11) NOT NULL,
  idDepartment int(11) NOT NULL,
  visible int(1) NOT NULL,
  PRIMARY KEY (idTitle)
)
ENGINE = INNODB,
AUTO_INCREMENT = 13,
AVG_ROW_LENGTH = 4096,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать индекс `FK_titles_idLargDirection` для объекта типа таблица `titles`
--
ALTER TABLE titles
ADD INDEX FK_titles_idLargDirection (idGroupDirection);

--
-- Создать внешний ключ
--
ALTER TABLE titles
ADD CONSTRAINT FK_titles_idDepartment FOREIGN KEY (idDepartment)
REFERENCES departments (idDepartment) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Создать внешний ключ
--
ALTER TABLE titles
ADD CONSTRAINT FK_titles_idDirection FOREIGN KEY (idDirection)
REFERENCES directions (idDirection) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Создать внешний ключ
--
ALTER TABLE titles
ADD CONSTRAINT FK_titles_idGroupDirection FOREIGN KEY (idGroupDirection)
REFERENCES group_direction (idGroupDirection) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Создать внешний ключ
--
ALTER TABLE titles
ADD CONSTRAINT FK_titles_idPlan FOREIGN KEY (idPlan)
REFERENCES plan_types (idPlan) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Создать внешний ключ
--
ALTER TABLE titles
ADD CONSTRAINT FK_titles_idProfile FOREIGN KEY (idProfile)
REFERENCES profiles (idProfile) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Создать таблицу `version_control`
--
CREATE TABLE version_control (
  idVersion int(11) NOT NULL AUTO_INCREMENT,
  idTitle int(11) NOT NULL,
  name varchar(50) NOT NULL,
  time datetime NOT NULL,
  PRIMARY KEY (idVersion)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать внешний ключ
--
ALTER TABLE version_control
ADD CONSTRAINT FK_version_control_idTitle FOREIGN KEY (idTitle)
REFERENCES titles (idTitle) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Создать таблицу `time_budgets`
--
CREATE TABLE time_budgets (
  idBudget int(11) NOT NULL AUTO_INCREMENT,
  idTitle int(11) NOT NULL,
  course int(2) NOT NULL,
  weeksTheory int(2) NOT NULL,
  weeksSession int(2) NOT NULL,
  weeksPract int(2) NOT NULL,
  weeksDiplom int(2) NOT NULL,
  weeksExam int(2) NOT NULL,
  weeksHoliday int(2) NOT NULL,
  PRIMARY KEY (idBudget)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать внешний ключ
--
ALTER TABLE time_budgets
ADD CONSTRAINT FK_time_budgets_idTitle FOREIGN KEY (idTitle)
REFERENCES titles (idTitle) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Создать таблицу `study_shedules`
--
CREATE TABLE study_shedules (
  idShedule int(11) NOT NULL AUTO_INCREMENT,
  idTitle int(11) NOT NULL,
  course int(2) NOT NULL,
  week int(2) NOT NULL,
  label varchar(2) DEFAULT NULL,
  PRIMARY KEY (idShedule)
)
ENGINE = INNODB,
AUTO_INCREMENT = 1769,
AVG_ROW_LENGTH = 68,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать внешний ключ
--
ALTER TABLE study_shedules
ADD CONSTRAINT FK_study_shedules_idTitle FOREIGN KEY (idTitle)
REFERENCES titles (idTitle) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Создать таблицу `physical`
--
CREATE TABLE physical (
  idPhysical int(11) NOT NULL AUTO_INCREMENT,
  idTitle int(11) NOT NULL,
  idPhysicalType int(11) NOT NULL,
  bsr int(3) NOT NULL,
  PRIMARY KEY (idPhysical)
)
ENGINE = INNODB,
AUTO_INCREMENT = 11,
AVG_ROW_LENGTH = 2730,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать внешний ключ
--
ALTER TABLE physical
ADD CONSTRAINT FK_physical_idPhysicalType FOREIGN KEY (idPhysicalType)
REFERENCES physical_types (idPhysicalType) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Создать внешний ключ
--
ALTER TABLE physical
ADD CONSTRAINT FK_physical_idTitle FOREIGN KEY (idTitle)
REFERENCES titles (idTitle) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Создать таблицу `aud_weeks`
--
CREATE TABLE aud_weeks (
  idAud int(11) NOT NULL AUTO_INCREMENT,
  idPhysical int(11) NOT NULL,
  week int(1) NOT NULL,
  PRIMARY KEY (idAud)
)
ENGINE = INNODB,
AUTO_INCREMENT = 113,
AVG_ROW_LENGTH = 341,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать внешний ключ
--
ALTER TABLE aud_weeks
ADD CONSTRAINT FK_aud_weeks_idPhysical FOREIGN KEY (idPhysical)
REFERENCES physical (idPhysical) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Создать таблицу `names`
--
CREATE TABLE names (
  idName int(11) NOT NULL AUTO_INCREMENT,
  idTitle int(11) NOT NULL,
  rectorName varchar(50) NOT NULL,
  studyName varchar(50) NOT NULL,
  prorectorName varchar(50) NOT NULL,
  decanName varchar(50) NOT NULL,
  departName varchar(50) NOT NULL,
  PRIMARY KEY (idName)
)
ENGINE = INNODB,
AUTO_INCREMENT = 5,
AVG_ROW_LENGTH = 5461,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать внешний ключ
--
ALTER TABLE names
ADD CONSTRAINT FK_names_idTitle FOREIGN KEY (idTitle)
REFERENCES titles (idTitle) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Создать таблицу `cycles`
--
CREATE TABLE cycles (
  idCycle int(11) NOT NULL AUTO_INCREMENT,
  idTitle int(11) NOT NULL,
  shortName varchar(10) NOT NULL,
  name varchar(80) NOT NULL,
  PRIMARY KEY (idCycle)
)
ENGINE = INNODB,
AUTO_INCREMENT = 11,
AVG_ROW_LENGTH = 2730,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать внешний ключ
--
ALTER TABLE cycles
ADD CONSTRAINT FK_cycles_idTitle FOREIGN KEY (idTitle)
REFERENCES titles (idTitle) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Создать таблицу `partes`
--
CREATE TABLE partes (
  idPart int(11) NOT NULL AUTO_INCREMENT,
  idCycle int(11) NOT NULL,
  shortName varchar(10) NOT NULL,
  name varchar(80) NOT NULL,
  PRIMARY KEY (idPart)
)
ENGINE = INNODB,
AUTO_INCREMENT = 14,
AVG_ROW_LENGTH = 2048,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать внешний ключ
--
ALTER TABLE partes
ADD CONSTRAINT FK_partes_idCycle FOREIGN KEY (idCycle)
REFERENCES cycles (idCycle) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$

--
-- Создать процедуру `kpCount`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE kpCount (IN idTitle int(11))
BEGIN
  SELECT
    COUNT(s.name) AS 'count'
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE (s.name LIKE ('%Курсовой проект%')
  OR s.name LIKE ('%Курсовая работа%'))
  AND c.idTitle = idTitle
  AND (s.exams = 1
  OR s.credits = 1)
  UNION ALL
  SELECT
    COUNT(s.name)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE (s.name LIKE ('%Курсовой проект%')
  OR s.name LIKE ('%Курсовая работа%'))
  AND c.idTitle = idTitle
  AND (s.exams = 2
  OR s.credits = 2)
  UNION ALL
  SELECT
    COUNT(s.name)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE (s.name LIKE ('%Курсовой проект%')
  OR s.name LIKE ('%Курсовая работа%'))
  AND c.idTitle = idTitle
  AND (s.exams = 3
  OR s.credits = 3)
  UNION ALL
  SELECT
    COUNT(s.name)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE (s.name LIKE ('%Курсовой проект%')
  OR s.name LIKE ('%Курсовая работа%'))
  AND c.idTitle = idTitle
  AND (s.exams = 4
  OR s.credits = 4)
  UNION ALL
  SELECT
    COUNT(s.name)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE (s.name LIKE ('%Курсовой проект%')
  OR s.name LIKE ('%Курсовая работа%'))
  AND c.idTitle = idTitle
  AND (s.exams = 5
  OR s.credits = 5)
  UNION ALL
  SELECT
    COUNT(s.name)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE (s.name LIKE ('%Курсовой проект%')
  OR s.name LIKE ('%Курсовая работа%'))
  AND c.idTitle = idTitle
  AND (s.exams = 6
  OR s.credits = 6)
  UNION ALL
  SELECT
    COUNT(s.name)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE (s.name LIKE ('%Курсовой проект%')
  OR s.name LIKE ('%Курсовая работа%'))
  AND c.idTitle = idTitle
  AND (s.exams = 7
  OR s.credits = 7)
  UNION ALL
  SELECT
    COUNT(s.name)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE (s.name LIKE ('%Курсовой проект%')
  OR s.name LIKE ('%Курсовая работа%'))
  AND c.idTitle = idTitle
  AND (s.exams = 8
  OR s.credits = 8);
END
$$

DELIMITER ;

--
-- Создать таблицу `subjects`
--
CREATE TABLE subjects (
  idSubject int(11) NOT NULL AUTO_INCREMENT,
  idPart int(11) NOT NULL,
  number int(2) NOT NULL,
  name varchar(80) NOT NULL,
  depart varchar(10) NOT NULL,
  exams int(1) NOT NULL,
  credits int(1) NOT NULL,
  bsr int(2) NOT NULL,
  lec decimal(2, 1) NOT NULL,
  lab decimal(2, 1) NOT NULL,
  pract decimal(2, 1) NOT NULL,
  self decimal(2, 1) NOT NULL,
  PRIMARY KEY (idSubject)
)
ENGINE = INNODB,
AUTO_INCREMENT = 129,
AVG_ROW_LENGTH = 153,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать внешний ключ
--
ALTER TABLE subjects
ADD CONSTRAINT FK_subjects_idPart FOREIGN KEY (idPart)
REFERENCES partes (idPart) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$

--
-- Создать процедуру `sumZE`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE sumZE (IN idTitle int(11))
BEGIN
  SELECT
    SUM((s.lec * 18 + s.lab * 18 + s.pract * 18 + s.self * 18 + s.bsr) / 36) AS 'sum'
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 1
  OR s.credits = 1)
  UNION ALL
  SELECT
    SUM((s.lec * 18 + s.lab * 18 + s.pract * 18 + s.self * 18 + s.bsr) / 36)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 2
  OR s.credits = 2)
  UNION ALL
  SELECT
    SUM((s.lec * 18 + s.lab * 18 + s.pract * 18 + s.self * 18 + s.bsr) / 36)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 3
  OR s.credits = 3)
  UNION ALL
  SELECT
    SUM((s.lec * 18 + s.lab * 18 + s.pract * 18 + s.self * 18 + s.bsr) / 36)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 4
  OR s.credits = 4)
  UNION ALL
  SELECT
    SUM((s.lec * 18 + s.lab * 18 + s.pract * 18 + s.self * 18 + s.bsr) / 36)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 5
  OR s.credits = 5)
  UNION ALL
  SELECT
    SUM((s.lec * 18 + s.lab * 18 + s.pract * 18 + s.self * 18 + s.bsr) / 36)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 6
  OR s.credits = 6)
  UNION ALL
  SELECT
    SUM((s.lec * 18 + s.lab * 18 + s.pract * 18 + s.self * 18 + s.bsr) / 36)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 7
  OR s.credits = 7)
  UNION ALL
  SELECT
    SUM((s.lec * 9 + s.lab * 9 + s.pract * 9 + s.self * 9 + s.bsr) / 36)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 8
  OR s.credits = 8);
END
$$

--
-- Создать процедуру `sumSelf`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE sumSelf (IN idTitle int(11))
BEGIN
  SELECT
    SUM(s.self) AS 'sum'
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 1
  OR s.credits = 1)
  UNION ALL
  SELECT
    SUM(s.self)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 2
  OR s.credits = 2)
  UNION ALL
  SELECT
    SUM(s.self)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 3
  OR s.credits = 3)
  UNION ALL
  SELECT
    SUM(s.self)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 4
  OR s.credits = 4)
  UNION ALL
  SELECT
    SUM(s.self)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 5
  OR s.credits = 5)
  UNION ALL
  SELECT
    SUM(s.self)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 6
  OR s.credits = 6)
  UNION ALL
  SELECT
    SUM(s.self)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 7
  OR s.credits = 7)
  UNION ALL
  SELECT
    SUM(s.self)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 8
  OR s.credits = 8);
END
$$

--
-- Создать процедуру `sumPart`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE sumPart (IN idPart int(11), IN studyTime int(1))
BEGIN

  /* Лекции */
  SELECT
    SUM(s.lec * 9) INTO @lecLast
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = studyTime * 2
  OR s.credits = studyTime * 2);
  SELECT
    SUM(s.lec * 18) + IFNULL(@lecLast, 0) INTO @lec
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams != studyTime * 2
  AND s.credits != studyTime * 2);
  /* Лабораторные */
  SELECT
    SUM(s.lab * 9) INTO @labLast
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = studyTime * 2
  OR s.credits = studyTime * 2);
  SELECT
    SUM(s.lab * 18) + IFNULL(@labLast, 0) INTO @lab
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams != studyTime * 2
  AND s.credits != studyTime * 2);
  /* Практики */
  SELECT
    SUM(s.pract * 9) INTO @practLast
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = studyTime * 2
  OR s.credits = studyTime * 2);
  SELECT
    SUM(s.pract * 18) + IFNULL(@practLast, 0) INTO @pract
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams != studyTime * 2
  AND s.credits != studyTime * 2);
  /* КСР */
  SELECT
    SUM(s.self * 9) INTO @selfLast
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = studyTime * 2
  OR s.credits = studyTime * 2);
  SELECT
    SUM(s.self * 18) + IFNULL(@selfLast, 0) INTO @ksr
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams != studyTime * 2
  AND s.credits != studyTime * 2);
  /* БСР */
  SELECT
    SUM(s.bsr) INTO @bsr
  FROM subjects s
  WHERE s.idPart = idPart;

  SELECT
    (@lec + @lab + @pract + @ksr + @bsr) / 36 AS 'sum'
  UNION ALL
  SELECT
    COUNT(s.exams)
  FROM subjects s
  WHERE s.idPart = idPart
  AND s.exams > 0
  UNION ALL
  SELECT
    COUNT(s.credits)
  FROM subjects s
  WHERE s.idPart = idPart
  AND s.credits > 0
  UNION ALL
  SELECT
    @lec + @lab + @pract + @ksr + @bsr
  UNION ALL
  SELECT
    @lec + @lab + @pract
  UNION ALL
  SELECT
    @lec
  UNION ALL
  SELECT
    @lab
  UNION ALL
  SELECT
    @pract
  UNION ALL
  SELECT
    @ksr + @bsr
  UNION ALL
  SELECT
    @ksr
  UNION ALL
  SELECT
    @bsr
  UNION ALL

  SELECT
    SUM(s.lec)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 1
  OR s.credits = 1)
  UNION ALL
  SELECT
    SUM(s.lab)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 1
  OR s.credits = 1)
  UNION ALL
  SELECT
    SUM(s.pract)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 1
  OR s.credits = 1)
  UNION ALL
  SELECT
    SUM(s.self)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 1
  OR s.credits = 1)
  UNION ALL

  SELECT
    SUM(s.lec)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 2
  OR s.credits = 2)
  UNION ALL
  SELECT
    SUM(s.lab)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 2
  OR s.credits = 2)
  UNION ALL
  SELECT
    SUM(s.pract)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 2
  OR s.credits = 2)
  UNION ALL
  SELECT
    SUM(s.self)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 2
  OR s.credits = 2)
  UNION ALL

  SELECT
    SUM(s.lec)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 3
  OR s.credits = 3)
  UNION ALL
  SELECT
    SUM(s.lab)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 3
  OR s.credits = 3)
  UNION ALL
  SELECT
    SUM(s.pract)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 3
  OR s.credits = 3)
  UNION ALL
  SELECT
    SUM(s.self)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 3
  OR s.credits = 3)
  UNION ALL

  SELECT
    SUM(s.lec)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 4
  OR s.credits = 4)
  UNION ALL
  SELECT
    SUM(s.lab)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 4
  OR s.credits = 4)
  UNION ALL
  SELECT
    SUM(s.pract)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 4
  OR s.credits = 4)
  UNION ALL
  SELECT
    SUM(s.self)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 4
  OR s.credits = 4)
  UNION ALL

  SELECT
    SUM(s.lec)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 5
  OR s.credits = 5)
  UNION ALL
  SELECT
    SUM(s.lab)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 5
  OR s.credits = 5)
  UNION ALL
  SELECT
    SUM(s.pract)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 5
  OR s.credits = 5)
  UNION ALL
  SELECT
    SUM(s.self)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 5
  OR s.credits = 5)
  UNION ALL

  SELECT
    SUM(s.lec)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 6
  OR s.credits = 6)
  UNION ALL
  SELECT
    SUM(s.lab)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 6
  OR s.credits = 6)
  UNION ALL
  SELECT
    SUM(s.pract)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 6
  OR s.credits = 6)
  UNION ALL
  SELECT
    SUM(s.self)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 6
  OR s.credits = 6)
  UNION ALL

  SELECT
    SUM(s.lec)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 7
  OR s.credits = 7)
  UNION ALL
  SELECT
    SUM(s.lab)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 7
  OR s.credits = 7)
  UNION ALL
  SELECT
    SUM(s.pract)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 7
  OR s.credits = 7)
  UNION ALL
  SELECT
    SUM(s.self)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 7
  OR s.credits = 7)
  UNION ALL

  SELECT
    SUM(s.lec)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 8
  OR s.credits = 8)
  UNION ALL
  SELECT
    SUM(s.lab)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 8
  OR s.credits = 8)
  UNION ALL
  SELECT
    SUM(s.pract)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 8
  OR s.credits = 8)
  UNION ALL
  SELECT
    SUM(s.self)
  FROM subjects s
  WHERE s.idPart = idPart
  AND (s.exams = 8
  OR s.credits = 8);
END
$$

--
-- Создать процедуру `sumBSR`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE sumBSR (IN idTitle int(11))
BEGIN
  SELECT
    SUM(s.bsr) AS 'sum'
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 1
  OR s.credits = 1)
  UNION ALL
  SELECT
    SUM(s.bsr)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 2
  OR s.credits = 2)
  UNION ALL
  SELECT
    SUM(s.bsr)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 3
  OR s.credits = 3)
  UNION ALL
  SELECT
    SUM(s.bsr)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 4
  OR s.credits = 4)
  UNION ALL
  SELECT
    SUM(s.bsr)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 5
  OR s.credits = 5)
  UNION ALL
  SELECT
    SUM(s.bsr)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 6
  OR s.credits = 6)
  UNION ALL
  SELECT
    SUM(s.bsr)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 7
  OR s.credits = 7)
  UNION ALL
  SELECT
    SUM(s.bsr)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 8
  OR s.credits = 8)
  UNION ALL
  SELECT
    SUM(s.bsr)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle;
END
$$

--
-- Создать процедуру `sumAud`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE sumAud (IN idTitle int(11))
BEGIN
  SELECT
    SUM(s.lec + s.lab + s.pract) AS 'sum'
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 1
  OR s.credits = 1)
  UNION ALL
  SELECT
    SUM(s.lec + s.lab + s.pract)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 2
  OR s.credits = 2)
  UNION ALL
  SELECT
    SUM(s.lec + s.lab + s.pract)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 3
  OR s.credits = 3)
  UNION ALL
  SELECT
    SUM(s.lec + s.lab + s.pract)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 4
  OR s.credits = 4)
  UNION ALL
  SELECT
    SUM(s.lec + s.lab + s.pract)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 5
  OR s.credits = 5)
  UNION ALL
  SELECT
    SUM(s.lec + s.lab + s.pract)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 6
  OR s.credits = 6)
  UNION ALL
  SELECT
    SUM(s.lec + s.lab + s.pract)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 7
  OR s.credits = 7)
  UNION ALL
  SELECT
    SUM(s.lec + s.lab + s.pract)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 8
  OR s.credits = 8);
END
$$

--
-- Создать процедуру `examCount`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE examCount (IN idTitle int(11))
BEGIN
  SELECT
    COUNT(s.exams) AS 'count'
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 1)
  UNION ALL
  SELECT
    COUNT(s.exams)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 2)
  UNION ALL
  SELECT
    COUNT(s.exams)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 3)
  UNION ALL
  SELECT
    COUNT(s.exams)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 4)
  UNION ALL
  SELECT
    COUNT(s.exams)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 5)
  UNION ALL
  SELECT
    COUNT(s.exams)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 6)
  UNION ALL
  SELECT
    COUNT(s.exams)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 7)
  UNION ALL
  SELECT
    COUNT(s.exams)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.exams = 8);
END
$$

--
-- Создать процедуру `creditCount`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE creditCount (IN idTitle int(11))
BEGIN
  SELECT
    COUNT(s.credits) AS 'count'
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.credits = 1)
  UNION ALL
  SELECT
    COUNT(s.credits)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.credits = 2)
  UNION ALL
  SELECT
    COUNT(s.credits)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.credits = 3)
  UNION ALL
  SELECT
    COUNT(s.credits)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.credits = 4)
  UNION ALL
  SELECT
    COUNT(s.credits)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.credits = 5)
  UNION ALL
  SELECT
    COUNT(s.credits)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.credits = 6)
  UNION ALL
  SELECT
    COUNT(s.credits)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.credits = 7)
  UNION ALL
  SELECT
    COUNT(s.credits)
  FROM subjects s
    INNER JOIN partes p
      ON s.idPart = p.idPart
    INNER JOIN cycles c
      ON p.idCycle = c.idCycle
  WHERE c.idTitle = idTitle
  AND (s.credits = 8);
END
$$

DELIMITER ;

--
-- Создать таблицу `sub_subject`
--
CREATE TABLE sub_subject (
  idSubSubject int(11) NOT NULL AUTO_INCREMENT,
  idSubject int(11) NOT NULL,
  name varchar(80) NOT NULL,
  PRIMARY KEY (idSubSubject)
)
ENGINE = INNODB,
AUTO_INCREMENT = 27,
AVG_ROW_LENGTH = 744,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать внешний ключ
--
ALTER TABLE sub_subject
ADD CONSTRAINT FK_sub_subject_idSubject FOREIGN KEY (idSubject)
REFERENCES subjects (idSubject) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Создать таблицу `sertification_types`
--
CREATE TABLE sertification_types (
  idSertificationType int(11) NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  PRIMARY KEY (idSertificationType)
)
ENGINE = INNODB,
AUTO_INCREMENT = 7,
AVG_ROW_LENGTH = 5461,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать таблицу `state_sertification`
--
CREATE TABLE state_sertification (
  idSertification int(11) NOT NULL AUTO_INCREMENT,
  idTitle int(11) NOT NULL,
  idSertificationType int(11) NOT NULL,
  semester int(2) NOT NULL,
  ze decimal(2, 1) NOT NULL,
  PRIMARY KEY (idSertification)
)
ENGINE = INNODB,
AUTO_INCREMENT = 19,
AVG_ROW_LENGTH = 3276,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать внешний ключ
--
ALTER TABLE state_sertification
ADD CONSTRAINT FK_state_sertification_idSertificationType FOREIGN KEY (idSertificationType)
REFERENCES sertification_types (idSertificationType) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Создать внешний ключ
--
ALTER TABLE state_sertification
ADD CONSTRAINT FK_state_sertification_idTitle FOREIGN KEY (idTitle)
REFERENCES titles (idTitle) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Создать таблицу `pract_types`
--
CREATE TABLE pract_types (
  idPractType int(11) NOT NULL AUTO_INCREMENT,
  name varchar(20) NOT NULL,
  PRIMARY KEY (idPractType)
)
ENGINE = INNODB,
AUTO_INCREMENT = 8,
AVG_ROW_LENGTH = 3276,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать таблицу `practs`
--
CREATE TABLE practs (
  idPract int(11) NOT NULL AUTO_INCREMENT,
  idTitle int(11) NOT NULL,
  idPractType int(11) NOT NULL,
  semester int(2) NOT NULL,
  week int(4) NOT NULL,
  PRIMARY KEY (idPract)
)
ENGINE = INNODB,
AUTO_INCREMENT = 44,
AVG_ROW_LENGTH = 2340,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Создать внешний ключ
--
ALTER TABLE practs
ADD CONSTRAINT FK_practs_idPractType FOREIGN KEY (idPractType)
REFERENCES pract_types (idPractType) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Создать внешний ключ
--
ALTER TABLE practs
ADD CONSTRAINT FK_practs_idTitle FOREIGN KEY (idTitle)
REFERENCES titles (idTitle) ON DELETE CASCADE ON UPDATE CASCADE;

-- 
-- Вывод данных для таблицы faculties
--
INSERT INTO faculties VALUES
(1, 'Общий доступ', '-', 1),
(2, 'Автоматизация и электротехнические системы', 'АЭС', 1),
(3, 'Факультет 2', 'Ф2', 1),
(8, '1234', '1234', 0),
(9, 'rhrhrht', 'rthhrtrth', 0),
(10, 'rghethrth', 'rhtrthrth', 0);

-- 
-- Вывод данных для таблицы profiles
--
INSERT INTO profiles VALUES
(1, '-'),
(6, 'Автоматизированные системы обработки информации и управления');

-- 
-- Вывод данных для таблицы plan_types
--
INSERT INTO plan_types VALUES
(1, 'Б', 'Бакалавриат'),
(2, 'М', 'Магистратура'),
(3, 'С', 'Специалитет');

-- 
-- Вывод данных для таблицы group_direction
--
INSERT INTO group_direction VALUES
(1, '00.00.00', '-'),
(4, '09.00.00', 'Информатика и вычислительная техника'),
(7, '00.12.22', 'Направление');

-- 
-- Вывод данных для таблицы directions
--
INSERT INTO directions VALUES
(1, '00.00.00', '-'),
(2, '09.03.01', 'Информатика и вычислительная техника');

-- 
-- Вывод данных для таблицы departments
--
INSERT INTO departments VALUES
(1, 'Общий доступ', '-', 1, 1),
(2, 'Специализированные компьютерные системы', 'СКС', 2, 1),
(16, 'Кафедра 1', 'К1', 3, 1),
(17, 'Кафедра 2', 'К2', 3, 1);

-- 
-- Вывод данных для таблицы titles
--
INSERT INTO titles VALUES
(1, 'Бакалавр', 2019, 2019, 'бакалавр', 4, 'бакалавриат', 'дневная', 4, 2, 6, 1, 2, 1),
(2, 'План 1', 2019, 2019, 'бакалавр', 4, 'Бакалавриат', 'вечерняя', 7, 2, 6, 1, 17, 1),
(4, 'План 2', 2019, 2019, 'магистр', 2, 'Магистратура', 'заочная ', 4, 2, 6, 2, 17, 1);

-- 
-- Вывод данных для таблицы cycles
--
INSERT INTO cycles VALUES
(1, 1, 'Б1', ' ГУМАНИТАРНЫЙ, СОЦИАЛЬНЫЙ и ЭКОНОМИЧЕСКИЙ ЦИКЛ'),
(2, 1, 'Б2', ' МАТЕМАТИЧЕСКИЙ и ЕСТЕСТВЕННО-НАУЧНЫЙ ЦИКЛ'),
(3, 1, 'Б3', 'ПРОФЕССИОНАЛЬНЫЙ ЦИКЛ'),
(5, 2, 'Б1', 'Цикл1'),
(8, 4, 'М1', 'шш'),
(10, 4, 'М2', 'рррр');

-- 
-- Вывод данных для таблицы partes
--
INSERT INTO partes VALUES
(1, 3, 'Б', 'Базовая часть'),
(2, 3, 'В', 'Вариативная часть'),
(6, 5, 'Б', 'Базовая часть'),
(10, 1, 'Б', 'Базовая часть'),
(11, 1, 'В', 'Вариативная часть, в том числе по выбору обучающегося'),
(12, 2, 'Б', 'Базовая часть'),
(13, 2, 'В', 'Вариативная часть, в том числе по выбору обучающегося');

-- 
-- Вывод данных для таблицы physical_types
--
INSERT INTO physical_types VALUES
(1, 'Физическая культура (ФК)'),
(2, 'Прикладная физическая культура (ПФК)*');

-- 
-- Вывод данных для таблицы roles
--
INSERT INTO roles VALUES
(1, 'Главный администратор'),
(2, 'Администратор'),
(3, 'Редактор'),
(4, 'Посетитель');

-- 
-- Вывод данных для таблицы subjects
--
INSERT INTO subjects VALUES
(1, 1, 1, 'Электротехника, электроника и схемотехника (электротехника)', 'ТОЭ', 3, 0, 0, 2.0, 1.0, 1.0, 3.0),
(3, 1, 2, 'Электротехника, электроника и схемотехника (электроника)', 'СКС', 4, 0, 18, 2.0, 2.0, 1.0, 4.0),
(6, 6, 1, '1', '1', 1, 0, 0, 1.0, 0.0, 0.0, 0.0),
(7, 1, 3, 'Электротехника, электроника и схемотехника (схемотехника)', 'СКС', 5, 0, 18, 2.0, 2.0, 1.0, 4.0),
(8, 1, 4, 'Курсовой проект. Схемотехника', 'СКС', 0, 5, 0, 0.0, 0.0, 0.0, 2.0),
(9, 1, 5, 'Программирование', 'СКС', 1, 0, 0, 2.0, 2.0, 1.0, 4.0),
(10, 1, 6, 'Программирование', 'СКС', 2, 0, 36, 2.0, 2.0, 0.0, 4.0),
(11, 1, 7, 'Программирование', 'СКС', 3, 0, 0, 2.0, 2.0, 1.0, 3.0),
(17, 6, 2, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(18, 6, 3, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(19, 6, 4, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(20, 6, 5, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(21, 6, 6, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(22, 6, 7, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(23, 6, 8, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(24, 6, 9, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(25, 6, 10, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(26, 6, 11, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(27, 6, 12, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(28, 6, 13, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(30, 6, 14, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(31, 6, 15, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(32, 6, 16, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(33, 6, 17, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(34, 6, 18, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(35, 6, 19, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(36, 6, 20, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(37, 6, 21, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(38, 6, 22, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(39, 6, 23, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(40, 6, 24, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(41, 6, 25, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(42, 6, 26, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(43, 6, 27, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(44, 6, 28, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(45, 6, 29, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(46, 6, 30, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(47, 6, 31, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(48, 6, 32, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(49, 6, 33, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(50, 6, 34, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(51, 6, 35, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(52, 6, 36, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(53, 6, 37, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(54, 6, 38, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(55, 6, 39, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(56, 6, 40, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(57, 6, 41, '1', '1', 1, 0, 0, 0.0, 0.0, 0.0, 0.0),
(58, 10, 1, 'История', 'СГД', 2, 0, 0, 1.0, 0.0, 1.0, 2.0),
(59, 10, 2, 'Философия', 'СГД', 4, 0, 0, 2.0, 0.0, 1.0, 1.0),
(60, 10, 3, 'Иностранный язык', 'ТППиОЯ', 0, 1, 0, 0.0, 0.0, 2.0, 2.0),
(61, 10, 4, 'Иностранный язык', 'ТППиОЯ', 0, 2, 0, 0.0, 0.0, 2.0, 1.0),
(62, 10, 5, 'Иностранный язык', 'ТППиОЯ', 3, 0, 0, 0.0, 0.0, 2.0, 1.0),
(63, 10, 6, 'Экономика', 'ЭУ', 0, 5, 0, 1.0, 0.0, 1.0, 2.0),
(64, 11, 1, 'Социология', 'СГД', 0, 5, 27, 1.0, 0.0, 0.5, 1.0),
(65, 11, 2, 'Правоведение', 'СГД', 0, 3, 27, 1.0, 0.0, 0.5, 1.0),
(66, 11, 3, 'Культурология', 'СГД', 0, 5, 27, 1.0, 0.0, 0.5, 1.0),
(69, 11, 4, 'Экономика предприятия', 'ЭУ', 0, 6, 0, 2.0, 0.0, 1.0, 2.0),
(70, 11, 5, 'Русский язык', 'ТППиОЯ', 0, 1, 0, 0.5, 0.0, 1.0, 0.5),
(71, 11, 6, 'Русский язык', 'ТППиОЯ', 0, 2, 0, 0.5, 0.0, 1.0, 0.5),
(73, 11, 7, 'Дисциплина по выбору №1', 'ЭУ', 7, 0, 0, 2.0, 0.0, 1.0, 3.0),
(74, 11, 8, 'Дисциплина по выбору №2', 'СГД', 0, 7, 27, 1.0, 0.0, 0.5, 1.0),
(75, 11, 9, 'Дисциплина по выбору №3 Курсовая работа', 'ЭУ', 0, 8, 18, 0.0, 0.0, 1.0, 1.0),
(76, 12, 1, 'Математика', 'ВМ', 1, 0, 0, 2.0, 0.0, 2.0, 4.0),
(77, 12, 2, 'Математика', 'ВМ', 2, 0, 54, 2.0, 0.0, 3.0, 4.0),
(78, 12, 3, 'Физика', 'РФ', 1, 0, 0, 2.0, 1.0, 1.0, 4.0),
(79, 12, 4, 'Физика', 'РФ', 2, 0, 0, 2.0, 1.0, 1.0, 4.0),
(80, 12, 5, 'Информатика', 'СКС', 1, 0, 27, 2.0, 1.5, 0.0, 2.0),
(81, 12, 6, 'Информатика', 'СКС', 0, 2, 27, 2.0, 1.5, 0.0, 2.0),
(82, 12, 7, 'Экология', 'ЭБЖД', 0, 3, 27, 1.0, 0.0, 0.5, 1.0),
(83, 13, 1, 'Компьютерная логика', 'СКС', 2, 0, 9, 2.0, 0.0, 2.0, 3.5),
(85, 13, 2, 'Теория вероятности и математическая статистика', 'ВМ', 0, 3, 0, 1.0, 0.0, 1.0, 2.0),
(86, 13, 3, 'Алгоритмы и методы вычислений', 'СКС', 3, 0, 0, 2.0, 1.0, 1.0, 4.0),
(87, 13, 4, 'Методы передачи и обработки информации', 'СКС', 5, 0, 0, 2.0, 2.0, 0.0, 4.0),
(88, 13, 5, 'Курсовой проект. Методы передачи и обработки информации', 'СКС', 0, 6, 0, 0.0, 0.0, 1.0, 1.0),
(89, 13, 6, 'Дисциплина по выбору №1', 'СКС', 0, 4, 36, 2.0, 2.0, 0.0, 3.0),
(90, 13, 7, 'Дисциплина по выбору №2', 'СКС', 0, 1, 54, 1.0, 0.0, 1.0, 3.0),
(91, 13, 8, 'Дисциплина по выбору №3 Курсовая работа', 'СКС', 0, 5, 0, 0.0, 0.0, 1.0, 1.0),
(92, 1, 8, 'Курсовая работа. Программирование', 'СКС', 0, 3, 36, 0.0, 0.0, 0.0, 2.0),
(93, 1, 9, 'Инженерная и компьютерная графика', 'АПИГ', 0, 1, 27, 1.0, 1.0, 0.0, 2.5),
(94, 1, 10, 'Защита информации', 'СКС', 8, 0, 0, 3.0, 3.0, 0.0, 6.0),
(95, 1, 11, 'ЭВМ и периферийные устройства', 'СКС', 7, 0, 0, 2.0, 2.0, 0.0, 5.0),
(96, 1, 12, 'Операционные системы', 'СКС', 6, 0, 0, 2.0, 2.0, 0.0, 4.0),
(97, 1, 13, 'Базы данных', 'СКС', 6, 0, 0, 2.0, 2.0, 0.0, 4.0),
(98, 1, 14, 'Курсовая работа. Базы данных', 'СКС', 0, 7, 0, 0.0, 0.0, 1.0, 2.0),
(99, 1, 15, 'Компьютерные сети и телекоммуникации', 'СКС', 7, 0, 0, 2.0, 2.0, 1.0, 5.0),
(100, 1, 16, 'Курсовой проект. Компьютерные сети и телекоммуникации', 'СКС', 0, 7, 0, 0.0, 0.0, 0.0, 2.0),
(101, 1, 17, 'Безопасность жизнедеятельности', 'ЭБЖД', 0, 2, 18, 1.0, 0.0, 1.0, 3.0),
(102, 1, 18, 'Метрология, стандартизация и сертификация', 'СКС', 0, 4, 18, 1.0, 1.0, 0.0, 1.0),
(104, 2, 1, 'Системное программирование', 'СКС', 0, 3, 18, 2.0, 2.0, 0.0, 3.0),
(105, 2, 2, 'Системное программирование', 'СКС', 4, 0, 0, 2.0, 2.0, 1.0, 4.0),
(106, 2, 3, 'Курсовая работа. Системное программирование.', 'СКС', 0, 4, 36, 0.0, 0.0, 0.0, 2.0),
(107, 2, 4, 'Системное программное обеспечение', 'СКС', 5, 0, 18, 2.0, 2.0, 0.0, 4.0),
(108, 2, 5, 'Системное программное обеспечение', 'СКС', 6, 0, 0, 2.0, 1.0, 1.0, 3.0),
(109, 2, 6, 'Курсовая работа. Системное программное обеспечение', 'СКС', 0, 6, 0, 0.0, 0.0, 0.0, 2.0),
(110, 2, 7, 'Архитектура компьютеров', 'СКС', 5, 0, 0, 2.0, 2.0, 0.0, 4.0),
(111, 2, 8, 'Архитектура компьютеров', 'СКС', 6, 0, 36, 1.0, 2.0, 0.0, 4.0),
(112, 2, 9, 'Прогаммно-аппаратная организация компьютеров', 'СКС', 0, 1, 0, 1.0, 1.0, 0.0, 2.0),
(113, 2, 10, 'Прикладная теория цифровых автоматов (ПТЦА)', 'СКС', 3, 0, 36, 2.0, 2.0, 0.0, 4.0),
(114, 2, 11, 'Курсовая работа. ПТЦА', 'СКС', 0, 4, 18, 0.0, 0.0, 1.0, 2.0),
(115, 2, 12, 'Параллельные и распределенные вычисления', 'СКС', 7, 0, 36, 2.0, 2.0, 0.0, 4.0),
(116, 2, 13, 'Курсовой проект. Параллельные и распределенные вычисления.', 'СКС', 0, 8, 0, 0.0, 0.0, 1.0, 3.0),
(117, 2, 14, 'Проектирование микропроцессорных систем', 'СКС', 7, 0, 36, 2.0, 2.0, 1.0, 4.0),
(118, 2, 15, 'Курсовой проект. Проектирование микропроцессорных систем', 'СКС', 0, 7, 0, 0.0, 0.0, 0.0, 2.0),
(119, 2, 16, 'Инженерия программного обеспечения', 'СКС', 4, 0, 0, 1.0, 2.0, 0.0, 3.0),
(120, 2, 17, 'Инженерия программного обеспечения', 'СКС', 5, 0, 0, 1.0, 2.0, 0.0, 3.0),
(121, 2, 18, 'Управление в технических системах', 'СКС', 6, 0, 0, 1.0, 2.0, 0.0, 3.0),
(122, 2, 19, 'Научно-исследовательская работа студентов', 'СКС', 0, 7, 9, 0.0, 0.0, 0.5, 2.0),
(123, 2, 20, 'Научно-исследовательская работа студентов', 'СКС', 0, 8, 54, 0.0, 0.0, 1.0, 3.0),
(124, 2, 21, 'Дисциплина по выбору №1', 'СКС', 8, 0, 0, 3.0, 4.0, 0.0, 7.0),
(125, 2, 22, 'Дисциплина по выбору №2', 'СКС', 8, 0, 0, 2.0, 2.0, 0.0, 6.0),
(126, 2, 23, 'Дисциплина по выбору №3', 'СКС', 4, 0, 18, 2.0, 3.0, 0.0, 4.0),
(127, 2, 24, 'Дисциплина по выбору №4', 'СКС', 8, 0, 36, 2.0, 2.0, 0.0, 4.0),
(128, 2, 25, 'Дисциплина по выбору №5', 'СКС', 0, 6, 0, 2.0, 2.0, 0.0, 3.0);

-- 
-- Вывод данных для таблицы sertification_types
--
INSERT INTO sertification_types VALUES
(1, '-'),
(2, 'Государственный экзамен'),
(3, 'Выпускная квалификационная работа');

-- 
-- Вывод данных для таблицы pract_types
--
INSERT INTO pract_types VALUES
(1, '-'),
(2, 'Учебная'),
(3, 'Производственная'),
(4, 'Преддипломная');

-- 
-- Вывод данных для таблицы physical
--
INSERT INTO physical VALUES
(1, 1, 1, 36),
(2, 1, 2, 108),
(3, 2, 1, 0),
(4, 2, 2, 0),
(5, 4, 1, 0),
(6, 4, 2, 0);

-- 
-- Вывод данных для таблицы version_control
--
-- Таблица academikplan.version_control не содержит данных

-- 
-- Вывод данных для таблицы users
--
INSERT INTO users VALUES
(1, 'root', 'root', NULL, 1, 1, 1),
(3, 'admin', 'admin', NULL, 2, 2, 1),
(22, 'moder', 'moder', NULL, 2, 3, 1),
(26, 'visitor', 'visitor', NULL, 2, 4, 1),
(27, 'adminkaf1', 'adminkaf1', NULL, 16, 2, 1),
(28, 'moderkaf1', 'moderkaf1', NULL, 16, 3, 1),
(29, 'visitorkaf1', 'visitorkaf1', NULL, 16, 4, 1),
(30, 'adminkaf2', 'adminkaf2', NULL, 17, 2, 1),
(31, 'moderkaf2', 'moderkaf2', NULL, 17, 3, 1),
(32, 'visitor2', 'visitor2', NULL, 17, 4, 1);

-- 
-- Вывод данных для таблицы time_budgets
--
-- Таблица academikplan.time_budgets не содержит данных

-- 
-- Вывод данных для таблицы sub_subject
--
INSERT INTO sub_subject VALUES
(5, 73, 'Основы организации хозяйственной деятельности (ОХД)'),
(6, 73, 'Организация производства'),
(7, 74, 'Психология'),
(8, 74, 'Педагогика'),
(9, 75, 'ОХД'),
(10, 75, 'Организация производства'),
(11, 89, 'Технологии программирования'),
(12, 89, 'Программирование на языке С++'),
(13, 90, 'Оформление технической документации'),
(14, 90, 'Документирование программного обеспечения'),
(15, 91, 'Технологии программирования'),
(16, 91, 'Программирование на языке С++'),
(17, 124, 'Технологии проектирования компьютерных систем'),
(18, 124, 'Моделирование'),
(19, 125, 'Специализированные архитектуры ЭВМ'),
(20, 125, 'Адаптивные интеллектуальные системы'),
(21, 126, 'Web-программирование'),
(22, 126, 'Информационные технологии'),
(23, 127, 'Интеллектуальные системы'),
(24, 127, 'Основы теории  нейронных сетей'),
(25, 128, 'Программирование для мобильных устройств'),
(26, 128, 'Системы реального времени');

-- 
-- Вывод данных для таблицы study_shedules
--
INSERT INTO study_shedules VALUES
(1, 1, 1, 1, ''),
(2, 1, 1, 2, ''),
(3, 1, 1, 3, ''),
(4, 1, 1, 4, ''),
(5, 1, 1, 5, ''),
(6, 1, 1, 6, ''),
(7, 1, 1, 7, ''),
(8, 1, 1, 8, ''),
(9, 1, 1, 9, 'СК'),
(10, 1, 1, 10, ''),
(11, 1, 1, 11, ''),
(12, 1, 1, 12, ''),
(13, 1, 1, 13, ''),
(14, 1, 1, 14, ''),
(15, 1, 1, 15, ''),
(16, 1, 1, 16, ''),
(17, 1, 1, 17, ''),
(18, 1, 1, 18, 'СК'),
(19, 1, 1, 19, 'С'),
(20, 1, 1, 20, 'С'),
(21, 1, 1, 21, 'К'),
(22, 1, 1, 22, 'К'),
(23, 1, 1, 23, ''),
(24, 1, 1, 24, ''),
(25, 1, 1, 25, ''),
(26, 1, 1, 26, ''),
(27, 1, 1, 27, ''),
(28, 1, 1, 28, ''),
(29, 1, 1, 29, ''),
(30, 1, 1, 30, ''),
(31, 1, 1, 31, 'СК'),
(32, 1, 1, 32, ''),
(33, 1, 1, 33, ''),
(34, 1, 1, 34, ''),
(35, 1, 1, 35, ''),
(36, 1, 1, 36, ''),
(37, 1, 1, 37, ''),
(38, 1, 1, 38, ''),
(39, 1, 1, 39, ''),
(40, 1, 1, 40, 'СК'),
(41, 1, 1, 41, 'С'),
(42, 1, 1, 42, 'С'),
(43, 1, 1, 43, 'К'),
(44, 1, 1, 44, 'К'),
(45, 1, 1, 45, 'К'),
(46, 1, 1, 46, 'К'),
(47, 1, 1, 47, 'К'),
(48, 1, 1, 48, 'К'),
(49, 1, 1, 49, 'К'),
(50, 1, 1, 50, 'К'),
(51, 1, 1, 51, 'К'),
(52, 1, 1, 52, 'К'),
(53, 1, 2, 1, ''),
(54, 1, 2, 2, ''),
(55, 1, 2, 3, ''),
(56, 1, 2, 4, ''),
(57, 1, 2, 5, ''),
(58, 1, 2, 6, ''),
(59, 1, 2, 7, ''),
(60, 1, 2, 8, ''),
(61, 1, 2, 9, 'СК'),
(62, 1, 2, 10, ''),
(63, 1, 2, 11, ''),
(64, 1, 2, 12, ''),
(65, 1, 2, 13, ''),
(66, 1, 2, 14, ''),
(67, 1, 2, 15, ''),
(68, 1, 2, 16, ''),
(69, 1, 2, 17, ''),
(70, 1, 2, 18, 'СК'),
(71, 1, 2, 19, 'С'),
(72, 1, 2, 20, 'С'),
(73, 1, 2, 21, 'К'),
(74, 1, 2, 22, 'К'),
(75, 1, 2, 23, ''),
(76, 1, 2, 24, ''),
(77, 1, 2, 25, ''),
(78, 1, 2, 26, ''),
(79, 1, 2, 27, ''),
(80, 1, 2, 28, ''),
(81, 1, 2, 29, ''),
(82, 1, 2, 30, ''),
(83, 1, 2, 31, 'СК'),
(84, 1, 2, 32, ''),
(85, 1, 2, 33, ''),
(86, 1, 2, 34, ''),
(87, 1, 2, 35, ''),
(88, 1, 2, 36, ''),
(89, 1, 2, 37, ''),
(90, 1, 2, 38, ''),
(91, 1, 2, 39, ''),
(92, 1, 2, 40, 'СК'),
(93, 1, 2, 41, 'С'),
(94, 1, 2, 42, 'С'),
(95, 1, 2, 43, 'П'),
(96, 1, 2, 44, 'П'),
(97, 1, 2, 45, 'К'),
(98, 1, 2, 46, 'К'),
(99, 1, 2, 47, 'К'),
(100, 1, 2, 48, 'К'),
(101, 1, 2, 49, 'К'),
(102, 1, 2, 50, 'К'),
(103, 1, 2, 51, 'К'),
(104, 1, 2, 52, 'К'),
(105, 1, 3, 1, ''),
(106, 1, 3, 2, ''),
(107, 1, 3, 3, ''),
(108, 1, 3, 4, ''),
(109, 1, 3, 5, ''),
(110, 1, 3, 6, ''),
(111, 1, 3, 7, ''),
(112, 1, 3, 8, ''),
(113, 1, 3, 9, 'СК'),
(114, 1, 3, 10, ''),
(115, 1, 3, 11, ''),
(116, 1, 3, 12, ''),
(117, 1, 3, 13, ''),
(118, 1, 3, 14, ''),
(119, 1, 3, 15, ''),
(120, 1, 3, 16, ''),
(121, 1, 3, 17, ''),
(122, 1, 3, 18, 'СК'),
(123, 1, 3, 19, 'С'),
(124, 1, 3, 20, 'С'),
(125, 1, 3, 21, 'К'),
(126, 1, 3, 22, 'К'),
(127, 1, 3, 23, ''),
(128, 1, 3, 24, ''),
(129, 1, 3, 25, ''),
(130, 1, 3, 26, ''),
(131, 1, 3, 27, ''),
(132, 1, 3, 28, ''),
(133, 1, 3, 29, ''),
(134, 1, 3, 30, ''),
(135, 1, 3, 31, 'СК'),
(136, 1, 3, 32, ''),
(137, 1, 3, 33, ''),
(138, 1, 3, 34, ''),
(139, 1, 3, 35, ''),
(140, 1, 3, 36, ''),
(141, 1, 3, 37, ''),
(142, 1, 3, 38, ''),
(143, 1, 3, 39, ''),
(144, 1, 3, 40, 'СК'),
(145, 1, 3, 41, 'С'),
(146, 1, 3, 42, 'С'),
(147, 1, 3, 43, 'П'),
(148, 1, 3, 44, 'П'),
(149, 1, 3, 45, 'П'),
(150, 1, 3, 46, 'К'),
(151, 1, 3, 47, 'К'),
(152, 1, 3, 48, 'К'),
(153, 1, 3, 49, 'К'),
(154, 1, 3, 50, 'К'),
(155, 1, 3, 51, 'К'),
(156, 1, 3, 52, 'К'),
(157, 1, 4, 1, ''),
(158, 1, 4, 2, ''),
(159, 1, 4, 3, ''),
(160, 1, 4, 4, ''),
(161, 1, 4, 5, ''),
(162, 1, 4, 6, ''),
(163, 1, 4, 7, ''),
(164, 1, 4, 8, ''),
(165, 1, 4, 9, 'СК'),
(166, 1, 4, 10, ''),
(167, 1, 4, 11, ''),
(168, 1, 4, 12, ''),
(169, 1, 4, 13, ''),
(170, 1, 4, 14, ''),
(171, 1, 4, 15, ''),
(172, 1, 4, 16, ''),
(173, 1, 4, 17, ''),
(174, 1, 4, 18, 'СК'),
(175, 1, 4, 19, 'С'),
(176, 1, 4, 20, 'С'),
(177, 1, 4, 21, 'К'),
(178, 1, 4, 22, 'К'),
(179, 1, 4, 23, ''),
(180, 1, 4, 24, ''),
(181, 1, 4, 25, ''),
(182, 1, 4, 26, ''),
(183, 1, 4, 27, ''),
(184, 1, 4, 28, ''),
(185, 1, 4, 29, ''),
(186, 1, 4, 30, ''),
(187, 1, 4, 31, 'СК'),
(188, 1, 4, 32, 'С'),
(189, 1, 4, 33, 'С'),
(190, 1, 4, 34, 'П'),
(191, 1, 4, 35, 'П'),
(192, 1, 4, 36, 'П'),
(193, 1, 4, 37, 'Г'),
(194, 1, 4, 38, 'Д'),
(195, 1, 4, 39, 'Д'),
(196, 1, 4, 40, 'Д'),
(197, 1, 4, 41, 'Д'),
(198, 1, 4, 42, 'Д'),
(199, 1, 4, 43, 'Д'),
(200, 1, 4, 44, 'К'),
(201, 1, 4, 45, 'К'),
(202, 1, 4, 46, 'К'),
(203, 1, 4, 47, 'К'),
(204, 1, 4, 48, 'К'),
(205, 1, 4, 49, 'К'),
(206, 1, 4, 50, 'К'),
(207, 1, 4, 51, 'К'),
(208, 1, 4, 52, 'К'),
(209, 1, 5, 1, ''),
(210, 1, 5, 2, ''),
(211, 1, 5, 3, ''),
(212, 1, 5, 4, ''),
(213, 1, 5, 5, ''),
(214, 1, 5, 6, ''),
(215, 1, 5, 7, ''),
(216, 1, 5, 8, ''),
(217, 1, 5, 9, ''),
(218, 1, 5, 10, ''),
(219, 1, 5, 11, ''),
(220, 1, 5, 12, ''),
(221, 1, 5, 13, ''),
(222, 1, 5, 14, ''),
(223, 1, 5, 15, ''),
(224, 1, 5, 16, ''),
(225, 1, 5, 17, ''),
(226, 1, 5, 18, ''),
(227, 1, 5, 19, ''),
(228, 1, 5, 20, ''),
(229, 1, 5, 21, ''),
(230, 1, 5, 22, ''),
(231, 1, 5, 23, ''),
(232, 1, 5, 24, ''),
(233, 1, 5, 25, ''),
(234, 1, 5, 26, ''),
(235, 1, 5, 27, ''),
(236, 1, 5, 28, ''),
(237, 1, 5, 29, ''),
(238, 1, 5, 30, ''),
(239, 1, 5, 31, ''),
(240, 1, 5, 32, ''),
(241, 1, 5, 33, ''),
(242, 1, 5, 34, ''),
(243, 1, 5, 35, ''),
(244, 1, 5, 36, ''),
(245, 1, 5, 37, ''),
(246, 1, 5, 38, ''),
(247, 1, 5, 39, ''),
(248, 1, 5, 40, ''),
(249, 1, 5, 41, ''),
(250, 1, 5, 42, ''),
(251, 1, 5, 43, ''),
(252, 1, 5, 44, ''),
(253, 1, 5, 45, ''),
(254, 1, 5, 46, ''),
(255, 1, 5, 47, ''),
(256, 1, 5, 48, ''),
(257, 1, 5, 49, ''),
(258, 1, 5, 50, ''),
(259, 1, 5, 51, ''),
(260, 1, 5, 52, ''),
(261, 1, 6, 1, ''),
(262, 1, 6, 2, ''),
(263, 1, 6, 3, ''),
(264, 1, 6, 4, ''),
(265, 1, 6, 5, ''),
(266, 1, 6, 6, ''),
(267, 1, 6, 7, ''),
(268, 1, 6, 8, ''),
(269, 1, 6, 9, ''),
(270, 1, 6, 10, ''),
(271, 1, 6, 11, ''),
(272, 1, 6, 12, ''),
(273, 1, 6, 13, ''),
(274, 1, 6, 14, ''),
(275, 1, 6, 15, ''),
(276, 1, 6, 16, ''),
(277, 1, 6, 17, ''),
(278, 1, 6, 18, ''),
(279, 1, 6, 19, ''),
(280, 1, 6, 20, ''),
(281, 1, 6, 21, ''),
(282, 1, 6, 22, ''),
(283, 1, 6, 23, ''),
(284, 1, 6, 24, ''),
(285, 1, 6, 25, ''),
(286, 1, 6, 26, ''),
(287, 1, 6, 27, ''),
(288, 1, 6, 28, ''),
(289, 1, 6, 29, ''),
(290, 1, 6, 30, ''),
(291, 1, 6, 31, ''),
(292, 1, 6, 32, ''),
(293, 1, 6, 33, ''),
(294, 1, 6, 34, ''),
(295, 1, 6, 35, ''),
(296, 1, 6, 36, ''),
(297, 1, 6, 37, ''),
(298, 1, 6, 38, ''),
(299, 1, 6, 39, ''),
(300, 1, 6, 40, ''),
(301, 1, 6, 41, ''),
(302, 1, 6, 42, ''),
(303, 1, 6, 43, ''),
(304, 1, 6, 44, ''),
(305, 1, 6, 45, ''),
(306, 1, 6, 46, ''),
(307, 1, 6, 47, ''),
(308, 1, 6, 48, ''),
(309, 1, 6, 49, ''),
(310, 1, 6, 50, ''),
(311, 1, 6, 51, ''),
(312, 1, 6, 52, ''),
(313, 1, 7, 1, ''),
(314, 1, 7, 2, ''),
(315, 1, 7, 3, ''),
(316, 1, 7, 4, ''),
(317, 1, 7, 5, ''),
(318, 1, 7, 6, ''),
(319, 1, 7, 7, ''),
(320, 1, 7, 8, ''),
(321, 1, 7, 9, ''),
(322, 1, 7, 10, ''),
(323, 1, 7, 11, ''),
(324, 1, 7, 12, ''),
(325, 1, 7, 13, ''),
(326, 1, 7, 14, ''),
(327, 1, 7, 15, ''),
(328, 1, 7, 16, ''),
(329, 1, 7, 17, ''),
(330, 1, 7, 18, ''),
(331, 1, 7, 19, ''),
(332, 1, 7, 20, ''),
(333, 1, 7, 21, ''),
(334, 1, 7, 22, ''),
(335, 1, 7, 23, ''),
(336, 1, 7, 24, ''),
(337, 1, 7, 25, ''),
(338, 1, 7, 26, ''),
(339, 1, 7, 27, ''),
(340, 1, 7, 28, ''),
(341, 1, 7, 29, ''),
(342, 1, 7, 30, ''),
(343, 1, 7, 31, ''),
(344, 1, 7, 32, ''),
(345, 1, 7, 33, ''),
(346, 1, 7, 34, ''),
(347, 1, 7, 35, ''),
(348, 1, 7, 36, ''),
(349, 1, 7, 37, ''),
(350, 1, 7, 38, ''),
(351, 1, 7, 39, ''),
(352, 1, 7, 40, ''),
(353, 1, 7, 41, ''),
(354, 1, 7, 42, ''),
(355, 1, 7, 43, ''),
(356, 1, 7, 44, ''),
(357, 1, 7, 45, ''),
(358, 1, 7, 46, ''),
(359, 1, 7, 47, ''),
(360, 1, 7, 48, ''),
(361, 1, 7, 49, ''),
(362, 1, 7, 50, ''),
(363, 1, 7, 51, ''),
(364, 1, 7, 52, ''),
(365, 1, 8, 1, ''),
(366, 1, 8, 2, ''),
(367, 1, 8, 3, ''),
(368, 1, 8, 4, ''),
(369, 1, 8, 5, ''),
(370, 1, 8, 6, ''),
(371, 1, 8, 7, ''),
(372, 1, 8, 8, ''),
(373, 1, 8, 9, ''),
(374, 1, 8, 10, ''),
(375, 1, 8, 11, ''),
(376, 1, 8, 12, ''),
(377, 1, 8, 13, ''),
(378, 1, 8, 14, ''),
(379, 1, 8, 15, ''),
(380, 1, 8, 16, ''),
(381, 1, 8, 17, ''),
(382, 1, 8, 18, ''),
(383, 1, 8, 19, ''),
(384, 1, 8, 20, ''),
(385, 1, 8, 21, ''),
(386, 1, 8, 22, ''),
(387, 1, 8, 23, ''),
(388, 1, 8, 24, ''),
(389, 1, 8, 25, ''),
(390, 1, 8, 26, ''),
(391, 1, 8, 27, ''),
(392, 1, 8, 28, ''),
(393, 1, 8, 29, ''),
(394, 1, 8, 30, ''),
(395, 1, 8, 31, ''),
(396, 1, 8, 32, ''),
(397, 1, 8, 33, ''),
(398, 1, 8, 34, ''),
(399, 1, 8, 35, ''),
(400, 1, 8, 36, ''),
(401, 1, 8, 37, ''),
(402, 1, 8, 38, ''),
(403, 1, 8, 39, ''),
(404, 1, 8, 40, ''),
(405, 1, 8, 41, ''),
(406, 1, 8, 42, ''),
(407, 1, 8, 43, ''),
(408, 1, 8, 44, ''),
(409, 1, 8, 45, ''),
(410, 1, 8, 46, ''),
(411, 1, 8, 47, ''),
(412, 1, 8, 48, ''),
(413, 1, 8, 49, ''),
(414, 1, 8, 50, ''),
(415, 1, 8, 51, ''),
(416, 1, 8, 52, ''),
(417, 1, 9, 1, ''),
(418, 1, 9, 2, ''),
(419, 1, 9, 3, ''),
(420, 1, 9, 4, ''),
(421, 1, 9, 5, ''),
(422, 1, 9, 6, ''),
(423, 1, 9, 7, ''),
(424, 1, 9, 8, ''),
(425, 1, 9, 9, ''),
(426, 1, 9, 10, ''),
(427, 1, 9, 11, ''),
(428, 1, 9, 12, ''),
(429, 1, 9, 13, ''),
(430, 1, 9, 14, ''),
(431, 1, 9, 15, ''),
(432, 1, 9, 16, ''),
(433, 1, 9, 17, ''),
(434, 1, 9, 18, ''),
(435, 1, 9, 19, ''),
(436, 1, 9, 20, ''),
(437, 1, 9, 21, ''),
(438, 1, 9, 22, ''),
(439, 1, 9, 23, ''),
(440, 1, 9, 24, ''),
(441, 1, 9, 25, ''),
(442, 1, 9, 26, ''),
(443, 1, 9, 27, ''),
(444, 1, 9, 28, ''),
(445, 1, 9, 29, ''),
(446, 1, 9, 30, ''),
(447, 1, 9, 31, ''),
(448, 1, 9, 32, ''),
(449, 1, 9, 33, ''),
(450, 1, 9, 34, ''),
(451, 1, 9, 35, ''),
(452, 1, 9, 36, ''),
(453, 1, 9, 37, ''),
(454, 1, 9, 38, ''),
(455, 1, 9, 39, ''),
(456, 1, 9, 40, ''),
(457, 1, 9, 41, ''),
(458, 1, 9, 42, ''),
(459, 1, 9, 43, ''),
(460, 1, 9, 44, ''),
(461, 1, 9, 45, ''),
(462, 1, 9, 46, ''),
(463, 1, 9, 47, ''),
(464, 1, 9, 48, ''),
(465, 1, 9, 49, ''),
(466, 1, 9, 50, ''),
(467, 1, 9, 51, ''),
(468, 1, 9, 52, ''),
(469, 2, 1, 1, ''),
(470, 2, 1, 2, ''),
(471, 2, 1, 3, ''),
(472, 2, 1, 4, ''),
(473, 2, 1, 5, ''),
(474, 2, 1, 6, ''),
(475, 2, 1, 7, ''),
(476, 2, 1, 8, ''),
(477, 2, 1, 9, ''),
(478, 2, 1, 10, ''),
(479, 2, 1, 11, ''),
(480, 2, 1, 12, ''),
(481, 2, 1, 13, ''),
(482, 2, 1, 14, ''),
(483, 2, 1, 15, ''),
(484, 2, 1, 16, ''),
(485, 2, 1, 17, ''),
(486, 2, 1, 18, ''),
(487, 2, 1, 19, ''),
(488, 2, 1, 20, ''),
(489, 2, 1, 21, ''),
(490, 2, 1, 22, ''),
(491, 2, 1, 23, ''),
(492, 2, 1, 24, ''),
(493, 2, 1, 25, ''),
(494, 2, 1, 26, ''),
(495, 2, 1, 27, ''),
(496, 2, 1, 28, ''),
(497, 2, 1, 29, ''),
(498, 2, 1, 30, ''),
(499, 2, 1, 31, ''),
(500, 2, 1, 32, ''),
(501, 2, 1, 33, ''),
(502, 2, 1, 34, ''),
(503, 2, 1, 35, ''),
(504, 2, 1, 36, ''),
(505, 2, 1, 37, ''),
(506, 2, 1, 38, ''),
(507, 2, 1, 39, ''),
(508, 2, 1, 40, ''),
(509, 2, 1, 41, ''),
(510, 2, 1, 42, ''),
(511, 2, 1, 43, ''),
(512, 2, 1, 44, ''),
(513, 2, 1, 45, ''),
(514, 2, 1, 46, ''),
(515, 2, 1, 47, ''),
(516, 2, 1, 48, ''),
(517, 2, 1, 49, ''),
(518, 2, 1, 50, ''),
(519, 2, 1, 51, ''),
(520, 2, 1, 52, ''),
(521, 2, 2, 1, ''),
(522, 2, 2, 2, ''),
(523, 2, 2, 3, ''),
(524, 2, 2, 4, ''),
(525, 2, 2, 5, ''),
(526, 2, 2, 6, ''),
(527, 2, 2, 7, ''),
(528, 2, 2, 8, ''),
(529, 2, 2, 9, ''),
(530, 2, 2, 10, ''),
(531, 2, 2, 11, ''),
(532, 2, 2, 12, ''),
(533, 2, 2, 13, ''),
(534, 2, 2, 14, ''),
(535, 2, 2, 15, ''),
(536, 2, 2, 16, ''),
(537, 2, 2, 17, ''),
(538, 2, 2, 18, ''),
(539, 2, 2, 19, ''),
(540, 2, 2, 20, ''),
(541, 2, 2, 21, ''),
(542, 2, 2, 22, ''),
(543, 2, 2, 23, ''),
(544, 2, 2, 24, ''),
(545, 2, 2, 25, ''),
(546, 2, 2, 26, ''),
(547, 2, 2, 27, ''),
(548, 2, 2, 28, ''),
(549, 2, 2, 29, ''),
(550, 2, 2, 30, ''),
(551, 2, 2, 31, ''),
(552, 2, 2, 32, ''),
(553, 2, 2, 33, ''),
(554, 2, 2, 34, ''),
(555, 2, 2, 35, ''),
(556, 2, 2, 36, ''),
(557, 2, 2, 37, ''),
(558, 2, 2, 38, ''),
(559, 2, 2, 39, ''),
(560, 2, 2, 40, ''),
(561, 2, 2, 41, ''),
(562, 2, 2, 42, ''),
(563, 2, 2, 43, ''),
(564, 2, 2, 44, ''),
(565, 2, 2, 45, ''),
(566, 2, 2, 46, ''),
(567, 2, 2, 47, ''),
(568, 2, 2, 48, ''),
(569, 2, 2, 49, ''),
(570, 2, 2, 50, ''),
(571, 2, 2, 51, ''),
(572, 2, 2, 52, ''),
(573, 2, 3, 1, ''),
(574, 2, 3, 2, ''),
(575, 2, 3, 3, ''),
(576, 2, 3, 4, ''),
(577, 2, 3, 5, ''),
(578, 2, 3, 6, ''),
(579, 2, 3, 7, ''),
(580, 2, 3, 8, ''),
(581, 2, 3, 9, ''),
(582, 2, 3, 10, ''),
(583, 2, 3, 11, ''),
(584, 2, 3, 12, ''),
(585, 2, 3, 13, ''),
(586, 2, 3, 14, ''),
(587, 2, 3, 15, ''),
(588, 2, 3, 16, ''),
(589, 2, 3, 17, ''),
(590, 2, 3, 18, ''),
(591, 2, 3, 19, ''),
(592, 2, 3, 20, ''),
(593, 2, 3, 21, ''),
(594, 2, 3, 22, ''),
(595, 2, 3, 23, ''),
(596, 2, 3, 24, ''),
(597, 2, 3, 25, ''),
(598, 2, 3, 26, ''),
(599, 2, 3, 27, ''),
(600, 2, 3, 28, ''),
(601, 2, 3, 29, ''),
(602, 2, 3, 30, ''),
(603, 2, 3, 31, ''),
(604, 2, 3, 32, ''),
(605, 2, 3, 33, ''),
(606, 2, 3, 34, ''),
(607, 2, 3, 35, ''),
(608, 2, 3, 36, ''),
(609, 2, 3, 37, ''),
(610, 2, 3, 38, ''),
(611, 2, 3, 39, ''),
(612, 2, 3, 40, ''),
(613, 2, 3, 41, ''),
(614, 2, 3, 42, ''),
(615, 2, 3, 43, ''),
(616, 2, 3, 44, ''),
(617, 2, 3, 45, ''),
(618, 2, 3, 46, ''),
(619, 2, 3, 47, ''),
(620, 2, 3, 48, ''),
(621, 2, 3, 49, ''),
(622, 2, 3, 50, ''),
(623, 2, 3, 51, ''),
(624, 2, 3, 52, ''),
(625, 2, 4, 1, ''),
(626, 2, 4, 2, ''),
(627, 2, 4, 3, ''),
(628, 2, 4, 4, ''),
(629, 2, 4, 5, ''),
(630, 2, 4, 6, ''),
(631, 2, 4, 7, ''),
(632, 2, 4, 8, ''),
(633, 2, 4, 9, ''),
(634, 2, 4, 10, ''),
(635, 2, 4, 11, ''),
(636, 2, 4, 12, ''),
(637, 2, 4, 13, ''),
(638, 2, 4, 14, ''),
(639, 2, 4, 15, ''),
(640, 2, 4, 16, ''),
(641, 2, 4, 17, ''),
(642, 2, 4, 18, ''),
(643, 2, 4, 19, ''),
(644, 2, 4, 20, ''),
(645, 2, 4, 21, ''),
(646, 2, 4, 22, ''),
(647, 2, 4, 23, ''),
(648, 2, 4, 24, ''),
(649, 2, 4, 25, ''),
(650, 2, 4, 26, ''),
(651, 2, 4, 27, ''),
(652, 2, 4, 28, ''),
(653, 2, 4, 29, ''),
(654, 2, 4, 30, ''),
(655, 2, 4, 31, ''),
(656, 2, 4, 32, ''),
(657, 2, 4, 33, ''),
(658, 2, 4, 34, ''),
(659, 2, 4, 35, ''),
(660, 2, 4, 36, ''),
(661, 2, 4, 37, ''),
(662, 2, 4, 38, ''),
(663, 2, 4, 39, ''),
(664, 2, 4, 40, ''),
(665, 2, 4, 41, ''),
(666, 2, 4, 42, ''),
(667, 2, 4, 43, ''),
(668, 2, 4, 44, ''),
(669, 2, 4, 45, ''),
(670, 2, 4, 46, ''),
(671, 2, 4, 47, ''),
(672, 2, 4, 48, ''),
(673, 2, 4, 49, ''),
(674, 2, 4, 50, ''),
(675, 2, 4, 51, ''),
(676, 2, 4, 52, ''),
(677, 4, 1, 1, ''),
(678, 4, 1, 2, ''),
(679, 4, 1, 3, ''),
(680, 4, 1, 4, ''),
(681, 4, 1, 5, ''),
(682, 4, 1, 6, ''),
(683, 4, 1, 7, ''),
(684, 4, 1, 8, ''),
(685, 4, 1, 9, ''),
(686, 4, 1, 10, ''),
(687, 4, 1, 11, ''),
(688, 4, 1, 12, ''),
(689, 4, 1, 13, ''),
(690, 4, 1, 14, ''),
(691, 4, 1, 15, ''),
(692, 4, 1, 16, ''),
(693, 4, 1, 17, ''),
(694, 4, 1, 18, ''),
(695, 4, 1, 19, ''),
(696, 4, 1, 20, ''),
(697, 4, 1, 21, ''),
(698, 4, 1, 22, ''),
(699, 4, 1, 23, ''),
(700, 4, 1, 24, ''),
(701, 4, 1, 25, ''),
(702, 4, 1, 26, ''),
(703, 4, 1, 27, ''),
(704, 4, 1, 28, ''),
(705, 4, 1, 29, ''),
(706, 4, 1, 30, ''),
(707, 4, 1, 31, ''),
(708, 4, 1, 32, ''),
(709, 4, 1, 33, ''),
(710, 4, 1, 34, ''),
(711, 4, 1, 35, ''),
(712, 4, 1, 36, ''),
(713, 4, 1, 37, ''),
(714, 4, 1, 38, ''),
(715, 4, 1, 39, ''),
(716, 4, 1, 40, ''),
(717, 4, 1, 41, ''),
(718, 4, 1, 42, ''),
(719, 4, 1, 43, ''),
(720, 4, 1, 44, ''),
(721, 4, 1, 45, ''),
(722, 4, 1, 46, ''),
(723, 4, 1, 47, ''),
(724, 4, 1, 48, ''),
(725, 4, 1, 49, ''),
(726, 4, 1, 50, ''),
(727, 4, 1, 51, ''),
(728, 4, 1, 52, ''),
(729, 4, 2, 1, ''),
(730, 4, 2, 2, ''),
(731, 4, 2, 3, ''),
(732, 4, 2, 4, ''),
(733, 4, 2, 5, ''),
(734, 4, 2, 6, ''),
(735, 4, 2, 7, ''),
(736, 4, 2, 8, ''),
(737, 4, 2, 9, ''),
(738, 4, 2, 10, ''),
(739, 4, 2, 11, ''),
(740, 4, 2, 12, ''),
(741, 4, 2, 13, ''),
(742, 4, 2, 14, ''),
(743, 4, 2, 15, ''),
(744, 4, 2, 16, ''),
(745, 4, 2, 17, ''),
(746, 4, 2, 18, ''),
(747, 4, 2, 19, ''),
(748, 4, 2, 20, ''),
(749, 4, 2, 21, ''),
(750, 4, 2, 22, ''),
(751, 4, 2, 23, ''),
(752, 4, 2, 24, ''),
(753, 4, 2, 25, ''),
(754, 4, 2, 26, ''),
(755, 4, 2, 27, ''),
(756, 4, 2, 28, ''),
(757, 4, 2, 29, ''),
(758, 4, 2, 30, ''),
(759, 4, 2, 31, ''),
(760, 4, 2, 32, ''),
(761, 4, 2, 33, ''),
(762, 4, 2, 34, ''),
(763, 4, 2, 35, ''),
(764, 4, 2, 36, ''),
(765, 4, 2, 37, ''),
(766, 4, 2, 38, ''),
(767, 4, 2, 39, ''),
(768, 4, 2, 40, ''),
(769, 4, 2, 41, ''),
(770, 4, 2, 42, ''),
(771, 4, 2, 43, ''),
(772, 4, 2, 44, ''),
(773, 4, 2, 45, ''),
(774, 4, 2, 46, ''),
(775, 4, 2, 47, ''),
(776, 4, 2, 48, ''),
(777, 4, 2, 49, ''),
(778, 4, 2, 50, ''),
(779, 4, 2, 51, ''),
(780, 4, 2, 52, ''),
(781, 4, 3, 1, ''),
(782, 4, 3, 2, ''),
(783, 4, 3, 3, ''),
(784, 4, 3, 4, ''),
(785, 4, 3, 5, ''),
(786, 4, 3, 6, ''),
(787, 4, 3, 7, ''),
(788, 4, 3, 8, ''),
(789, 4, 3, 9, ''),
(790, 4, 3, 10, ''),
(791, 4, 3, 11, ''),
(792, 4, 3, 12, ''),
(793, 4, 3, 13, ''),
(794, 4, 3, 14, ''),
(795, 4, 3, 15, ''),
(796, 4, 3, 16, ''),
(797, 4, 3, 17, ''),
(798, 4, 3, 18, ''),
(799, 4, 3, 19, ''),
(800, 4, 3, 20, ''),
(801, 4, 3, 21, ''),
(802, 4, 3, 22, ''),
(803, 4, 3, 23, ''),
(804, 4, 3, 24, ''),
(805, 4, 3, 25, ''),
(806, 4, 3, 26, ''),
(807, 4, 3, 27, ''),
(808, 4, 3, 28, ''),
(809, 4, 3, 29, ''),
(810, 4, 3, 30, ''),
(811, 4, 3, 31, ''),
(812, 4, 3, 32, ''),
(813, 4, 3, 33, ''),
(814, 4, 3, 34, ''),
(815, 4, 3, 35, ''),
(816, 4, 3, 36, ''),
(817, 4, 3, 37, ''),
(818, 4, 3, 38, ''),
(819, 4, 3, 39, ''),
(820, 4, 3, 40, ''),
(821, 4, 3, 41, ''),
(822, 4, 3, 42, ''),
(823, 4, 3, 43, ''),
(824, 4, 3, 44, ''),
(825, 4, 3, 45, ''),
(826, 4, 3, 46, ''),
(827, 4, 3, 47, ''),
(828, 4, 3, 48, ''),
(829, 4, 3, 49, ''),
(830, 4, 3, 50, ''),
(831, 4, 3, 51, ''),
(832, 4, 3, 52, ''),
(833, 4, 4, 1, ''),
(834, 4, 4, 2, ''),
(835, 4, 4, 3, ''),
(836, 4, 4, 4, ''),
(837, 4, 4, 5, ''),
(838, 4, 4, 6, ''),
(839, 4, 4, 7, ''),
(840, 4, 4, 8, ''),
(841, 4, 4, 9, ''),
(842, 4, 4, 10, ''),
(843, 4, 4, 11, ''),
(844, 4, 4, 12, ''),
(845, 4, 4, 13, ''),
(846, 4, 4, 14, ''),
(847, 4, 4, 15, ''),
(848, 4, 4, 16, ''),
(849, 4, 4, 17, ''),
(850, 4, 4, 18, ''),
(851, 4, 4, 19, ''),
(852, 4, 4, 20, ''),
(853, 4, 4, 21, ''),
(854, 4, 4, 22, ''),
(855, 4, 4, 23, ''),
(856, 4, 4, 24, ''),
(857, 4, 4, 25, ''),
(858, 4, 4, 26, ''),
(859, 4, 4, 27, ''),
(860, 4, 4, 28, ''),
(861, 4, 4, 29, ''),
(862, 4, 4, 30, ''),
(863, 4, 4, 31, ''),
(864, 4, 4, 32, ''),
(865, 4, 4, 33, ''),
(866, 4, 4, 34, ''),
(867, 4, 4, 35, ''),
(868, 4, 4, 36, ''),
(869, 4, 4, 37, ''),
(870, 4, 4, 38, ''),
(871, 4, 4, 39, ''),
(872, 4, 4, 40, ''),
(873, 4, 4, 41, ''),
(874, 4, 4, 42, ''),
(875, 4, 4, 43, ''),
(876, 4, 4, 44, ''),
(877, 4, 4, 45, ''),
(878, 4, 4, 46, ''),
(879, 4, 4, 47, ''),
(880, 4, 4, 48, ''),
(881, 4, 4, 49, ''),
(882, 4, 4, 50, ''),
(883, 4, 4, 51, ''),
(884, 4, 4, 52, ''),
(885, 4, 5, 1, ''),
(886, 4, 5, 2, ''),
(887, 4, 5, 3, ''),
(888, 4, 5, 4, ''),
(889, 4, 5, 5, ''),
(890, 4, 5, 6, ''),
(891, 4, 5, 7, ''),
(892, 4, 5, 8, ''),
(893, 4, 5, 9, ''),
(894, 4, 5, 10, ''),
(895, 4, 5, 11, ''),
(896, 4, 5, 12, ''),
(897, 4, 5, 13, ''),
(898, 4, 5, 14, ''),
(899, 4, 5, 15, ''),
(900, 4, 5, 16, ''),
(901, 4, 5, 17, ''),
(902, 4, 5, 18, ''),
(903, 4, 5, 19, ''),
(904, 4, 5, 20, ''),
(905, 4, 5, 21, ''),
(906, 4, 5, 22, ''),
(907, 4, 5, 23, ''),
(908, 4, 5, 24, ''),
(909, 4, 5, 25, ''),
(910, 4, 5, 26, ''),
(911, 4, 5, 27, ''),
(912, 4, 5, 28, ''),
(913, 4, 5, 29, ''),
(914, 4, 5, 30, ''),
(915, 4, 5, 31, ''),
(916, 4, 5, 32, ''),
(917, 4, 5, 33, ''),
(918, 4, 5, 34, ''),
(919, 4, 5, 35, ''),
(920, 4, 5, 36, ''),
(921, 4, 5, 37, ''),
(922, 4, 5, 38, ''),
(923, 4, 5, 39, ''),
(924, 4, 5, 40, ''),
(925, 4, 5, 41, ''),
(926, 4, 5, 42, ''),
(927, 4, 5, 43, ''),
(928, 4, 5, 44, ''),
(929, 4, 5, 45, ''),
(930, 4, 5, 46, ''),
(931, 4, 5, 47, ''),
(932, 4, 5, 48, ''),
(933, 4, 5, 49, ''),
(934, 4, 5, 50, ''),
(935, 4, 5, 51, ''),
(936, 4, 5, 52, ''),
(937, 4, 6, 1, ''),
(938, 4, 6, 2, ''),
(939, 4, 6, 3, ''),
(940, 4, 6, 4, ''),
(941, 4, 6, 5, ''),
(942, 4, 6, 6, ''),
(943, 4, 6, 7, ''),
(944, 4, 6, 8, ''),
(945, 4, 6, 9, ''),
(946, 4, 6, 10, ''),
(947, 4, 6, 11, ''),
(948, 4, 6, 12, ''),
(949, 4, 6, 13, ''),
(950, 4, 6, 14, ''),
(951, 4, 6, 15, ''),
(952, 4, 6, 16, ''),
(953, 4, 6, 17, ''),
(954, 4, 6, 18, ''),
(955, 4, 6, 19, ''),
(956, 4, 6, 20, ''),
(957, 4, 6, 21, ''),
(958, 4, 6, 22, ''),
(959, 4, 6, 23, ''),
(960, 4, 6, 24, ''),
(961, 4, 6, 25, ''),
(962, 4, 6, 26, ''),
(963, 4, 6, 27, ''),
(964, 4, 6, 28, ''),
(965, 4, 6, 29, ''),
(966, 4, 6, 30, ''),
(967, 4, 6, 31, ''),
(968, 4, 6, 32, ''),
(969, 4, 6, 33, ''),
(970, 4, 6, 34, ''),
(971, 4, 6, 35, ''),
(972, 4, 6, 36, ''),
(973, 4, 6, 37, ''),
(974, 4, 6, 38, ''),
(975, 4, 6, 39, ''),
(976, 4, 6, 40, ''),
(977, 4, 6, 41, ''),
(978, 4, 6, 42, ''),
(979, 4, 6, 43, ''),
(980, 4, 6, 44, ''),
(981, 4, 6, 45, ''),
(982, 4, 6, 46, ''),
(983, 4, 6, 47, ''),
(984, 4, 6, 48, ''),
(985, 4, 6, 49, ''),
(986, 4, 6, 50, ''),
(987, 4, 6, 51, ''),
(988, 4, 6, 52, ''),
(989, 4, 7, 1, ''),
(990, 4, 7, 2, ''),
(991, 4, 7, 3, ''),
(992, 4, 7, 4, ''),
(993, 4, 7, 5, ''),
(994, 4, 7, 6, ''),
(995, 4, 7, 7, ''),
(996, 4, 7, 8, ''),
(997, 4, 7, 9, ''),
(998, 4, 7, 10, ''),
(999, 4, 7, 11, ''),
(1000, 4, 7, 12, ''),
(1001, 4, 7, 13, ''),
(1002, 4, 7, 14, ''),
(1003, 4, 7, 15, ''),
(1004, 4, 7, 16, ''),
(1005, 4, 7, 17, ''),
(1006, 4, 7, 18, ''),
(1007, 4, 7, 19, ''),
(1008, 4, 7, 20, ''),
(1009, 4, 7, 21, ''),
(1010, 4, 7, 22, ''),
(1011, 4, 7, 23, ''),
(1012, 4, 7, 24, ''),
(1013, 4, 7, 25, ''),
(1014, 4, 7, 26, ''),
(1015, 4, 7, 27, ''),
(1016, 4, 7, 28, ''),
(1017, 4, 7, 29, ''),
(1018, 4, 7, 30, ''),
(1019, 4, 7, 31, ''),
(1020, 4, 7, 32, ''),
(1021, 4, 7, 33, ''),
(1022, 4, 7, 34, ''),
(1023, 4, 7, 35, ''),
(1024, 4, 7, 36, ''),
(1025, 4, 7, 37, ''),
(1026, 4, 7, 38, ''),
(1027, 4, 7, 39, ''),
(1028, 4, 7, 40, ''),
(1029, 4, 7, 41, ''),
(1030, 4, 7, 42, ''),
(1031, 4, 7, 43, ''),
(1032, 4, 7, 44, ''),
(1033, 4, 7, 45, ''),
(1034, 4, 7, 46, ''),
(1035, 4, 7, 47, ''),
(1036, 4, 7, 48, ''),
(1037, 4, 7, 49, ''),
(1038, 4, 7, 50, ''),
(1039, 4, 7, 51, ''),
(1040, 4, 7, 52, ''),
(1041, 4, 8, 1, ''),
(1042, 4, 8, 2, ''),
(1043, 4, 8, 3, ''),
(1044, 4, 8, 4, ''),
(1045, 4, 8, 5, ''),
(1046, 4, 8, 6, ''),
(1047, 4, 8, 7, ''),
(1048, 4, 8, 8, ''),
(1049, 4, 8, 9, ''),
(1050, 4, 8, 10, ''),
(1051, 4, 8, 11, ''),
(1052, 4, 8, 12, ''),
(1053, 4, 8, 13, ''),
(1054, 4, 8, 14, ''),
(1055, 4, 8, 15, ''),
(1056, 4, 8, 16, ''),
(1057, 4, 8, 17, ''),
(1058, 4, 8, 18, ''),
(1059, 4, 8, 19, ''),
(1060, 4, 8, 20, ''),
(1061, 4, 8, 21, ''),
(1062, 4, 8, 22, ''),
(1063, 4, 8, 23, ''),
(1064, 4, 8, 24, ''),
(1065, 4, 8, 25, ''),
(1066, 4, 8, 26, ''),
(1067, 4, 8, 27, ''),
(1068, 4, 8, 28, ''),
(1069, 4, 8, 29, ''),
(1070, 4, 8, 30, ''),
(1071, 4, 8, 31, ''),
(1072, 4, 8, 32, ''),
(1073, 4, 8, 33, ''),
(1074, 4, 8, 34, ''),
(1075, 4, 8, 35, ''),
(1076, 4, 8, 36, ''),
(1077, 4, 8, 37, ''),
(1078, 4, 8, 38, ''),
(1079, 4, 8, 39, ''),
(1080, 4, 8, 40, ''),
(1081, 4, 8, 41, ''),
(1082, 4, 8, 42, ''),
(1083, 4, 8, 43, ''),
(1084, 4, 8, 44, ''),
(1085, 4, 8, 45, ''),
(1086, 4, 8, 46, ''),
(1087, 4, 8, 47, ''),
(1088, 4, 8, 48, ''),
(1089, 4, 8, 49, ''),
(1090, 4, 8, 50, ''),
(1091, 4, 8, 51, ''),
(1092, 4, 8, 52, ''),
(1093, 4, 9, 1, ''),
(1094, 4, 9, 2, ''),
(1095, 4, 9, 3, ''),
(1096, 4, 9, 4, ''),
(1097, 4, 9, 5, ''),
(1098, 4, 9, 6, ''),
(1099, 4, 9, 7, ''),
(1100, 4, 9, 8, ''),
(1101, 4, 9, 9, ''),
(1102, 4, 9, 10, ''),
(1103, 4, 9, 11, ''),
(1104, 4, 9, 12, ''),
(1105, 4, 9, 13, ''),
(1106, 4, 9, 14, ''),
(1107, 4, 9, 15, ''),
(1108, 4, 9, 16, ''),
(1109, 4, 9, 17, ''),
(1110, 4, 9, 18, ''),
(1111, 4, 9, 19, ''),
(1112, 4, 9, 20, ''),
(1113, 4, 9, 21, ''),
(1114, 4, 9, 22, ''),
(1115, 4, 9, 23, ''),
(1116, 4, 9, 24, ''),
(1117, 4, 9, 25, ''),
(1118, 4, 9, 26, ''),
(1119, 4, 9, 27, ''),
(1120, 4, 9, 28, ''),
(1121, 4, 9, 29, ''),
(1122, 4, 9, 30, ''),
(1123, 4, 9, 31, ''),
(1124, 4, 9, 32, ''),
(1125, 4, 9, 33, ''),
(1126, 4, 9, 34, ''),
(1127, 4, 9, 35, ''),
(1128, 4, 9, 36, ''),
(1129, 4, 9, 37, ''),
(1130, 4, 9, 38, ''),
(1131, 4, 9, 39, ''),
(1132, 4, 9, 40, ''),
(1133, 4, 9, 41, ''),
(1134, 4, 9, 42, ''),
(1135, 4, 9, 43, ''),
(1136, 4, 9, 44, ''),
(1137, 4, 9, 45, ''),
(1138, 4, 9, 46, ''),
(1139, 4, 9, 47, ''),
(1140, 4, 9, 48, ''),
(1141, 4, 9, 49, ''),
(1142, 4, 9, 50, ''),
(1143, 4, 9, 51, ''),
(1144, 4, 9, 52, ''),
(1405, 2, 5, 1, ''),
(1406, 2, 5, 2, ''),
(1407, 2, 5, 3, ''),
(1408, 2, 5, 4, ''),
(1409, 2, 5, 5, ''),
(1410, 2, 5, 6, ''),
(1411, 2, 5, 7, ''),
(1412, 2, 5, 8, ''),
(1413, 2, 5, 9, ''),
(1414, 2, 5, 10, ''),
(1415, 2, 5, 11, ''),
(1416, 2, 5, 12, ''),
(1417, 2, 5, 13, ''),
(1418, 2, 5, 14, ''),
(1419, 2, 5, 15, ''),
(1420, 2, 5, 16, ''),
(1421, 2, 5, 17, ''),
(1422, 2, 5, 18, ''),
(1423, 2, 5, 19, ''),
(1424, 2, 5, 20, ''),
(1425, 2, 5, 21, ''),
(1426, 2, 5, 22, ''),
(1427, 2, 5, 23, ''),
(1428, 2, 5, 24, ''),
(1429, 2, 5, 25, ''),
(1430, 2, 5, 26, ''),
(1431, 2, 5, 27, ''),
(1432, 2, 5, 28, ''),
(1433, 2, 5, 29, ''),
(1434, 2, 5, 30, ''),
(1435, 2, 5, 31, ''),
(1436, 2, 5, 32, ''),
(1437, 2, 5, 33, ''),
(1438, 2, 5, 34, ''),
(1439, 2, 5, 35, ''),
(1440, 2, 5, 36, ''),
(1441, 2, 5, 37, ''),
(1442, 2, 5, 38, ''),
(1443, 2, 5, 39, ''),
(1444, 2, 5, 40, ''),
(1445, 2, 5, 41, ''),
(1446, 2, 5, 42, ''),
(1447, 2, 5, 43, ''),
(1448, 2, 5, 44, ''),
(1449, 2, 5, 45, ''),
(1450, 2, 5, 46, ''),
(1451, 2, 5, 47, ''),
(1452, 2, 5, 48, ''),
(1453, 2, 5, 49, ''),
(1454, 2, 5, 50, ''),
(1455, 2, 5, 51, ''),
(1456, 2, 5, 52, '');

-- 
-- Вывод данных для таблицы state_sertification
--
INSERT INTO state_sertification VALUES
(2, 1, 3, 8, 9.0),
(3, 4, 2, 4, 0.0),
(4, 4, 2, 4, 0.0),
(5, 2, 2, 0, 0.0),
(6, 2, 2, 0, 0.0);

-- 
-- Вывод данных для таблицы practs
--
INSERT INTO practs VALUES
(1, 1, 3, 6, 3),
(10, 4, 4, 2, 0),
(11, 4, 2, 0, 0),
(13, 2, 3, 0, 0),
(14, 2, 2, 0, 0),
(15, 2, 3, 0, 0),
(41, 1, 4, 8, 3);

-- 
-- Вывод данных для таблицы names
--
INSERT INTO names VALUES
(1, 1, ' Зинченко А.М.', 'О.С. Балашова', 'В.В. Бондарчук', 'И.А. Карпук', 'С.В. Гонтовой'),
(2, 2, ' ', ' ', ' ', ' ', ' '),
(3, 4, ' ', ' ', ' ', ' ', ' ');

-- 
-- Вывод данных для таблицы aud_weeks
--
INSERT INTO aud_weeks VALUES
(1, 1, 2),
(2, 1, 0),
(3, 1, 0),
(4, 1, 0),
(5, 1, 0),
(6, 1, 0),
(7, 1, 0),
(8, 1, 0),
(9, 2, 2),
(10, 2, 2),
(11, 2, 2),
(12, 2, 2),
(13, 2, 2),
(14, 2, 2),
(15, 2, 0),
(16, 2, 0),
(49, 3, 0),
(50, 3, 0),
(51, 3, 0),
(52, 3, 0),
(53, 3, 0),
(54, 3, 0),
(55, 3, 0),
(56, 3, 0),
(57, 4, 0),
(58, 4, 0),
(59, 4, 0),
(60, 4, 0),
(61, 4, 0),
(62, 4, 0),
(63, 4, 0),
(64, 4, 0),
(65, 5, 0),
(66, 5, 0),
(67, 5, 0),
(68, 5, 0),
(69, 5, 0),
(70, 5, 0),
(71, 5, 0),
(72, 5, 0),
(73, 6, 0),
(74, 6, 0),
(75, 6, 0),
(76, 6, 0),
(77, 6, 0),
(78, 6, 0),
(79, 6, 0),
(80, 6, 0);

--
-- Установка базы данных по умолчанию
--
USE academikplan;

--
-- Удалить триггер `sertificationTrigger`
--
DROP TRIGGER IF EXISTS sertificationTrigger;

--
-- Удалить триггер `profileTrigger`
--
DROP TRIGGER IF EXISTS profileTrigger;

--
-- Удалить триггер `practTypeTrigger`
--
DROP TRIGGER IF EXISTS practTypeTrigger;

--
-- Удалить триггер `groupDirectionTrigger`
--
DROP TRIGGER IF EXISTS groupDirectionTrigger;

--
-- Удалить триггер `directionTrigger`
--
DROP TRIGGER IF EXISTS directionTrigger;

--
-- Установка базы данных по умолчанию
--
USE academikplan;

DELIMITER $$

--
-- Создать триггер `sertificationTrigger`
--
CREATE
DEFINER = 'root'@'localhost'
TRIGGER sertificationTrigger
BEFORE DELETE
ON sertification_types
FOR EACH ROW
BEGIN
  UPDATE state_sertification ss
  SET ss.idSertificationType = 1
  WHERE ss.idSertificationType = old.idSertificationType;
END
$$

--
-- Создать триггер `profileTrigger`
--
CREATE
DEFINER = 'root'@'localhost'
TRIGGER profileTrigger
BEFORE DELETE
ON profiles
FOR EACH ROW
BEGIN
  UPDATE titles t
  SET t.idProfile = 1
  WHERE t.idProfile = old.idProfile;
END
$$

--
-- Создать триггер `practTypeTrigger`
--
CREATE
DEFINER = 'root'@'localhost'
TRIGGER practTypeTrigger
BEFORE DELETE
ON pract_types
FOR EACH ROW
BEGIN
  UPDATE practs p
  SET p.idPractType = 1
  WHERE p.idPractType = old.idPractType;
END
$$

--
-- Создать триггер `groupDirectionTrigger`
--
CREATE
DEFINER = 'root'@'localhost'
TRIGGER groupDirectionTrigger
BEFORE DELETE
ON group_direction
FOR EACH ROW
BEGIN
  UPDATE titles t
  SET t.idGroupDirection = 1
  WHERE t.idGroupDirection = old.idGroupDirection;
END
$$

--
-- Создать триггер `directionTrigger`
--
CREATE
DEFINER = 'root'@'localhost'
TRIGGER directionTrigger
BEFORE DELETE
ON directions
FOR EACH ROW
BEGIN
  UPDATE titles t
  SET t.idDirection = 1
  WHERE t.idDirection = old.idDirection;
END
$$

DELIMITER ;

-- 
-- Восстановить предыдущий режим SQL (SQL mode)
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;