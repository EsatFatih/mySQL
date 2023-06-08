/*======================== HAVING CLAUSE =======================
    HAVING, AGGREGATE FUNCTION'lar ile birlikte kullanilan 
FILTRELEME komutudur.
    Aggregate fonksiyonlar ile ilgili bir kosul koymak 
icin GROUP BY'dan sonra HAVING cumlecigi kullanilir.    

-- Yeni create ettigimiz bir field uzerinden filtreleme yaptigimiz icin
-- WHERE cumlecigini kullanamayiz, WHERE cumlecigi sadece tablomuzda var olan
-- field'lar icin bir filtreleme yapar.
===============================================================*/

CREATE TABLE isciler
(
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20)
);

INSERT INTO isciler VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO isciler VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO isciler VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500,'Honda');
INSERT INTO isciler VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO isciler VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO isciler VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO isciler VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

SELECT * FROM isciler;

-- Sirketlere gore toplam isci sayisini listeleyiniz

SELECT sirket, COUNT(isim)isci_sayisi
FROM isciler
GROUP BY sirket;

-- 1) Sirketlere gore isci_sayisini 1'den buyukse yazdiriniz

SELECT sirket, COUNT(isim)isci_sayisi
FROM isciler
GROUP BY sirket
HAVING isci_sayisi>1;

-- 2) Toplam geliri 8000 liradan fazla olan isimleri gosteren sorgu yaziniz

SELECT isim, SUM(maas)top_maas
FROM isciler
GROUP BY isim
HAVING top_maas>8000;

-- 3) Her sirketin MIN maaslarini eger 4000'den buyukse goster.

SELECT sirket, MIN(maas)min_maas
FROM isciler
GROUP BY sirket
HAVING min_maas>4000;

-- Yeni create ettigimiz bir field uzerinden filtreleme yaptigimiz icin
-- WHERE cumlecigini kullanamayiz, WHERE cumlecigi sadece tablomuzda var olan
-- field'lar icin bir filtreleme yapar.

-- 4) Eger bir sehirde alinan MAX maas 5000'den dusukse sehir ismini 
-- ve MAX maasi veren sorgu yaziniz

SELECT sehir, MAX(maas)max_maas
FROM isciler
GROUP BY sehir
HAVING max_maas<5000;

-- 5) Eger bir sehirde alinan MAX maas 5000'den buyukse sehir ismini
-- ve MAX maasi, sehir isim sirali veren sorgu yaziniz

SELECT sehir, MAX(maas)max_maas
FROM isciler
GROUP BY sehir
HAVING max_maas>5000
ORDER BY sehir;

-- 6) Eger bir sehirde alinan MAX maas 5000'den buyukse ve sehir ismi
-- 'I' harfi ile basliyorsa o sehirleri ve MAX maasi, maas
-- sirali veren sorgu yaziniz

SELECT sehir, MAX(maas)max_maas
FROM isciler
WHERE sehir LIKE 'I%'
GROUP BY sehir
HAVING max_maas>5000
ORDER BY max_maas;

/*============================ LIMIT ===========================
>Tablodaki verilerin belli bir kismini listelemek icin LIMIT
 komutunu kullaniriz.
>LIMIT komutundan sonra kullandigimiz sayi kadar kaydi bize getirir.
>Eger belirli bir aralikta calismak istiyorsak bu durumda 
iki sayi gireriz, ancak bu sayilardan ilki baslangic noktamizi 
ifade ederken ikincisi kac kayit getirecegimizi belirtir. Baslangic 
noktasi dahil edilmez!
===============================================================*/

-- 1) Isciler tablosundan ilk 5 kaydi getiriniz.

SELECT *
FROM isciler
LIMIT 5;

-- 2) Isim sirali tablodan ilk 3 kaydi listeleyin.

SELECT *
FROM isciler
ORDER BY isim
LIMIT 3;

