-- 1. Headcount atual por unidade e setor
SELECT u.unidade, s.setor, COUNT(*) AS headcount
FROM colaborador c
JOIN dim_unidade u ON u.id_unidade=c.id_unidade
JOIN dim_setor s ON s.id_setor=c.id_setor
WHERE c.status_colaborador='Ativo'
GROUP BY u.unidade, s.setor
ORDER BY headcount DESC;

-- 2. Desligamentos por motivo
SELECT motivo, COUNT(*) AS desligamentos
FROM fato_movimentacao
WHERE tipo_movimentacao='Desligamento'
GROUP BY motivo
ORDER BY desligamentos DESC;

-- 3. Turnover simplificado por setor
WITH quadro AS (
 SELECT id_setor, COUNT(*) AS total_historico,
        SUM(CASE WHEN status_colaborador='Ativo' THEN 1 ELSE 0 END) AS ativos
 FROM colaborador GROUP BY id_setor
), deslig AS (
 SELECT id_setor_origem AS id_setor, COUNT(*) AS desligamentos
 FROM fato_movimentacao WHERE tipo_movimentacao='Desligamento'
 GROUP BY id_setor_origem
)
SELECT s.setor, q.ativos, COALESCE(d.desligamentos,0) AS desligamentos,
 ROUND(COALESCE(d.desligamentos,0)*1.0 / NULLIF((q.ativos+q.total_historico)/2.0,0),4) AS turnover
FROM quadro q JOIN dim_setor s ON s.id_setor=q.id_setor
LEFT JOIN deslig d ON d.id_setor=q.id_setor
ORDER BY turnover DESC;

-- 4. Absenteísmo e custo por setor
SELECT s.setor, SUM(a.horas_ausentes) AS horas_ausentes,
       ROUND(SUM(a.custo_estimado),2) AS custo_estimado
FROM fato_ausencia a
JOIN colaborador c ON c.id_colaborador=a.id_colaborador
JOIN dim_setor s ON s.id_setor=c.id_setor
GROUP BY s.setor ORDER BY horas_ausentes DESC;

-- 5. Horas extras aprovadas e custo por setor
SELECT s.setor, SUM(h.horas_extras) AS horas_extras,
       ROUND(SUM(h.custo_hora_extra),2) AS custo_total
FROM fato_hora_extra h
JOIN colaborador c ON c.id_colaborador=h.id_colaborador
JOIN dim_setor s ON s.id_setor=c.id_setor
WHERE h.aprovada=1
GROUP BY s.setor ORDER BY custo_total DESC;

-- 6. Conclusão de treinamentos obrigatórios
SELECT t.treinamento,
 COUNT(*) AS participacoes,
 SUM(CASE WHEN p.status_treinamento='Concluído' THEN 1 ELSE 0 END) AS concluidos,
 ROUND(100.0*SUM(CASE WHEN p.status_treinamento='Concluído' THEN 1 ELSE 0 END)/COUNT(*),1) AS taxa_conclusao_pct
FROM fato_participacao_treinamento p
JOIN dim_treinamento t ON t.id_treinamento=p.id_treinamento
WHERE t.obrigatorio=1
GROUP BY t.treinamento ORDER BY taxa_conclusao_pct;

-- 7. Desempenho e potencial
SELECT classificacao, potencial, COUNT(*) AS colaboradores,
       ROUND(AVG(nota_final),2) AS nota_media
FROM fato_avaliacao_desempenho
GROUP BY classificacao, potencial
ORDER BY nota_media DESC;

-- 8. Colaboradores que exigem atenção de desenvolvimento
SELECT c.matricula, c.nome_ficticio, s.setor, a.ano_ciclo,
       a.nota_final, a.classificacao, a.potencial, a.possui_pdi
FROM fato_avaliacao_desempenho a
JOIN colaborador c ON c.id_colaborador=a.id_colaborador
JOIN dim_setor s ON s.id_setor=c.id_setor
WHERE a.nota_final<3.0 OR (a.potencial='Alto' AND a.possui_pdi=0)
ORDER BY a.nota_final;
