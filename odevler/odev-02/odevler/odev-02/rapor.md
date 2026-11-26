# Ödev 2 Raporu — JOIN, ERD ve Normalizasyon

* **Ad Soyad:** Ali Aktemur
* **Öğrenci No:** 202607131015
* **Ders:** BLP 105 Veritabanı Yönetim Sistemleri
* **Tarih:** 25 Kasım 2026

**Yapay Zekâ Kullanım Beyanı:** Bu ödevde SQL sorgularının oluşturulması, Mermaid ERD sözdiziminin düzenlenmesi ve rapor metninin yapılandırılması aşamalarında yapay zekâ aracından (Gemini) destek alınmıştır; tüm sorgu sonuçları ve veritabanı tasarım kararları tarafımdan kontrol edilerek doğrulanmıştır.

---

## 1. Fan-out (Çoklama) Etkisi

Bölüm 1'deki 4. soruda görevi olan robotların toplam batarya seviyesi, `JOIN` kullanılmadan hesaplandığında **262** iken `robots` ve `missions` tabloları `INNER JOIN` ile birleştirildiğinde **700**'e çıkmıştır (toplam **438** birim fazladan hesaplanmıştır). Bunun nedeni, birden fazla görevi olan robotların her görev satırı için tekrar listelenmesidir: **Atlas-01** (82), **Kartal-01** (18) ve **Kartal-03** (91) üçer kez; **Mars-01** (47) ve **Mars-02** (9) ikişer kez toplama dahil edilmiştir (yalnızca tek görevi olan **Atlas-02** 1 kez sayılmıştır). Gerçek bir filo yönetim raporunda bu hata, mevcut toplam enerji kapasitesinin olduğundan yaklaşık 2,6 kat fazla görünmesine yol açar; bu da vardiya planlamasında yetersiz bataryayla robotların sahaya sürülmesine ve operasyonların yarıda kesilmesine neden olur.

## 2. En Zor Tasarım Kararı

Kendi projemin ERD'sinde en çok düşündüğüm karar, yapay zeka modellerinin birim maliyet ve sağlayıcı bilgilerini (`provider`, `cost_per_1k_tokens`) doğrudan yanıt tablosunda (`MODEL_RESPONSES`) tutmak yerine ayrı bir `AI_MODELS` tablosuna ayırmaktı. Tek tablo yapısında sorgu yazmak daha kolay görünse de iki modelin yüzlerce yanıt ürettiği bir senaryoda sağlayıcı adı ve birim fiyat her satırda tekrar edecek, ayrıca ileride bir modelin token fiyatı güncellendiğinde geçmiş tüm kayıtların değişmesi veya tutarsızlık oluşması riski doğacaktı. Bu nedenle 3. Normal Form (3NF) kurallarını korumak ve geçmiş yanıtların o anki maliyetini (`response_cost`) bozmadan model tanımlarını merkezileştirmek için `AI_MODELS` tablosunu ayırmayı seçtim.
