CREATE TABLE IF NOT EXISTS `echoscapes`.`CentralLocation` (
  `CentralLocationID` INT NOT NULL,
  `Latitude` DECIMAL(8,6) NOT NULL,
  `Longitude` DECIMAL(8,6) NOT NULL,
  `Description` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`CentralLocationID`),
  UNIQUE INDEX `Latitude_UNIQUE` (`Latitude` ASC) VISIBLE,
  UNIQUE INDEX `Longitude_UNIQUE` (`Longitude` ASC) VISIBLE,
  UNIQUE INDEX `Description_UNIQUE` (`Description` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `echoscapes`.`Route` (
  `RouteID` INT NOT NULL,
  `WellLit` INT NOT NULL,
  `Stairs` INT NOT NULL,
  `Incline` INT NOT NULL,
  `Image` BLOB NOT NULL,
  PRIMARY KEY (`RouteID`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `echoscapes`.`Soundscape` (
  `SoundscapeID` INT NOT NULL,
  `Duration` INT NOT NULL,
  `Sound` BLOB NOT NULL,
  PRIMARY KEY (`SoundscapeID`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `echoscapes`.`POI` (
  `POI_ID` INT NOT NULL,
  `Latitude` DECIMAL(8,6) NOT NULL,
  `Longitude` DECIMAL(8,6) NOT NULL,
  `POI_Name` VARCHAR(60) NOT NULL,
  `Description` VARCHAR(250) NOT NULL,
  `SoundscapeID` INT NOT NULL,
  `RouteID` INT NOT NULL,
  PRIMARY KEY (`POI_ID`),
  UNIQUE INDEX `POI_Name_UNIQUE` (`POI_Name` ASC) VISIBLE,
  UNIQUE INDEX `Description_UNIQUE` (`Description` ASC) VISIBLE,
  UNIQUE INDEX `SoundscapeID_UNIQUE` (`SoundscapeID` ASC) VISIBLE,
  INDEX `RouteID_idx` (`RouteID` ASC) VISIBLE,
  CONSTRAINT `SoundscapeID`
    FOREIGN KEY (`SoundscapeID`)
    REFERENCES `echoscapes`.`Soundscape` (`SoundscapeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `RouteID`
    FOREIGN KEY (`RouteID`)
    REFERENCES `echoscapes`.`Route` (`RouteID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- constraints

-- latitude must be positive
ALTER TABLE CentralLocation
ADD CHECK (Latitude > 0.0);

-- longitude must be negative
ALTER TABLE CentralLocation
ADD CHECK (Longitude < 0.0);

-- latitude must be positive
ALTER TABLE POI
ADD CHECK (Latitude > 0.0);

-- longitude must be negative
ALTER TABLE POI
ADD CHECK (Longitude < 0.0);

-- values can only be 0 or 1

ALTER TABLE Route
ADD CHECK ((Stairs = 0) OR (Stairs = 1));

ALTER TABLE Route
ADD CHECK ((Incline = 0) OR (Incline = 1));

ALTER TABLE Route
ADD CHECK ((WellLit = 0) OR (WellLit = 1));

SELECT * FROM POI;

-- dummy data insertion, CREATE

INSERT INTO CentralLocation (CentralLocationID, Latitude, Longitude, Description)
VALUES (1, 44.33455, -69.39441, "Cotter Union");

-- READ
SELECT * FROM CentralLocation;
SELECT * FROM Soundscape;

-- UPDATE
UPDATE CentralLocation
SET Description = "Cotter Union aka Spa"
WHERE CentralLocationID = 1;

-- DELETE
DELETE FROM CentralLocation WHERE CentralLocationID = 1;

INSERT INTO CentralLocation (CentralLocationID, Latitude, Longitude, Description)
VALUES (1, 44.33455, -69.39441, "Cotter Union");

INSERT INTO Soundscape (SoundscapeID, Duration, Sound)
VALUES (28,30,"Miller Lawn sounds");

SELECT * FROM Soundscape;

SELECT * FROM Route;

INSERT INTO Soundscape (SoundscapeID, Duration, Sound)
VALUES (28,30,"Miller Lawn sounds");

SELECT * FROM POI;
INSERT INTO POI (POI_ID, Latitude, Longitude, POI_Name, Description, SoundscapeID, RouteID)
VALUES (8, 44.564037, -69.662807, "Miller Lawn", "This is the lawn.", 28, 6);

SELECT * FROM POI;

SELECT Soundscape.Sound
FROM Soundscape
JOIN POI ON POI.SoundscapeID = Soundscape.SoundscapeID
WHERE POI.POI_ID = 8;

SELECT * FROM Route;
SELECT Route.Image
FROM Route
JOIN POI ON POI.RouteID = Route.RouteID
WHERE POI.POI_ID = 8;