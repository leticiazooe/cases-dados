CREATE TABLE "calibracoes" (
"calibracao_id" TEXT,
  "equipamento_id" TEXT,
  "laboratorio_id" TEXT,
  "data_programada" TEXT,
  "data_realizada" TEXT,
  "custo" REAL,
  "resultado" TEXT
);

CREATE TABLE "equipamentos" (
"equipamento_id" TEXT,
  "tipo" TEXT,
  "unidade" TEXT,
  "criticidade" TEXT,
  "periodicidade_dias" INTEGER
);

CREATE TABLE "laboratorios" (
"laboratorio_id" TEXT,
  "laboratorio" TEXT,
  "acreditado" TEXT,
  "lead_time_dias" INTEGER
);

CREATE TABLE "medicoes" (
"medicao_id" TEXT,
  "calibracao_id" TEXT,
  "ponto" TEXT,
  "erro" REAL,
  "tolerancia" REAL
);

CREATE TABLE "nao_conformidades" (
"nao_conformidade_id" TEXT,
  "calibracao_id" TEXT,
  "tipo" TEXT,
  "criticidade" TEXT,
  "status" TEXT
);
