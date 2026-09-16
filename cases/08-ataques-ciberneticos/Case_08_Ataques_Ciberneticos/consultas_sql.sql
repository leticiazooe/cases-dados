-- 1. Alertas por severidade e tipo
SELECT severidade,tipo_ataque,COUNT(*) alertas FROM fato_alerta GROUP BY severidade,tipo_ataque ORDER BY alertas DESC;
-- 2. Taxa de alertas verdadeiros
SELECT ROUND(AVG(CASE WHEN falso_positivo=0 THEN 1.0 ELSE 0 END),4) taxa FROM fato_alerta;
-- 3. Incidentes por criticidade
SELECT severidade,status,COUNT(*) incidentes,ROUND(SUM(perda_estimada),2) perda FROM fato_incidente GROUP BY severidade,status;
-- 4. MTTD e MTTR
SELECT severidade,ROUND(AVG(mttd_min),1) mttd,ROUND(AVG(mttr_contencao_min),1) mttr FROM fato_incidente GROUP BY severidade;
-- 5. Vulnerabilidades fora do SLA
SELECT a.codigo,v.cve,v.severidade,v.status,CAST(julianday(COALESCE(v.data_correcao,'2026-06-30'))-julianday(v.data_deteccao) AS INTEGER) dias FROM fato_vulnerabilidade v JOIN dim_ativo a ON a.ativo_id=v.ativo_id WHERE v.status<>'Corrigida' OR julianday(v.data_correcao)-julianday(v.data_deteccao)>v.sla_dias ORDER BY dias DESC;
-- 6. Ativos com maior exposição
SELECT a.codigo,a.criticidade,COUNT(v.vulnerabilidade_id) vulnerabilidades,SUM(CASE WHEN v.severidade IN('Alta','Crítica') AND v.status<>'Corrigida' THEN 1 ELSE 0 END) criticas_abertas FROM dim_ativo a LEFT JOIN fato_vulnerabilidade v ON v.ativo_id=a.ativo_id GROUP BY a.ativo_id ORDER BY criticas_abertas DESC;
-- 7. Usuários com logins suspeitos
SELECT u.nome,a.nome area,COUNT(*) logins_suspeitos FROM fato_tentativa_login l JOIN dim_usuario u ON u.usuario_id=l.usuario_id JOIN dim_area a ON a.area_id=u.area_id WHERE l.login_suspeito=1 GROUP BY u.usuario_id ORDER BY logins_suspeitos DESC;
-- 8. Taxa de clique em phishing
SELECT tipo,ROUND(AVG(clicou),4) taxa_clique,ROUND(AVG(informou_credencial),4) taxa_credencial,ROUND(AVG(reportou),4) taxa_reporte FROM fato_phishing GROUP BY tipo;
-- 9. Treinamento por área
SELECT a.nome,ROUND(AVG(CASE WHEN t.status='Concluído' THEN 1.0 ELSE 0 END),4) conclusao,ROUND(AVG(t.nota),1) nota FROM fato_treinamento t JOIN dim_usuario u ON u.usuario_id=t.usuario_id JOIN dim_area a ON a.area_id=u.area_id GROUP BY a.area_id;
-- 10. Custo total de incidentes
SELECT i.tipo_ataque,ROUND(SUM(c.parada_operacional+c.recuperacao+c.consultoria+c.juridico+c.comunicacao),2) custo FROM fato_custo_incidente c JOIN fato_incidente i ON i.incidente_id=c.incidente_id GROUP BY i.tipo_ataque ORDER BY custo DESC;
