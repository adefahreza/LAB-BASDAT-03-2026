SET search_path TO classicmodels;

SELECT * FROM classicmodels.employees AS e;
SELECT * FROM classicmodels.customers AS c;
SELECT * FROM classicmodels.offices;
SELECT * FROM classicmodels.orders;
SELECT * FROM classicmodels.orderdetails;
SELECT * FROM classicmodels.products;
SELECT * FROM classicmodels.productlines;
SELECT * FROM classicmodels.payments;

-- 1
SELECT 
	c.contactfirstname, 
	c.customername, 
	of.city,
	CONCAT(e.firstname, ' ', e.lastname) AS sales_rep_name
FROM classicmodels.customers AS c
JOIN classicmodels.employees AS e
	ON c.salesrepemployeenumber = e.employeenumber
JOIN classicmodels.offices AS of
	ON of.officecode = e.officecode
WHERE c.contactfirstname ILIKE 'A%' AND of.city != 'NYC'
ORDER BY c.customername ASC;	

-- 2
SELECT 
	c.customername,
	SUM(py.amount) AS total_payment,
	MAX(py.amount) AS max_single_payment
FROM classicmodels.customers AS c
JOIN classicmodels.payments AS py
ON py.customernumber = c.customernumber
GROUP BY c.customername
HAVING SUM(py.amount) > 50000
ORDER BY SUM(py.amount) DESC

-- 3
SELECT
	c.customername,
	COUNT(o.ordernumber) AS total_order,
	ROUND(AVG(od.quantityordered), 2) AS avg_quantity_per_order
FROM classicmodels.customers AS c
JOIN classicmodels.orders AS o
ON o.customernumber = c.customernumber
JOIN classicmodels.orderdetails AS od
ON od.ordernumber = o.ordernumber
GROUP BY c.customername
HAVING COUNT(o.ordernumber) > 3 AND ROUND(AVG(od.quantityordered), 2) > 35
ORDER BY total_order DESC, avg_quantity_per_order DESC;

SELECT * FROM orders;

-- 4
SELECT 
	pl.productline AS productLine, 
	SUM(od.quantityordered) AS total_terjual,
	ROUND(AVG(od.priceeach), 2) AS rata_rata_harga,
	ROUND(AVG((p.msrp - od.priceEach) / p.msrp * 100), 2) AS avg_discount_percentage
FROM classicmodels.productlines AS pl
JOIN classicmodels.products AS p
ON p.productline = pl.productline
JOIN classicmodels.orderdetails AS od
ON od.productcode = p.productcode
GROUP BY pl.productline
HAVING SUM(od.quantityordered) > 3000 AND ROUND(AVG(od.priceeach), 2) > 80
ORDER BY total_terjual DESC;

SELECT * FROM orderdetails;
SELECT * FROM products;

-- 
-- 5
SELECT 
	c.customername, 
	SUM(od.quantityordered * od.priceeach) AS total_transaksi, 
	COUNT(DISTINCT o.orderNumber) AS total_shipped_orders, 
	ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber), 2) AS avg_transaction_per_order
FROM classicmodels.customers AS c
JOIN classicmodels.orders AS o
ON c.customerNumber = o.customerNumber
JOIN classicmodels.orderdetails AS od
ON o.orderNumber = od.orderNumber
WHERE o.status = 'Shipped'
GROUP BY c.customerNumber, c.customername
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderDate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

-- 6
SELECT 
	c.customerName, 
	c.city AS customer_city, 
	of.city AS office_city, 
	SUM(od.quantityOrdered) AS total_unit_terjual, 
	ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber), 2) AS avg_nilaiper_order
FROM classicmodels.customers AS c
JOIN classicmodels.employees AS e
	ON c.salesrepemployeenumber = e.employeenumber
JOIN classicmodels.offices AS of
	ON e.officeCode = of.officeCode
JOIN classicmodels.orders AS o
	ON c.customerNumber = o.customerNumber
JOIN classicmodels.orderdetails AS od
	ON o.orderNumber = od.orderNumber
WHERE of.territory = 'EMEA' 
GROUP BY c.customerNumber, of.city
HAVING COUNT(DISTINCT EXTRACT(year FROM o.orderDate)) > 2 
	AND SUM(od.quantityOrdered) > 1000 
	AND SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber) > 10000;

-- 
SELECT * FROM orderdetails;






