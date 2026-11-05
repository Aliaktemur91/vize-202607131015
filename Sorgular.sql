-- 1. Tablo Oluşturma
CREATE TABLE IF NOT EXISTS evaluations (
    id INT,
    model_id INT,
    scenario_id INT,
    accuracy_1_5 INT, 
    latency_ms DECIMAL(10,2), 
    total_tokens INT
);

-- 2. 500 Satırlık Veri ve Tuzakların Üretilmesi
INSERT INTO evaluations (id, model_id, scenario_id, accuracy_1_5, latency_ms, total_tokens)
SELECT 
    g.id,
    CASE WHEN g.id <= 250 THEN 1 ELSE 2 END,
    (random() * 49 + 1)::INT,
    CASE 
        WHEN random() < 0.1 THEN NULL 
        ELSE (random() * 4 + 1)::INT 
    END,
    CASE 
        WHEN random() < 0.15 THEN (random() * 1.5 + 0.8) 
        ELSE (random() * 1500 + 800) 
    END,
    (random() * 400 + 50)::INT
FROM generate_series(1, 500) AS g(id);

-- 3. Hafta 5 Analiz Sorgusu (Birim Düzeltme ve NULL Filtreleme)
SELECT 
    model_id,
    COUNT(*) AS total_scenarios,
    AVG(accuracy_1_5) AS avg_accuracy,
    AVG(CASE 
        WHEN latency_ms < 10 THEN latency_ms * 1000 
        ELSE latency_ms 
    END) AS corrected_latency_ms
FROM 
    evaluations
WHERE 
    accuracy_1_5 IS NOT NULL
GROUP BY 
    model_id
HAVING 
    COUNT(*) >= 20;
