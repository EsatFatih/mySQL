-- id, isim ve irtibat fieldlarinin oldugu bir tedarik tablosu olusturun.
-- id field'ini Primary Key yapin.
CREATE TABLE tedarik
(
id INT PRIMARY KEY,
isim VARCHAR(10),
irtibat VARCHAR(15)
);
-- tedarikci_id , urun_id , urun_isim , musteri_isim  fieldlari olan urun 
-- tablosu olusturun. Bu tablodaki tedarikci_id fieldini tedarik tablosunun
-- PK 'si ile Foreign Key yapin.
CREATE TABLE urun
(
tedarikci_id INT,
urun_id INT,
urun_isim VARCHAR(10),
musteri_isim VARCHAR(15),
CONSTRAINT urun_fk FOREIGN KEY (tedarikci_id)
REFERENCES tedarik (id)
);
INSERT INTO tedarik VALUES(100, 'IBM', 'Ali Can'); 
INSERT INTO tedarik VALUES(101, 'APPLE', 'Merve Temiz'); 
INSERT INTO tedarik VALUES(102, 'SAMSUNG', 'Kemal Can'); 
INSERT INTO tedarik VALUES(103, 'LG', 'Ali Can');

INSERT INTO urun VALUES(100, 1001,'Laptop', 'Suleyman'); 
INSERT INTO urun VALUES(101, 1002,'iPad', 'Fatma'); 
INSERT INTO urun VALUES(102, 1003,'TV', 'Ramazan'); 
INSERT INTO urun VALUES(103, 1004,'Phone', 'Ali Can');
SELECT * FROM tedarik;
SELECT * FROM urun;

-- 'LG' firmasinda calisan 'Ali Can'in ismini 'Veli Can' olarak degistiriniz.

UPDATE tedarik
SET irtibat = 'Veli Can'
WHERE isim = 'LG';

/*
a) Urun tablosundan Ali Can'in aldigi urunun ismini, 
tedarik tablosunda irtibat Merve Temiz olan 
sirketin ismi ile degistirin. */

-- 1. Adim : Ali Can'in aldigi urunun ismini Apple olarak degistirin

UPDATE urun
SET urun_isim='APPLE'
WHERE musteri_isim ='Ali Can';

-- 2. Adim : Irtibat'i Merve Temiz olan kaydin sirket ismini getirin

SELECT isim
FROM tedarik
WHERE irtibat ='Merve Temiz';

-- 3. Adim : iki sorguyu birlestiriyoruz

UPDATE urun
SET urun_isim=(SELECT isim
			   FROM tedarik
			   WHERE irtibat ='Merve Temiz')
WHERE musteri_isim ='Ali Can';

/*-------------------------------------------------------------------------
b) TV satin alan musterinin ismini, 
IBM'in irtibat'i ile degistirin.
-------------------------------------------------------------------------*/
UPDATE urun
SET musteri_isim=(SELECT irtibat
			   FROM tedarik
			   WHERE isim ='IBM')
WHERE urun_isim ='TV';

-- ****************************************************************************************

/*-------------------------------------------------------------------------
1) Lise tablosu olusturun.
 Icinde id,isim,veli_isim ve grade field'lari olsun. 
 Id field'i Primary Key olsun.
 --------------------------------------------------------------------------*/
 /*-------------------------------------------------------------------------
 2)  Kayitlari tabloya ekleyin.
 (123, 'Ali Can', 'Hasan',75), 
 (124, 'Merve Gul', 'Ayse',85), 
 (125, 'Kemal Yasa', 'Hasan',85),
 (126, 'Rumeysa Aydin', 'Zeynep',85);
 (127, 'Oguz Karaca', 'Tuncay',85);
 (128, 'Resul Can', 'Tugay',85);
 (129, 'Tugay Kala', 'Osman',45);
 --------------------------------------------------------------------------*/
 
 CREATE TABLE lise
 (
 id INT PRIMARY KEY,
 isim VARCHAR(20),
 veli_isim VARCHAR(20),
 grade VARCHAR(15)
 );
 
 SELECT*FROM lise;
 
 INSERT INTO lise VALUES(123, 'Ali Can', 'Hasan',75);
 INSERT INTO lise VALUES(124, 'Merve Gul', 'Ayse',85);
 INSERT INTO lise VALUES(125, 'Kemal Yasa', 'Hasan',85);
 INSERT INTO lise VALUES(126, 'Rumeysa Aydin', 'Zeynep',85);
 INSERT INTO lise VALUES(127, 'Oguz Karaca', 'Tuncay',85);
 INSERT INTO lise VALUES(128, 'Resul Can', 'Tugay',85);
 INSERT INTO lise VALUES(129, 'Tugay Kala', 'Osman',45);
 
 /*-------------------------------------------------------------------------
3)deneme_puani tablosu olusturun. 
ogrenci_id, ders_adi, yazili_notu field'lari olsun, 
ogrenci_id field'i Foreign Key olsun 
--------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------
4) deneme_puani tablosuna kayitlari ekleyin
 ('123','kimya',75), 
 ('124','fizik',65),
 ('125','tarih',90),
 ('126','kimya',87),
 ('127','tarih',69),
 ('128','kimya',93),
 ('129','fizik',25)
--------------------------------------------------------------------------*/

CREATE TABLE deneme_puani
(
ogrenci_id INT,
ders_adi VARCHAR(25),
yazili_notu INT,
CONSTRAINT denemepuani_fk FOREIGN KEY(ogrenci_id)
REFERENCES lise (id)
);

