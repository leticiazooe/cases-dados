-- Case 25 — Auditoria de Cópias Controladas
-- Modelo de referência. Ajustar ao banco real antes de uso produtivo.

CREATE TABLE documentos (
    documento_id TEXT PRIMARY KEY,
    codigo_documento TEXT NOT NULL,
    titulo_documento TEXT NOT NULL,
    revisao_vigente TEXT NOT NULL,
    projeto TEXT,
    criticidade TEXT,
    atualizado_em DATETIME
);

CREATE TABLE copias (
    copia_id TEXT PRIMARY KEY,
    documento_id TEXT NOT NULL,
    revisao_copia TEXT NOT NULL,
    tipo_copia TEXT NOT NULL,
    data_emissao DATETIME NOT NULL,
    validade_ate DATETIME,
    status_copia TEXT NOT NULL,
    solicitante TEXT,
    aprovador TEXT,
    usuario_emissor TEXT NOT NULL,
    responsavel TEXT,
    setor TEXT,
    localizacao TEXT,
    motivo_emissao TEXT,
    quantidade_autorizada INTEGER,
    numero_copia INTEGER,
    data_baixa DATETIME,
    motivo_baixa TEXT,
    copia_substituta_id TEXT,
    FOREIGN KEY (documento_id) REFERENCES documentos(documento_id)
);

CREATE TABLE eventos_copia (
    evento_id INTEGER PRIMARY KEY AUTOINCREMENT,
    copia_id TEXT NOT NULL,
    data_evento DATETIME NOT NULL,
    tipo_evento TEXT NOT NULL,
    usuario TEXT,
    responsavel_anterior TEXT,
    responsavel_novo TEXT,
    localizacao_anterior TEXT,
    localizacao_nova TEXT,
    observacao TEXT,
    FOREIGN KEY (copia_id) REFERENCES copias(copia_id)
);

CREATE VIEW vw_auditoria_copias AS
SELECT
    c.copia_id,
    d.codigo_documento,
    d.titulo_documento,
    c.revisao_copia,
    d.revisao_vigente,
    c.tipo_copia,
    c.status_copia,
    c.data_emissao,
    c.validade_ate,
    c.responsavel,
    c.setor,
    c.localizacao,
    CASE WHEN c.revisao_copia = d.revisao_vigente THEN 1 ELSE 0 END AS revisao_conforme,
    CASE WHEN c.responsavel IS NOT NULL AND TRIM(c.responsavel) <> '' THEN 1 ELSE 0 END AS possui_responsavel,
    CASE WHEN c.localizacao IS NOT NULL AND TRIM(c.localizacao) <> '' THEN 1 ELSE 0 END AS possui_localizacao
FROM copias c
JOIN documentos d ON d.documento_id = c.documento_id;
