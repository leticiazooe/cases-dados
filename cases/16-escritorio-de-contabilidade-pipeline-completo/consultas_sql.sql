-- Consultas iniciais; adapte ao SGBD de destino.
-- 1. Volume total da principal tabela fato
SELECT COUNT(*) AS total_registros FROM "obrigacoes";
-- 2. Distribuição da tabela principal
SELECT * FROM "obrigacoes" ORDER BY 1 DESC LIMIT 100;
-- 3. Estatística do campo obrigacao_id
SELECT COUNT("obrigacao_id") AS registros, ROUND(AVG("obrigacao_id"),2) AS media, MIN("obrigacao_id") AS minimo, MAX("obrigacao_id") AS maximo FROM "obrigacoes";
-- 4. Validação de chaves duplicadas
SELECT "obrigacao_id", COUNT(*) FROM "obrigacoes" GROUP BY 1 HAVING COUNT(*) > 1;
