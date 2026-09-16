-- Consultas iniciais; adapte ao SGBD de destino.
-- 1. Volume total da principal tabela fato
SELECT COUNT(*) AS total_registros FROM "pecas_utilizadas";
-- 2. Distribuição da tabela principal
SELECT * FROM "pecas_utilizadas" ORDER BY 1 DESC LIMIT 100;
-- 3. Estatística do campo uso_id
SELECT COUNT("uso_id") AS registros, ROUND(AVG("uso_id"),2) AS media, MIN("uso_id") AS minimo, MAX("uso_id") AS maximo FROM "pecas_utilizadas";
-- 4. Validação de chaves duplicadas
SELECT "uso_id", COUNT(*) FROM "pecas_utilizadas" GROUP BY 1 HAVING COUNT(*) > 1;
