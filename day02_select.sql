/*==================================SELECT-WHERE=============================================
Verileri SELECT komutu ile veritabanindan cekerken filtreleme yapmak icin : 
 
SELECT ile birlikte WHERE komutu kullanilabilir.
-----Syntax----- :
SELECT field1, field2 
FROM tablo_adi 
WHERE kosul;
-- SELECT -- hangi sutunlari(field) getirsin
-- FROM -- hangi tablodan(table) getirsin
-- WHERE -- hangi satirlari(record) getirsin
=========================================================================================*/

CREATE TABLE meslek_lisesi (
okul_no CHAR(4) UNIQUE,
isim VARCHAR(50) NOT NULL,
derece DOUBLE,
adres VARCHAR(100),
son_degisiklik_tarihi DATE
);

SELECT * FROM meslek_lisesi;

INSERT INTO meslek_lisesi VALUES('1001','Fatih Oz', 89,'Ankara', '2022-11-23');      
INSERT INTO meslek_lisesi VALUES('1002','Fatih Yildiz', 94,'Istanbul', '2022-11-23');
INSERT INTO meslek_lisesi VALUES('1003','Bora Sverige', 78,'Izmir', '2022-11-23');
INSERT INTO meslek_lisesi VALUES('1004','Nevzat Celik', 69,'Ankara', '2022-11-23');
INSERT INTO meslek_lisesi VALUES('1005','Gursel Unal', 90,'Istanbul', '2022-11-23');
INSERT INTO meslek_lisesi VALUES('1006','Soner Karatasoglu ', 85,'Istanbul', '2022-11-23');
INSERT INTO meslek_lisesi VALUES('1007','Talha Kurt', 75,'Ankara', '2022-11-23');
INSERT INTO meslek_lisesi VALUES('1008','Yakup Lejon', 79,'Izmir', '2022-11-23');
INSERT INTO meslek_lisesi VALUES('1009','Ilhan Gurbetci', 80,'Izmir', '2022-11-23');

-- Q1 : Derecesi 90'dan yuksek olan ogrencilerin tum bilgilerini getirin.

SELECT *
FROM meslek_lisesi
WHERE derece>90;

-- Q2 : Derecesi 80'den kucuk olan ogrencilerin isimlerini listeleyin.

SELECT isim
FROM meslek_lisesi
WHERE derece<80;

-- Q3 : Adresi Ankara olan ogrencilerin isim ve derece bilgilerini listeleyin.

SELECT isim,derece
FROM meslek_lisesi
WHERE adres='Ankara';

-- Q4 : okul_no'su 1005 olan ogrencinin isim ve adres bilgisini listeleyin.

SELECT isim,adres
FROM meslek_lisesi
WHERE okul_no='1005';

SELECT okul_no,adres
FROM meslek_lisesi
WHERE derece<80 AND derece>70;

/*================================== SELECT-BETWEEN =============================================
BETWEEN iki mantiksal ifade ile tanimlayabilecegimiz durumlari tek komutla 
yazabilme imkani verir, yazdigimiz iki sinirda araliga dahildir.
-----Syntax-----
SELECT field1,field2,...
FROM table_name
WHERE field_name 
BETWEEN deger1 AND deger2;
=========================================================================================*/
/*==========================AND (ve) Operatoru kullanimi==================================
=> And ile belirtilen sartlarin tamami gerceklesiyorsa o kayit listelenir,
Sartlardan bir tanesi bile tutmazsa listelenmez.
SELECT * FROM matematik WHERE sinav1 < 50  AND sinav2 < 50
Bu ornekte hem sinav1 hem de sinav2 field'i 50'den kucuk olan kayitlar listelenecektir.
/*==========================OR (veya) Operatoru kullanimi==================================
=> Or ile belirtilen sartlardan en az biri gerceklesiyorsa o kayit listelenir,
sartlardan hicbiri gerceklesmiyorsa o kayit listelenmez.
SELECT * FROM matematik WHERE sinav1 < 50 OR sinav2 < 50
Bu ornekte sinav1 veya sinav2 field'i 50'den kucuk olan kayitlar listelenecektir.
=========================================================================================*/

