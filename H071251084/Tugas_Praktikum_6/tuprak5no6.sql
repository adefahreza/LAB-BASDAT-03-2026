
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

SELECT *
-- 
DROP INDEX cariGenre;
DROP INDEX cariDomisi;

DROP TABLE anggota;
DROP TABLE buku;
DROP TABLE peminjaman;








