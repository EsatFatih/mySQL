/*============================== JOIN ISLEMLERI ===============================
    
    Union,Union All Operatorleri farkli tablolardaki sutunlari 
    birlestirmek icin kullanilir.
    
    Join islemleri ise farkli Tablolari birlestirmek icin kullanilir. Diger 
    bir ifade ile farkli tablolardaki secilen sutunlar ile yeni bir tablo 
    olusturmak icin kullanilabilir.
    
    JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir ozelliktir. Cunku
    Foreign Key'ler ile iliskili olan tablolardan istenilen sutunlari cekmek 
    icin JOIN islemleri kullanilabilir.
    
    mySQL'de 3 Cesit Join islemi kullanilabilmektedir.
    
    1) INNER JOIN:  Tablolardaki ortak olan sonuc kumesini gosterir
    2) LEFT JOIN:  Ilk tabloda (Sol) olan sonuclari gosterir
    3) RIGHT JOIN:  Ikinci tabloda (Sag) olan tum sonuclari gosterir
      
    full JOIN=(left join + union + right join) Tablodaki tum sonuclari gosterir
==============================================================================*/   

CREATE TABLE sirket 
    (
        sirket_id int, 
        sirket_isim VARCHAR(20)
    );
    
    INSERT INTO sirket VALUES(100, 'Toyota');
    INSERT INTO sirket VALUES(101, 'Honda');
    INSERT INTO sirket VALUES(102, 'Ford');
    INSERT INTO sirket VALUES(103, 'Hyundai');
    
    CREATE TABLE siparisler
    (
        siparis_id int,
        sirket_id int, 
        siparis_tarihi DATE
    );
    
    INSERT INTO siparisler VALUES(11, 101, '2020-04-17');
    INSERT INTO siparisler VALUES(22, 102, '2020-04-18');
    INSERT INTO siparisler VALUES(33, 103, '2020-04-19');
    INSERT INTO siparisler VALUES(44, 104, '2020-04-20');
    INSERT INTO siparisler VALUES(55, 105, '2020-04-21');
    
SELECT * FROM sirket;
SELECT * FROM siparisler;

/*=============================== INNER JOIN  ==================================
    
    Iki tablonun kesisim kumesi ile yeni bir tablo olusturmak icin kullanilir.
    
    1) Select'ten sonra tabloda gormek istediginiz sutunlari yazarken
       table_name.field_name seklinde yazin.
    2) From'dan sonra table_name yazarken 
       1. table_name + INNER JOIN + 2. table_name yazmaliyiz.
    3) Join'i hangi kurala gore yapacaginizi belirtmelisiniz. 
       Bunun icin ON kuralimiz yazilmali.
    
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    INNER JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
    
================================================================================  */

/* -----------------------------------------------------------------------------
  ORNEK1: Iki Tabloda sirket_id'si ayni olanlarin sirket_ismi, siparis_id ve 
  siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/

SELECT sirket.sirket_id, sirket.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
FROM sirket 
INNER JOIN siparisler
ON sirket.sirket_id = siparisler.sirket_id;

-- INNER JOIN ile sadece iki tablodaki ortak olan satirlar secilir.
-- Diger bir ifadeyle iki tablodaki ortak olan sirket_id degerleri icin
-- ilgili sutunlar listenir.

/*=============================== LEFT JOIN  ==================================
    
    LEFT JOIN, 1. tablodan (sol tablo) SELECT ile ifade edilen sutunlara ait tum
    satirlari getirir. 
    Ancak, diger tablodan sadece ON ile belirtilen kosula uyan satirlari getirir. 
    
    1) Left Join'de ilk tablodaki tum record'lar gosterilir.
    2) Ilk tablodaki datalara 2.tablodan gelen ek datalar 
       varsa bu ek datalar ortak datalar icin gosterilir, 
       ancak ortak olmayan datalar icin o kisimlar bos kalir.
    3) Ilk yazdiginiz Tablonun tamamini aldigi icin hangi tabloyu
       istedigimize karar verip once onu yazmaliyiz. 
        
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    LEFT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
    
==============================================================================*/  

