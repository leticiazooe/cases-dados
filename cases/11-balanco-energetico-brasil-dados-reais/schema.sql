PRAGMA foreign_keys=ON;
CREATE TABLE dim_fonte_energia(
 fonte_id INTEGER PRIMARY KEY, fonte TEXT UNIQUE NOT NULL,
 grupo_energetico TEXT NOT NULL, classificacao TEXT NOT NULL);
CREATE TABLE dim_tempo(
 ano INTEGER PRIMARY KEY, producao_total_ktep REAL NOT NULL,
 importacao_total_ktep REAL NOT NULL, exportacao_total_ktep REAL NOT NULL,
 saldo_fisico_ktep REAL NOT NULL, razao_exportacao_importacao REAL);
CREATE TABLE fato_fluxo_energetico(
 fluxo_id INTEGER PRIMARY KEY, ano INTEGER NOT NULL, fonte_id INTEGER NOT NULL,
 operacao TEXT NOT NULL CHECK(operacao IN ('Produção','Importação','Exportação')),
 valor_ktep REAL NOT NULL, valor_original_ben REAL NOT NULL, unidade TEXT NOT NULL,
 FOREIGN KEY(ano) REFERENCES dim_tempo(ano),
 FOREIGN KEY(fonte_id) REFERENCES dim_fonte_energia(fonte_id));
CREATE TABLE dim_fonte_dados(
 fonte_dados_id INTEGER PRIMARY KEY, instituicao TEXT NOT NULL, publicacao TEXT NOT NULL,
 ano_base TEXT NOT NULL, url_pagina TEXT NOT NULL, url_arquivo TEXT NOT NULL,
 data_acesso TEXT NOT NULL, licenca TEXT NOT NULL, observacao TEXT);
CREATE INDEX idx_fluxo_ano ON fato_fluxo_energetico(ano);
CREATE INDEX idx_fluxo_fonte ON fato_fluxo_energetico(fonte_id);
CREATE INDEX idx_fluxo_operacao ON fato_fluxo_energetico(operacao);
