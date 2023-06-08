-- kategoriler ve urunler adında iki tablo olusturun. kategoriler tablosunda kat_id, kat_adi
-- adinda iki adet sütun oluşturun

CREATE TABLE kategoriler
( 
kat_id INT PRIMARY KEY,
kat_isim VARCHAR(20)
);

INSERT INTO kategoriler VALUES(1, 'Bilgisayar');
INSERT INTO kategoriler VALUES(2, 'Telefon');
INSERT INTO kategoriler VALUES(3, 'Televizyon');
INSERT INTO kategoriler VALUES(4, 'Oyun Konsolu');
INSERT INTO kategoriler VALUES(5, 'Ev Aletleri');


CREATE TABLE urunler1
( 
urun_id INT, 
kat_id INT,
urun_isim VARCHAR(25),
urun_fiyat DOUBLE,
stok_miktari INT,
CONSTRAINT urunler1_fk FOREIGN KEY(kat_id)
REFERENCES kategoriler (kat_id)
);


INSERT INTO urunler1 VALUES(1,1, 'Masaustu',25000,10);
INSERT INTO urunler1 VALUES(2,2, 'Iphone 14',40000,15);
INSERT INTO urunler1 VALUES(3,1, 'Hp Laptop',27000,20);
INSERT INTO urunler1 VALUES(4,2, 'Samsung S22',18000,10);
INSERT INTO urunler1 VALUES(5,2, 'Oppo',18000,15);
INSERT INTO urunler1 VALUES(6,3, 'LG',15000,25);
INSERT INTO urunler1 VALUES(7,3,'Philips',16000,20);
INSERT INTO urunler1 VALUES(8,4, 'Xbox',20000,15);
INSERT INTO urunler1 VALUES(9,4, 'Sony',22000,15);

SELECT*FROM kategoriler;
SELECT*FROM urunler1;


-- Iki Tabloda kat_id'si ayni olanlarin kat_adi, urun_id ve 
--  urun_isimlerini listeleyen bir sorgu yaziniz.

SELECT kategoriler.kat_id, kategoriler.kat_isim, urunler1.urun_id, urunler1.urun_isim
FROM kategoriler INNER JOIN urunler1
ON kategoriler.kat_id = urunler1.kat_id;

-- Urunler1 tablosundaki tum urunleri ve bu urunlere ait olan 
--  kat_id ve kat_isimlerini listeleyen bir sorgu yaziniz. 

SELECT urunler1.urun_id, urunler1.urun_isim, kategoriler.kat_id, kategoriler.kat_isim
FROM urunler1 LEFT JOIN kategoriler
ON kategoriler.kat_id = urunler1.kat_id;

-- Kategoriler tablosundaki tum kategorileri ve bu kategorilere ait olan 
-- urun_isim, urun_fiyat ve stok_miktarlarini listeleyen bir sorgu yaziniz.

SELECT kategoriler.kat_id, kategoriler.kat_isim, urunler1.urun_isim, urunler1.urun_fiyat, urunler1.stok_miktari
FROM urunler1 RIGHT JOIN kategoriler
ON kategoriler.kat_id = urunler1.kat_id;

-- Kategoriler ve urunler1 adindaki tablolarda yer alan kat_id, 
-- kat_isim, urun_id ve urun_fiyatlarini listeleyen bir sorgu yaziniz.

SELECT kategoriler.kat_id, kategoriler.kat_isim, urunler1.urun_id, urunler1.urun_fiyat
FROM urunler1 RIGHT JOIN kategoriler
ON kategoriler.kat_id = urunler1.kat_id

UNION

SELECT kategoriler.kat_id, kategoriler.kat_isim, urunler1.urun_id, urunler1.urun_fiyat
FROM urunler1 LEFT JOIN kategoriler
ON kategoriler.kat_id = urunler1.kat_id;

-- Televizyon ve Oyun Konsolu kategorilerinde bulunan urunlerin isimlerini ve 
-- fiyatlarini, fiyat sirali olarak listeleyiniz

SELECT urunler1.urun_isim, urunler1.urun_fiyat
FROM kategoriler LEFT JOIN urunler1
ON kategoriler.kat_id = urunler1.kat_id
WHERE kat_isim IN('Televizyon','Oyun Konsolu')
ORDER BY urun_fiyat;

-- Tum urunlerin isimlerini, fiyatlarini ve 
-- stok miktarlarini stok miktari ters ve urun fiyati sirali listeleyiniz. 
-- NOT: Urun ismi olmasa bile kategori ismi gosterilsin.

SELECT urunler1.urun_isim, urunler1.urun_fiyat, urunler1.stok_miktari
FROM kategoriler LEFT JOIN urunler1
ON kategoriler.kat_id = urunler1.kat_id
ORDER BY stok_miktari DESC, urun_fiyat ;
