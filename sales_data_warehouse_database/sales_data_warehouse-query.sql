-- 2a) All inexpensive Tshirts sold in California to young people 
 select S.city, I.color, C.cName, F.price
    from Sales F, Store S, Item I, Customer C
    where F.storeID = S.storeID and F.itemID = I.itemID 
    and F.custID = C.custID and S.state = 'CA' 
    and I.category = 'Tshirt' and C.age < 22 and F.price < 25;

-- 2b) Total sales by store ID and customer name 
select storeID, cName, sum(price)
from Sales s, Customer c
where s.custID=c.custID
group by storeID, cName;

-- 2c) Drill-down Total sales by store ID, category, and customer 
select storeID, i.category, cName, sum(price)
from Sales s, Customer c, Item i
where s.custID=c.custID and s.itemID=i.itemID
group by storeID, i.category, cName;

-- 2d) "Slice" Total sales by store ID, category, and customer for "store6" only
select s.storeID, i.category, cName, sum(price)
from Sales s, Customer c, Item i, Store t
where s.custID=c.custID and s.itemID=i.itemID
and s.storeID=t.storeID and t.storeId ='store6'
group by storeID, i.category, cName;

-- 2e) "Dice" Total sales by store ID, category, and customer for "store6" and "Jacket" only
select s.storeID, i.category, cName, sum(price)
from Sales s, Customer c, Item i, Store t
where s.custID=c.custID and s.itemID=i.itemID
and s.storeID=t.storeID and t.storeId ='store6' and i.category='Jacket'
group by storeID, i.category, cName;

-- 2f) Roll-up Total sales by category 
select i.category, sum(price)
from Sales s, Customer c, Item i, Store t
where s.custID=c.custID and s.itemID=i.itemID and s.storeID=t.storeID
group by i.category;

-- 2g) Total sales by state, county, city
select state, county, city, sum(price)
from Sales F, Store S
where F.storeID = S.storeID
group by state, county, city;

-- 2h) Total sales by state, county, city with rollup
select state, county, city, sum(price)
from Sales F, Store S
where F.storeID = S.storeID
group by state, county, city with rollup;

-- 3a) List total sales by state of store and age of customer 
select state, age, sum(price) as total_sales
from Sales sa, Store st, Customer c
where sa.storeID = st.storeID and sa.custID = c.custID
group by state, age;

-- 3b) Drill down to items by item color (on the basis of the previous query)
select state, age, color, sum(price) as total_sales
from Sales sa, Store st, Customer c, item i
where sa.storeID = st.storeID and sa.custID = c.custID
	  and sa.itemID = i.itemID
group by state, age, color;

-- 3c) Use "with rollup" with the previous query 
--    (for the rollup rows the output must match the result of query a)
select state, age, color, sum(price) as total_sales
from Sales sa, Store st, Customer c, item i
where sa.storeID = st.storeID and sa.custID = c.custID
	  and sa.itemID = i.itemID
group by state, age, color with rollup;

-- 3d) Slice by listing only items with blue color (on the basis of query b)
select state, age, color, sum(price) as total_sales
from Sales sa, Store st, Customer c, item i
where sa.storeID = st.storeID and sa.custID = c.custID
	  and sa.itemID = i.itemID and color like 'blue'
group by state, age, color;

-- 3e) Rollup total sales by customer age and item color 
-- 	   (on the basis of query b)- remaining dimensions are customer age and item color 
select age, color, sum(price) as total_sales
from Sales sa, Store st, Customer c, item i
where sa.storeID = st.storeID and sa.custID = c.custID
	  and sa.itemID = i.itemID
group by age, color with rollup;




