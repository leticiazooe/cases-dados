-- 1. Membros por plano e status
SELECT p.nome AS plano,m.status,COUNT(*) AS membros FROM fato_membro m JOIN dim_plano p ON p.plano_id=m.plano_id GROUP BY p.nome,m.status;
-- 2. Receita recorrente mensal estimada
SELECT ROUND(SUM(p.valor_mensal),2) AS mrr FROM fato_membro m JOIN dim_plano p ON p.plano_id=m.plano_id WHERE m.status='Ativo';
-- 3. Visitas e receita por unidade
SELECT u.nome,COUNT(*) visitas,SUM(v.qtd_pessoas) visitantes,ROUND(SUM(v.valor_pago),2) receita FROM fato_visita v JOIN dim_unidade u ON u.unidade_id=v.unidade_id GROUP BY u.unidade_id ORDER BY visitantes DESC;
-- 4. Frequência média por cliente
SELECT ROUND(AVG(visitas),2) FROM (SELECT cliente_id,COUNT(*) visitas FROM fato_visita GROUP BY cliente_id);
-- 5. Receita e margem da loja
SELECT p.categoria,ROUND(SUM(i.valor_liquido),2) receita,ROUND(SUM(i.valor_liquido-i.quantidade*p.custo),2) margem FROM fato_item_venda i JOIN dim_produto p ON p.produto_id=i.produto_id GROUP BY p.categoria ORDER BY receita DESC;
-- 6. Eventos por ocupação
SELECT e.nome,e.data_evento,e.capacidade,COALESCE(SUM(i.quantidade),0) vendidos,ROUND(COALESCE(SUM(i.quantidade),0)*1.0/e.capacidade,4) ocupacao FROM dim_evento e LEFT JOIN fato_ingresso_evento i ON i.evento_id=e.evento_id GROUP BY e.evento_id ORDER BY ocupacao DESC;
-- 7. Funil de marketing
SELECT c.nome,SUM(i.impressoes) impressoes,SUM(i.clique) cliques,SUM(i.conversao) conversoes,ROUND(SUM(i.receita_atribuida),2) receita,ROUND(SUM(i.receita_atribuida)-c.investimento,2) retorno FROM dim_campanha c JOIN fato_interacao_campanha i ON i.campanha_id=c.campanha_id GROUP BY c.campanha_id;
-- 8. NPS geral
SELECT ROUND(100.0*SUM(CASE WHEN nps>=9 THEN 1 ELSE 0 END)/COUNT(*)-100.0*SUM(CASE WHEN nps<=6 THEN 1 ELSE 0 END)/COUNT(*),1) nps FROM fato_avaliacao;
-- 9. Feedback por tema
SELECT tema,ROUND(AVG(nota),2) nota_media,COUNT(*) avaliacoes FROM fato_avaliacao GROUP BY tema ORDER BY nota_media;
-- 10. Clientes sem visita recente
SELECT c.cliente_id,c.nome,MAX(v.data_visita) ultima_visita FROM dim_cliente c LEFT JOIN fato_visita v ON v.cliente_id=c.cliente_id GROUP BY c.cliente_id HAVING MAX(v.data_visita)<'2026-01-01' OR MAX(v.data_visita) IS NULL;