SELECT*FROM deneme_puani;

 INSERT INTO deneme_puani VALUES(123,'kimya',75);
 INSERT INTO deneme_puani VALUES(124,'fizik',65);
 INSERT INTO deneme_puani VALUES(125,'tarih',90);
 INSERT INTO deneme_puani VALUES(126,'kimya',87);
 INSERT INTO deneme_puani VALUES(127,'tarih',69);
 INSERT INTO deneme_puani VALUES(128,'kimya',93);
 INSERT INTO deneme_puani VALUES(129,'fizik',25);
 
/*-------------------------------------------------------------------------
5) Ismi Resul Can olan ogrencinin notunu notlar tablosundaki 
ogrenci id'si 129 olan yazili notu ile update edin. 
--------------------------------------------------------------------------*/

UPDATE lise
SET grade = (SELECT yazili_notu
		   FROM deneme_puani
           WHERE ogrenci_id=129)
WHERE isim = 'Resul Can';

/*-------------------------------------------------------------------------
6) Ders adi fizik olan kayitlarin yazili notunu Oguz Karaca'nin grade'i
ile update edin. 
--------------------------------------------------------------------------*/
UPDATE deneme_puani
SET yazili_notu = (SELECT grade
		           FROM lise
                   WHERE isim='Oguz Karaca')
WHERE ders_adi = 'fizik';


/*-------------------------------------------------------------------------
7) Ali Can'in grade'ini, 124 ogrenci_id'li yazili_notu ile guncelleyin.
--------------------------------------------------------------------------*/
UPDATE lise
SET grade = (SELECT yazili_notu
		   FROM deneme_puani
           WHERE ogrenci_id=124)
WHERE isim = 'Ali Can';

/*-------------------------------------------------------------------------
8) Ders adi Kimya olan yazili notlarini Rumeysa Aydin'in 
grade'i ile guncelleyin.
--------------------------------------------------------------------------*/
UPDATE deneme_puani
SET yazili_notu = (SELECT grade
		           FROM lise
                   WHERE isim ='Rumeysa Aydin')
WHERE ders_adi = 'kimya';


/*-------------------------------------------------------------------------
9) Ders adi tarih olan yazili notlarini Resul Can'in 
grade'i ile guncelleyin.
--------------------------------------------------------------------------*/
UPDATE deneme_puani
SET yazili_notu = (SELECT grade
		           FROM lise
                   WHERE isim ='Resul Can')
WHERE ders_adi = 'tarih';

/*-------------------------------------------------------------------------
10) Ders adi fizik olan yazili notlarini veli adi Tuncay olan 
grade ile guncelleyin.
--------------------------------------------------------------------------*/
UPDATE deneme_puani
SET yazili_notu = (SELECT grade
		   FROM lise
           WHERE veli_isim ='Tuncay')
WHERE ders_adi = 'fizik';

/*-------------------------------------------------------------------------
11) Tum ogencilerin gradelerini deneme_puani tablosundaki yazili_notu ile update edin. 
--------------------------------------------------------------------------*/

UPDATE lise
SET grade = (SELECT yazili_notu
		   FROM deneme_puani
           WHERE deneme_puani.ogrenci_id=lise.id);
           
-- ****************************************************************************

/*------------------------------------------------------------------------
Mart_satislar isimli bir tablo olusturun, 
icinde urun_id, musteri_isim, urun_isim ve urun_fiyat field'lari olsun
1) Ismi hatice olan musterinin urun_id'sini 30,urun_isim'ini Ford yapin 
2) Toyota marka araclara %10 indirim yapin 
3) Ismi Ali olanlarin urun_fiyatlarini %15 artirin 
4) Honda araclarin urun id'sini 50 yapin.
--------------------------------------------------------------------------*/
CREATE TABLE mart_satislar 
(
 urun_id int,
 musteri_isim varchar(20),
 urun_isim varchar(10),
 urun_fiyat int 
);
INSERT INTO mart_satislar VALUES (10, 'Ali', 'Honda',75000); 
INSERT INTO mart_satislar VALUES (10, 'Ayse', 'Honda',95200); 
INSERT INTO mart_satislar VALUES (20, 'Hasan', 'Toyota',107500); 
INSERT INTO mart_satislar VALUES (30, 'Mehmet', 'Ford', 112500); 
INSERT INTO mart_satislar VALUES (20, 'Ali', 'Toyota',88000); 
INSERT INTO mart_satislar VALUES (10, 'Hasan', 'Honda',150000); 
INSERT INTO mart_satislar VALUES (40, 'Ayse', 'Hyundai',140000); 
INSERT INTO mart_satislar VALUES (20, 'Hatice', 'Toyota',60000);

SELECT * FROM mart_satislar;

-- 1) Ismi hatice olan musterinin urun_id'sini 30, urun_isim'ini Ford yapin 

UPDATE mart_satislar
SET urun_id =30 , urun_isim= 'Ford'
WHERE musteri_isim='Hatice';

-- 2) Toyota marka araclara %10 indirim yapin 

UPDATE mart_satislar
SET urun_fiyat =urun_fiyat*0.9
WHERE urun_isim='Toyota';

-- 3) Ismi A ile baslayan butun musterilerin urun_fiyatlarini %15 artirin

UPDATE mart_satislar
SET urun_fiyat =urun_fiyat*1.15
WHERE musteri_isim LIKE 'A%';

-- 4) Honda araclarin urun id'sini 50 yapin.

UPDATE mart_satislar
SET urun_id =50
WHERE urun_isim='Honda';