CREATE TABLE ogretmen_lisesi(
id int,
isim VARCHAR(45),
adres VARCHAR(100),
sinav_notu DOUBLE
);
INSERT INTO ogretmen_lisesi VALUES (111, 'Emine Yucel', 'Ankara', 75);
INSERT INTO ogretmen_lisesi VALUES (112, 'Muhammet Talha Kurt', 'Istanbul', 85);
INSERT INTO ogretmen_lisesi VALUES (113, 'Ilhan Sahin', 'Ankara', 70);
INSERT INTO ogretmen_lisesi VALUES (114, 'Kadir Corumlu', 'Corum', 90);
INSERT INTO ogretmen_lisesi VALUES (115, 'Selman Kasabali', 'Ankara',70);
INSERT INTO ogretmen_lisesi VALUES (116, 'Murat Aycicek', 'Izmir', 85);
INSERT INTO ogretmen_lisesi VALUES (117, 'Tugba Ozsoy', 'Bolu', 85);


SELECT * FROM ogretmen_lisesi;

/*-------------------------------------------------------------------------
Q5: Derecesi notu 70'ten buyuk 80'den kucuk olan ogrencilerin tum bilgilerini listeleyin.
---------------------------------------------------------------------------*/

-- ************* 1.YOL **************
SELECT *
FROM ogretmen_lisesi
WHERE sinav_notu<80 AND sinav_notu>70;

-- ************* 2.YOL **************

SELECT *
FROM ogretmen_lisesi
WHERE sinav_notu
BETWEEN 71 AND 79; -- Between kosulunda once kucuk olan degeri yazmaliyiz!!

/*-------------------------------------------------------------------------
Q5: Muhammet Talha ve Murat arasinda olan ogrencilerin isimlerini listeleyin.
---------------------------------------------------------------------------*/

SELECT isim
FROM ogretmen_lisesi
WHERE isim
BETWEEN 'Muhammet Talha' AND 'Murat';

-- NOT : String ifadeleri BETWEEN komutu ile kiyaslamak istedigimizde bize
-- sonucu ASCII degerlerine gore siralayarak gonderir.

/*-------------------------------------------------------------------------
Q8: Ankara ile Corum arasinda olan ogrencilerin isimlerini listeleyin.
---------------------------------------------------------------------------*/

SELECT isim
FROM ogretmen_lisesi
WHERE adres
BETWEEN 'Ankara' AND 'Corum';

CREATE TABLE personel(
id CHAR(5),
isim VARCHAR(50),
maas INT
);

INSERT INTO personel VALUES('10001','Ahmet Aslan',7000);
INSERT INTO personel VALUES('10002','Mehmet Yilmaz',12000);
INSERT INTO personel VALUES('10003','Meryem',7215);
INSERT INTO personel VALUES('10004','Veli Han',5000);
INSERT INTO personel VALUES('10005','Mustafa Ali',5500);
INSERT INTO personel VALUES('10006','Ayse Can',5600);
INSERT INTO personel VALUES('10010','Ayse',4700);
INSERT INTO personel VALUES('10009','Ayse Cemile',4000);
INSERT INTO personel VALUES('10008','Ayse Cano',4300);
INSERT INTO personel VALUES('10007','Can Ayse',7700);
INSERT INTO personel VALUES('10011','Yeliz Alina',12700);

SELECT * FROM personel;

/*-------------------------------------------------------------------------
Q9: id'si 10005 ile 10009 arasinda olan personelin bilgilerini listele
---------------------------------------------------------------------------*/

SELECT *
FROM personel
WHERE id
BETWEEN '10005' AND '10009';

/*-------------------------------------------------------------------------
Q10: Ismi Mehmet Yilmaz ile Veli arasinda olan personel bilgilerini listeleyin
---------------------------------------------------------------------------*/

SELECT*
FROM personel
WHERE isim
BETWEEN 'Mehmet Yilmaz' AND 'Veli';

