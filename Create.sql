SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Pristaniste`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pristaniste` (
  `idPristaniste` INT NOT NULL,
  `Kapacitet` INT NOT NULL,
  `Pozicija` INT NOT NULL,
  PRIMARY KEY (`idPristaniste`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Brod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Brod` (
  `idBrod` INT NOT NULL,
  `Naziv` VARCHAR(45) NOT NULL,
  `Kapacitet(kg)` DECIMAL(18,4) NOT NULL,
  `Dimenzije(m^2)` DECIMAL(18,4) NOT NULL,
  `Pristaniste_idPristaniste` INT NOT NULL,
  PRIMARY KEY (`idBrod`),
  INDEX `Pristaniste_idPristaniste_idx` (`Pristaniste_idPristaniste` ASC),
  CONSTRAINT `fk_Brod_Pristaniste`
    FOREIGN KEY (`Pristaniste_idPristaniste`)
    REFERENCES `mydb`.`Pristaniste` (`idPristaniste`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Linija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Linija` (
  `idLinija` INT NOT NULL,
  `Destinacija` VARCHAR(45) NOT NULL,
  `Kilometraza` DECIMAL(18,4) NULL,
  PRIMARY KEY (`idLinija`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Voznja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Voznja` (
  `Brod_idBrod` INT NOT NULL,
  `Linija_idLinija` INT NOT NULL,
  `Vreme_polaska` DATETIME NULL,
  `Vreme_dolaska` DATETIME NULL,
  PRIMARY KEY (`Brod_idBrod`, `Linija_idLinija`),
  INDEX `Linija_idLinija_idx` (`Linija_idLinija` ASC),
  CONSTRAINT `fk_Voznja_Brod`
    FOREIGN KEY (`Brod_idBrod`)
    REFERENCES `mydb`.`Brod` (`idBrod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Voznja_Linija`
    FOREIGN KEY (`Linija_idLinija`)
    REFERENCES `mydb`.`Linija` (`idLinija`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Teret`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Teret` (
  `idTeret` INT NOT NULL,
  `Tezina(kg)` DECIMAL(18,4) NOT NULL,
  `Dimenzije(m^2)` DECIMAL(18,4) NOT NULL,
  `Destinacija` VARCHAR(45) NOT NULL,
  `Voznja_Brod_idBrod` INT NULL,
  `Voznja_Linija_idLinija` INT NULL,
  PRIMARY KEY (`idTeret`),
  INDEX `Voznja_Brod_idBrod_idx` (`Voznja_Brod_idBrod` ASC),
  INDEX `Voznja_Linija_idLinija_idx` (`Voznja_Linija_idLinija` ASC),
  CONSTRAINT `fk_Teret_Voznja_Brod`
    FOREIGN KEY (`Voznja_Brod_idBrod`)
    REFERENCES `mydb`.`Voznja` (`Brod_idBrod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Teret_Voznja_Linija`
    FOREIGN KEY (`Voznja_Linija_idLinija`)
    REFERENCES `mydb`.`Voznja` (`Linija_idLinija`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Kapetan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Kapetan` (
  `idKapetan` INT NOT NULL,
  `Ime` VARCHAR(45) NOT NULL,
  `Starost` VARCHAR(45) NULL,
  PRIMARY KEY (`idKapetan`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Upravlja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Upravlja` (
  `Brod_idBrod` INT NOT NULL,
  `Kapetan_idKapetan` INT NOT NULL,
  `Pocetak_upravljanja` DATETIME NULL,
  `Zavrsetak_upravljanja` DATETIME NULL,
  PRIMARY KEY (`Brod_idBrod`, `Kapetan_idKapetan`),
  INDEX `Kapetan_idKapetan_idx` (`Kapetan_idKapetan` ASC),
  CONSTRAINT `fk_Upravlja_Brod`
    FOREIGN KEY (`Brod_idBrod`)
    REFERENCES `mydb`.`Brod` (`idBrod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Upravlja_Kapetan`
    FOREIGN KEY (`Kapetan_idKapetan`)
    REFERENCES `mydb`.`Kapetan` (`idKapetan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rezerva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rezerva` (
  `Brod_idBrod_1` INT NOT NULL,
  `Brod_idBrod_2` INT NOT NULL,
  PRIMARY KEY (`Brod_idBrod_1`, `Brod_idBrod_2`),
  INDEX `Brod_idBrod_2_idx` (`Brod_idBrod_2` ASC),
  CONSTRAINT `fk_Rezerva_Brod1`
    FOREIGN KEY (`Brod_idBrod_1`)
    REFERENCES `mydb`.`Brod` (`idBrod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rezerva_Brod2`
    FOREIGN KEY (`Brod_idBrod_2`)
    REFERENCES `mydb`.`Brod` (`idBrod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Specijalan_teret`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specijalan_teret` (
  `Teret_idTeret` INT NOT NULL,
  `Vrsta` VARCHAR(45) NOT NULL,
  `Zastita` VARCHAR(45) NULL,
  `Osiguranje` VARCHAR(45) NULL,
  PRIMARY KEY (`Teret_idTeret`),
  CONSTRAINT `fk_Specijalan_teret_Teret`
    FOREIGN KEY (`Teret_idTeret`)
    REFERENCES `mydb`.`Teret` (`idTeret`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
