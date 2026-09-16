PRAGMA foreign_keys = ON;

CREATE TABLE dim_fabrica (
  id_fabrica INTEGER PRIMARY KEY,
  fabrica TEXT NOT NULL,
  uf TEXT NOT NULL
);

CREATE TABLE dim_linha (
  id_linha INTEGER PRIMARY KEY,
  id_fabrica INTEGER NOT NULL REFERENCES dim_fabrica(id_fabrica),
  linha TEXT NOT NULL
);

CREATE TABLE dim_produto (
  id_produto INTEGER PRIMARY KEY,
  codigo_produto TEXT NOT NULL UNIQUE,
  produto TEXT NOT NULL,
  categoria TEXT NOT NULL,
  custo_unitario NUMERIC NOT NULL
);

CREATE TABLE dim_turno (
  id_turno INTEGER PRIMARY KEY,
  turno TEXT NOT NULL
);

CREATE TABLE dim_motivo_parada (
  id_motivo_parada INTEGER PRIMARY KEY,
  motivo_parada TEXT NOT NULL,
  tipo_parada TEXT NOT NULL
);

CREATE TABLE fato_producao (
  id_producao INTEGER PRIMARY KEY,
  data_producao DATE NOT NULL,
  id_linha INTEGER NOT NULL REFERENCES dim_linha(id_linha),
  id_produto INTEGER NOT NULL REFERENCES dim_produto(id_produto),
  id_turno INTEGER NOT NULL REFERENCES dim_turno(id_turno),
  qtd_planejada INTEGER NOT NULL CHECK(qtd_planejada >= 0),
  qtd_produzida INTEGER NOT NULL CHECK(qtd_produzida >= 0),
  qtd_sucata INTEGER NOT NULL CHECK(qtd_sucata >= 0),
  minutos_parados INTEGER NOT NULL DEFAULT 0 CHECK(minutos_parados >= 0),
  id_motivo_parada INTEGER REFERENCES dim_motivo_parada(id_motivo_parada),
  minutos_programados INTEGER NOT NULL DEFAULT 480 CHECK(minutos_programados > 0)
);

CREATE INDEX idx_fato_data ON fato_producao(data_producao);
CREATE INDEX idx_fato_linha ON fato_producao(id_linha);
CREATE INDEX idx_fato_produto ON fato_producao(id_produto);

CREATE VIEW vw_kpi_producao AS
SELECT
  f.data_producao, fa.fabrica, l.linha, p.codigo_produto, p.produto, t.turno,
  f.qtd_planejada, f.qtd_produzida, f.qtd_sucata, f.minutos_parados,
  ROUND(CAST(f.qtd_produzida AS REAL) / NULLIF(f.qtd_planejada, 0), 4) AS atingimento,
  ROUND(CAST(f.qtd_sucata AS REAL) / NULLIF(f.qtd_produzida, 0), 4) AS taxa_sucata,
  ROUND(1 - CAST(f.minutos_parados AS REAL) / f.minutos_programados, 4) AS disponibilidade
FROM fato_producao f
JOIN dim_linha l ON l.id_linha = f.id_linha
JOIN dim_fabrica fa ON fa.id_fabrica = l.id_fabrica
JOIN dim_produto p ON p.id_produto = f.id_produto
JOIN dim_turno t ON t.id_turno = f.id_turno;
