-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema invbio_ist17j
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema invbio_ist17j
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `invbio_ist17j` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `invbio_ist17j` ;

-- -----------------------------------------------------
-- Table `bdd_biotecnologia`.`catalogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invbio_ist17j`.`catalogo` (
  `cat_id` INT NOT NULL,
  `cat_nombre` VARCHAR(45) NOT NULL,
  `cat_descripcion` VARCHAR(100) NULL DEFAULT NULL,
  `cat_padre` INT NOT NULL,
  `cat_codigo` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`cat_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bdd_biotecnologia`.`donaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invbio_ist17j`.`donaciones` (
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
-- Table `bdd_biotecnologia`.`detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invbio_ist17j`.`detalle` (
  `det_id` INT NOT NULL AUTO_INCREMENT,
  `det_cantidad` INT NOT NULL,
  `det_fechacad` DATE NOT NULL,
  `don_cedula` INT NOT NULL,
  `cat_id` INT NOT NULL,
  `cat_id_estado` INT NOT NULL,
  PRIMARY KEY (`det_id`),
  INDEX `don_detalle_idx` (`don_cedula` ASC) VISIBLE,
  INDEX `fk_detalle_catalogo1_idx` (`cat_id` ASC) VISIBLE,
  INDEX `det_cat_estado_idx` (`cat_id_estado` ASC) VISIBLE,
  CONSTRAINT `cat_det_estado`
    FOREIGN KEY (`cat_id_estado`)
    REFERENCES `invbio_ist17j`.`catalogo` (`cat_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `cat_det_nombre`
    FOREIGN KEY (`cat_id`)
    REFERENCES `invbio_ist17j`.`catalogo` (`cat_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `don_detalle`
    FOREIGN KEY (`don_cedula`)
    REFERENCES `invbio_ist17j`.`donaciones` (`don_cedula`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bdd_biotecnologia`.`permisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invbio_ist17j`.`permisos` (
  `per_id` INT NOT NULL,
  `per_nombre` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`per_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bdd_biotecnologia`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invbio_ist17j`.`usuario` (
  `usu_id` INT NOT NULL AUTO_INCREMENT,
  `usu_nombre` VARCHAR(100) NOT NULL,
  `usu_cedula` VARCHAR(20) NOT NULL,
  `usu_telefono` VARCHAR(20) BINARY NULL DEFAULT NULL,
  `usu_correo` VARCHAR(50) NULL DEFAULT NULL,
  `usu_cargo` VARCHAR(20) NULL DEFAULT NULL,
  `usu_login` VARCHAR(20) NOT NULL,
  `usu_clave` VARCHAR(64) NOT NULL,
  `usu_condicion` TINYINT NOT NULL DEFAULT '1',
  `per_id` INT NOT NULL,
  PRIMARY KEY (`usu_id`),
  UNIQUE INDEX `login_UNIQUE` (`usu_login` ASC) VISIBLE,
  INDEX `usu_per_idx` (`per_id` ASC) VISIBLE,
  CONSTRAINT `usu_per`
    FOREIGN KEY (`per_id`)
    REFERENCES `invbio_ist17j`.`permisos` (`per_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 183
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `bdd_biotecnologia`.`usos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invbio_ist17j`.`usos` (
  `uso_id` INT NOT NULL AUTO_INCREMENT,
  `uso_cantidad` INT NOT NULL,
  `uso_descripcion` VARCHAR(200) NOT NULL,
  `usu_id` INT NOT NULL,
  PRIMARY KEY (`uso_id`),
  INDEX `usu_usos_idx` (`usu_id` ASC) VISIBLE,
  CONSTRAINT `usu_usos`
    FOREIGN KEY (`usu_id`)
    REFERENCES `invbio_ist17j`.`usuario` (`usu_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bdd_biotecnologia`.`detalle_usos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invbio_ist17j`.`detalle_usos` (
  `detalle_det_id` INT NOT NULL,
  `usos_uso_id` INT NOT NULL,
  PRIMARY KEY (`detalle_det_id`, `usos_uso_id`),
  INDEX `fk_detalle_has_usos_usos1_idx` (`usos_uso_id` ASC) VISIBLE,
  INDEX `fk_detalle_has_usos_detalle1_idx` (`detalle_det_id` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_has_usos_detalle1`
    FOREIGN KEY (`detalle_det_id`)
    REFERENCES `invbio_ist17j`.`detalle` (`det_id`),
  CONSTRAINT `fk_detalle_has_usos_usos1`
    FOREIGN KEY (`usos_uso_id`)
    REFERENCES `invbio_ist17j`.`usos` (`uso_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `invbio_ist17j` ;

-- -----------------------------------------------------
-- Table `invbio_ist17j`.`catalogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invbio_ist17j`.`catalogo` (
  `cat_id` INT NOT NULL,
  `cat_nombre` VARCHAR(45) NOT NULL,
  `cat_descripcion` VARCHAR(100) NULL DEFAULT NULL,
  `cat_padre` INT NOT NULL,
  `cat_codigo` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`cat_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `invbio_ist17j`.`donaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invbio_ist17j`.`donaciones` (
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
-- Table `invbio_ist17j`.`detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invbio_ist17j`.`detalle` (
  `det_id` INT NOT NULL AUTO_INCREMENT,
  `det_cantidad` INT NOT NULL,
  `det_fechacad` DATE NOT NULL,
  `don_cedula` INT NOT NULL,
  `cat_id` INT NOT NULL,
  `cat_id_estado` INT NOT NULL,
  PRIMARY KEY (`det_id`),
  INDEX `don_detalle_idx` (`don_cedula` ASC) VISIBLE,
  INDEX `fk_detalle_catalogo1_idx` (`cat_id` ASC) VISIBLE,
  INDEX `det_cat_estado_idx` (`cat_id_estado` ASC) VISIBLE,
  CONSTRAINT `cat_det_estado`
    FOREIGN KEY (`cat_id_estado`)
    REFERENCES `invbio_ist17j`.`catalogo` (`cat_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `cat_det_nombre`
    FOREIGN KEY (`cat_id`)
    REFERENCES `invbio_ist17j`.`catalogo` (`cat_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `don_detalle`
    FOREIGN KEY (`don_cedula`)
    REFERENCES `invbio_ist17j`.`donaciones` (`don_cedula`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `invbio_ist17j`.`usos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invbio_ist17j`.`usos` (
  `uso_id` INT NOT NULL AUTO_INCREMENT,
  `uso_cantidad` INT NOT NULL,
  `uso_descripcion` VARCHAR(200) NOT NULL,
  `usu_cedula` INT NOT NULL,
  PRIMARY KEY (`uso_id`),
  INDEX `usos_usu_idx` (`usu_cedula` ASC) VISIBLE,
  CONSTRAINT `usos_usu`
    FOREIGN KEY (`usu_cedula`)
    REFERENCES `invbio_ist17j`.`usuarios` (`usu_cedula`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `invbio_ist17j`.`detalle_usos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invbio_ist17j`.`detalle_usos` (
  `detalle_det_id` INT NOT NULL,
  `usos_uso_id` INT NOT NULL,
  PRIMARY KEY (`detalle_det_id`, `usos_uso_id`),
  INDEX `fk_detalle_has_usos_usos1_idx` (`usos_uso_id` ASC) VISIBLE,
  INDEX `fk_detalle_has_usos_detalle1_idx` (`detalle_det_id` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_has_usos_detalle1`
    FOREIGN KEY (`detalle_det_id`)
    REFERENCES `invbio_ist17j`.`detalle` (`det_id`),
  CONSTRAINT `fk_detalle_has_usos_usos1`
    FOREIGN KEY (`usos_uso_id`)
    REFERENCES `invbio_ist17j`.`usos` (`uso_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `invbio_ist17j`.`permisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invbio_ist17j`.`permisos` (
  `per_id` INT NOT NULL,
  `per_nombre` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`per_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `invbio_ist17j`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invbio_ist17j`.`usuario` (
  `usu_id` INT NOT NULL AUTO_INCREMENT,
  `usu_nombre` VARCHAR(100) NOT NULL,
  `usu_cedula` VARCHAR(20) NOT NULL,
  `usu_telefono` VARCHAR(20) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `usu_correo` VARCHAR(50) NULL DEFAULT NULL,
  `usu_cargo` VARCHAR(20) NULL DEFAULT NULL,
  `usu_login` VARCHAR(20) NOT NULL,
  `usu_clave` VARCHAR(64) NOT NULL,
  `usu_condicion` TINYINT NOT NULL DEFAULT '1',
  `per_id` INT NOT NULL,
  PRIMARY KEY (`usu_id`),
  UNIQUE INDEX `login_UNIQUE` (`usu_login` ASC) VISIBLE,
  INDEX `usu_per_idx` (`per_id` ASC) VISIBLE,
  CONSTRAINT `usu_per`
    FOREIGN KEY (`per_id`)
    REFERENCES `invbio_ist17j`.`permisos` (`per_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 183
DEFAULT CHARACTER SET = utf8mb3;

USE `bdd_biotecnologia` ;

-- -----------------------------------------------------
-- procedure sp_catalogo_delete
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_catalogo_delete`(in padre int)
BEGIN
	DELETE FROM catalogo  WHERE `cat_id` = padre;
		SELECT 'BORRADO';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_catalogo_insert
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_catalogo_insert`(in nombre varchar(100),in des varchar(200),in padre int,in codigo varchar(200))
BEGIN
declare sig int;
  IF exists (SELECT * FROM CATALOGO WHERE CAT_NOMBRE=nombre and cat_padre=padre) then
     select 1;
  else   
	   select max(cat_id) into sig from catalogo; 
        set sig=sig+1;
       INSERT INTO catalogo (`cat_id`,`cat_nombre`,`cat_descripcion`,
		`cat_padre`,`cat_codigo`)
	   VALUES (sig,nombre,des,padre,codigo);
       select 0;
       end if;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_catalogo_select
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_catalogo_select`(in padre int)
BEGIN
	SELECT * FROM catalogo where cat_padre=padre;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_catalogo_update
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_catalogo_update`(in op int,in nombre varchar(100),in des varchar(200),in padre int,in codigo varchar(200))
BEGIN
UPDATE catalogo SET
	`cat_nombre` = nombre,
	`cat_descripcion` = des,
    `cat_codigo` = codigo
     WHERE `cat_id` = padre;
     SELECT * FROM CATALOGO WHERE  `cat_id` = padre;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_detalle_delete
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_delete`(in id int)
BEGIN
	DELETE FROM detalle  WHERE `det_id` = id;
		SELECT 'BORRADO';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_detalle_insert
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_insert`(in nombre int,in cantidad int ,in fecha date,in cedula int ,in estado int)
BEGIN
declare sig int;
	   select max(det_id) into sig from detalle; 
        set sig=sig+1;
       INSERT INTO detalle (`det_id`,`cat_id`,`det_cantidad`,
		`det_fechacad`,`don_cedula`,`cat_id_estado`)
	   VALUES (sig,nombre,cantidad,fecha,cedula,estado);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_detalle_select
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_select`(in id int)
BEGIN
	SELECT * FROM detalle where det_id=id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_detalle_update
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_update`(in id int, in nombre int,in cantidad int,in fecha date,in cedula int,in estado int)
BEGIN
UPDATE detalle SET
	`cat_id` = nombre,
	`det_cantidad` = cantidad,
    `det_fechacad` = fecha,
    `don_cedula` = cedula,
    `cat_id_estado` = estado
     WHERE `det_id` = id;
     SELECT * FROM detalle WHERE  `det_id` = id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_detalle_usos_delete
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_usos_delete`(in detalle_id int, in usos_id int)
BEGIN
	DELETE FROM detalle_usos  WHERE `detalle_det_id` = detalle_id and `usos_uso_id` = usos_id;
		SELECT 'BORRADO';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_detalle_usos_insert
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_usos_insert`(in detalle_id int,in usos_id int)
BEGIN
       INSERT INTO detalle_usos (`detalle_det_id`,`usos_uso_id`)
	   VALUES (detalle_id,usos_id);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_detalle_usos_select
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_usos_select`(in detalle_id int,in usos_id int)
BEGIN
	SELECT * FROM detalle_usos where  detalle_det_id = detalle_id and usos_uso_id = usos_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_detalle_usos_update
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_usos_update`(in detalle_id int, in usos_id int)
BEGIN
UPDATE detalle_usos SET
	`detalle_det_id` = detalle_id,
	`usos_uso_id` = usos_id
     WHERE `detalle_det_id` = detalle_id and `usos_uso_id` = usos_id;
     SELECT * FROM detalle_usos WHERE  `detalle_det_id` = detalle_id and `usos_uso_id` = usos_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_donaciones_delete
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_donaciones_delete`(in id int)
BEGIN
	DELETE FROM donaciones  WHERE `don_cedula` = id;
		SELECT 'BORRADO';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_donaciones_insert
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_donaciones_insert`(in cedula int,in nombre varchar(100),in telefono int,in correo varchar(100) ,in direccion varchar(100),in fecha date)
BEGIN
       INSERT INTO donaciones (`don_cedula`,`don_nombre`,`don_telefono`,
		`don_correo`,`don_direccion`,`don_fecha`)
	   VALUES (cedula,nombre,telefono,correo,direccion,fecha);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_donaciones_select
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_donaciones_select`(in id int)
BEGIN
	SELECT * FROM donaciones where don_cedula=id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_donaciones_update
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_donaciones_update`(in cedula int,in nombre varchar(100),in telefono int,in correo varchar(100) ,in direccion varchar(100),in fecha date)
BEGIN
UPDATE donaciones SET
	`don_cedeula` = cedula,
	`don_nombre` = nombre,
    `don_telefono` = telefono,
    `don_correo` = correo,
    `don_direccion` = direccion,
    `don_fecha` = fecha
     WHERE `don_cedula` = cedula;
     SELECT * FROM donaciones WHERE  `don_cedula` =cedula;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usos_delete
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usos_delete`(in id int)
BEGIN
	DELETE FROM usos  WHERE `uso_id` = id;
		SELECT 'BORRADO';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usos_insert
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usos_insert`(in cantidad int,in descripcion varchar(200),in cedula int)
BEGIN
       declare sig int;
	   select max(uso_id) into sig from usos; 
        set sig=sig+1;
       INSERT INTO usos (`uso_id`,`uso_cantidad`,`uso_descripcion`,
		`usu_cedula`)
	   VALUES (sig,cantidad,descripcion,cedula);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usos_select
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usos_select`(in id int)
BEGIN
	SELECT * FROM usos where uso_id=id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usos_update
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usos_update`(in id int,in cantidad int,in descripcion varchar(200),in cedula int)
BEGIN
UPDATE usos SET
	`uso_cantidad` = cantidad,
	`uso_descripcion` = descripcion,
    `usu_cedula` = cedula
     WHERE `uso_id` = id;
     SELECT * FROM usos WHERE  `uso_id` = id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usuarios_delete
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuarios_delete`(in id int)
BEGIN
	DELETE FROM usuarios  WHERE `usu_cedula` = id;
		SELECT 'BORRADO';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usuarios_insert
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuarios_insert`(in cedula int,in nombre varchar(50) ,in apellido varchar(50),in telefono varchar(10) ,in usuario varchar(45),in contraseña varchar(45))
BEGIN
       INSERT INTO usuarios (`usu_cedula`,`usu_nombre`,`usu_apellido`,
		`usu_telefono`,`usu_usuario`,`usu_contraseña`)
	   VALUES (cedula,nombre,apellido,telefono,usuario,contraseña);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usuarios_select
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuarios_select`(in id int)
BEGIN
	SELECT * FROM usuarios where usu_cedula=id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usuarios_update
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuarios_update`(in cedula int,in nombre varchar(50) ,in apellido varchar(50),in telefono varchar(10) ,in usuario varchar(45),in contraseña varchar(45))
BEGIN
UPDATE usuarios SET
	`usu_cedula` = cedula,
	`usu_nombre` = nombre,
    `usu_apellido` = apellido,
    `usu_telefono` = telefono,
    `usu_usuario` = usuario,
    `usu_contraseña` = contraseña
     WHERE `usu_cedula` = cedula;
     SELECT * FROM usuarios WHERE  `usu_cedula` = cedula;
END$$

DELIMITER ;
USE `invbio_ist17j` ;

-- -----------------------------------------------------
-- procedure sp_catalogo_delete
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_catalogo_delete`(in padre int)
BEGIN
	DELETE FROM catalogo  WHERE `cat_id` = padre;
		SELECT 'BORRADO';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_catalogo_insert
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_catalogo_insert`(in nombre varchar(100),in des varchar(200),in padre int,in codigo varchar(200))
BEGIN
declare sig int;
  IF exists (SELECT * FROM CATALOGO WHERE CAT_NOMBRE=nombre and cat_padre=padre) then
     select 1;
  else   
	   select max(cat_id) into sig from catalogo; 
        set sig=sig+1;
       INSERT INTO catalogo (`cat_id`,`cat_nombre`,`cat_descripcion`,
		`cat_padre`,`cat_codigo`)
	   VALUES (sig,nombre,des,padre,codigo);
       select 0;
       end if;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_catalogo_select
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_catalogo_select`(in padre int)
BEGIN
	SELECT * FROM catalogo where cat_padre=padre;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_catalogo_update
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_catalogo_update`(in op int,in nombre varchar(100),in des varchar(200),in padre int,in codigo varchar(200))
BEGIN
UPDATE catalogo SET
	`cat_nombre` = nombre,
	`cat_descripcion` = des,
    `cat_codigo` = codigo
     WHERE `cat_id` = padre;
     SELECT * FROM CATALOGO WHERE  `cat_id` = padre;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_detalle_delete
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_delete`(in id int)
BEGIN
	DELETE FROM detalle  WHERE `det_id` = id;
		SELECT 'BORRADO';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_detalle_insert
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_insert`(in nombre int,in cantidad int ,in fecha date,in cedula int ,in estado int)
BEGIN
declare sig int;
	   select max(det_id) into sig from detalle; 
        set sig=sig+1;
       INSERT INTO detalle (`det_id`,`cat_id`,`det_cantidad`,
		`det_fechacad`,`don_cedula`,`cat_id_estado`)
	   VALUES (sig,nombre,cantidad,fecha,cedula,estado);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_detalle_select
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_select`(in id int)
BEGIN
	SELECT * FROM detalle where det_id=id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_detalle_update
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_update`(in id int, in nombre int,in cantidad int,in fecha date,in cedula int,in estado int)
BEGIN
UPDATE detalle SET
	`cat_id` = nombre,
	`det_cantidad` = cantidad,
    `det_fechacad` = fecha,
    `don_cedula` = cedula,
    `cat_id_estado` = estado
     WHERE `det_id` = id;
     SELECT * FROM detalle WHERE  `det_id` = id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_detalle_usos_delete
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_usos_delete`(in detalle_id int, in usos_id int)
BEGIN
	DELETE FROM detalle_usos  WHERE `detalle_det_id` = detalle_id and `usos_uso_id` = usos_id;
		SELECT 'BORRADO';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_detalle_usos_insert
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_usos_insert`(in detalle_id int,in usos_id int)
BEGIN
       INSERT INTO detalle_usos (`detalle_det_id`,`usos_uso_id`)
	   VALUES (detalle_id,usos_id);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_detalle_usos_select
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_usos_select`(in detalle_id int,in usos_id int)
BEGIN
	SELECT * FROM detalle_usos where  detalle_det_id = detalle_id and usos_uso_id = usos_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_detalle_usos_update
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_usos_update`(in detalle_id int, in usos_id int)
BEGIN
UPDATE detalle_usos SET
	`detalle_det_id` = detalle_id,
	`usos_uso_id` = usos_id
     WHERE `detalle_det_id` = detalle_id and `usos_uso_id` = usos_id;
     SELECT * FROM detalle_usos WHERE  `detalle_det_id` = detalle_id and `usos_uso_id` = usos_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_donaciones_delete
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_donaciones_delete`(in id int)
BEGIN
	DELETE FROM donaciones  WHERE `don_cedula` = id;
		SELECT 'BORRADO';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_donaciones_insert
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_donaciones_insert`(in cedula int,in nombre varchar(100),in telefono int,in correo varchar(100) ,in direccion varchar(100),in fecha date)
BEGIN
       INSERT INTO donaciones (`don_cedula`,`don_nombre`,`don_telefono`,
		`don_correo`,`don_direccion`,`don_fecha`)
	   VALUES (cedula,nombre,telefono,correo,direccion,fecha);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_donaciones_select
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_donaciones_select`(in id int)
BEGIN
	SELECT * FROM donaciones where don_cedula=id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_donaciones_update
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_donaciones_update`(in cedula int,in nombre varchar(100),in telefono int,in correo varchar(100) ,in direccion varchar(100),in fecha date)
BEGIN
UPDATE donaciones SET
	`don_cedeula` = cedula,
	`don_nombre` = nombre,
    `don_telefono` = telefono,
    `don_correo` = correo,
    `don_direccion` = direccion,
    `don_fecha` = fecha
     WHERE `don_cedula` = cedula;
     SELECT * FROM donaciones WHERE  `don_cedula` =cedula;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usos_delete
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usos_delete`(in id int)
BEGIN
	DELETE FROM usos  WHERE `uso_id` = id;
		SELECT 'BORRADO';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usos_insert
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usos_insert`(in cantidad int,in descripcion varchar(200),in cedula int)
BEGIN
       declare sig int;
	   select max(uso_id) into sig from usos; 
        set sig=sig+1;
       INSERT INTO usos (`uso_id`,`uso_cantidad`,`uso_descripcion`,
		`usu_cedula`)
	   VALUES (sig,cantidad,descripcion,cedula);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usos_select
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usos_select`(in id int)
BEGIN
	SELECT * FROM usos where uso_id=id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usos_update
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usos_update`(in id int,in cantidad int,in descripcion varchar(200),in cedula int)
BEGIN
UPDATE usos SET
	`uso_cantidad` = cantidad,
	`uso_descripcion` = descripcion,
    `usu_cedula` = cedula
     WHERE `uso_id` = id;
     SELECT * FROM usos WHERE  `uso_id` = id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usuarios_delete
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuarios_delete`(in id int)
BEGIN
	DELETE FROM usuarios  WHERE `usu_cedula` = id;
		SELECT 'BORRADO';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usuarios_insert
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuarios_insert`(in cedula int,in nombre varchar(50) ,in apellido varchar(50),in telefono varchar(10) ,in usuario varchar(45),in contraseña varchar(45))
BEGIN
       INSERT INTO usuarios (`usu_cedula`,`usu_nombre`,`usu_apellido`,
		`usu_telefono`,`usu_usuario`,`usu_contraseña`)
	   VALUES (cedula,nombre,apellido,telefono,usuario,contraseña);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usuarios_select
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuarios_select`(in id int)
BEGIN
	SELECT * FROM usuarios where usu_cedula=id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_usuarios_update
-- -----------------------------------------------------

DELIMITER $$
USE `invbio_ist17j`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuarios_update`(in cedula int,in nombre varchar(50) ,in apellido varchar(50),in telefono varchar(10) ,in usuario varchar(45),in contraseña varchar(45))
BEGIN
UPDATE usuarios SET
	`usu_cedula` = cedula,
	`usu_nombre` = nombre,
    `usu_apellido` = apellido,
    `usu_telefono` = telefono,
    `usu_usuario` = usuario,
    `usu_contraseña` = contraseña
     WHERE `usu_cedula` = cedula;
     SELECT * FROM usuarios WHERE  `usu_cedula` = cedula;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
USE `bdd_biotecnologia`
