-- Consultas de auditoria — Case 25

-- 1. Cópias ativas com revisão obsoleta
SELECT *
FROM vw_auditoria_copias
WHERE status_copia = 'Ativa'
  AND revisao_conforme = 0;

-- 2. Cópias controladas ativas sem responsável
SELECT *
FROM vw_auditoria_copias
WHERE tipo_copia = 'Controlada'
  AND status_copia = 'Ativa'
  AND possui_responsavel = 0;

-- 3. Cópias controladas ativas sem localização
SELECT *
FROM vw_auditoria_copias
WHERE tipo_copia = 'Controlada'
  AND status_copia = 'Ativa'
  AND possui_localizacao = 0;

-- 4. Cópias vencidas ainda ativas
SELECT *
FROM vw_auditoria_copias
WHERE status_copia = 'Ativa'
  AND validade_ate IS NOT NULL
  AND validade_ate < CURRENT_TIMESTAMP;

-- 5. Documentos com múltiplas revisões simultaneamente ativas
SELECT
    codigo_documento,
    COUNT(DISTINCT revisao_copia) AS revisoes_ativas
FROM vw_auditoria_copias
WHERE status_copia = 'Ativa'
GROUP BY codigo_documento
HAVING COUNT(DISTINCT revisao_copia) > 1;

-- 6. Volume de cópias por documento
SELECT
    codigo_documento,
    titulo_documento,
    COUNT(*) AS total_copias
FROM vw_auditoria_copias
GROUP BY codigo_documento, titulo_documento
ORDER BY total_copias DESC;

-- 7. Exceções por setor
SELECT
    setor,
    SUM(CASE WHEN revisao_conforme = 0 THEN 1 ELSE 0 END) AS revisao_obsoleta,
    SUM(CASE WHEN possui_responsavel = 0 THEN 1 ELSE 0 END) AS sem_responsavel,
    SUM(CASE WHEN possui_localizacao = 0 THEN 1 ELSE 0 END) AS sem_localizacao
FROM vw_auditoria_copias
WHERE tipo_copia = 'Controlada'
GROUP BY setor;
