-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema calendar
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `calendar` ;

-- -----------------------------------------------------
-- Schema calendar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `calendar` DEFAULT CHARACTER SET utf8 ;
USE `calendar` ;

-- -----------------------------------------------------
-- Table `calendar`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calendar`.`Users` ;

CREATE TABLE IF NOT EXISTS `calendar`.`Users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `calendar`.`EventTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calendar`.`EventTypes` ;

CREATE TABLE IF NOT EXISTS `calendar`.`EventTypes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `name_UNIQUE` ON `calendar`.`EventTypes` (`name` ASC);

CREATE UNIQUE INDEX `slug_UNIQUE` ON `calendar`.`EventTypes` (`slug` ASC);


-- -----------------------------------------------------
-- Table `calendar`.`Events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calendar`.`Events` ;

CREATE TABLE IF NOT EXISTS `calendar`.`Events` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dateStart` DATETIME NULL,
  `dateEnd` DATETIME NULL,
  `location` VARCHAR(255) NULL,
  `descr` TEXT NULL,
  `owner_id` INT NOT NULL,
  `price` JSON NULL,
  `appDeadline` DATETIME NULL,
  `latlong` POINT NULL,
  `eventType_id` INT NOT NULL,
  `name` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Games_Users`
    FOREIGN KEY (`owner_id`)
    REFERENCES `calendar`.`Users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Events_EventTypes1`
    FOREIGN KEY (`eventType_id`)
    REFERENCES `calendar`.`EventTypes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Games_Users_idx` ON `calendar`.`Events` (`owner_id` ASC);

CREATE INDEX `fk_Events_EventTypes1_idx` ON `calendar`.`Events` (`eventType_id` ASC);

CREATE UNIQUE INDEX `name_UNIQUE` ON `calendar`.`Events` (`name` ASC);


-- -----------------------------------------------------
-- Table `calendar`.`Teams`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calendar`.`Teams` ;

CREATE TABLE IF NOT EXISTS `calendar`.`Teams` (
  `idTeams` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `descr` VARCHAR(500) NULL,
  `contacts` JSON NULL,
  PRIMARY KEY (`idTeams`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `calendar`.`Teams_has_Events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calendar`.`Teams_has_Events` ;

CREATE TABLE IF NOT EXISTS `calendar`.`Teams_has_Events` (
  `Teams_idTeams` INT NOT NULL,
  `Events_idEvents` INT NOT NULL,
  PRIMARY KEY (`Teams_idTeams`, `Events_idEvents`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Teams_has_Events_Events1_idx` ON `calendar`.`Teams_has_Events` (`Events_idEvents` ASC);

CREATE INDEX `fk_Teams_has_Events_Teams1_idx` ON `calendar`.`Teams_has_Events` (`Teams_idTeams` ASC);


-- -----------------------------------------------------
-- Table `calendar`.`EventAdmins`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calendar`.`EventAdmins` ;

CREATE TABLE IF NOT EXISTS `calendar`.`EventAdmins` (
  `idUsers` INT NOT NULL,
  `idEvents` INT NOT NULL,
  PRIMARY KEY (`idUsers`, `idEvents`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Users_has_Events_Events1_idx` ON `calendar`.`EventAdmins` (`idEvents` ASC);

CREATE INDEX `fk_Users_has_Events_Users1_idx` ON `calendar`.`EventAdmins` (`idUsers` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
