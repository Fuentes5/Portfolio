use activity4;

SELECT * FROM  batters;

ALTER TABLE `activity4`.`batters` 
CHANGE COLUMN `ï»¿playerID` `playerID` CHAR(20) NOT NULL ;

ALTER TABLE `activity4`.`batters` 
CHANGE COLUMN `Team` `Team` CHAR(3) NULL DEFAULT NULL ;

SELECT * FROM  batters;