/* -----------------------------------------------------------------------------
  ORNEK2: sirketler tablosundaki tum sirketleri ve bu sirketlere ait olan 
  siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/

-- ********************* LEFT COZUMU *********************

SELECT sirket.sirket_id, sirket.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
FROM sirket LEFT JOIN siparisler
ON sirket.sirket_id = siparisler.sirket_id;

-- ********************* RIGHT COZUMU *********************

SELECT sirket.sirket_id, sirket.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
FROM siparisler RIGHT JOIN sirket
ON sirket.sirket_id = siparisler.sirket_id;

-- from dan sonra  Left Join'de ilk tablodaki tum satirlar gosterilir.
-- Ilk tablodaki satirlara 2.tablodan kosula uyan ortak satirlar 
-- gosterilir, ancak ortak olmayan kisimlar bos kalir

/*=============================== RIGHT JOIN  ==================================
    
    RIGHT JOIN, 2. tablodan (sag tablo) SELECT ile ifade edilen sutunlara ait tum
    satirlari getirir. 
    Ancak, diger tablodan sadece ON ile belirtilen kosula uyan satirlari getirir. 
        
    1) Right Join'de ikinci tablodaki tum record'lar gosterilir.
    2) Ikinci tablodaki datalara 1.tablodan gelen ek datalar 
       varsa bu ek datalar ortak datalar icin gosterilir ancak 
       ortak olmayan datalar icin o kisimlar bos kalir
       
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    RIGHT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
    
==============================================================================*/

/* -----------------------------------------------------------------------------
  ORNEK3: siparisler tablosundaki tum siparis_id ve siparis_tarihleri ile 
  bunlara karsilik gelen sirket_isimlerini listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/   

SELECT siparisler.siparis_id, siparisler.siparis_tarihi, sirket.sirket_id, sirket.sirket_isim
FROM sirket RIGHT JOIN siparisler 
ON sirket.sirket_id = siparisler.sirket_id;

/*=============================== full JOIN  ==================================
    full JOIN: (left join + union + right join)
    full  JOIN, Her iki tablo icin secilen sutunlara ait olan tum satirlari 
    getirmek icin kullanilir. 
    
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    left JOIN tablo2
    ON tablo1.sutun = tablo2.sutun
    union
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    right JOIN tablo2
    ON tablo1.sutun = tablo2.sutun
    
    1) full JOIN'de iki tabloda var olan tum record'lar gosterilir.
    2) Bir tabloda olup otekinde olmayan data'lar bos kalir.
==============================================================================*/

