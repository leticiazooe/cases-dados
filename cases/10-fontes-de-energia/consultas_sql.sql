-- 1. Participação da matriz e geração por fonte
SELECT f.classificacao,f.fonte,ROUND(SUM(g.geracao_liquida_mwh)/1000,1) geracao_gwh FROM fato_geracao_mensal g JOIN dim_usina u ON u.usina_id=g.usina_id JOIN dim_fonte_energia f ON f.fonte_id=u.fonte_id GROUP BY f.classificacao,f.fonte ORDER BY geracao_gwh DESC;
-- 2. Custo médio por MWh por fonte
SELECT f.fonte,ROUND(SUM(c.valor_rs)/SUM(g.geracao_liquida_mwh),2) custo_rs_mwh FROM dim_usina u JOIN dim_fonte_energia f ON f.fonte_id=u.fonte_id JOIN fato_custo c ON c.usina_id=u.usina_id JOIN fato_geracao_mensal g ON g.usina_id=u.usina_id AND g.competencia=c.competencia GROUP BY f.fonte;
-- 3. Emissões e intensidade
SELECT f.classificacao,f.fonte,ROUND(SUM(e.emissoes_tco2e),1) tco2e,ROUND(SUM(e.emissoes_tco2e)/SUM(g.geracao_liquida_mwh),3) intensidade FROM fato_emissao e JOIN dim_usina u ON u.usina_id=e.usina_id JOIN dim_fonte_energia f ON f.fonte_id=u.fonte_id JOIN fato_geracao_mensal g ON g.usina_id=e.usina_id AND g.competencia=e.competencia GROUP BY f.classificacao,f.fonte;
-- 4. Fator de capacidade e disponibilidade
SELECT u.usina,f.fonte,ROUND(AVG(g.fator_capacidade)*100,1) fator_capacidade_pct,ROUND(AVG(g.disponibilidade)*100,1) disponibilidade_pct FROM fato_geracao_mensal g JOIN dim_usina u ON u.usina_id=g.usina_id JOIN dim_fonte_energia f ON f.fonte_id=u.fonte_id GROUP BY u.usina_id ORDER BY fator_capacidade_pct DESC;
-- 5. Indisponibilidades não planejadas
SELECT u.usina,COUNT(*) eventos,ROUND(SUM(i.duracao_horas),1) horas,ROUND(SUM(i.energia_nao_gerada_mwh),1) mwh_perdidos FROM fato_indisponibilidade i JOIN dim_usina u ON u.usina_id=i.usina_id WHERE i.tipo='Não planejada' GROUP BY u.usina_id ORDER BY mwh_perdidos DESC;
-- 6. Curtailment renovável
SELECT f.fonte,ROUND(SUM(g.corte_mwh),1) corte_mwh,ROUND(SUM(g.corte_mwh)/SUM(g.geracao_bruta_mwh)*100,2) corte_pct FROM fato_geracao_mensal g JOIN dim_usina u ON u.usina_id=g.usina_id JOIN dim_fonte_energia f ON f.fonte_id=u.fonte_id WHERE f.classificacao='Renovável' GROUP BY f.fonte;
-- 7. Contratos ativos e receita
SELECT f.fonte,COUNT(*) contratos,ROUND(SUM(c.volume_mwh),1) volume_mwh,ROUND(SUM(c.receita_contratada_rs),2) receita FROM fato_contrato c JOIN dim_usina u ON u.usina_id=c.usina_id JOIN dim_fonte_energia f ON f.fonte_id=u.fonte_id WHERE c.status='Ativo' GROUP BY f.fonte;
-- 8. Investimentos e desvios
SELECT f.fonte,i.status,ROUND(SUM(i.orcamento_rs),2) orcado,ROUND(SUM(i.realizado_rs),2) realizado,ROUND(SUM(i.realizado_rs-i.orcamento_rs),2) desvio FROM fato_investimento i JOIN dim_usina u ON u.usina_id=i.usina_id JOIN dim_fonte_energia f ON f.fonte_id=u.fonte_id GROUP BY f.fonte,i.status;
