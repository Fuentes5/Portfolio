use activity4;

SELECT * FROM  baseballteams;

DELETE  FROM baseballteams WHERE Team='WAS';

select * from baseballteams;

INSERT INTO baseballteams (Team, Description, W, L, Runs, AB, Hits, Doubles , Triples, Homers, Walks, Strikeouts) 
VALUES ( 'WAS', 'Washington Nationals', '26', '34', '293', '1968', '519', '112', '12', '66', '192', '451');

select * from baseballteams;


ALTER TABLE `activity4`.`baseballteams` 
CHANGE COLUMN `Team` `Team` VARCHAR(3) NOT NULL ,
ADD PRIMARY KEY (`Team`);
;

select * from baseballteams;

