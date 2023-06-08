/*==================================SELECT-REGEXP_LIKE==================================
 Daha karmasik pattern ile sorgulama islemi icin REGEXP_LIKE kullanilabilir.
  -- 'c' => case-sensitive demektir
  -- 'i' => case-insensitive demektir ve default case-insensitive aktiftir.
  
-----Syntax-----
 SELECT sutun1,sutun2,...
 FROM tablo_adi
 WHERE REGEXP_LIKE(sutun_adi, 'pattern[]','c'[])
%
=========================================================================================*/
CREATE TABLE kelimeler
    (
        id int UNIQUE,
        kelime VARCHAR(50) NOT NULL,
        harf_sayisi int
    );
    
    INSERT INTO kelimeler VALUES 
    (1001, 'hot', 3),
    (1002, 'hat', 3),
    (1003, 'hit', 3),
    (1004, 'hbt', 3),
    (1005, 'hct', 3),
    (1006, 'adem', 4),
    (1007, 'selim', 5),
    (1008, 'yusuf', 5),
    (1009, 'hip', 3),
    (1010, 'HOT', 3),
    (1011, 'hOt', 3),
    (1012, 'h9t', 3),
    (1013, 'hoot', 4),
    (1014, 'haaat', 5),
    (1015, 'hooooot', 7),
    (1016, 'h-t', 3),
    (1017, 'h?t', 3),
    (1018, 'hOOOt', 5),
    (1019, 'O', 1);
SELECT * FROM kelimeler;

-- Q1 : Icerisinde 'ot' veya 'at' bulunan kelimeleri case-sensitive'e dikkat ederek listele
  -- 'c' => case-sensitive'e dikkat ederek listele
    -- NOT: VEYA islemi icin | karakteri kullanilir.
    
SELECT kelime
FROM kelimeler
WHERE REGEXP_LIKE (kelime,'OT|AT','c');
    
    -- Q2 : Icerisinde 'ot' veya 'at' bulunan kelimeleri 
-- case-sensitive'e dikkat etmeksizin listele

SELECT kelime
FROM kelimeler
WHERE REGEXP_LIKE (kelime,'ot|at','i');

-- Q3 : 'ho' veya 'hi' ile baslayan kelimeleri 
-- case-sensitive'e dikkat etmeksizin listele
    -- NOT: Baslangici gostermek icin ^ karakteri kullanilir.
    
SELECT kelime
FROM kelimeler
WHERE REGEXP_LIKE (kelime,'^ho|^hi');

-- Q4 : Sonu 't' veya 'm' ile bitenleri 
-- case-sensitive'e dikkat etmeksizin listele
    -- NOT: Bitisi gostermek icin $ karakteri kullanilir.
    
SELECT kelime
FROM kelimeler
WHERE REGEXP_LIKE (kelime,'t$|m$');

-- Q5 : h ile baslayip t ile biten 3 harfli kelimeleri (h ile t kucuk harfli olanlari) listeleyiniz
    -- NOT : [!-~] = Butun karakterleri ifade eder.
    --       [a-zA-Z0-9] = Harf ve rakamlari temsil eder.
    
SELECT kelime
FROM kelimeler
WHERE REGEXP_LIKE (kelime,'h[!-~]t', 'c');

-- Q6 : h ile baslayip t ile biten 2. karakteri sayi olan
--     3 harfli kelimeleri (h ile t kucuk harfli olanlari) listeleyiniz

SELECT kelime
FROM kelimeler
WHERE REGEXP_LIKE (kelime,'h[0-9]t', 'c');

-- Q6 : h ile baslayip t ile biten 2. karakteri buyuk harf olan
--     3 harfli kelimeleri (h ile t kucuk harfli olanlari) listeleyiniz

SELECT kelime
FROM kelimeler
WHERE REGEXP_LIKE (kelime,'h[A-Z]t', 'c');

SELECT kelime
FROM kelimeler
WHERE  kelime LIKE 'h_t'; -- REGEXP_LIKE 'dan farkli

-- Q8 : 2. harfi O olan 3 harfli kelimeleri (o harfi buyuk olanlari)
-- ve id'lerini listeleyiniz

SELECT kelime,id
FROM kelimeler
WHERE REGEXP_LIKE (kelime,'^[!-~][O][!-~]$', 'c');

-- Q9 : 2. ve 3. harfi o olan tum kelimeleri 
-- (case sensitive olmaksizin) listeleyiniz 

SELECT kelime
FROM kelimeler
WHERE REGEXP_LIKE (kelime,'[!-~]oo');

-- ************************ Kelimeler Tablosundan *******************************
-- ODEV SELECT LIKE
/*-------------------------------------------------------------------------
Q1: 3 harfli kelimeleri listeleyin
---------------------------------------------------------------------------*/
SELECT kelime
FROM kelimeler
WHERE kelime LIKE '___';

/*-------------------------------------------------------------------------
Q2: En az 3 harfli kelimeleri listeleyin
---------------------------------------------------------------------------*/

SELECT kelime
FROM kelimeler
WHERE kelime LIKE '___%';

/*-------------------------------------------------------------------------
Q3: H ile baslayip t ile biten kelimeleri listeleyin
---------------------------------------------------------------------------*/

SELECT kelime
FROM kelimeler
WHERE kelime LIKE 'H%t';

/*-------------------------------------------------------------------------
Q4: h ile baslayip t ile biten kelimeleri case sensitive listeleyin
---------------------------------------------------------------------------*/
SELECT kelime
FROM kelimeler
WHERE REGEXP_LIKE (kelime,'^h.*t$','c'); 

/*-------------------------------------------------------------------------
Q5: h ile baslayip t ile biten 3 harfli kelimeleri case sensitive listeleyin
---------------------------------------------------------------------------*/
SELECT kelime
FROM kelimeler
WHERE REGEXP_LIKE (kelime,'h[!-~]t','c'); 

/*-------------------------------------------------------------------------
Q6: 3 ya da daha az karakterli kelimeleri listeleyin
---------------------------------------------------------------------------*/
SELECT kelime
FROM kelimeler
WHERE kelime NOT LIKE '____%';

/*-------------------------------------------------------------------------
Q7: id'si 8 rakamini iceren kelimeleri listeleyin
---------------------------------------------------------------------------*/
SELECT kelime,id
FROM kelimeler
WHERE id LIKE '%8%' ;
