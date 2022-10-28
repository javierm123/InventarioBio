-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bdd_biotecnologia
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bdd_biotecnologia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bdd_biotecnologia` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `bdd_biotecnologia` ;

-- -----------------------------------------------------
-- Table `bdd_biotecnologia`.`donaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd_biotecnologia`.`donaciones` (
  `don_cedula` INT NOT NULL,
  `don_nombre` VARCHAR(100) NOT NULL,
  `don_telefono` VARCHAR(10) NOT NULL,
  `don_correo` VARCHAR(50) NOT NULL,
  `don_direccion` VARCHAR(100) NOT NULL,
  `don_fecha` DATE NOT NULL,
  PRIMARY KEY (`don_cedula`),
  UNIQUE INDEX `don_cedula_UNIQUE` (`don_cedula` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bdd_biotecnologia`.`catalogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd_biotecnologia`.`catalogo` (
  `cat_id` INT NOT NULL,
  `cat_nombre` VARCHAR(45) NOT NULL,
  `cat_descripcion` VARCHAR(100) NOT NULL,
  `cat_padre` INT NOT NULL,
  PRIMARY KEY (`cat_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bdd_biotecnologia`.`detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd_biotecnologia`.`detalle` (
  `det_id` INT NOT NULL AUTO_INCREMENT,
  `det_cantidad` INT NOT NULL,
  `det_fechacad` DATE NOT NULL,
  `don_cedula` INT NOT NULL,
  `cat_id` INT NOT NULL,
  PRIMARY KEY (`det_id`),
  INDEX `don_detalle_idx` (`don_cedula` ASC) VISIBLE,
  INDEX `fk_detalle_catalogo1_idx` (`cat_id` ASC) VISIBLE,
  CONSTRAINT `don_detalle`
    FOREIGN KEY (`don_cedula`)
    REFERENCES `bdd_biotecnologia`.`donaciones` (`don_cedula`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_detalle_catalogo1`
    FOREIGN KEY (`cat_id`)
    REFERENCES `bdd_biotecnologia`.`catalogo` (`cat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bdd_biotecnologia`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd_biotecnologia`.`usuarios` (
  `usu_cedula` INT NOT NULL,
  `usu_nombre` VARCHAR(50) NOT NULL,
  `usu_apellido` VARCHAR(50) NOT NULL,
  `usu_telefono` VARCHAR(10) NOT NULL,
  `usu_usuario` VARCHAR(45) NOT NULL,
  `usu_contraseña` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`usu_cedula`),
  UNIQUE INDEX `usu_cedula_UNIQUE` (`usu_cedula` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bdd_biotecnologia`.`usos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd_biotecnologia`.`usos` (
  `uso_id` INT NOT NULL AUTO_INCREMENT,
  `uso_cantidad` INT NOT NULL,
  `uso_descripcion` VARCHAR(200) NOT NULL,
  `usu_cedula` INT NOT NULL,
  PRIMARY KEY (`uso_id`),
  INDEX `usos_usu_idx` (`usu_cedula` ASC) VISIBLE,
  CONSTRAINT `usos_usu`
    FOREIGN KEY (`usu_cedula`)
    REFERENCES `bdd_biotecnologia`.`usuarios` (`usu_cedula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bdd_biotecnologia`.`detalle_has_usos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdd_biotecnologia`.`detalle_has_usos` (
  `detalle_det_id` INT NOT NULL,
  `usos_uso_id` INT NOT NULL,
  PRIMARY KEY (`detalle_det_id`, `usos_uso_id`),
  INDEX `fk_detalle_has_usos_usos1_idx` (`usos_uso_id` ASC) VISIBLE,
  INDEX `fk_detalle_has_usos_detalle1_idx` (`detalle_det_id` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_has_usos_detalle1`
    FOREIGN KEY (`detalle_det_id`)
    REFERENCES `bdd_biotecnologia`.`detalle` (`det_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_has_usos_usos1`
    FOREIGN KEY (`usos_uso_id`)
    REFERENCES `bdd_biotecnologia`.`usos` (`uso_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
