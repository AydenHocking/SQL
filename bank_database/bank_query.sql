-- 1.
SELECT SUM(amount) AS T_Dep_Amount
FROM transaction
WHERE type = 'Deposit';

-- 2.
SELECT id AS ID, amount AS Amount, tdate AS Tran_Date, type AS Tran_Type, account_num AS Acc_Number
FROM transaction
WHERE account_num = '1111222233331441' AND tdate BETWEEN '2019-09-01' AND '2019-09-30';

-- 3.
SELECT SUM(amount * (tdate < '2019-09-01')) AS Balance
FROM transaction
WHERE account_num = '1111222233331441';
-- 4.
SELECT c.name AS Customer_N, t.amount AS Highest_Dep_Amount
FROM transaction t
JOIN account a ON t.account_num = a.number
JOIN customer c ON a.owner_ssn = c.ssn
WHERE t.type = 'Deposit'
ORDER BY t.amount DESC
LIMIT 1;

-- 5.
SELECT c.name AS Customer_N
FROM customer c
JOIN account a ON c.ssn = a.owner_ssn
WHERE c.sex = 'M' AND a.type = 'Checking';

-- 6.
SELECT a.number AS Acc_Number, a.type AS Acc_Type
FROM account a
JOIN customer c ON a.owner_ssn = c.ssn
WHERE c.name = 'Alexander Felix';

-- 7. 
SELECT
    a.number AS Acc_Number,
    a.type AS Acc_Type,
	(SELECT SUM(amount) FROM transaction WHERE account_num = a.number) AS Balance
FROM
    account a
WHERE
    a.owner_ssn = '724432341';
-- 8A. 
SELECT name AS Customer_N
FROM customer
WHERE ssn IN 
	(SELECT DISTINCT owner_ssn FROM account WHERE number IN 
	(SELECT DISTINCT account_num FROM transaction WHERE amount >= 1000));

-- 8B. 
SELECT DISTINCT c.name AS Customer_N
FROM customer c
JOIN account a ON c.ssn = a.owner_ssn
JOIN transaction t ON a.number = t.account_num
WHERE t.amount >= 1000;

-- 9. 
SELECT c.name AS Customer_N
FROM customer c
JOIN account a ON c.ssn = a.owner_ssn
JOIN transaction t ON a.number = t.account_num
WHERE t.type = 'Deposit'
GROUP BY c.ssn
HAVING COUNT(t.id) >= 2;
