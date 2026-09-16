PRAGMA foreign_keys = ON;
CREATE TABLE dim_area (
  area_id INTEGER PRIMARY KEY, nome TEXT NOT NULL UNIQUE, diretoria TEXT NOT NULL
);
CREATE TABLE dim_cliente (
  cliente_id INTEGER PRIMARY KEY, nome TEXT NOT NULL UNIQUE, setor TEXT NOT NULL, regiao TEXT NOT NULL
);
CREATE TABLE dim_tipo_projeto (
  tipo_projeto_id INTEGER PRIMARY KEY, nome TEXT NOT NULL UNIQUE, categoria_investimento TEXT NOT NULL
);
CREATE TABLE dim_recurso (
  recurso_id INTEGER PRIMARY KEY, nome TEXT NOT NULL, area_id INTEGER NOT NULL, funcao TEXT NOT NULL,
  horas_semanais INTEGER NOT NULL CHECK(horas_semanais > 0), custo_hora REAL NOT NULL CHECK(custo_hora > 0),
  ativo INTEGER NOT NULL CHECK(ativo IN (0,1)), FOREIGN KEY(area_id) REFERENCES dim_area(area_id)
);
CREATE TABLE fato_projeto (
  projeto_id INTEGER PRIMARY KEY, codigo TEXT NOT NULL UNIQUE, nome TEXT NOT NULL,
  tipo_projeto_id INTEGER NOT NULL, area_id INTEGER NOT NULL, cliente_id INTEGER NOT NULL,
  gerente_id INTEGER NOT NULL, prioridade TEXT NOT NULL, complexidade TEXT NOT NULL,
  inicio_planejado TEXT NOT NULL, fim_planejado TEXT NOT NULL, inicio_real TEXT, fim_real TEXT,
  status TEXT NOT NULL, progresso_pct INTEGER NOT NULL CHECK(progresso_pct BETWEEN 0 AND 100),
  orcamento_aprovado REAL NOT NULL CHECK(orcamento_aprovado >= 0), roi_meta REAL NOT NULL,
  objetivo TEXT NOT NULL,
  FOREIGN KEY(tipo_projeto_id) REFERENCES dim_tipo_projeto(tipo_projeto_id),
  FOREIGN KEY(area_id) REFERENCES dim_area(area_id), FOREIGN KEY(cliente_id) REFERENCES dim_cliente(cliente_id),
  FOREIGN KEY(gerente_id) REFERENCES dim_recurso(recurso_id)
);
CREATE TABLE fato_atividade (
  atividade_id INTEGER PRIMARY KEY, projeto_id INTEGER NOT NULL, codigo TEXT NOT NULL UNIQUE,
  nome TEXT NOT NULL, fase TEXT NOT NULL, responsavel_id INTEGER NOT NULL,
  inicio_planejado TEXT NOT NULL, fim_planejado TEXT NOT NULL, inicio_real TEXT, fim_real TEXT,
  status TEXT NOT NULL, progresso_pct INTEGER NOT NULL CHECK(progresso_pct BETWEEN 0 AND 100),
  horas_planejadas REAL NOT NULL, horas_realizadas REAL NOT NULL, caminho_critico INTEGER NOT NULL,
  FOREIGN KEY(projeto_id) REFERENCES fato_projeto(projeto_id),
  FOREIGN KEY(responsavel_id) REFERENCES dim_recurso(recurso_id)
);
CREATE TABLE fato_marco (
  marco_id INTEGER PRIMARY KEY, projeto_id INTEGER NOT NULL, nome TEXT NOT NULL,
  data_planejada TEXT NOT NULL, data_real TEXT, status TEXT NOT NULL, marco_gate INTEGER NOT NULL,
  FOREIGN KEY(projeto_id) REFERENCES fato_projeto(projeto_id)
);
CREATE TABLE fato_alocacao (
  alocacao_id INTEGER PRIMARY KEY, projeto_id INTEGER NOT NULL, recurso_id INTEGER NOT NULL,
  inicio TEXT NOT NULL, fim TEXT NOT NULL, alocacao_pct INTEGER NOT NULL CHECK(alocacao_pct BETWEEN 0 AND 100),
  papel TEXT NOT NULL, FOREIGN KEY(projeto_id) REFERENCES fato_projeto(projeto_id),
  FOREIGN KEY(recurso_id) REFERENCES dim_recurso(recurso_id)
);
CREATE TABLE fato_risco (
  risco_id INTEGER PRIMARY KEY, projeto_id INTEGER NOT NULL, categoria TEXT NOT NULL,
  descricao TEXT NOT NULL, probabilidade INTEGER NOT NULL CHECK(probabilidade BETWEEN 1 AND 5),
  impacto INTEGER NOT NULL CHECK(impacto BETWEEN 1 AND 5), score INTEGER NOT NULL CHECK(score BETWEEN 1 AND 25),
  status TEXT NOT NULL, resposta TEXT NOT NULL, responsavel_id INTEGER NOT NULL, data_revisao TEXT NOT NULL,
  FOREIGN KEY(projeto_id) REFERENCES fato_projeto(projeto_id),
  FOREIGN KEY(responsavel_id) REFERENCES dim_recurso(recurso_id)
);
CREATE TABLE fato_custo (
  custo_id INTEGER PRIMARY KEY, projeto_id INTEGER NOT NULL, competencia TEXT NOT NULL,
  categoria TEXT NOT NULL, valor_planejado REAL NOT NULL, valor_real REAL NOT NULL, status_lancamento TEXT NOT NULL,
  FOREIGN KEY(projeto_id) REFERENCES fato_projeto(projeto_id)
);
CREATE TABLE fato_mudanca (
  mudanca_id INTEGER PRIMARY KEY, projeto_id INTEGER NOT NULL, data_solicitacao TEXT NOT NULL,
  solicitante TEXT NOT NULL, tipo TEXT NOT NULL, descricao TEXT NOT NULL, impacto_custo REAL NOT NULL,
  impacto_prazo_dias INTEGER NOT NULL, status TEXT NOT NULL, aprovador_id INTEGER NOT NULL,
  FOREIGN KEY(projeto_id) REFERENCES fato_projeto(projeto_id),
  FOREIGN KEY(aprovador_id) REFERENCES dim_recurso(recurso_id)
);
CREATE TABLE fato_apontamento_horas (
  apontamento_id INTEGER PRIMARY KEY, projeto_id INTEGER NOT NULL, recurso_id INTEGER NOT NULL,
  competencia TEXT NOT NULL, horas_regulares REAL NOT NULL, horas_extras REAL NOT NULL, tipo_atividade TEXT NOT NULL,
  FOREIGN KEY(projeto_id) REFERENCES fato_projeto(projeto_id),
  FOREIGN KEY(recurso_id) REFERENCES dim_recurso(recurso_id)
);
CREATE INDEX idx_atividade_projeto ON fato_atividade(projeto_id);
CREATE INDEX idx_custo_projeto_competencia ON fato_custo(projeto_id, competencia);
CREATE INDEX idx_risco_projeto ON fato_risco(projeto_id);
CREATE INDEX idx_horas_recurso_competencia ON fato_apontamento_horas(recurso_id, competencia);
