CREATE TABLE "alunos"("aluno_id" INTEGER PRIMARY KEY,"codigo_aluno" TEXT,"idade" INTEGER,"genero" TEXT,"regiao" TEXT,"data_cadastro" TEXT);

CREATE TABLE "aulas"("aula_id" INTEGER PRIMARY KEY,"modalidade_id" INTEGER,"profissional_id" INTEGER,"data_aula" TEXT,"horario" TEXT,"capacidade" INTEGER,"participantes" INTEGER,"status" TEXT,FOREIGN KEY("modalidade_id") REFERENCES "modalidades"("modalidade_id"),FOREIGN KEY("profissional_id") REFERENCES "profissionais"("profissional_id"));

CREATE TABLE "avaliacoes_fisicas"("avaliacao_id" INTEGER PRIMARY KEY,"matricula_id" INTEGER,"profissional_id" INTEGER,"data_avaliacao" TEXT,"imc" REAL,"gordura_pct" REAL,"peso_kg" REAL,"objetivo" TEXT,FOREIGN KEY("matricula_id") REFERENCES "matriculas"("matricula_id"),FOREIGN KEY("profissional_id") REFERENCES "profissionais"("profissional_id"));

CREATE TABLE "cancelamentos"("cancelamento_id" INTEGER PRIMARY KEY,"matricula_id" INTEGER,"data_cancelamento" TEXT,"motivo" TEXT,"tentativa_retencao" TEXT,FOREIGN KEY("matricula_id") REFERENCES "matriculas"("matricula_id"));

CREATE TABLE "frequencias"("frequencia_id" INTEGER PRIMARY KEY,"matricula_id" INTEGER,"data_acesso" TEXT,"hora_acesso" TEXT,"modalidade_id" INTEGER,"duracao_minutos" INTEGER,FOREIGN KEY("matricula_id") REFERENCES "matriculas"("matricula_id"),FOREIGN KEY("modalidade_id") REFERENCES "modalidades"("modalidade_id"));

CREATE TABLE "matriculas"("matricula_id" INTEGER PRIMARY KEY,"aluno_id" INTEGER,"plano_id" INTEGER,"data_inicio" TEXT,"data_fim" TEXT,"status" TEXT,"canal_aquisicao" TEXT,FOREIGN KEY("aluno_id") REFERENCES "alunos"("aluno_id"),FOREIGN KEY("plano_id") REFERENCES "planos"("plano_id"));

CREATE TABLE "modalidades"("modalidade_id" INTEGER PRIMARY KEY,"modalidade" TEXT);

CREATE TABLE "pagamentos"("pagamento_id" INTEGER PRIMARY KEY,"matricula_id" INTEGER,"competencia" TEXT,"valor" INTEGER,"data_vencimento" TEXT,"data_pagamento" TEXT,"status" TEXT,FOREIGN KEY("matricula_id") REFERENCES "matriculas"("matricula_id"));

CREATE TABLE "planos"("plano_id" INTEGER PRIMARY KEY,"plano" TEXT,"valor_referencia" INTEGER);

CREATE TABLE "profissionais"("profissional_id" INTEGER PRIMARY KEY,"codigo_profissional" TEXT,"modalidade_id" INTEGER,"funcao" TEXT,FOREIGN KEY("modalidade_id") REFERENCES "modalidades"("modalidade_id"));

CREATE TABLE "reservas_aula"("reserva_id" INTEGER PRIMARY KEY,"aula_id" INTEGER,"aluno_id" INTEGER,"status" TEXT,FOREIGN KEY("aula_id") REFERENCES "aulas"("aula_id"),FOREIGN KEY("aluno_id") REFERENCES "alunos"("aluno_id"));
