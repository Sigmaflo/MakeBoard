-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ssafy_8th_web
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ssafy_8th_web
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ssafy_8th_web` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema ssafyweb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ssafyweb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ssafyweb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `ssafy_8th_web` ;

-- -----------------------------------------------------
-- Table `ssafy_8th_web`.`member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ssafy_8th_web`.`member` (
  `user_id` VARCHAR(16) NOT NULL,
  `user_name` VARCHAR(20) NOT NULL,
  `user_password` VARCHAR(16) NOT NULL,
  `join_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ssafy_8th_web`.`board`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ssafy_8th_web`.`board` (
  `board_no` INT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(16) NOT NULL,
  `subject` VARCHAR(100) NOT NULL,
  `content` VARCHAR(2000) NOT NULL,
  `hit` INT NULL DEFAULT '0',
  `register_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`board_no`),
  INDEX `board_to_member_user_id_fk_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `board_to_member_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `ssafy_8th_web`.`member` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ssafy_8th_web`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ssafy_8th_web`.`comment` (
  `comment_no` INT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(16) NOT NULL,
  `comment_content` VARCHAR(500) NOT NULL,
  `commen_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `board_no` INT NOT NULL,
  PRIMARY KEY (`comment_no`),
  INDEX `comment_to_board_board_no_fk_idx` (`board_no` ASC) VISIBLE,
  INDEX `comment_to_member_user_id_fk_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `comment_to_board_board_no_fk`
    FOREIGN KEY (`board_no`)
    REFERENCES `ssafy_8th_web`.`board` (`board_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `comment_to_member_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `ssafy_8th_web`.`member` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `ssafyweb` ;

-- -----------------------------------------------------
-- Table `ssafyweb`.`members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ssafyweb`.`members` (
  `user_id` VARCHAR(16) NOT NULL,
  `user_name` VARCHAR(20) NOT NULL,
  `user_password` VARCHAR(16) NOT NULL,
  `email_id` VARCHAR(20) NULL DEFAULT NULL,
  `email_domain` VARCHAR(45) NULL DEFAULT NULL,
  `join_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ssafyweb`.`board`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ssafyweb`.`board` (
  `article_no` INT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(16) NULL DEFAULT NULL,
  `subject` VARCHAR(100) NULL DEFAULT NULL,
  `content` VARCHAR(2000) NULL DEFAULT NULL,
  `hit` INT NULL DEFAULT '0',
  `register_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_no`),
  INDEX `board_to_members_user_id_fk` (`user_id` ASC) VISIBLE,
  CONSTRAINT `board_to_members_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `ssafyweb`.`members` (`user_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ssafyweb`.`memo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ssafyweb`.`memo` (
  `memo_no` INT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(16) NULL DEFAULT NULL,
  `comment` VARCHAR(500) NULL DEFAULT NULL,
  `memo_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `article_no` INT NULL DEFAULT NULL,
  PRIMARY KEY (`memo_no`),
  INDEX `memo_to_board_article_no_fk` (`article_no` ASC) VISIBLE,
  INDEX `memo_to_member_fk_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `memo_to_board_article_no_fk`
    FOREIGN KEY (`article_no`)
    REFERENCES `ssafyweb`.`board` (`article_no`),
  CONSTRAINT `memo_to_member_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `ssafyweb`.`members` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
