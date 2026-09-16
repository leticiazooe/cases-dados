-- Ordens por status
SELECT status_os,COUNT(*) quantidade FROM ordem_servico GROUP BY status_os ORDER BY quantidade DESC;

-- Preventivas e corretivas por mês
SELECT strftime('%Y-%m',o.data_abertura) mes,t.classificacao,COUNT(*) ordens
FROM ordem_servico o JOIN dim_tipo_manutencao t ON t.id_tipo_manutencao=o.id_tipo_manutencao
GROUP BY mes,t.classificacao ORDER BY mes;

-- Equipamentos com mais falhas
SELECT e.codigo,e.equipamento,e.criticidade,COUNT(*) falhas
FROM fato_falha f JOIN dim_equipamento e ON e.id_equipamento=f.id_equipamento
GROUP BY e.id_equipamento ORDER BY falhas DESC LIMIT 15;

-- MTTR por equipamento, em horas
SELECT e.codigo,e.equipamento,ROUND(AVG(p.duracao_minutos)/60.0,2) mttr_horas
FROM fato_parada p JOIN dim_equipamento e ON e.id_equipamento=p.id_equipamento
GROUP BY e.id_equipamento ORDER BY mttr_horas DESC;

-- MTBF aproximado usando horas disponíveis e falhas
WITH prod AS (SELECT id_linha,SUM(horas_disponiveis) horas FROM fato_producao GROUP BY id_linha), fal AS (SELECT e.id_linha,e.id_equipamento,COUNT(*) falhas FROM fato_falha f JOIN dim_equipamento e ON e.id_equipamento=f.id_equipamento GROUP BY e.id_equipamento)
SELECT e.codigo,e.equipamento,ROUND(p.horas/NULLIF(f.falhas,0),2) mtbf_horas
FROM fal f JOIN dim_equipamento e ON e.id_equipamento=f.id_equipamento JOIN prod p ON p.id_linha=e.id_linha
ORDER BY mtbf_horas;

-- Disponibilidade por linha
SELECT l.linha,ROUND(100.0*SUM(p.horas_disponiveis)/NULLIF(SUM(p.horas_programadas),0),2) disponibilidade_pct
FROM fato_producao p JOIN dim_linha l ON l.id_linha=p.id_linha GROUP BY l.id_linha ORDER BY disponibilidade_pct;

-- Cumprimento preventivo
SELECT status_plano,COUNT(*) planos,ROUND(100.0*COUNT(*)/(SELECT COUNT(*) FROM plano_preventivo),1) percentual FROM plano_preventivo GROUP BY status_plano;

-- Custo total por equipamento
SELECT e.codigo,e.equipamento,ROUND(SUM(o.custo_mao_obra+o.custo_pecas+o.custo_terceiros),2) custo_total
FROM ordem_servico o JOIN dim_equipamento e ON e.id_equipamento=o.id_equipamento
GROUP BY e.id_equipamento ORDER BY custo_total DESC LIMIT 20;

-- Paradas não planejadas
SELECT e.codigo,e.equipamento,COUNT(*) paradas,ROUND(SUM(p.duracao_minutos)/60.0,1) horas_paradas,ROUND(SUM(p.custo_estimado),2) custo
FROM fato_parada p JOIN dim_equipamento e ON e.id_equipamento=p.id_equipamento WHERE p.planejada=0
GROUP BY e.id_equipamento ORDER BY custo DESC;

-- Peças abaixo do estoque mínimo
SELECT codigo_peca,descricao,estoque_atual,estoque_minimo,item_critico FROM dim_peca WHERE estoque_atual<estoque_minimo ORDER BY item_critico DESC,estoque_atual;

-- Retrabalho
SELECT ROUND(100.0*SUM(retrabalho)/NULLIF(COUNT(*),0),2) taxa_retrabalho_pct FROM ordem_servico WHERE status_os IN ('Concluída','Encerrada');

-- Fornecedores e custos
SELECT f.fornecedor_ficticio,f.avaliacao,f.prazo_medio_dias,COUNT(s.id_servico) servicos,ROUND(SUM(s.custo_final),2) custo
FROM dim_fornecedor f LEFT JOIN fato_servico_terceirizado s ON s.id_fornecedor=f.id_fornecedor GROUP BY f.id_fornecedor ORDER BY f.avaliacao DESC;
