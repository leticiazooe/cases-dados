-- 1. Inventário por tipo e status
SELECT t.categoria,t.tipo,a.status,COUNT(*) quantidade,ROUND(SUM(a.custo_aquisicao),2) valor_aquisicao,ROUND(SUM(a.valor_contabil),2) valor_contabil FROM fato_ativo a JOIN dim_tipo_ativo t ON t.tipo_id=a.tipo_id GROUP BY t.categoria,t.tipo,a.status;
-- 2. Garantias vencidas e próximas do vencimento
SELECT a.patrimonio,t.tipo,a.modelo,a.fim_garantia,l.local,u.unidade FROM fato_ativo a JOIN dim_tipo_ativo t ON t.tipo_id=a.tipo_id JOIN dim_localizacao l ON l.localizacao_id=a.localizacao_id JOIN dim_unidade u ON u.unidade_id=l.unidade_id WHERE a.status<>'Baixado' AND a.fim_garantia<='2026-12-31' ORDER BY a.fim_garantia;
-- 3. Ativos sem responsável
SELECT a.patrimonio,t.tipo,u.unidade,l.local,a.status FROM fato_ativo a JOIN dim_tipo_ativo t ON t.tipo_id=a.tipo_id JOIN dim_localizacao l ON l.localizacao_id=a.localizacao_id JOIN dim_unidade u ON u.unidade_id=l.unidade_id LEFT JOIN fato_atribuicao x ON x.ativo_id=a.ativo_id AND x.data_fim IS NULL WHERE a.status='Em uso' AND x.atribuicao_id IS NULL;
-- 4. Custo e indisponibilidade de manutenção
SELECT t.tipo,COUNT(m.manutencao_id) manutencoes,ROUND(SUM(m.custo),2) custo,ROUND(AVG(m.indisponibilidade_dias),1) dias_indisponiveis FROM fato_manutencao m JOIN fato_ativo a ON a.ativo_id=m.ativo_id JOIN dim_tipo_ativo t ON t.tipo_id=a.tipo_id GROUP BY t.tipo ORDER BY custo DESC;
-- 5. Ativos depreciados ainda em uso
SELECT t.tipo,COUNT(*) ativos,ROUND(SUM(a.custo_aquisicao),2) custo_historico FROM fato_ativo a JOIN dim_tipo_ativo t ON t.tipo_id=a.tipo_id WHERE a.valor_contabil=0 AND a.status='Em uso' GROUP BY t.tipo;
-- 6. Utilização de licenças
SELECT s.software,c.codigo,c.quantidade_adquirida,COUNT(a.alocacao_id) utilizadas,c.quantidade_adquirida-COUNT(a.alocacao_id) disponiveis,ROUND(COUNT(a.alocacao_id)*100.0/c.quantidade_adquirida,1) utilizacao_pct FROM fato_contrato_licenca c JOIN dim_software s ON s.software_id=c.software_id LEFT JOIN fato_alocacao_licenca a ON a.contrato_id=c.contrato_id AND a.status='Ativa' GROUP BY c.contrato_id;
-- 7. Custo por unidade
SELECT u.unidade,COUNT(*) ativos,ROUND(SUM(a.custo_aquisicao),2) aquisicao,ROUND(SUM(a.valor_contabil),2) valor_contabil FROM fato_ativo a JOIN dim_localizacao l ON l.localizacao_id=a.localizacao_id JOIN dim_unidade u ON u.unidade_id=l.unidade_id GROUP BY u.unidade;
-- 8. Histórico de movimentação
SELECT a.patrimonio,t.tipo,m.data_movimentacao,o.local origem,d.local destino,m.tipo FROM fato_movimentacao m JOIN fato_ativo a ON a.ativo_id=m.ativo_id JOIN dim_tipo_ativo t ON t.tipo_id=a.tipo_id JOIN dim_localizacao o ON o.localizacao_id=m.origem_id JOIN dim_localizacao d ON d.localizacao_id=m.destino_id ORDER BY m.data_movimentacao DESC;
