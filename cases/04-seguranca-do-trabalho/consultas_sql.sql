-- Eventos por tipo e setor
SELECT s.id_nome setor,i.tipo_incidente,COUNT(*) eventos,SUM(i.dias_afastamento) dias FROM fato_incidente i JOIN dim_setor s ON s.id_setor=i.id_setor GROUP BY s.id_nome,i.tipo_incidente;
-- EPIs vencidos
SELECT e.epi,COUNT(*) vencidos FROM fato_entrega_epi f JOIN dim_epi e ON e.id_epi=f.id_epi WHERE f.status_epi='Vencido' GROUP BY e.epi;
-- Treinamentos
SELECT t.treinamento,p.status,COUNT(*) quantidade FROM fato_participacao_treinamento p JOIN dim_treinamento t ON t.id_treinamento=p.id_treinamento GROUP BY t.treinamento,p.status;
-- Ações atrasadas
SELECT * FROM fato_plano_acao WHERE status='Atrasada' ORDER BY prazo;
