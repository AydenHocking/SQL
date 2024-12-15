#1

 SELECT * FROM Person WHERE gender = 'male' AND age > 18;

#2
SELECT name FROM Person WHERE gender = 'female' AND age >= 30;

#3
SELECT DISTINCT P.name
FROM Person P, Eats E
WHERE P.name = E.name
  AND P.gender = 'male' AND P.age > 20 AND E.pizza = 'cheese';
 
 
#4
SELECT pizzeria
FROM Serves
WHERE price >= 9;

SELECT DISTINCT pizzeria
FROM Serves
WHERE pizzeria NOT IN
  (SELECT DISTINCT pizzeria
   FROM Serves
   WHERE price >= 9);
   
#5   
SELECT pizzeria
FROM Serves
WHERE price < 9;

SELECT DISTINCT pizzeria
FROM Serves
WHERE pizzeria NOT IN
  (SELECT DISTINCT pizzeria
   FROM Serves
   WHERE price < 9);
   
   #6A
SELECT DISTINCT E.pizza
FROM Eats AS E
JOIN Person AS P ON E.name = P.name
JOIN Serves AS S ON E.pizza = S.pizza
WHERE P.gender = 'female'
AND P.age > 20
AND S.price > 9;

#6B
SELECT pizza
FROM Serves
WHERE price > 9
AND pizza IN (
    SELECT E.pizza
    FROM Eats AS E
    JOIN Person AS P ON E.name = P.name
    WHERE P.gender = 'female'
    AND P.age > 20
);

#7A
SELECT name
FROM Frequents
WHERE pizzeria = 'Dominos';

#7B
SELECT DISTINCT E.name
FROM Eats AS E
JOIN Serves AS S ON E.pizza = S.pizza
WHERE S.pizzeria = 'Dominos'
AND E.name NOT IN (
    SELECT DISTINCT name
    FROM Frequents
    WHERE pizzeria = 'Dominos'
);

#8A
SELECT pizza
FROM Eats
JOIN Person ON Eats.name = Person.name
WHERE age > 24;

#8B
SELECT DISTINCT pizza
FROM Eats
WHERE pizza NOT IN (
    SELECT DISTINCT pizza
    FROM Eats
    JOIN Person ON Eats.name = Person.name
    WHERE age > 24
);





