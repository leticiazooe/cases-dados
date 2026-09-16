-- 1. Cumprimento de SLA por prioridade
SELECT p.prioridade,COUNT(*) chamados,ROUND(AVG(c.sla_resposta_cumprido)*100,1) sla_resposta_pct,ROUND(AVG(c.sla_resolucao_cumprido)*100,1) sla_resolucao_pct FROM fato_chamado c JOIN dim_politica_sla p ON p.prioridade_id=c.prioridade_id GROUP BY p.prioridade_id;
-- 2. Volume e tempo por categoria
SELECT ca.categoria,COUNT(*) volume,ROUND(AVG(c.tempo_resposta_h),2) resposta_h,ROUND(AVG(c.tempo_resolucao_h),2) resolucao_h FROM fato_chamado c JOIN dim_categoria ca ON ca.categoria_id=c.categoria_id GROUP BY ca.categoria_id ORDER BY volume DESC;
-- 3. Backlog atual
SELECT e.equipe,c.status,COUNT(*) backlog,ROUND(AVG((julianday('2026-07-01')-julianday(c.abertura))*24),1) idade_media_h FROM fato_chamado c JOIN dim_equipe e ON e.equipe_id=c.equipe_id WHERE c.status<>'Resolvido' GROUP BY e.equipe,c.status;
-- 4. Reincidência
SELECT ca.categoria,COUNT(*) total,SUM(c.reincidente) reincidentes,ROUND(AVG(c.reincidente)*100,1) taxa_pct FROM fato_chamado c JOIN dim_categoria ca ON ca.categoria_id=c.categoria_id GROUP BY ca.categoria_id ORDER BY taxa_pct DESC;
-- 5. Satisfação por equipe
SELECT e.equipe,COUNT(s.pesquisa_id) respostas,ROUND(AVG(s.nota),2) csat FROM fato_satisfacao s JOIN fato_chamado c ON c.chamado_id=s.chamado_id JOIN dim_equipe e ON e.equipe_id=c.equipe_id GROUP BY e.equipe;
-- 6. Desempenho dos técnicos
SELECT t.tecnico,e.equipe,COUNT(*) chamados,ROUND(AVG(c.tempo_resolucao_h),2) tmr_h,ROUND(AVG(c.sla_resolucao_cumprido)*100,1) sla_pct,ROUND(AVG(s.nota),2) csat FROM fato_chamado c JOIN dim_tecnico t ON t.tecnico_id=c.tecnico_id JOIN dim_equipe e ON e.equipe_id=t.equipe_id LEFT JOIN fato_satisfacao s ON s.chamado_id=c.chamado_id GROUP BY t.tecnico_id ORDER BY sla_pct DESC;
-- 7. Tendência mensal
SELECT substr(abertura,1,7) mes,COUNT(*) chamados,ROUND(AVG(tempo_resolucao_h),2) tmr_h,ROUND(AVG(sla_resolucao_cumprido)*100,1) sla_pct FROM fato_chamado GROUP BY substr(abertura,1,7) ORDER BY mes;
-- 8. Causas com maior esforço
SELECT ca.categoria,ROUND(SUM(i.duracao_min)/60.0,1) horas_esforco,COUNT(DISTINCT c.chamado_id) chamados FROM fato_interacao i JOIN fato_chamado c ON c.chamado_id=i.chamado_id JOIN dim_categoria ca ON ca.categoria_id=c.categoria_id GROUP BY ca.categoria_id ORDER BY horas_esforco DESC;