-- 3) Maas sirali tablodan 4. kayittan 6. kayda kadar olan
-- kayitlarin isim ve sehir bilgilerini listeleyin.

SELECT isim, sehir
FROM isciler
ORDER BY maas
LIMIT 3,3;

-- 4) Maasi en yuksek 3 kisinin bilgilerini listeleyen sorguyu yaziniz.

SELECT *
FROM isciler
ORDER BY maas DESC
LIMIT 3;

-- 5) Maasi en dusuk 3 kisinin sadece isimlerini listeleyen sorguyu yaziniz

SELECT isim
FROM isciler
ORDER BY maas
LIMIT 3;

-- 6) Maasi en dusuk 3 kisinin sadece isimlerini, isim sirali listeleyen sorguyu yaziniz

SELECT isim
FROM isciler
ORDER BY maas, isim
LIMIT 3;

-- 7) Maas'i 4000'den buyuk olan ilk 3 kisinin sehrini listeleyin.

SELECT sehir
FROM isciler
WHERE maas>4000
ORDER BY maas
LIMIT 3; 
 
 /*============================ DISTINCT ===========================
    DISTINCT cumlecigi bir Sorgu ifadesinde benzer olan kayitlari
    filtrelemek icin kullanilir. Dolayisiyla secilen sutun veya 
    sutunlar icin benzersiz veri iceren satirlar olusturmaya yarar.
    
    Syntax :
    --------
    SELECT DISTINCT field_name1, field_name2,...
    FROM table_name
    
===============================================================*/

-- 1) Iscileri yasadiklari sehirler ile tekrarsiz listeleyin

SELECT DISTINCT isim, sehir
FROM isciler;

-- Group By'da bir fielda gore gruplama yapip, Aggregate Function'lar 
-- yardimiyla baska bir field'da islem yapip bize islem yaptigi field'i 
-- yeni bir field olarak donduruyor.DISTINCT cumlecigi bir Sorgu ifadesinde
-- benzer olan kayitlari filtrelemek icin kullanilir. DISTINCT komutu bize
-- bir field'daki kayitlarin tek bir ornegini dondurur

SELECT * FROM manav;

-- 2) Manav tablosundan satilan farkli meyve turlerini listeleyen bir query yaziniz

SELECT DISTINCT urun_adi
FROM manav;

-- 3) Satilan farkli meyve turlerinden NULL olmayanlari listeleyen

SELECT DISTINCT urun_adi
FROM manav
WHERE urun_adi IS NOT NULL;

-- 4) Satilan farkli meyve turlerinden NULL olmayanlari meyve isim sirali
-- listeleyen bir query yaziniz

SELECT DISTINCT urun_adi
FROM manav
WHERE urun_adi IS NOT NULL
ORDER BY urun_adi;

-- 5) Satilan meyve ve satin alan kisi isimlerinden farkli olan ikilileri 
-- listeleyen query yaziniz

SELECT DISTINCT urun_adi, isim
FROM manav;

-- ********************** Isciler Tablosundan ************************
-- 1) Isme gore toplam maaslari bulun

SELECT DISTINCT isim, SUM(maas)top_maas
FROM isciler
GROUP BY isim;

-- 2) Sehre gore toplam isci sayisini bulun

SELECT DISTINCT sehir, COUNT(isim)top_isci
FROM isciler
GROUP BY sehir;

-- 3) Sehre gore toplam isci sayisini, buyukten kucuge yazdiriniz 

SELECT DISTINCT sehir, COUNT(isim)top_isci
FROM isciler
GROUP BY sehir
ORDER BY top_isci DESC ;

-- 4) Sirketlere gore maasi 5000 liradan fazla olan isci sayisini bulun

SELECT sirket, COUNT(isim)isci
FROM isciler
WHERE maas > 5000
GROUP BY sirket;

-- 5) Her sirket icin Min ve Max maasi bulun

SELECT sirket, MIN(maas), MAX(maas)
FROM isciler
GROUP BY sirket;




