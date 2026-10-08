-- 1
SELECT
	orderNumber,
	UPPER(productCode) AS "Kode Produk",
	quantityOrdered,
	priceEach
FROM classicmodels.orderdetails
WHERE (quantityordered BETWEEN 20 AND 50 OR priceeach <30) AND LEFT(productcode, 3) ILIKE 'S18%'
ORDER BY quantityordered DESC;

-- 2
SELECT 
	customerNumber, 
	customerName, 
	country, 
	CONCAT(contactFirstName, ' ', contactLastName) AS "Nama Kontak",
	creditLimit,
	creditLimit - 10000 AS "Selisih Kredit"
FROM classicmodels.customers
WHERE country IN ('USA', 'Canada', 'France') AND creditLimit > 30000
ORDER BY creditLimit DESC;

-- 3
SELECT 
	productCode, 
	productName, 
	buyPrice, 
	msrp, 
	GREATEST(buyPrice, msrp) AS "Harga Tertinggi", 
	LEAST(buyPrice, msrp) AS "Harga Terendah"
FROM classicmodels.products
WHERE productName ILIKE '%car%'

-- 4
SELECT 
	orderNumber, 
	orderDate,
	shippedDate,
	EXTRACT(YEAR FROM orderDate) AS "Tahun",
	EXTRACT(MONTH FROM orderDate) AS "Bulan",
	shippedDate - orderDate AS "Lama Pengiriman",
	AGE(shippedDate, orderDate) AS "Interval Pengiriman",
	CURRENT_DATE AS "Tanggal Laporan",
	CURRENT_TIME AS "Waktu Laporan"
FROM classicmodels.orders
WHERE shippedDate IS NOT NULL

-- 5
SELECT 
	orderNumber,
	orderDate,
	shippedDate,
	orderDate + INTERVAL '10 days' AS "Estimasi Kirim",
	COALESCE(shippedDate, orderDate + INTERVAL '10 days') AS "Tanggal Aktual",
	AGE(shippedDate, orderDate) AS "Selisih Waktu"
FROM classicmodels.orders
WHERE comments ILIKE '%customer%' AND (EXTRACT(MONTH FROM orderDate) BETWEEN 10 AND 12) AND orderNumber % 2 = 1
ORDER BY orderDate DESC;

