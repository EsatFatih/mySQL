/* ====================================== UPDATE ========================================
Tabloda varolan herhangi bir record'a ait verinin degistirilmesi icin kullanilir.
-----Syntax-----
UPDATE table_name
SET field1=''
WHERE condition;
UPDATE islemlerinin yapilabilmesi icin Ayarlar -> SQL Editor -> "Safe Updates" check box'indaki
tik isaretini kaldirip kaydetmemiz gerekiyor, sonrasinda MySQL'i kapatip tekrar acmaliyiz
========================================================================================*/

/*--------------------------------------------------------------------------------------
1) Bir firmalar tablosu olusturun icinde id,
isim ve iletisim_isim field'lari olsun. 
Id ve isim'i beraber Primary Key yapin.
---------------------------------------------------------------------------------------*/
CREATE TABLE firmalar
(
id INT,
isim VARCHAR(20),
iletisim_isim VARCHAR(20),
CONSTRAINT firmalar_pk PRIMARY KEY (id, isim)
);
/*--------------------------------------------------------------------------------------
2) Icine 3 kayit ekleyin :
(1, 'ACB', 'Ali Can'), 
(2, 'RDB', 'Veli Gul'), 
(3, 'KMN', 'Ayse Gulmez').
---------------------------------------------------------------------------------------*/
INSERT INTO firmalar VALUES 
(1, 'ACB', 'Ali Can'), 
(2, 'RDB', 'Veli Gul'), 
(3, 'KMN', 'Ayse Gulmez');

SELECT * FROM firmalar;

-- Id'si 3 olan firmanin ismini 'KRM' olarak guncelleyiniz.

UPDATE firmalar
SET isim ='KRM'
WHERE id =3;

-- Iletisim ismi Veli Gul olan firmanin id'sini 4, ismini FDS olarak guncelleyiniz.

UPDATE firmalar
SET id ='4', isim='FDS'
WHERE iletisim_isim = 'Veli Gul';

-- Ismi ACB olan firmanin iletisim ismini 'Osman Can' olarak guncelleyiniz.

UPDATE firmalar
SET iletisim_isim= 'Osman Can'
WHERE isim = 'ACB';

-- Iletisim ismi 'Osman Can' olan firmanin iletisim ismini 'Ayse Can' olarak guncelleyiniz.

UPDATE firmalar
SET iletisim_isim= 'Ayse Can'
WHERE iletisim_isim = 'Osman Can';


-- ODEV 

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
           WHERE deneme_puani.ogrenci_id=lise.id)












