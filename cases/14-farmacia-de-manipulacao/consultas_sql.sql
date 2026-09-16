-- 1. Pedidos e receita por filial
SELECT f.filial,COUNT(*) pedidos,ROUND(SUM(p.valor_liquido),2) valor_pedidos,ROUND(SUM(v.receita),2) receita FROM fato_pedido p JOIN dim_filial f ON f.filial_id=p.filial_id LEFT JOIN fato_venda v ON v.pedido_id=p.pedido_id GROUP BY f.filial_id;
-- 2. Tempo médio de produção por forma farmacêutica
SELECT fo.forma_farmaceutica,COUNT(*) producoes,ROUND(AVG(pr.tempo_producao_dias),2) tempo_medio_dias FROM fato_producao pr JOIN fato_pedido p ON p.pedido_id=pr.pedido_id JOIN fato_prescricao r ON r.prescricao_id=p.prescricao_id JOIN dim_formula fo ON fo.formula_id=r.formula_id GROUP BY fo.forma_farmaceutica;
-- 3. Taxa de aprovação da qualidade
SELECT resultado,COUNT(*) controles,ROUND(COUNT(*)*100.0/SUM(COUNT(*)) OVER(),2) percentual FROM fato_controle_qualidade GROUP BY resultado;
-- 4. Lotes vencidos ou próximos do vencimento
SELECT i.insumo,l.codigo_lote,l.validade,l.saldo_atual,l.status,f.fornecedor FROM fato_lote_insumo l JOIN dim_insumo i ON i.insumo_id=l.insumo_id JOIN dim_fornecedor f ON f.fornecedor_id=l.fornecedor_id WHERE l.saldo_atual>0 AND l.validade<='2026-09-30' ORDER BY l.validade;
-- 5. Rentabilidade estimada por fórmula
SELECT fo.formula,COUNT(*) vendas,ROUND(SUM(v.receita),2) receita,ROUND(SUM(v.receita-v.custo_estimado),2) margem,ROUND(SUM(v.receita-v.custo_estimado)/SUM(v.receita)*100,1) margem_pct FROM fato_venda v JOIN fato_pedido p ON p.pedido_id=v.pedido_id JOIN fato_prescricao r ON r.prescricao_id=p.prescricao_id JOIN dim_formula fo ON fo.formula_id=r.formula_id GROUP BY fo.formula_id ORDER BY margem DESC;
-- 6. Entregas no prazo
SELECT modalidade,COUNT(*) entregas,ROUND(AVG(no_prazo)*100,1) no_prazo_pct FROM fato_entrega GROUP BY modalidade;
-- 7. Especialidades prescritoras
SELECT m.especialidade,COUNT(*) prescricoes,COUNT(DISTINCT m.medico_id) prescritores FROM fato_prescricao r JOIN dim_medico m ON m.medico_id=r.medico_id GROUP BY m.especialidade ORDER BY prescricoes DESC;
-- 8. Insumos por saldo e validade
SELECT i.insumo,i.unidade_medida,ROUND(SUM(l.saldo_atual),2) saldo,MIN(l.validade) proxima_validade FROM fato_lote_insumo l JOIN dim_insumo i ON i.insumo_id=l.insumo_id WHERE l.status='Liberado' GROUP BY i.insumo_id ORDER BY proxima_validade;
