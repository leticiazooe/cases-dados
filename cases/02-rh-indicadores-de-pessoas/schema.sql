PRAGMA foreign_keys = ON;

CREATE TABLE dim_unidade (
  id_unidade INTEGER PRIMARY KEY,
  unidade TEXT NOT NULL,
  cidade TEXT NOT NULL,
  uf TEXT NOT NULL,
  regiao TEXT NOT NULL
);

CREATE TABLE dim_setor (
  id_setor INTEGER PRIMARY KEY,
  setor TEXT NOT NULL,
  diretoria TEXT NOT NULL
);

CREATE TABLE dim_cargo (
  id_cargo INTEGER PRIMARY KEY,
  cargo TEXT NOT NULL,
  nivel TEXT NOT NULL,
  faixa_salarial_min NUMERIC NOT NULL,
  faixa_salarial_max NUMERIC NOT NULL
);

CREATE TABLE colaborador (
  id_colaborador INTEGER PRIMARY KEY,
  matricula TEXT NOT NULL UNIQUE,
  nome_ficticio TEXT NOT NULL,
  id_unidade INTEGER NOT NULL REFERENCES dim_unidade(id_unidade),
  id_setor INTEGER NOT NULL REFERENCES dim_setor(id_setor),
  id_cargo INTEGER NOT NULL REFERENCES dim_cargo(id_cargo),
  data_admissao DATE NOT NULL,
  data_desligamento DATE,
  tipo_contrato TEXT NOT NULL,
  modalidade_trabalho TEXT NOT NULL,
  salario_base NUMERIC NOT NULL,
  status_colaborador TEXT NOT NULL CHECK(status_colaborador IN ('Ativo','Desligado')),
  id_gestor INTEGER REFERENCES colaborador(id_colaborador)
);

CREATE TABLE fato_movimentacao (
  id_movimentacao INTEGER PRIMARY KEY,
  id_colaborador INTEGER NOT NULL REFERENCES colaborador(id_colaborador),
  data_movimentacao DATE NOT NULL,
  tipo_movimentacao TEXT NOT NULL,
  motivo TEXT NOT NULL,
  id_setor_origem INTEGER REFERENCES dim_setor(id_setor),
  id_setor_destino INTEGER REFERENCES dim_setor(id_setor),
  id_cargo_origem INTEGER REFERENCES dim_cargo(id_cargo),
  id_cargo_destino INTEGER REFERENCES dim_cargo(id_cargo),
  variacao_salarial_pct NUMERIC NOT NULL DEFAULT 0
);

CREATE TABLE fato_ausencia (
  id_ausencia INTEGER PRIMARY KEY,
  id_colaborador INTEGER NOT NULL REFERENCES colaborador(id_colaborador),
  data_inicio DATE NOT NULL,
  data_fim DATE NOT NULL,
  tipo_ausencia TEXT NOT NULL,
  horas_ausentes NUMERIC NOT NULL CHECK(horas_ausentes >= 0),
  justificada INTEGER NOT NULL CHECK(justificada IN (0,1)),
  custo_estimado NUMERIC NOT NULL CHECK(custo_estimado >= 0)
);

CREATE TABLE fato_hora_extra (
  id_hora_extra INTEGER PRIMARY KEY,
  id_colaborador INTEGER NOT NULL REFERENCES colaborador(id_colaborador),
  data_referencia DATE NOT NULL,
  tipo_hora_extra TEXT NOT NULL,
  horas_extras NUMERIC NOT NULL CHECK(horas_extras > 0),
  percentual_adicional NUMERIC NOT NULL CHECK(percentual_adicional >= 0),
  custo_hora_extra NUMERIC NOT NULL CHECK(custo_hora_extra >= 0),
  aprovada INTEGER NOT NULL CHECK(aprovada IN (0,1))
);

CREATE TABLE dim_treinamento (
  id_treinamento INTEGER PRIMARY KEY,
  treinamento TEXT NOT NULL,
  categoria TEXT NOT NULL,
  carga_horaria INTEGER NOT NULL,
  obrigatorio INTEGER NOT NULL CHECK(obrigatorio IN (0,1)),
  validade_meses INTEGER
);

CREATE TABLE fato_participacao_treinamento (
  id_participacao INTEGER PRIMARY KEY,
  id_colaborador INTEGER NOT NULL REFERENCES colaborador(id_colaborador),
  id_treinamento INTEGER NOT NULL REFERENCES dim_treinamento(id_treinamento),
  data_inicio DATE NOT NULL,
  data_conclusao DATE,
  status_treinamento TEXT NOT NULL,
  nota NUMERIC,
  custo_treinamento NUMERIC NOT NULL CHECK(custo_treinamento >= 0)
);

CREATE TABLE fato_avaliacao_desempenho (
  id_avaliacao INTEGER PRIMARY KEY,
  id_colaborador INTEGER NOT NULL REFERENCES colaborador(id_colaborador),
  ano_ciclo INTEGER NOT NULL,
  nota_resultados NUMERIC NOT NULL CHECK(nota_resultados BETWEEN 0 AND 5),
  nota_competencias NUMERIC NOT NULL CHECK(nota_competencias BETWEEN 0 AND 5),
  nota_final NUMERIC NOT NULL CHECK(nota_final BETWEEN 0 AND 5),
  classificacao TEXT NOT NULL,
  potencial TEXT NOT NULL,
  possui_pdi INTEGER NOT NULL CHECK(possui_pdi IN (0,1))
);

CREATE INDEX idx_colaborador_unidade ON colaborador(id_unidade);
CREATE INDEX idx_colaborador_setor ON colaborador(id_setor);
CREATE INDEX idx_ausencia_data ON fato_ausencia(data_inicio);
CREATE INDEX idx_he_data ON fato_hora_extra(data_referencia);
CREATE INDEX idx_mov_data ON fato_movimentacao(data_movimentacao);

CREATE VIEW vw_indicadores_pessoas AS
SELECT c.id_colaborador, c.matricula, c.nome_ficticio, u.unidade, s.setor,
       ca.cargo, ca.nivel, c.data_admissao, c.data_desligamento,
       c.tipo_contrato, c.modalidade_trabalho, c.salario_base,
       c.status_colaborador
FROM colaborador c
JOIN dim_unidade u ON u.id_unidade = c.id_unidade
JOIN dim_setor s ON s.id_setor = c.id_setor
JOIN dim_cargo ca ON ca.id_cargo = c.id_cargo;