/*-------------------------------------------------------------------------
Q11: Ismi Ahmet ile Ayse Cano arasinda olan personel bilgilerini listeleyin
---------------------------------------------------------------------------*/

SELECT *
FROM personel
WHERE isim
BETWEEN 'Ahmet' AND 'Ayse Cano';

/*-------------------------------------------------------------------------
Q12: Maasi 7000 ya da ismi Ayse olan personel id'lerini listeleyin
---------------------------------------------------------------------------*/

SELECT id
FROM personel
WHERE maas=7000 OR isim='Ayse';

/*-------------------------------------------------------------------------
Q13: Id'si 10001, 10005 ya da 10008 olan personel isimlerini listeleyin
---------------------------------------------------------------------------*/

SELECT isim
FROM personel
WHERE id=10001 OR id=10005 OR id=10008;

/*================================== SELECT-IN ===========================================
IN birden fazla mantiksal ifade ile tanimlayabilecegimiz durumlari tek komutla yazabilme
imkani verir. IN icerisine yazacagimiz sartlar ayni field'a ait olmali.
-----Syntax-----
SELECT field1,field2,...
FROM table_name
WHERE field_name IN (deger1,deger2,...);
=========================================================================================*/

/*-------------------------------------------------------------------------
Q14: Id'si 10001, 10005 ya da 10008 olan personel isimlerini listeleyin
---------------------------------------------------------------------------*/
SELECT isim
FROM personel
WHERE id IN (10001,10005,10008);
/*-------------------------------------------------------------------------
Q15: Maasi sadece 7000 veya 12000 olan personelin bilgilerini listele
---------------------------------------------------------------------------*/
SELECT *
FROM personel
WHERE maas IN (7000,12000);

/*================================== SELECT-LIKE =============================================
LIKE keyword sorgulama yaparken belirli patternleri kullanabilmemize olanak saglar.
-----Syntax-----
 SELECT field1,field2,...
 FROM table_name
 WHERE field LIKE pattern
 
 ----------------
 Pattern icin :
 % ---> 0 veya daha fazla karakteri belirtir
 _ ---> Tek bir karakteri temsil eder.
=========================================================================================*/

/*-------------------------------------------------------------------------
Q16: Ismi A ile baslayan personeli listeleyiniz
---------------------------------------------------------------------------*/
SELECT *
FROM personel
WHERE isim LIKE 'a%';
/*-------------------------------------------------------------------------
Q17: Isminde Ayse iceren personelin isimlerini listeleyiniz
---------------------------------------------------------------------------*/
SELECT isim
FROM personel
WHERE isim LIKE 'ayse%';

/*-------------------------------------------------------------------------
Q18: Ismi n harfi ile biten personeli listeleyiniz
---------------------------------------------------------------------------*/
SELECT *
FROM personel
WHERE isim LIKE '%n';
/*-------------------------------------------------------------------------
Q19: Isminin 2. harfi e olan personeli listeleyiniz
---------------------------------------------------------------------------*/
SELECT *
FROM personel
WHERE isim LIKE '_e%';
/*-------------------------------------------------------------------------
Q20: Isminin 2. harfi e olup diger harflerinde y olan personeli listeleyiniz
---------------------------------------------------------------------------*/
SELECT *
FROM personel
WHERE isim LIKE '_e%' AND isim LIKE '%y%';
/*-------------------------------------------------------------------------
Q21: Isminde a harfi olmayan personeli listeleyiniz
---------------------------------------------------------------------------*/
SELECT *
FROM personel
WHERE isim  NOT LIKE '%a%' ;
/*-------------------------------------------------------------------------
Q22: Maasi 5 haneli olan personeli listeleyiniz
---------------------------------------------------------------------------*/
SELECT *
FROM personel
WHERE maas LIKE '_____'  ;
/*-------------------------------------------------------------------------
Q23: 1. harfi a ve 7. harfi a olan personeli listeleyiniz
---------------------------------------------------------------------------*/
SELECT *
FROM personel
WHERE isim LIKE 'a_____a%'  ;




