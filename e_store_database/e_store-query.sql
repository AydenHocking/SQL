SHOW COLUMNS FROM e_store.products;
SHOW COLUMNS FROM e_store.reviews;

SELECT * FROM e_store.products;

SELECT MIN(price)
FROM e_store.products;

SELECT MIN(price) AS minimum_product_price
FROM e_store.products;

SELECT * FROM e_store.reviews;

SELECT MIN(stars) AS lowest_star,product_id
FROM e_store.reviews
WHERE product_id = 4;

SELECT
MIN(price) AS product_min_price,
MAX(price) AS product_max_price
FROM e_store.products
WHERE id <= 5;

SELECT products.id, name, AVG(stars) AS stars_avg
FROM products JOIN reviews
ON products.id = reviews.product_id
WHERE product_id = 1;

SELECT products.id, name, stars
FROM products JOIN reviews
ON products.id = reviews.product_id;

SELECT products.id, name, AVG(stars)
FROM products JOIN reviews
ON products.id = reviews.product_id
WHERE reviews.product_id = 2 OR reviews.product_id = 4;
-- WHERE products.name = 'Smartphone' OR products.name = 'Headphones';SELECT products.id, name, AVG(stars)

SELECT products.id, name, AVG(stars)
FROM products JOIN reviews
ON products.id = reviews.product_id
WHERE reviews.product_id = 2 OR reviews.product_id = 4
GROUP BY products.id;

SELECT name, AVG(stars)
FROM products JOIN reviews
ON products.id = reviews.product_id
WHERE reviews.product_id = 2; 
-- OR WHERE products.name = 'Smartphone';

SELECT name, AVG(stars)
FROM products JOIN reviews
ON products.id = reviews.product_id
WHERE reviews.product_id = 4;

SELECT AVG(stars)
FROM products JOIN reviews
ON products.id = reviews.product_id
WHERE reviews.product_id = 2 OR reviews.product_id = 4;

SELECT products.id, name, AVG(stars)
FROM products JOIN reviews
ON products.id = reviews.product_id
WHERE reviews.product_id = 2 OR reviews.product_id = 4;

SELECT products.id, name, AVG(stars) AS avg_stars
FROM products JOIN reviews
ON products.id = reviews.product_id
GROUP BY products.id;

SELECT products.id, name, AVG(stars) AS avg_stars
FROM products JOIN reviews
ON products.id = reviews.product_id
WHERE products.name = 'Smartphone'
OR products.name = 'Headphones'
GROUP BY products.name;

insert into products values(7, 'Smartphone', 90.80, 9, '2015-10-04');

SELECT products.id, name, stars
FROM products JOIN reviews
ON products.id = reviews.product_id
WHERE reviews.product_id = 2 OR reviews.product_id = 4;

select products.id, name, avg(stars) as avg_stars
from products join reviews
on products.id = reviews.product_id
where products.id = 2 or products.id = 4
group by(products.id);

Select name, avg(stars) as avg_stars
from products join reviews
on products.id = reviews.product_id
where products.id = 2 or products.id = 4
group by(products.name);

select products.id, name, avg(stars) as avg_stars
from products join reviews
on products.id = reviews.product_id
where products.id = 2 or products.id = 4
group by(products.name);

SELECT products.id, name, AVG(stars) AS avg_stars
FROM products JOIN reviews
ON products.id = reviews.product_id
GROUP BY products.id;

SELECT products.id, name, AVG(stars) AS avg_stars
FROM products JOIN reviews
ON products.id = reviews.product_id
GROUP BY products.id HAVING avg_stars > 3;

SELECT products.id, products.name, AVG(stars) AS avg_stars
FROM products JOIN reviews
ON products.id = reviews.product_id
WHERE products.id < 6
GROUP BY products.id
HAVING avg_stars < 4;

SELECT products.id, products.name, AVG(stars) AS avg_stars
FROM products JOIN reviews
ON products.id = reviews.product_id
where (avg_stars < 4);