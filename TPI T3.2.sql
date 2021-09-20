-- -------------------------------------------
-- ESTUDIO GRAL DE TRABAJO TPI (1 REALIZACION DE SCRIPT SQL)
-- -------------------------------------------
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- -----------------------------------------------------
-- TPI BASE DE DATOS 1
-- Una vez redactada  la base se redacten las instrucciones de dicha base
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`consecionaria` ;
CREATE TABLE IF NOT EXISTS `mydb`.`consecionaria` (
  `Id` INT(11) NOT NULL,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`pedido` ;
CREATE TABLE IF NOT EXISTS `mydb`.`pedido` (
  `Id` INT(11) NOT NULL,
  `FechaDeVenta` DATETIME NULL DEFAULT NULL,
  `FechaDeEntrega` DATETIME NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  `consecionaria_Id` INT(11) NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_pedido_consecionaria`
    FOREIGN KEY (`consecionaria_Id`)
    REFERENCES `mydb`.`consecionaria` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`linea_montaje` ;
CREATE TABLE IF NOT EXISTS `mydb`.`linea_montaje` (
  `Id` INT(11) NOT NULL,
  `Codigo` VARCHAR(45) NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`modelo` ;
CREATE TABLE IF NOT EXISTS `mydb`.`modelo` (
  `Id` INT(11) NOT NULL,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  `linea_montaje_Id` INT(11) NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_modelo_linea_montaje1`
    FOREIGN KEY (`linea_montaje_Id`)
    REFERENCES `mydb`.`linea_montaje` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`pedido_detalle` ;
CREATE TABLE IF NOT EXISTS `mydb`.`pedido_detalle` (
  `Id` INT(11) NOT NULL,
  `modelo_Id` INT(11) NOT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  `pedido_Id` INT(11) NOT NULL,
  `modelo_Id1` INT(11) NOT NULL,
  PRIMARY KEY (`Id`, `modelo_Id`),
  CONSTRAINT `fk_pedido_detalle_pedido1`
    FOREIGN KEY (`pedido_Id`)
    REFERENCES `mydb`.`pedido` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_detalle_modelo1`
    FOREIGN KEY (`modelo_Id1`)
    REFERENCES `mydb`.`modelo` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`automovil` ;
CREATE TABLE IF NOT EXISTS `mydb`.`automovil` (
  `Id` INT(11) NOT NULL,
  `Chasis` VARCHAR(45) NULL DEFAULT NULL,
  `FechaInicio` DATETIME NULL DEFAULT NULL,
  `FechaFin` DATETIME NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  `pedido_detalle_Id` INT(11) NOT NULL,
  `pedido_detalle_modelo_Id` INT(11) NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_automovil_pedido_detalle1`
    FOREIGN KEY (`pedido_detalle_Id` , `pedido_detalle_modelo_Id`)
    REFERENCES `mydb`.`pedido_detalle` (`Id` , `modelo_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`estacion` ;
CREATE TABLE IF NOT EXISTS `mydb`.`estacion` (
  `Id` INT(11) NOT NULL,
  `OrdenEstacion` INT(11) NULL DEFAULT NULL,
  `TareaDeterminada` VARCHAR(45) NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  `linea_montaje_Id` INT(11) NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_estacion_linea_montaje1`
    FOREIGN KEY (`linea_montaje_Id`)
    REFERENCES `mydb`.`linea_montaje` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`automovil_estacion` ;
CREATE TABLE IF NOT EXISTS `mydb`.`automovil_estacion` (
  `FechaIngresoEstacion` DATETIME NULL DEFAULT NULL,
  `FechaEgresoEstacion` DATETIME NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  `estacion_Id` INT(11) NOT NULL,
  `automovil_Id` INT(11) NOT NULL,
  CONSTRAINT `fk_automovil_estacion_estacion1`
    FOREIGN KEY (`estacion_Id`)
    REFERENCES `mydb`.`estacion` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_automovil_estacion_automovil1`
    FOREIGN KEY (`automovil_Id`)
    REFERENCES `mydb`.`automovil` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`unidad` ;
CREATE TABLE IF NOT EXISTS `mydb`.`unidad` (
  `Id` INT(11) NOT NULL,
  `Descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `Eliminar` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`insumos` ;
CREATE TABLE IF NOT EXISTS `mydb`.`insumos` (
  `Id` INT(11) NOT NULL,
  `Descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `Cantidad` INT(11) NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` VARCHAR(45) NULL DEFAULT NULL,
  `unidad_Id` INT(11) NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_insumos_unidad1`
    FOREIGN KEY (`unidad_Id`)
    REFERENCES `mydb`.`unidad` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`insumo_estacion` ;
CREATE TABLE IF NOT EXISTS `mydb`.`insumo_estacion` (
  `CantidadConsumida` INT(11) NULL DEFAULT NULL,
  `UnidadConsumida` INT(11) NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  `estacion_Id` INT(11) NOT NULL,
  `insumos_Id` INT(11) NOT NULL,
  PRIMARY KEY (`insumos_Id`, `estacion_Id`),
  CONSTRAINT `fk_insumo_estacion_estacion1`
    FOREIGN KEY (`estacion_Id`)
    REFERENCES `mydb`.`estacion` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_insumo_estacion_insumos1`
    FOREIGN KEY (`insumos_Id`)
    REFERENCES `mydb`.`insumos` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`proveedor` ;
CREATE TABLE IF NOT EXISTS `mydb`.`proveedor` (
  `Id` INT(11) NOT NULL,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `CUIT` VARCHAR(45) NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`proveedor_insumos` ;
CREATE TABLE IF NOT EXISTS `mydb`.`proveedor_insumos` (
  `Precio` INT(11) NULL DEFAULT NULL,
  `Eliminado` BIT(1) NULL DEFAULT NULL,
  `FechaEliminado` DATETIME NULL DEFAULT NULL,
  `insumos_Id` INT(11) NOT NULL,
  `proveedor_Id` INT(11) NOT NULL,
  CONSTRAINT `fk_proveedor_insumos_insumos1`
    FOREIGN KEY (`insumos_Id`)
    REFERENCES `mydb`.`insumos` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proveedor_insumos_proveedor1`
    FOREIGN KEY (`proveedor_Id`)
    REFERENCES `mydb`.`proveedor` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-- -------------------------------------------
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
-- -------------------------------------------
-- ESTUDIO GRAL DE TRABAJO TPI (2 REDACCION DE INSTRUCCIONES)
-- 1_REDACCION DE INGRESOS
-- SE SOLICITA REDACTAR LOS PROCEDIMIENTOS DE ALTA Y BAJA DE LAS SIGUIENTES ENTIDADES 
-- Concesionaria, Insumos, Pedido(Cabecera mas Detalle), y Provedores.
-- -------------------------------------------
-- Concesionaria
-- -------------------------------------------
CREATE PROCEDURE alta_concesionaria(`Id`INT,`Nombre` VARCHAR(45))
BEGIN
INSERT INTO `mydb`.`consecionaria` values(Id,Nombre);  -- INSERTAR VALORES NOMBRE, E ID
SET NEW.`Eliminado`=0;  -- SE AFIRMA QUE NO DEBE SER ELIMINADA ESTA CONCESIONARIA
SET NEW.`FechaEliminado`=NULL; -- NO TIENE FECHA DE EXPIRACION
END;
CREATE PROCEDURE elim_concesionaria(id2 int(11))
BEGIN
DECLARE c CURSOR FOR SELECT * FROM `mydb`.`consecionaria` WHERE id like id; -- SE BUSCA EN LA TABLA CONCESIONARIA 
OPEN c;-- SE ABRE EL CURSOR DE BUSQUEDA
SET`Eliminado`=1;-- SE CONFIRMA LA ELIMINACION DEL REGISTRO ENCONTRADO
CLOSE c;-- SE CIERRA EL CURSOR.
END;
CREATE PROCEDURE baja_concesionaria()
BEGIN
DECLARE c CURSOR FOR SELECT * FROM `mydb`.`consecionaria` WHERE Eliminado=1;-- SE BUSCA EN LA TABLA CONCESIONARIA 
OPEN c;-- SE ABRE EL CURSOR DE BUSQUEDA
DROP c.consecionaria;-- SE ELIMINA LO YA ENCONTRADO
CLOSE c;-- SE CIERRA EL CURSOR.
END;
-- -------------------------------------------
-- Insumos
-- -------------------------------------------
CREATE PROCEDURE alta_insumos(`Id` INT(11),`Descripcion` VARCHAR(45),`Cantidad` INT(11),`unidad_Id` INT(11))
BEGIN
INSERT INTO `mydb`.`insumos` VALUES(`Id`,`Descripcion`,`Cantidad`,`unidad_Id`); -- INSERTAR VALORES DE INSUMOS
SET NEW.`Eliminado`=0;  -- SE AFIRMA QUE NO DEBE SER ELIMINADA ESTA CONCESIONARIA
SET NEW.`FechaEliminado`=NULL; -- NO TIENE FECHA DE EXPIRACION
END;
CREATE PROCEDURE elim_insumos(id1 int(11))
BEGIN
DECLARE c CURSOR FOR SELECT * FROM `mydb`.`insumos` WHERE id like id1; -- SE BUSCA EN LA TABLA CONCESIONARIA 
OPEN c;-- SE ABRE EL CURSOR DE BUSQUEDA
SET`Eliminado`=1;-- SE CONFIRMA LA ELIMINACION DEL REGISTRO ENCONTRADO
CLOSE c;-- SE CIERRA EL CURSOR.
END;
CREATE PROCEDURE baja_insumos()
BEGIN
DECLARE c CURSOR FOR SELECT * FROM `mydb`.`insumos` WHERE Eliminado=1;-- SE BUSCA EN LA TABLA CONCESIONARIA 
OPEN c;-- SE ABRE EL CURSOR DE BUSQUEDA
DROP c.insumos;-- SE ELIMINA LO YA ENCONTRADO
CLOSE c;-- SE CIERRA EL CURSOR.
END;
-- -------------------------------------------
-- Pedido
-- -------------------------------------------
CREATE PROCEDURE alta_pedido( `Id` INT(11),`FechaDeVenta` DATETIME,`FechaDeEntrega` DATETIME,`consecionaria_Id` INT(11))
BEGIN
INSERT INTO `mydb`.`pedido` VALUES(`Id`,`FechaDeVenta`,`FechaDeEntrega`,`consecionaria_Id`); -- INSERTAR VALORES DE PEDIDOS
SET NEW.`Eliminado`=0;  -- SE AFIRMA QUE NO DEBE SER ELIMINADA ESTA CONCESIONARIA
SET NEW.`FechaEliminado`=NULL; -- NO TIENE FECHA DE EXPIRACION
END;
CREATE PROCEDURE elim_pedido(id3 int(11))
BEGIN
DECLARE c CURSOR FOR SELECT * FROM `mydb`.`pedido` WHERE id like id3; -- SE BUSCA EN LA TABLA CONCESIONARIA 
OPEN c;-- SE ABRE EL CURSOR DE BUSQUEDA
SET`Eliminado`=1;-- SE CONFIRMA LA ELIMINACION DEL REGISTRO ENCONTRADO
CLOSE c;-- SE CIERRA EL CURSOR.
END;
CREATE PROCEDURE baja_pedido()
BEGIN
DECLARE c CURSOR FOR SELECT * FROM `mydb`.`pedido` WHERE Eliminado=1;-- SE BUSCA EN LA TABLA CONCESIONARIA 
OPEN c;-- SE ABRE EL CURSOR DE BUSQUEDA
DROP c.pedido;-- SE ELIMINA LO YA ENCONTRADO
CLOSE c;-- SE CIERRA EL CURSOR.
END;
-- -------------------------------------------
-- Proveedor
-- -------------------------------------------
CREATE PROCEDURE alta_proveedor( `Id` INT(11),`Nombre` VARCHAR(45),`CUIT` VARCHAR(45))
BEGIN
INSERT INTO `mydb`.`proveedor` VALUES( `Id`,`Nombre`,`CUIT`); -- INSERTAR VALORES DE PEDIDOS
SET NEW.`Eliminado`=0;  -- SE AFIRMA QUE NO DEBE SER ELIMINADA ESTA CONCESIONARIA
SET NEW.`FechaEliminado`=NULL; -- NO TIENE FECHA DE EXPIRACION
END;
CREATE PROCEDURE elim_proveedor(id4 int(11))
BEGIN
DECLARE c CURSOR FOR SELECT * FROM `mydb`.`proveedor` WHERE id like id4; -- SE BUSCA EN LA TABLA CONCESIONARIA 
OPEN c;-- SE ABRE EL CURSOR DE BUSQUEDA
SET`Eliminado`=1;-- SE CONFIRMA LA ELIMINACION DEL REGISTRO ENCONTRADO
CLOSE c;-- SE CIERRA EL CURSOR.
END;
CREATE PROCEDURE baja_proveedor()
BEGIN
DECLARE c CURSOR FOR SELECT * FROM `mydb`.`proveedor` WHERE Eliminado=1;-- SE BUSCA EN LA TABLA CONCESIONARIA 
OPEN c;-- SE ABRE EL CURSOR DE BUSQUEDA
DROP c.proveedor;-- SE ELIMINA LO YA ENCONTRADO
CLOSE c;-- SE CIERRA EL CURSOR.
END;
