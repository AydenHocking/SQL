-- Joseph Abdulwahab, Dev Amin, Ayden Hocking, Grishma Howale
/* Delete the tables if they already exist */
DROP DATABASE IF EXISTS social_network;
CREATE DATABASE social_network;
USE social_network;

drop table if exists Highschooler;
drop table if exists Friend;
drop table if exists Likes;

/* Create the schema for our tables */
create table Highschooler(ID int, name text, grade int);
create table Friend(ID1 int, ID2 int);
create table Likes(ID1 int, ID2 int);

/* Populate the tables with our data */
insert into Highschooler values (1510, 'Jordan', 9);
insert into Highschooler values (1689, 'Gabriel', 9);
insert into Highschooler values (1381, 'Tiffany', 9);
insert into Highschooler values (1709, 'Cassandra', 9);
insert into Highschooler values (1101, 'Haley', 10);
insert into Highschooler values (1782, 'Andrew', 10);
insert into Highschooler values (1468, 'Kris', 10);
insert into Highschooler values (1641, 'Brittany', 10);
insert into Highschooler values (1247, 'Alexis', 11);
insert into Highschooler values (1316, 'Austin', 11);
insert into Highschooler values (1911, 'Gabriel', 11);
insert into Highschooler values (1501, 'Jessica', 11);
insert into Highschooler values (1304, 'Jordan', 12);
insert into Highschooler values (1025, 'John', 12);
insert into Highschooler values (1934, 'Kyle', 12);
insert into Highschooler values (1661, 'Logan', 12);

insert into Friend values (1510, 1381);
insert into Friend values (1510, 1689);
insert into Friend values (1689, 1709);
insert into Friend values (1381, 1247);
insert into Friend values (1709, 1247);
insert into Friend values (1689, 1782);
insert into Friend values (1782, 1468);
insert into Friend values (1782, 1316);
insert into Friend values (1782, 1304);
insert into Friend values (1468, 1101);
insert into Friend values (1468, 1641);
insert into Friend values (1101, 1641);
insert into Friend values (1247, 1911);
insert into Friend values (1247, 1501);
insert into Friend values (1911, 1501);
insert into Friend values (1501, 1934);
insert into Friend values (1316, 1934);
insert into Friend values (1934, 1304);
insert into Friend values (1304, 1661);
insert into Friend values (1661, 1025);
insert into Friend select ID2, ID1 from Friend;

insert into Likes values(1689, 1709);
insert into Likes values(1709, 1689);
insert into Likes values(1782, 1709);
insert into Likes values(1911, 1247);
insert into Likes values(1247, 1468);
insert into Likes values(1641, 1468);
insert into Likes values(1316, 1304);
insert into Likes values(1501, 1934);
insert into Likes values(1934, 1501);
insert into Likes values(1025, 1101);

DELIMITER //
CREATE TRIGGER friendly_trigger
BEFORE INSERT ON Highschooler
FOR EACH ROW
begin
  IF New.name = "Friendly" THEN
    insert into Likes select New.id, Highschooler.id from Highschooler 
    where Highschooler.grade = New.grade;
  END IF;
end //
DELIMITER ;
 INSERT INTO Highschooler VALUES(1222, 'Friendly', 10);

DELIMITER //
CREATE PROCEDURE insert_friend(IN friend1 INT, IN friend2 INT)
BEGIN
	SET @aFriendb = (SELECT COUNT(*) FROM Friend WHERE ID1 = friend1 and ID2 = friend2);
    IF @aFriendb = 0 THEN
		INSERT INTO Friend VALUES (friend1, friend2);
	END IF;
    
	SET @bFrienda = (SELECT COUNT(*) FROM Friend WHERE ID1 = friend2 and ID2 = friend1);
    IF @bFrienda = 0 THEN
        INSERT INTO Friend VALUES (friend2, friend1);
	END IF;
END //
DELIMITER ;
CALL insert_friend(1934, 1661);

DELIMITER //
CREATE TRIGGER auto_inc_highschooler
BEFORE INSERT ON Highschooler 
FOR EACH ROW
BEGIN
	IF NEW.ID is NULL THEN
		SET @maxID = (select id from Highschooler order by id DESC limit 1);
		SET NEW.ID = @maxID + 1;
	END IF;
END; //
DELIMITER ;
-- INSERT INTO Highschooler VALUES(null, 'Test', 10);
-- select * from highschooler;

create view full_friend as 
	select h1.name as name1, h1.grade as grade1, h2.name as name2, h2.grade as grade2 
	from highschooler as h1, friend as f, highschooler as h2 
	where f.id1 = h1.id and f.id2 = h2.id;
-- select * from full_friend;


    




