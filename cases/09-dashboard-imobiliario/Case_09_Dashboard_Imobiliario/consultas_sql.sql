-- 1. Preço médio por m² e bairro
SELECT l.cidade,l.bairro,ROUND(AVG(i.valor_estimado/i.area_m2),2) preco_m2,COUNT(*) imoveis FROM fato_imovel i JOIN dim_localizacao l ON l.localizacao_id=i.localizacao_id GROUP BY l.localizacao_id ORDER BY preco_m2 DESC;
-- 2. Valorização no período
WITH p AS (SELECT imovel_id,MIN(competencia) primeira,MAX(competencia) ultima FROM fato_historico_preco GROUP BY imovel_id) SELECT l.bairro,ROUND(AVG((h2.valor_estimado/h1.valor_estimado)-1),4) valorizacao FROM p JOIN fato_historico_preco h1 ON h1.imovel_id=p.imovel_id AND h1.competencia=p.primeira JOIN fato_historico_preco h2 ON h2.imovel_id=p.imovel_id AND h2.competencia=p.ultima JOIN fato_imovel i ON i.imovel_id=p.imovel_id JOIN dim_localizacao l ON l.localizacao_id=i.localizacao_id GROUP BY l.bairro ORDER BY valorizacao DESC;
-- 3. Rentabilidade bruta estimada
SELECT codigo,ROUND(12*aluguel_estimado/valor_estimado,4) yield_anual FROM fato_imovel ORDER BY yield_anual DESC;
-- 4. Vacância atual por bairro
SELECT l.bairro,COUNT(DISTINCT v.imovel_id) vagos,COUNT(DISTINCT i.imovel_id) total,ROUND(COUNT(DISTINCT v.imovel_id)*1.0/COUNT(DISTINCT i.imovel_id),4) taxa FROM fato_imovel i JOIN dim_localizacao l ON l.localizacao_id=i.localizacao_id LEFT JOIN fato_vacancia v ON v.imovel_id=i.imovel_id AND v.data_fim IS NULL GROUP BY l.localizacao_id;
-- 5. Tempo médio de vacância
SELECT l.bairro,ROUND(AVG(v.dias_vago),1) dias FROM fato_vacancia v JOIN fato_imovel i ON i.imovel_id=v.imovel_id JOIN dim_localizacao l ON l.localizacao_id=i.localizacao_id GROUP BY l.bairro ORDER BY dias DESC;
-- 6. Aluguéis ativos e receita mensal
SELECT l.cidade,l.bairro,COUNT(*) contratos,ROUND(SUM(c.valor_aluguel),2) receita FROM fato_contrato_aluguel c JOIN fato_imovel i ON i.imovel_id=c.imovel_id JOIN dim_localizacao l ON l.localizacao_id=i.localizacao_id WHERE c.status='Ativo' GROUP BY l.localizacao_id ORDER BY receita DESC;
-- 7. Desconto de venda
SELECT l.bairro,ROUND(AVG(t.desconto_pct),4) desconto_medio,ROUND(AVG(t.dias_mercado),1) dias_mercado FROM fato_transacao t JOIN fato_imovel i ON i.imovel_id=t.imovel_id JOIN dim_localizacao l ON l.localizacao_id=i.localizacao_id GROUP BY l.bairro;
-- 8. Conversão de anúncios
SELECT canal,COUNT(*) anuncios,SUM(leads) leads,SUM(CASE WHEN status='Convertido' THEN 1 ELSE 0 END) convertidos,ROUND(SUM(CASE WHEN status='Convertido' THEN 1.0 ELSE 0 END)/COUNT(*),4) conversao FROM fato_anuncio GROUP BY canal;
-- 9. Perfil do estoque
SELECT t.nome,i.perfil,COUNT(*) qtd,ROUND(AVG(i.area_m2),1) area_media,ROUND(AVG(i.valor_estimado),2) valor_medio FROM fato_imovel i JOIN dim_tipo_imovel t ON t.tipo_id=i.tipo_id GROUP BY t.nome,i.perfil;
-- 10. Propostas abaixo do preço
SELECT a.anuncio_id,i.codigo,a.preco_anunciado,ROUND(AVG(p.valor_proposta),2) proposta_media,COUNT(*) propostas FROM fato_proposta p JOIN fato_anuncio a ON a.anuncio_id=p.anuncio_id JOIN fato_imovel i ON i.imovel_id=a.imovel_id GROUP BY a.anuncio_id ORDER BY propostas DESC;
