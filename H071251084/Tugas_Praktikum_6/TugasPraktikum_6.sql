SET search_path TO classicmodels;

SELECT * FROM classicmodels.employees;
SELECT * FROM classicmodels.customers;
SELECT * FROM classicmodels.offices;
SELECT * FROM classicmodels.orders;
SELECT * FROM classicmodels.orderdetails;
SELECT * FROM classicmodels.products;
SELECT * FROM classicmodels.productlines;
SELECT * FROM classicmodels.payments;

-- 01
SELECT 
	productcode,
	productname,
	msrp AS harga_eceran, 
	quantityInStock AS stok_tersedia,
	CASE
		WHEN msrp < 50 AND quantityInStock > 500 THEN 'Harga Ekonomis - Stok Tinggi'
		WHEN msrp < 50 AND quantityInStock <= 500 THEN 'Harga Ekonomis - Stok Rendah'
		WHEN (msrp BETWEEN 50 AND 100) AND quantityInStock > 500 THEN 'Harga Menengah - Stok Tinggi'
		WHEN (msrp BETWEEN 50 AND 100) AND quantityInStock <= 500 THEN 'Harga Menengah - Stok Rendah'
		WHEN msrp >= 100 AND quantityInStock <= 500 THEN 'Harga Premium - Stok Rendah'
		ELSE 'Harga Premium - Stok Tinggi'
	END AS karakteristik
FROM classicmodels.products 
ORDER BY msrp DESC;

-- 02
SELECT 
	productCode,
	SUM(quantityordered) AS total_ordered,
	COUNT(DISTINCT ordernumber) AS banyak_pemesanan
FROM orderdetails
GROUP BY productCode
HAVING SUM(quantityOrdered) > (
	SELECT AVG(quantityOrdered) 
	FROM classicmodels.orderdetails
) AND
	COUNT(DISTINCT ordernumber) > 10
ORDER BY total_ordered DESC;

-- 03
SELECT 
	productCode,
	productName,
	quantityInstock,
	msrp
FROM classicmodels.products
WHERE quantityInStock > (
	SELECT AVG(quantityInStock)
	FROM products
) AND msrp > (
	SELECT AVG(msrp)
	FROM products
)
ORDER BY quantityInStock DESC;

-- 04
BEGIN;

UPDATE orders
SET status = 'Shipped'
WHERE ordernumber = '10100'

SAVEPOINT status_pengiriman;

UPDATE orders
SET status = 'Cancelled'
WHERE ordernumber = '10100'

SELECT * FROM orders 
WHERE ordernumber = 10100;

ROLLBACK TO SAVEPOINT status_pengiriman;

COMMIT;


-- 05 
CREATE DATABASE praktikumPraktikum2;


CREATE TABLE anggota (
	idAnggota BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	namaAnggota VARCHAR(50) NOT NULL,
	kotaDomisili VARCHAR(20) NOT NULL
);

CREATE TABLE buku (
	idBuku BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	judul VARCHAR(100) NOT NULL,
	genre VARCHAR(20) NOT NULL,
	stok INT DEFAULT 1
);

CREATE TABLE peminjaman (
	idPeminjaman INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	idAnggota INT,
	CONSTRAINT fk_anggota_peminjaman
		FOREIGN KEY (idAnggota)
		REFERENCES anggota(idAnggota),
	idBuku INT,
	CONSTRAINT fk_buku_dipinjam
		FOREIGN KEY (idBuku)
		REFERENCES buku(idBuku),
	tanggalPinjam DATE NOT NULL,
	tanggalKembali DATE,
	denda INT DEFAULT 0
);

CREATE INDEX cariGenre
ON buku(genre);

CREATE INDEX cariDomisi
ON anggota(kotaDomisili);


-- 
SELECT * FROM buku;
SELECT genre FROM buku;

-- 
DROP INDEX cariGenre;
DROP INDEX cariDomisili;

DROP TABLE anggota;
DROP TABLE buku;
DROP TABLE peminjaman;

DROP DATABASE praktikumPraktikum2;





