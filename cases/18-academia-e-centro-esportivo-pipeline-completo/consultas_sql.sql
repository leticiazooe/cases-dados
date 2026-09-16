-- Consultas iniciais; adapte ao SGBD de destino.
-- 1. Volume total da principal tabela fato
SELECT COUNT(*) AS total_registros FROM "pagamentos";
-- 2. Distribuição da tabela principal
SELECT * FROM "pagamentos" ORDER BY 1 DESC LIMIT 100;
-- 3. Estatística do campo valor
SELECT COUNT("valor") AS registros, ROUND(AVG("valor"),2) AS media, MIN("valor") AS minimo, MAX("valor") AS maximo FROM "pagamentos";
-- 4. Validação de chaves duplicadas
SELECT "pagamento_id", COUNT(*) FROM "pagamentos" GROUP BY 1 HAVING COUNT(*) > 1;
