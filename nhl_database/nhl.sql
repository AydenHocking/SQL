DROP DATABASE IF EXISTS nhl;
CREATE DATABASE nhl;
USE nhl;

DROP TABLE IF EXISTS player CASCADE;
DROP TABLE IF EXISTS team CASCADE;
DROP TABLE IF EXISTS game CASCADE;
DROP TABLE IF EXISTS injuryrecord CASCADE;

CREATE TABLE player (
    pname VARCHAR(20) NOT NULL,
    skilllevel INT,
    position VARCHAR(20),
    PRIMARY KEY(pname)
);
INSERT INTO player VALUE ('Chris Kreider', 4, 'center');
INSERT INTO player VALUE ('Tony DeAngelo', 2, 'forward');
INSERT INTO player VALUE ('Oliver Ekman-Larsson', 5, 'center');
INSERT INTO player VALUE ('Lawson Crouse', 2, 'forward');

CREATE TABLE team (
	tname VARCHAR(50) NOT NULL,
    city VARCHAR(20),
    coach VARCHAR(20),
    captain VARCHAR(20) NOT NULL,
    PRIMARY KEY(tname),
    FOREIGN KEY(captain) REFERENCES player(pname)
);
INSERT INTO team VALUE ('Rangers', 'New York', 'David Quinn','Chris Kreider');
INSERT INTO team VALUE ('Coyotes', 'Arizona', 'Rick Tocchet','Oliver Ekman-Larsson');

CREATE TABLE game (
	hostteam VARCHAR(50) NOT NULL,
	guestteam VARCHAR(50) NOT NULL,
    date DATE,
    score VARCHAR(7),
    PRIMARY KEY(hostteam, guestteam),
    FOREIGN KEY(hostteam) REFERENCES team(tname),
	FOREIGN KEY(guestteam) REFERENCES team(tname)
);
INSERT INTO game VALUE ('Rangers', 'Coyotes', '2019-03-04','4-2');
INSERT INTO game VALUE ('Coyotes', 'Rangers', '2020-10-22','3-4');

CREATE TABLE injuryrecord (
	injuryid VARCHAR(20) NOT NULL,
    description VARCHAR(200),
    PRIMARY KEY(injuryid),
    FOREIGN KEY(injuryid) REFERENCES player(pname)
);
INSERT INTO injuryrecord VALUE ('Tony DeAngelo', 'Pulled hamstring on 10/22/2020. Cannot play for two weeks.');

SELECT  
	(SELECT t1.captain FROM team t1 WHERE t1.tname = g.hostteam) AS Host,
		   (SELECT t2.captain FROM team t2 WHERE t2.tname = g.guestteam) AS Guest,
		   g.date AS Date,
		   g.score AS Score
FROM game g
WHERE g.hostteam = 'Rangers' AND g.guestteam = 'Coyotes' OR g.hostteam = 'Coyotes' AND g.guestteam = 'Rangers';