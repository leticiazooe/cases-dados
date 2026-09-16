-- Consultas iniciais; adapte ao SGBD de destino.
-- 1. Volume total da principal tabela fato
SELECT COUNT(*) AS total_registros FROM "movimentacoes";
-- 2. Distribuição da tabela principal
SELECT * FROM "movimentacoes" ORDER BY 1 DESC LIMIT 100;
-- 3. Estatística do campo movimentacao_id
SELECT COUNT("movimentacao_id") AS registros, ROUND(AVG("movimentacao_id"),2) AS media, MIN("movimentacao_id") AS minimo, MAX("movimentacao_id") AS maximo FROM "movimentacoes";
-- 4. Validação de chaves duplicadas
SELECT "movimentacao_id", COUNT(*) FROM "movimentacoes" GROUP BY 1 HAVING COUNT(*) > 1;
