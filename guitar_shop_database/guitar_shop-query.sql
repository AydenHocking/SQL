SELECT product_code, product_name, list_price, discount_percent
FROM Products
ORDER BY list_price DESC;

SELECT product_name, list_price, date_added
FROM Products
WHERE list_price > 500 AND list_price < 2000
ORDER BY date_added DESC;

SELECT c.category_name, p.product_name, p.list_price
FROM Categories c, products p
WHERE c.category_id = p.category_id
ORDER BY c.category_name, p.product_name;

SELECT p1.product_name, p1.list_price
FROM Products p1, Products p2
WHERE p1.list_price = p2.list_price AND p1.product_id <> p2.product_id;
    
SELECT order_id, order_date, ship_date
FROM Orders
WHERE ship_date IS NULL;

SELECT CONCAT(c.first_name, ' ', c.last_name) as CustomerName, o.order_date
FROM Orders o, Customers c
WHERE o.customer_id = c.customer_id and YEAR(o.order_date) = 2015 and MONTH(o.order_date) = 4;

SELECT p.product_name, c.category_name, p.list_price
FROM Products p, Categories c
WHERE p.category_id = c.category_id
ORDER BY list_price desc limit 1; -- limit to only display 1 record

SELECT DISTINCT CONCAT(c.first_name, ' ', c.last_name) as customer_name, a.state, YEAR(o.order_date) as year
FROM Customers c, Orders o, Addresses a 
WHERE c.customer_id = a.customer_id = o.customer_id AND (a.state = 'NJ' OR a.state = 'NY') AND YEAR(o.order_date) = 2015;

SELECT SUM(o.tax_amount) as total_tax_paid_NJ
FROM Orders o, Addresses a
WHERE a.address_id = o.billing_address_id AND a.state = 'NJ';

SELECT a.state, SUM(o.ship_amount) as SumShippingCost
FROM Orders o, Addresses a
WHERE a.address_id = o.billing_address_id AND a.state = 'NJ'
union
SELECT a.state, SUM(o.ship_amount) as SumShippingCost
FROM Orders o, Addresses a
WHERE a.address_id = o.billing_address_id AND a.state = 'NY'
union
SELECT a.state, SUM(o.ship_amount) as SumShippingCost
FROM Orders o, Addresses a
WHERE a.address_id = o.billing_address_id AND a.state = 'OR'
union
SELECT a.state, SUM(o.ship_amount) as SumShippingCost
FROM Orders o, Addresses a
WHERE a.address_id = o.billing_address_id AND a.state = 'NE'
union
SELECT a.state, SUM(o.ship_amount) as SumShippingCost
FROM Orders o, Addresses a
WHERE a.address_id = o.billing_address_id AND a.state = 'CA'
union
SELECT a.state, SUM(o.ship_amount) as SumShippingCost
FROM Orders o, Addresses a
WHERE a.address_id = o.billing_address_id AND a.state = 'CO';







