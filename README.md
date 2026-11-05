# VTYS Vize Projesi: Model Performans Karşılaştırması (Kura #16)

**Öğrenci Adı Soyadı:** Ali Aktemur  
**Öğrenci No:** 202607131015  
**Program:** Yapay Zeka Operatörlüğü (YZO)  
**Ders:** BLP 105 / BLP 1005 - Veritabanı Yönetim Sistemleri (Güz 2026)  

---

## 📌 Proje Özeti
Bu proje, bir üniversite hazırlık programında öğrencilere İngilizce pratiği yaptıran iki farklı yapay zeka modelinin yanıt doğruluğu (accuracy), gecikme süresi (latency) ve maliyet kriterlerine göre karşılaştırılmasını konu almaktadır.

* **Kura Bilgisi:** Kura #16 (YZO × Eğitim × Sohbet Asistanı × Model Performans Karşılaştırması)
* **Veri Kaynağı:** [Hugging Face - LMSYS Chatbot Arena Conversations](https://huggingface.co/datasets/lmsys/chatbot_arena_conversations) (Apache 2.0 Lisansı)

---

## 📂 Proje Yapısı ve Yönlendirmeler



* **`sorgular.sql`**: Veritabanı tablosunun oluşturulması (`CREATE TABLE`), 500 satırlık test verisinin ve veri tuzaklarının üretilmesi (`generate_series`) ile 5. hafta analiz sorgularını (`CASE WHEN`, `GROUP BY`, `HAVING`) içerir.
* **`AI_BEYAN.md`**: Proje sürecinde yararlanılan yapay zeka araçlarının kullanım amacını belirten beyan dosyasıdır.
* **`evaluations` Tablosu**: 250'şer satır olmak üzere iki farklı modelin değerlendirme verilerini barındırır.

---

## 🛠️ Veri Tuzakları ve SQL Çözümleri

Veri setinde analiz sonuçlarını bozabilecek iki temel veri tuzağı kurgulanmış ve SQL ile temizlenmiştir:

1. **Ölçü Birimi Tutarsızlığı (Saniye / Milisaniye):**  
   Gecikme (latency) verilerinin bazı satırlarda saniye (örn: `1.2`), bazı satırlarda ise milisaniye (örn: `1500`) cinsinden kaydedildiği tespit edilmiştir. Sorgu içerisinde `CASE WHEN latency_ms < 10 THEN latency_ms * 1000` mantığı kullanılarak tüm değerler milisaniyeye dönüştürülmüştür.

2. **Eksik Değerlendirmeler (NULL Yönetimi):**  
   Yarıda kesilen sohbetler nedeniyle `accuracy_1_5` kolonunda oluşan `NULL` değerler, `WHERE accuracy_1_5 IS NOT NULL` koşulu ile filtrelenerek ortalama hesaplamasından hariç tutulmuştur.

---

## 📊 Sorgu Çıktısı ve Analiz Sonucu

psql (PostgreSQL Shell) üzerinde çalıştırılan nihai sorgu sonucunda aşağıdaki veriler elde edilmiştir:

| Model ID | Toplam Geçerli Senaryo | Ortalama Doğruluk (1-5) | Düzeltilmiş Gecikme (ms) |
| :--- | :--- | :--- | :--- |
| **Model 1** | 233 | 2.89 | 1572.61 ms |
| **Model 2** | 221 | 3.02 | 1533.61 ms |

**Sonuç:** Model 2, daha yüksek doğruluk puanı (3.02) ve daha düşük ortalama gecikme süresi (1533.61 ms) ile doğruluk ve hız parametreleri birlikte değerlendirildiğinde daha verimli model olarak öne çıkmaktadır.
