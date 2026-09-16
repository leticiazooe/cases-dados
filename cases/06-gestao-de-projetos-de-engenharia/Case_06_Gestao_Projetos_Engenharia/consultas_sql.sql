-- 1. Visão executiva do portfólio
SELECT status, COUNT(*) AS projetos, ROUND(SUM(orcamento_aprovado),2) AS orcamento
FROM fato_projeto GROUP BY status ORDER BY projetos DESC;

-- 2. Projetos atrasados ou com prazo vencido
SELECT codigo, nome, status, progresso_pct, fim_planejado,
       CAST(julianday('2026-06-30') - julianday(fim_planejado) AS INTEGER) AS dias_atraso
FROM fato_projeto
WHERE status = 'Em atraso' OR (status NOT IN ('Concluído','Cancelado') AND fim_planejado < '2026-06-30')
ORDER BY dias_atraso DESC;

-- 3. Desvio de custo por projeto
SELECT p.codigo, p.nome, p.orcamento_aprovado,
       ROUND(SUM(c.valor_real),2) AS custo_real,
       ROUND(SUM(c.valor_real)-p.orcamento_aprovado,2) AS desvio_valor,
       ROUND(SUM(c.valor_real)/NULLIF(p.orcamento_aprovado,0)-1,4) AS desvio_pct
FROM fato_projeto p LEFT JOIN fato_custo c ON c.projeto_id=p.projeto_id
GROUP BY p.projeto_id ORDER BY desvio_pct DESC;

-- 4. Saúde do cronograma por gerente
SELECT r.nome AS gerente, COUNT(*) AS projetos,
       ROUND(AVG(p.progresso_pct),1) AS progresso_medio,
       SUM(CASE WHEN p.status='Em atraso' THEN 1 ELSE 0 END) AS projetos_atrasados
FROM fato_projeto p JOIN dim_recurso r ON r.recurso_id=p.gerente_id
GROUP BY r.recurso_id ORDER BY projetos_atrasados DESC;

-- 5. Atividades críticas em atraso
SELECT p.codigo, a.codigo AS atividade, a.nome, r.nome AS responsavel, a.fim_planejado, a.progresso_pct
FROM fato_atividade a JOIN fato_projeto p ON p.projeto_id=a.projeto_id
JOIN dim_recurso r ON r.recurso_id=a.responsavel_id
WHERE a.caminho_critico=1 AND a.status='Em atraso'
ORDER BY a.fim_planejado;

-- 6. Exposição a riscos abertos
SELECT p.codigo, COUNT(*) AS riscos_abertos, SUM(r.score) AS exposicao,
       SUM(CASE WHEN r.score>=15 THEN 1 ELSE 0 END) AS riscos_altos
FROM fato_risco r JOIN fato_projeto p ON p.projeto_id=r.projeto_id
WHERE r.status IN ('Aberto','Em mitigação')
GROUP BY p.projeto_id ORDER BY exposicao DESC;

-- 7. Capacidade e horas extras por recurso
SELECT r.nome, r.funcao, ROUND(SUM(h.horas_regulares),1) AS horas_regulares,
       ROUND(SUM(h.horas_extras),1) AS horas_extras,
       ROUND(SUM(h.horas_extras)/NULLIF(SUM(h.horas_regulares+h.horas_extras),0),4) AS pct_horas_extras
FROM fato_apontamento_horas h JOIN dim_recurso r ON r.recurso_id=h.recurso_id
GROUP BY r.recurso_id ORDER BY horas_extras DESC;

-- 8. Impacto das mudanças aprovadas/implementadas
SELECT p.codigo, COUNT(*) AS mudancas, ROUND(SUM(m.impacto_custo),2) AS impacto_custo,
       SUM(m.impacto_prazo_dias) AS impacto_prazo_dias
FROM fato_mudanca m JOIN fato_projeto p ON p.projeto_id=m.projeto_id
WHERE m.status IN ('Aprovada','Implementada')
GROUP BY p.projeto_id ORDER BY impacto_custo DESC;

-- 9. Pontualidade dos marcos
SELECT m.nome, COUNT(*) AS marcos_concluidos,
       ROUND(AVG(CASE WHEN m.data_real<=m.data_planejada THEN 1.0 ELSE 0 END),4) AS taxa_pontualidade
FROM fato_marco m WHERE m.data_real IS NOT NULL GROUP BY m.nome;

-- 10. Tendência mensal de custos
SELECT competencia, ROUND(SUM(valor_planejado),2) AS planejado,
       ROUND(SUM(valor_real),2) AS realizado
FROM fato_custo GROUP BY competencia ORDER BY competencia;
