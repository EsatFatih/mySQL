/* ======================== EXISTS CONDITION ===========================
EXISTS Condition subquery'ler ile kullanilir. IN ifadesinin kullanimina
benzer olarak, EXISTS ve NOT EXISTS ifadeleri de alt sorgudan getirilen 
degerlerin icerisinde bir degerin olmasi veya olmamasi durumunda islem 
yapilmasini saglar.
======================================================================*/

CREATE TABLE mayis_satislar
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO mayis_satislar VALUES (10, 'Mark', 'Honda');
INSERT INTO mayis_satislar VALUES (10, 'Mark', 'Honda');
INSERT INTO mayis_satislar VALUES (20, 'John', 'Toyota');
INSERT INTO mayis_satislar VALUES (30, 'Amy', 'Ford');
INSERT INTO mayis_satislar VALUES (20, 'Mark', 'Toyota');
INSERT INTO mayis_satislar VALUES (10, 'Adem', 'Honda');
INSERT INTO mayis_satislar VALUES (40, 'John', 'Hyundai');
INSERT INTO mayis_satislar VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan_satislar
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO nisan_satislar VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan_satislar VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan_satislar VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan_satislar VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan_satislar VALUES (20, 'Mine', 'Toyota');

select*from mayis_satislar;
select*from nisan_satislar;

/*----------------------------------------------------------------
SORU 1 : Her iki ayda da ayni id ile satilan urunlerin urun_id'lerini
ve urunleri mayis ayinda alanlarin isimlerini getiren bir query yaziniz.
----------------------------------------------------------------*/ 

SELECT urun_id, musteri_isim
FROM mayis_satislar
WHERE urun_id IN(SELECT urun_id
				FROM nisan_satislar
                WHERE mayis_satislar.urun_id = nisan_satislar.urun_id);
                
SELECT urun_id, musteri_isim
FROM mayis_satislar
WHERE EXISTS (SELECT urun_id
				FROM nisan_satislar
                WHERE mayis_satislar.urun_id = nisan_satislar.urun_id);
                
/*----------------------------------------------------------------
SORU 2 : Her iki ayda da satilan urun_isimleri ayni olan urunlerin,
urun_isim'ini ve urunleri nisan ayinda alan musterilerin isimlerini 
getiren bir Query yaziniz.
----------------------------------------------------------------*/ 

SELECT urun_isim, musteri_isim
FROM nisan_satislar
WHERE EXISTS (SELECT urun_isim
			  FROM mayis_satislar
			  WHERE mayis_satislar.urun_isim = nisan_satislar.urun_isim);
              
/*----------------------------------------------------------------
SORU 3 : Nisan ayinda satilip mayis ayinda satilmayan urun ismini ve
satin alan kisiyi listeleyen bir QUERY yaziniz.
----------------------------------------------------------------*/

SELECT urun_isim, musteri_isim
FROM nisan_satislar
WHERE NOT EXISTS (SELECT urun_isim
			      FROM mayis_satislar
			      WHERE mayis_satislar.urun_isim = nisan_satislar.urun_isim);
                  
/*----------------------------------------------------------------
SORU 4 : Mayis ayinda satilip nisan ayinda satilmayan urun id ve
satin alan kisiyi listeleyen bir QUERY yaziniz.
----------------------------------------------------------------*/ 
                  
SELECT urun_id, musteri_isim
FROM mayis_satislar
WHERE NOT EXISTS (SELECT urun_id
			      FROM nisan_satislar
			      WHERE mayis_satislar.urun_id = nisan_satislar.urun_id);
                  
/* ======================== IS NULL CONDITION ===========================
    Arama yapilan field'da NULL degeri almis kayitlari getirir.
======================================================================*/
                  
CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
adres varchar(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa');
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

SELECT * FROM insanlar;

-- Ismi null olan kayitlari listeleyin :

SELECT*
FROM insanlar
WHERE isim IS NULL;

-- Ismi null olan kayitlari 'Isimsiz' olarak guncelleyin :

UPDATE insanlar
SET isim ='isimsiz'
WHERE isim IS NULL;

-- Ismi 'Isimsiz' olan kayitlari silin :

DELETE FROM İnsanlar
WHERE isim = 'isimsiz';

-- Ismi NULL olan kayitlari silin :

DELETE FROM insanlar
WHERE isim IS NULL;

/* ======================== ORDER BY ===========================
=> ORDER BY komutu belli bir field'a gore NATURAL ORDER olarak siralama
yapmak icin kullanilir.
=> ORDER BY komutu sadece SELECT komutu ile kullanilir.
=> ORDER BY komutuna ozel olarak, siralama yapacagimiz field ismi yerine 
field sirasini da yazabiliriz.
=> Isimleri natural order'a gore siralamak icin sorgunun sonuna 
 ORDER BY (field_name) yazmak yeterlidir.
=> Isimleri ters siralama ile yazdirmak isterseniz DESC yaziyoruz.
=> Ayni degerde olan kayitlari, tablodaki kayit sirasina gore getirir.
==============================================================*/

CREATE TABLE insanciklar
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),
adres varchar(50)
);

INSERT INTO insanciklar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanciklar VALUES(234567890, 'Veli','Cem', 'Ankara');
INSERT INTO insanciklar VALUES(345678901, 'Mine','Bulut', 'Ankara');
INSERT INTO insanciklar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul');
INSERT INTO insanciklar VALUES (344678901, 'Mine','Yasa', 'Ankara');
INSERT INTO insanciklar VALUES (345678901, 'Ali','Yilmaz', 'Istanbul');

SELECT * FROM insanciklar;

-- Soru 1: Insanciklar tablosundaki datalari adres'e gore siralayin :

SELECT*
FROM insanciklar
ORDER BY adres;

-- Soru 2: Isim' i Mine olanlari soyisim sirali olarak listeleyen Query yaziniz.

SELECT*
FROM insanciklar
WHERE isim ='Mine'
ORDER BY soyisim;

-- Soru 3: Insanciklar tablosundaki soyismi BULUT olanlari isim sirali olarak listeleyin.

SELECT*
FROM insanciklar
WHERE soyisim ='BULUT'
ORDER BY isim;

-- Soru 4: Insanciklar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin.

SELECT*
FROM insanciklar
ORDER BY ssn DESC;

-- Soru 5: Insanciklar tablosundaki tum kayitlari SSN numarasina gore siralayin.

SELECT*
FROM insanciklar
ORDER BY ssn ;

-- Soru 6: Insanciklar tablosundaki tum kayitlari Soyisimler ters sirali,
-- isimler Natural sirali olarak listeleyin.

SELECT*
FROM insanciklar
ORDER BY soyisim DESC , isim ;

-- Soru 7: Insanciklar tablosundaki tum kayitlari adresler ters sirali, 
-- isimler ters sirali olarak listeleyin

SELECT*
FROM insanciklar
ORDER BY adres DESC, isim DESC;

-- Soru 8: Insanciklar tablosundaki tum kayitlari adresler ters sirali, 
-- isimler ters sirali, soyisimler ters sirali olarak listeleyin.

SELECT*
FROM insanciklar
ORDER BY adres DESC, isim DESC, soyisim DESC;
                  