/* -----------------------------------------------------------------------------
  ORNEK4: sirketler ve siparisler adindaki tablolarda yer alan sirket_id, 
  sirket_isim, siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/

SELECT sirket.sirket_id, sirket.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
FROM sirket  LEFT JOIN siparisler
ON sirket.sirket_id = siparisler.sirket_id

UNION

SELECT sirket.sirket_id, sirket.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
FROM  sirket RIGHT JOIN siparisler
ON sirket.sirket_id = siparisler.sirket_id;

-- *************************************************************************************    
    
    CREATE TABLE bolumler (
      bolum_id   int PRIMARY KEY,
      bolum_isim VARCHAR(14),
      konum      VARCHAR(13)
    );
    
    INSERT INTO bolumler VALUES (10,'MUHASEBE','IST');
    INSERT INTO bolumler VALUES (20,'MUDURLUK','ANKARA');
    INSERT INTO bolumler VALUES (30,'SATIS','IZMIR');
    INSERT INTO bolumler VALUES (40,'ISLETME','BURSA');
    INSERT INTO bolumler VALUES (50,'DEPO', 'YOZGAT');
    
    CREATE TABLE calisanlar (
      personel_id   int PRIMARY KEY,
      personel_isim VARCHAR(10),
      meslek        VARCHAR(9),
      mudur_id      int,
      maas          int,
      bolum_id      int
    );
  
  
    INSERT INTO calisanlar VALUES (7369,'AHMET','KATIP',1111,800,20);
    INSERT INTO calisanlar VALUES (7499,'BAHATTIN','SATISE',1222,1600,30);
    INSERT INTO calisanlar VALUES (7521,'NESE','SATISE',1222,1250,30);
    INSERT INTO calisanlar VALUES (1111,'MUZAFFER','MUDUR',7839,2975,20);
    INSERT INTO calisanlar VALUES (7654,'MUHAMMET','SATISE',1222,1250,30);
    INSERT INTO calisanlar VALUES (1222,'EMINE','MUDUR',7839,2850,30);
    INSERT INTO calisanlar VALUES (1333,'HARUN','MUDUR',7839, 2450,10);
    INSERT INTO calisanlar VALUES (7788,'MESUT','ANALIST',1111,3000,20);
    INSERT INTO calisanlar VALUES (7839,'SEHER','BASKAN',NULL,5000,10);
    INSERT INTO calisanlar VALUES (7844,'DUYGU','SATISE',1222,1500,30);
    INSERT INTO calisanlar VALUES (7876,'ALI','KATIP',1111,1100,20);
    INSERT INTO calisanlar VALUES (7900,'MERVE','KATIP',1222,950,30);
    INSERT INTO calisanlar VALUES (7902,'NAZLI','ANALIST',1111,3000,20);
    INSERT INTO calisanlar VALUES (7934,'EBRU','KATIP',1333,1300,10);
    INSERT INTO calisanlar VALUES (7956,'SIBEL','MIMAR',1333,3300,60);
    INSERT INTO calisanlar VALUES (7933,'ZEKI','MUHENDIS',1333,4300,60);
    
   SELECT * FROM bolumler;
   SELECT * FROM calisanlar;
   
   /* -----------------------------------------------------------------------------
  ORNEK1: SATIS ve MUHASEBE bolumlerinde calisanlarin isimlerini ve 
  bolumlerini, once bolum sonra isim sirali olarak listeleyiniz
------------------------------------------------------------------------------*/

SELECT calisanlar.personel_isim, bolumler.bolum_isim
FROM  bolumler JOIN calisanlar
ON bolumler.bolum_id = calisanlar.bolum_id
WHERE bolum_isim IN ('SATIS','MUHASEBE')
ORDER BY bolum_isim, personel_isim;

/* -----------------------------------------------------------------------------
  ORNEK2: SATIS,ISLETME ve DEPO bolumlerinde calisan personelin isimlerini,  
  bolumlerini  isim sirali olarak listeleyiniz. 
  NOT: calisani olmasa bile bolum ismi gosterilmelidir.
------------------------------------------------------------------------------*/

SELECT bolumler.bolum_isim, calisanlar.personel_isim
FROM  bolumler LEFT JOIN calisanlar
ON bolumler.bolum_id = calisanlar.bolum_id
WHERE bolum_isim IN ('SATIS','ISLETME','DEPO')
ORDER BY bolum_isim, personel_isim;

/* -----------------------------------------------------------------------------
  ORNEK3: Calisan tum personelin isimlerini, bolum isimlerini ve 
  maaslarini bolum ters ve maas sirali listeleyiniz. 
  NOT: calisani olmasa bile bolum ismi gosterilmelidir.
------------------------------------------------------------------------------*/

SELECT calisanlar.personel_isim, bolumler.bolum_isim, calisanlar.maas
FROM bolumler RIGHT JOIN calisanlar
ON bolumler.bolum_id = calisanlar.bolum_id
ORDER BY bolum_isim DESC, maas;

/* -----------------------------------------------------------------------------
  ORNEK4: SATIS ve MUDURLUK bolumlerinde calisan personelin maaslari 2000'den
  buyuk olanlarin isimlerini, bolum isimlerini ve 
  maaslarini bolume ve isme gore siralayarak listeleyiniz. 
------------------------------------------------------------------------------*/ 

SELECT calisanlar.personel_isim, bolumler.bolum_isim, calisanlar.maas
FROM bolumler RIGHT JOIN calisanlar
ON bolumler.bolum_id = calisanlar.bolum_id
WHERE bolum_isim IN ('SATIS','MUDURLUK') AND maas > 2000
ORDER BY bolum_isim , personel_isim;
