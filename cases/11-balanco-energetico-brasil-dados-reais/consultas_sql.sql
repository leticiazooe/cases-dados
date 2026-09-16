-- 1. Evolução nacional dos fluxos
SELECT ano,ROUND(producao_total_ktep,1) producao,ROUND(importacao_total_ktep,1) importacao,
ROUND(exportacao_total_ktep,1) exportacao,ROUND(saldo_fisico_ktep,1) saldo FROM dim_tempo ORDER BY ano;

-- 2. Fontes com maior produção em 2024
SELECT e.fonte,e.grupo_energetico,e.classificacao,ROUND(f.valor_ktep,1) producao_ktep
FROM fato_fluxo_energetico f JOIN dim_fonte_energia e ON e.fonte_id=f.fonte_id
WHERE f.ano=2024 AND f.operacao='Produção' ORDER BY f.valor_ktep DESC;

-- 3. Dependência de importações por fonte
SELECT e.fonte,ROUND(SUM(CASE WHEN f.operacao='Importação' THEN f.valor_ktep ELSE 0 END),1) importacao,
ROUND(SUM(CASE WHEN f.operacao='Produção' THEN f.valor_ktep ELSE 0 END),1) producao,
ROUND(SUM(CASE WHEN f.operacao='Importação' THEN f.valor_ktep ELSE 0 END)/
NULLIF(SUM(CASE WHEN f.operacao IN ('Importação','Produção') THEN f.valor_ktep ELSE 0 END),0)*100,2) dependencia_pct
FROM fato_fluxo_energetico f JOIN dim_fonte_energia e ON e.fonte_id=f.fonte_id
GROUP BY e.fonte ORDER BY dependencia_pct DESC;

-- 4. Saldo físico por produto em 2024
SELECT e.fonte,ROUND(SUM(CASE WHEN f.operacao='Exportação' THEN f.valor_ktep
WHEN f.operacao='Importação' THEN -f.valor_ktep ELSE 0 END),1) saldo_ktep
FROM fato_fluxo_energetico f JOIN dim_fonte_energia e ON e.fonte_id=f.fonte_id
WHERE f.ano=2024 GROUP BY e.fonte ORDER BY saldo_ktep DESC;

-- 5. Renovável versus não renovável
SELECT f.ano,e.classificacao,f.operacao,ROUND(SUM(f.valor_ktep),1) valor_ktep
FROM fato_fluxo_energetico f JOIN dim_fonte_energia e ON e.fonte_id=f.fonte_id
GROUP BY f.ano,e.classificacao,f.operacao ORDER BY f.ano,e.classificacao,f.operacao;

-- 6. Crescimento 2010-2024 por fonte e operação
WITH p AS (SELECT fonte_id,operacao,
SUM(CASE WHEN ano=2010 THEN valor_ktep END) v2010,
SUM(CASE WHEN ano=2024 THEN valor_ktep END) v2024
FROM fato_fluxo_energetico GROUP BY fonte_id,operacao)
SELECT e.fonte,p.operacao,ROUND(p.v2010,1) v2010,ROUND(p.v2024,1) v2024,
ROUND((p.v2024/p.v2010-1)*100,1) variacao_pct
FROM p JOIN dim_fonte_energia e ON e.fonte_id=p.fonte_id WHERE p.v2010>0 ORDER BY variacao_pct DESC;
