/*================================== DELETE ============================================
DELETE FROM table_name komutu tablodaki tum recordlari siler.
Eger tum kayitlar silindikten sonra tabloyu gormek isterseniz size sadece bos bir tablo
gosterir. 
DELETE komutu sadece datalari siler, tabloyu silmez.
=======================================================================================*/

SELECT*FROM mart_satislar;

DELETE FROM mart_satislar;

/*===============================================================================================
-- DELETE FROM tablo_adi;  Tablonun tum icerigini siler.
-- Bu komut bir DML komutudur. Dolayisiyla devaminda WHERE gibi cumlecikler
-- kullanilabilir.
    
    -- DELETE FROM tablo_adi
    -- WHERE field = veri;
    
--    DELETE FROM ogrenciler;     -- Tum verileri sil.
--    SAVEPOINT ABC;     -- Verilen konuma verileri kaydeder.
--    ROLLBACK TO  ABC;  -- Silinen Verileri geri getir.
-- Bilgileri geri getirirken sikinti yasamamak icin ayarlar sql execution auto commit tiki kaldir
==================================================================================================*/ 

CREATE TABLE cucuklar
(
id char(3),
isim varchar(50),
veli_isim varchar(50),
yazili_notu int,
CONSTRAINT cocuklar_pk
PRIMARY KEY (id)
);

INSERT INTO cucuklar VALUES(123, 'Ali Can', 'Hasan',75); 
INSERT INTO cucuklar VALUES(124, 'Merve Gul', 'Ayse',85); 
INSERT INTO cucuklar VALUES(125, 'Kemal Yasa', 'Ali',85);

SELECT * FROM cucuklar;

-- Veli Ismi Ali ya da Ayse olan kaydi siliniz

DELETE FROM cucuklar
WHERE veli_isim ='Ali' OR veli_isim ='Ayse';

DELETE FROM cucuklar
WHERE veli_isim IN ('Ali','Ayse');

-- Yazili notu 84'ten buyuk olan cocuklari

DELETE FROM cucuklar
WHERE yazili_notu > 84;

-- Yazili notu 85'ten farkli olan cocuklari silin 

DELETE FROM cucuklar
WHERE yazili_notu != 85;

DELETE FROM cucuklar
WHERE yazili_notu <> 85;

DELETE FROM cucuklar
WHERE NOT yazili_notu = 85;

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

CREATE TABLE cocuk
    (
        id CHAR(3),
        isim VARCHAR(50),
        veli_isim VARCHAR(50),
        yazili_notu int       
    );
  
    INSERT INTO cocuk VALUES(123, 'Ali Can', 'Hasan',75);
    INSERT INTO cocuk VALUES(124, 'Merve Gul', 'Ayse',85);
    INSERT INTO cocuk VALUES(125, 'Kemal Yasa', 'Hasan',85);
    INSERT INTO cocuk VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
    INSERT INTO cocuk VALUES(127, 'Mustafa Bak', 'Can',99);
    
    SELECT*FROM cocuk;
    
    -- Id'si 124'ten buyuk olan kayitlari silin :
 
DELETE FROM cocuk
WHERE id > 124; -- Bu satirda belli sartlari tasiyan verileri sildik

SAVEPOINT cilek; -- Olusturdugumuz yeni bir alana database'imizin bir kopyasini koyduk

ROLLBACK TO cilek; -- Bu satirda ise yaptigimiz degisiklikleri savepoint cilek durumundaki haline geri dondurduk


/* ============================= DELETE - TRUNCATE - DROP ================================   
  
  => TRUNCATE TABLE komutu tablodaki tum datalari kalici olarak siler
  => Truncate ve Delete komutlarinin ikisi de bir tabloda bulunan recordlari silmek icin kullanilir.
  => Iki komut da sadece belirtilen tablodaki kayitlari siler.
  => En belirgin farki ise Delete komutu ile belirli bir araligi silebilirken,
  => Truncate komutu tablodaki tum verileri siler.
  
  1-) TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamini siler.
    Ancak, secmeli silme yapamaz. Cunku Truncate komutu DML degil DDL komutudur.*/ 
   
       TRUNCATE TABLE cocuklar; -- dogru yazim
       DROP TABLE puanlar;
       DELETE FROM cocuklar
       WHERE id>125;
  
       SELECT * FROM cocuklar;
       
   /* 2-) DELETE komutu beraberinde WHERE cumlecigi kullanilabilir. TRUNCATE ile 
    kullanilmaz.
    
        TRUNCATE TABLE ogrenciler
        WHERE veli_isim='Hasan';  .....yanlis yazim
        
-- TRUNCATE komutu tablo yapisini degistirmeden, 
-- tablo icinde yer alan tum verileri tek komutla silmenizi saglar.
        
    3-) Delete komutu ile silinen veriler ROLLBACK Komutu ile kolaylikla geri 
    alinabilir.
    
    4-) Truncate ile silinen veriler geri alinmasi daha zordur. Ancak
    Transaction yontemi ile geri alinmasi mumkun olabilir.
    
    5-) DROP komutu da bir DDL komutudur. Ancak DROP veriler ile birlikte tabloyu da 
    siler. 
    
    -- Tablodaki kayitlari silmek ile tabloyu silmek farkli islemlerdir.
    -- Silme komutlari da iki basamaklidir, biz genelde geri getirilebilecek sekilde sileriz. 
    -- Ancak bazen guvenlik gibi sebeplerle geri getirilmeyecek sekilde silinmesi istenebilir.
==============================================================================*/

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*============================== ON DELETE CASCADE ================================
  Her defasinda once child tablodaki verileri silmek yerine ON DELETE CASCADE
  silme ozelligini aktif hale getirebiliriz.
  
  Bunun icin FK olan satirin en sonuna ON DELETE CASCADE komutunu yazmak yeterli
  
===================================================================================*/

CREATE TABLE talebeler
    (
        id CHAR(3) primary key,  
        isim VARCHAR(50),
        veli_isim VARCHAR(50),
        yazili_notu int
    );
    
    INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
    INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
    INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
    INSERT INTO talebeler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
    INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
    
    CREATE TABLE dereceler 
    (  
    talebe_id char(3), 
    ders_adi varchar(30), 
    yazili_notu int, 
    CONSTRAINT dereceler_fk FOREIGN KEY (talebe_id) 
    REFERENCES talebeler(id)  ON DELETE CASCADE
    ); 
    
    INSERT INTO dereceler VALUES ('123','Kimya',75);
    INSERT INTO dereceler VALUES ('124', 'Fizik',65);
    INSERT INTO dereceler VALUES ('125', 'Tarih',90);
    INSERT INTO dereceler VALUES ('126', 'Matematik',90); 
    INSERT INTO dereceler VALUES ('127', 'Matematik',23); 
    
    SELECT*FROM talebeler;
    SELECT*FROM dereceler;
    
    DELETE FROM talebeler
    WHERE id>125;
    
	DELETE FROM talebeler
    WHERE talebe_id>125; 
    
    DROP TABLE dereceler;
    DROP TABLE talebeler;
    





    
    

















































