
-- ders_programi_adi, ders_programi_saati ,ogretmen_tablosu ve bolum fieldlarinin oldugu bir ders_programi tablosu olusturun.
-- ogretmen_tablosu fieldini Primary Key yapin. ders_programi_adi field'i bos birakilamasin. 

CREATE TABLE ders_programi
(
ders_programi_adi VARCHAR(25) NOT NULL,
ders_programi_saati INT,
ogretmen_tablosu VARCHAR(20) PRIMARY KEY,
bolum VARCHAR(30)
);

INSERT INTO ders_programi VALUES('Matematik',10,'isa','Sayisal'); 
INSERT INTO ders_programi VALUES('Turkce',12,'Mehdi','Sozel'); 
INSERT INTO ders_programi VALUES('Bilgisayar',6,'Adem','Sayisal'); 
INSERT INTO ders_programi VALUES('Fen Bilgisi',6,'Yasemin','Sayisal'); 
INSERT INTO ders_programi VALUES('Muzik',4,'Galip','Secmeli_ders_programi'); 
INSERT INTO ders_programi VALUES('Ingilizce',8,'Esat','Secmeli_ders_programi'); 
INSERT INTO ders_programi VALUES('Hayat_Bilgisi',2,'Muhammet','Sozel'); 

select*from ders_programi;

DELETE FROM ders_programi;

-- brans, ogretmen_tablosu_adi fieldlari olan ogretmen_tablosu  Bu tablodaki ogretmen_tablosu_adi fieldini ders_programi tablosunun
-- PK 'si ile Foreign Key yapin.

CREATE TABLE ogretmen_tablosu 
(
Dogum_yeri CHAR(25),
ogretmen_tablosu_adi CHAR(25),
irtibat varchar(15),
CONSTRAINT ogretmen_tablosu_fk FOREIGN KEY (ogretmen_tablosu_adi)
REFERENCES ders_programi (ogretmen_tablosu)
);

INSERT INTO ogretmen_tablosu VALUES('Ankara','isa','5412124545'); 
INSERT INTO ogretmen_tablosu VALUES('Istanbul','Mehdi','5412123285'); 
INSERT INTO ogretmen_tablosu VALUES('Izmir','Adem','5365457848'); 
INSERT INTO ogretmen_tablosu VALUES('Ankara','Yasemin','5415265214'); 
INSERT INTO ogretmen_tablosu VALUES('Izmir','Galip','5458742658'); 
INSERT INTO ogretmen_tablosu VALUES('Ankara','Esat','5074568547'); 
INSERT INTO ogretmen_tablosu VALUES('Istanbul','Muhammet','5074568747'); 

select*from ders_programi;
select*from ogretmen_tablosu;

-- ders_programi saati 6 saat olan  ders_programileri siralayiniz

SELECT ders_programi_saati, ders_programi_adi
FROM ders_programi
WHERE ders_programi_saati = 6;

-- fen bilgisi ders_programiinin ogretmen_tablosuinin irtibat numarasini gosteren query yaziniz

SELECT irtibat
FROM ogretmen_tablosu 
WHERE ogretmen_tablosu_adi IN(SELECT ogretmen_tablosu
					       FROM ders_programi 
                           WHERE ders_programi_adi= 'Fen Bilgisi' );
                           
-- matematik ogretmen_tablosuin irtibat numarasini '5333885890' olarak guncelleyiniz

UPDATE ogretmen_tablosu
SET irtibat = '5333885890'
WHERE ogretmen_tablosu_adi IN (SELECT ogretmen_tablosu
							   FROM ders_programi
                               WHERE ders_programi_adi = 'Matematik' );
                               
-- Hayat bilgisi ders_programiinin ders_programi_saatini 3, bolumunu de secmeli_ders_programi olarak guncelleyiniz

UPDATE ders_programi
SET ders_programi_saati =3, bolum ='Secmeli_ders_programi'
WHERE ders_programi = 'Hayat_Bilgisi';

-- ders_programi saatleri 2 le 8 arasinda olan ders_programilerin bolum bilgisini gosteren.... 

SELECT bolum
FROM ders_programi 
WHERE ders_programi_saati>2 AND ders_programi_saati<8;

-- ***********regexp_like cozumu******************

select irtibat,Dogum_yeri
from ogretmen_tablosu
where regexp_like (dogum_yeri,'^A','c'); 

-- 'c' ifade case sensitive yapmak icin kullanilir
-- dogum yeri izmir olan ogretmen_tablosuin ders_programi_adini edebiyat olarak guncelleyiniz

update ders_programi
set ders_programi_adi='Edebiyat'
where ogretmen_tablosu IN (select ogretmen_tablosu_adi
                    from ogretmen_tablosu
                    where Dogum_yeri='Izmir');
                    
select*from ders_programi;

-- ogretmen_tablosundaki datalari adrese gore siralayiniz

select*
from ogretmen_tablosu
order by Dogum_yeri;



