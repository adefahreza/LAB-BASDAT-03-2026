SET search_path TO classicmodels;

-- SELECT * FROM payments;
-- SELECT * FROM customers;
-- SELECT * FROM products;
-- SELECT * FROM orders;
-- SELECT * FROM orderdetails;
-- SELECT * FROM employees;
-- SELECT * FROM offices;

-- 1
SELECT 
	customerNumber AS "Nomor Pelanggan",
	SUM(amount) AS "Total Pembayaran",
	COUNT(*) AS "Jumlah Frekuensi",
	MAX(amount) AS "Setoran Terbesar"
FROM classicmodels.payments
GROUP BY customerNumber
HAVING COUNT(*) > 4 AND AVG(amount) > 20000;

-- 2
SELECT
	customerNumber AS "Nomor Pelanggan",
	SUM(amount) AS "Total Dana"
FROM classicmodels.payments
GROUP BY customerNumber
HAVING SUM(amount) > 80000
ORDER BY SUM(amount) DESC

-- 3
SELECT 
	productLine AS "Kategori",
	COUNT(*) AS "Jumlah per Kategori",
	ROUND(AVG(buyPrice), 2) AS "Rata Rata",
	STRING_AGG(productName, ', ' ORDER BY productName) AS "Nama Produk"
FROM classicmodels.products
GROUP BY productLine
HAVING COUNT(productLine) > 10

-- 4
SELECT DISTINCT reportsto AS "Nomor Identitas"
FROM classicmodels.employees
WHERE reportsto IS NOT NULL
EXCEPT
SELECT DISTINCT employeeNumber FROM classicmodels.employees
WHERE jobtitle LIKE 'VP%' OR jobtitle LIKE 'President%'

-- 5
SELECT 
	productCode AS "Kode Produk",
	SUM(quantityOrdered) AS "Total Unit Terjual",
	ROUND(AVG(priceEach), 2) AS "Harga Rata Rata"
FROM classicmodels.orderdetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY SUM(quantityOrdered) DESC

-- 6
SELECT
	productCode AS "Produk Kode",
	SUM(quantityOrdered) AS "Total Unit Terjual",
	SUM(quantityOrdered * priceEach) AS "Pendapatan Kotor",
	ROUND(AVG(priceEach), 2) AS "Harga Rata Rata",
	MAX(priceEach) - MIN(priceEach) AS "Rentang Volatilitas"
FROM classicmodels.orderdetails
WHERE quantityOrdered > 20
GROUP BY productCode
HAVING SUM(quantityOrdered * priceEach) > 50000
ORDER BY SUM(quantityOrdered * priceEach) DESC

-- 7
SELECT customerNumber FROM classicmodels.customers
WHERE creditlimit > 80000
INTERSECT
SELECT customerNumber FROM classicmodels.orders
WHERE status IN ('Cancelled', 'On Hold')
EXCEPT
SELECT customerNumber FROM classicmodels.payments
GROUP BY customerNumber
HAVING SUM(amount) > 100000



-- noo 7
SELECT customerNumber FROM customers
WHERE creditlimit > 80000
INTERSECT
SELECT customerNumber FROM orders
WHERE status IN ('Cancelled', 'On Hold')
EXCEPT
SELECT customerNumber FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 100000;





-- 

























