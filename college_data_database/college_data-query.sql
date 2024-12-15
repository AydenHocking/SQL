#1
SELECT MIN(s.GPA) AS Lowest_GPA, MAX(s.GPA) AS Highest_GPA
FROM Student s
JOIN Apply a ON s.sID = a.sID
WHERE a.major = 'CS';


#2
SELECT MAX(s.GPA) - MIN(s.GPA) AS The_spread
FROM Student s;

#3
SELECT MIN(GPA), MAX(GPA), apply.cName, apply.major
FROM student, apply
WHERE student.sID = apply.sID
group by cName, major;

#4
SELECT state, SUM(enrollment)
FROM College
group by state;

#5
SELECT AVG(subquery.GPA) AS avgGPA_CS
FROM (SELECT s.GPA FROM Student s
JOIN Apply a ON s.sID = a.SID
WHERE a.major = 'CS') AS subquery;

#6

Select
(Select avg(GPA)
From Student
Where sID in (Select sID
From Apply
Where major='CS'))
-
(Select avg(GPA)
From Student
Where sID not in (Select sID
From Apply
Where major='CS'));

#7
SELECT COUNT(*) AS NumberOfRows
FROM Student;

#8
SELECT COUNT(DISTINCT siD) AS NumberOfStudents
FROM Apply
WHERE cName = 'Cornell';

#9a
SELECT sID, COUNT(DISTINCT cName) AS NumberOfCollegesApplied
FROM Apply
GROUP BY sID;

#9b without 0
SELECT s.sName, s.sID, COUNT(DISTINCT a.cName) AS NumberOfCollegesApplied
FROM Student s
JOIN Apply a ON s.sID = a.sID
group by s.sID, s.sName;



#10
SELECT cName, COUNT(*) AS num_applications
FROM Apply
GROUP BY cName
HAVING COUNT(*) < 5;



#11
SELECT * FROM Student;
Insert into Student values (432, 'Kevin', null, 1500);
Insert into Student values (321, 'Lori', null, 2500);
SELECT * FROM Student;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM Student WHERE GPA is null;
SELECT count(GPA)
FROM Student;
SELECT count(*)
FROM Student;


