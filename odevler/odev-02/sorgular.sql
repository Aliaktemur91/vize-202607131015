-- Ödev 2, Bölüm 1: Filo soruları
-- Ad Soyad: Ali Aktemur
-- Veritabanı: robot_fleet
-- Her sorgunun altına sonucu açıklayan tek cümlelik yorum yaz.

-- Soru 1: Her robotun adı, operatör adı ve operatör telefonu (INNER JOIN)
SELECT r.name AS robot_adi,
       o.operator_name AS operator_adi,
       o.phone AS operator_telefonu
FROM robots r
INNER JOIN operators o ON r.operator_name = o.operator_name;

-- Yorum: Toplam 9 satır döndü çünkü INNER JOIN yalnızca operator_name değeri boş (NULL) olmayan ve operators tablosuyla eşleşen robotları getirdi.


-- Soru 2: Aynı liste, bütün robotlar görünsün (LEFT JOIN). 1. sorguyla karşılaştır, kim kayboldu?
SELECT r.name AS robot_adi,
       o.operator_name AS operator_adi,
       o.phone AS operator_telefonu
FROM robots r
LEFT JOIN operators o ON r.operator_name = o.operator_name;

-- Yorum: Toplam 10 satır döndü; 1. sorguda operatörü atanmamış (NULL) olduğu için kaybolan Mars-03 bu sorguda operatör bilgileri NULL olarak listelendi.


-- Soru 3: Hiç görev almamış robotların adı ve modeli
SELECT r.name AS robot_adi,
       r.model
FROM robots r
LEFT JOIN missions m ON r.id = m.robot_id
WHERE m.id IS NULL;

-- Yorum: Toplam 4 satır döndü çünkü missions tablosunda hiç kaydı bulunmayan robotlar yalnızca Kartal-02, Atlas-03, Mars-03 ve Kartal-04'tür.


-- Soru 4a: JOIN ile hesaplanan toplam batarya (görevi olan robotlar)
SELECT SUM(r.battery_level) AS join_toplam_batarya
FROM robots r
INNER JOIN missions m ON r.id = m.robot_id;

-- Soru 4b: JOIN kullanmadan doğru toplam
SELECT SUM(r.battery_level) AS dogru_toplam_batarya
FROM robots r
WHERE r.id IN (SELECT DISTINCT m.robot_id FROM missions m);

-- Yorum (iki sonuç ve fark): JOIN ile toplam 700 çıkarken JOIN olmadan doğru toplam 262 çıktı; birden fazla görevi olan robotların bataryaları her görev satırı için tekrar toplandığından sonuç 438 fazla hesaplandı.


-- Soru 5: Robot başına görev sayısı; count(*) ve count(m.id) yan yana
SELECT r.name AS robot_adi,
       COUNT(*) AS count_yildiz,
       COUNT(m.id) AS gorev_sayisi
FROM robots r
LEFT JOIN missions m ON r.id = m.robot_id
GROUP BY r.id, r.name
ORDER BY r.id;

-- Yorum (hangi robotlarda ikisi farklı?): Toplam 10 satır döndü; hiç görevi olmayan Kartal-02, Atlas-03, Mars-03 ve Kartal-04 için LEFT JOIN sonrası oluşan NULL satırı COUNT(*) 1 olarak sayarken COUNT(m.id) 0 saydığı için sonuçlar farklı çıktı.-- Ödev 2, Bölüm 1: Filo soruları
-- Ad Soyad: Ali Aktemur
-- Veritabanı: robot_fleet
-- Her sorgunun altına sonucu açıklayan tek cümlelik yorum yaz.

-- Soru 1: Her robotun adı, operatör adı ve operatör telefonu (INNER JOIN)
SELECT r.name AS robot_adi,
       o.operator_name AS operator_adi,
       o.phone AS operator_telefonu
FROM robots r
INNER JOIN operators o ON r.operator_name = o.operator_name;

-- Yorum: Toplam 9 satır döndü çünkü INNER JOIN yalnızca operator_name değeri boş (NULL) olmayan ve operators tablosuyla eşleşen robotları getirdi.


-- Soru 2: Aynı liste, bütün robotlar görünsün (LEFT JOIN). 1. sorguyla karşılaştır, kim kayboldu?
SELECT r.name AS robot_adi,
       o.operator_name AS operator_adi,
       o.phone AS operator_telefonu
FROM robots r
LEFT JOIN operators o ON r.operator_name = o.operator_name;

-- Yorum: Toplam 10 satır döndü; 1. sorguda operatörü atanmamış (NULL) olduğu için kaybolan Mars-03 bu sorguda operatör bilgileri NULL olarak listelendi.


-- Soru 3: Hiç görev almamış robotların adı ve modeli
SELECT r.name AS robot_adi,
       r.model
FROM robots r
LEFT JOIN missions m ON r.id = m.robot_id
WHERE m.id IS NULL;

-- Yorum: Toplam 4 satır döndü çünkü missions tablosunda hiç kaydı bulunmayan robotlar yalnızca Kartal-02, Atlas-03, Mars-03 ve Kartal-04'tür.


-- Soru 4a: JOIN ile hesaplanan toplam batarya (görevi olan robotlar)
SELECT SUM(r.battery_level) AS join_toplam_batarya
FROM robots r
INNER JOIN missions m ON r.id = m.robot_id;

-- Soru 4b: JOIN kullanmadan doğru toplam
SELECT SUM(r.battery_level) AS dogru_toplam_batarya
FROM robots r
WHERE r.id IN (SELECT DISTINCT m.robot_id FROM missions m);

-- Yorum (iki sonuç ve fark): JOIN ile toplam 700 çıkarken JOIN olmadan doğru toplam 262 çıktı; birden fazla görevi olan robotların bataryaları her görev satırı için tekrar toplandığından sonuç 438 fazla hesaplandı.


-- Soru 5: Robot başına görev sayısı; count(*) ve count(m.id) yan yana
SELECT r.name AS robot_adi,
       COUNT(*) AS count_yildiz,
       COUNT(m.id) AS gorev_sayisi
FROM robots r
LEFT JOIN missions m ON r.id = m.robot_id
GROUP BY r.id, r.name
ORDER BY r.id;

-- Yorum (hangi robotlarda ikisi farklı?): Toplam 10 satır döndü; hiç görevi olmayan Kartal-02, Atlas-03, Mars-03 ve Kartal-04 için LEFT JOIN sonrası oluşan NULL satırı COUNT(*) 1 olarak sayarken COUNT(m.id) 0 saydığı için sonuçlar farklı çıktı.
