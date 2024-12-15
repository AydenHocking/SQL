/*
#1
Filters all emploees fname and lname
based on their left-most char of each,
Displays fname, lname if char match AJ.
*/
SELECT emp.fname, emp.lname, 'Ayden_Hocking' AS Ayden_Hocking
FROM employee emp
WHERE CONCAT(LEFT(emp.fname, 1), LEFT(emp.lname, 1)) = 'AJ';
/*
#2
Joins department and employee ssn based on department mgrssn,
Filters for department dname Hardware,
Displays fname, lname, salary.
*/
SELECT emp.fname, emp.lname, emp.salary, 'Ayden_Hocking' AS Ayden_Hocking
FROM employee emp
JOIN department dep ON emp.dno = dep.dnumber
WHERE dep.dname = 'Hardware';
/*
#3
Joins works_on and employee ssn based on works_on ssn,
Joins project and works_on pno based on project pnumber,
Filters for project pname being ProjectX,
Displays fname, lname, salary.
*/
SELECT emp.fname, emp.lname, emp.salary, 'Ayden_Hocking' AS Ayden_Hocking
FROM employee emp
JOIN works_on wo ON emp.ssn = wo.essn
JOIN project proj ON wo.pno = proj.pnumber
WHERE proj.pname = 'ProductX';
/*
#4
Calculates 5% of employees salary and adds all results
together into 1 result labeled total401k.
*/
SELECT SUM(emp.salary * 0.05) AS total401k, 'Ayden_Hocking' AS Ayden_Hocking
FROM employee emp;
/*
#5
Joins project and works_on pno based on 
project pnumber, Filters for project pname 
being ProjectX, Adds total number of works_on hours for ProjectX.
*/
SELECT SUM(wo.hours) AS total_hours, 'Ayden_Hocking' AS Ayden_Hocking
FROM works_on wo
JOIN project proj ON wo.pno = proj.pnumber
WHERE proj.pname = 'ProductX';
/*
#6
Joins department and employee dno based on departments
dnumber, filters for sex(f), lists in descending order,
limits results to row 1.
*/
SELECT emp.fname, emp.lname, dep.dname AS department_name, emp.salary, 'Ayden_Hocking' AS Ayden_Hocking
FROM employee emp
JOIN department dep ON emp.dno = dep.dnumber
WHERE emp.sex = 'F'
ORDER BY emp.salary DESC
LIMIT 1;