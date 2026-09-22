# Case 25 — Auditoria de Cópias Controladas

## Objetivo

Estruturar uma análise de dados voltada à auditoria de cópias controladas de documentos, com foco em rastreabilidade, revisão vigente, responsabilidade, localização, validade, recolhimento e risco de uso de documentos obsoletos.

Este case nasceu de um problema real de gestão documental.

> Pergunta central: conseguimos provar, por meio dos dados, qual documento e revisão cada cópia representa, quem é responsável por ela, onde ela está e o que acontece quando uma nova revisão é liberada?

## Status

**Fase atual:** definição analítica e modelo de dados.

Este case **não contém dados reais da empresa nem dados sintéticos gerados para simular resultados** nesta versão. A estrutura foi criada para receber uma base real devidamente autorizada ou, futuramente, uma base sintética explicitamente identificada como tal.

## O que os dados precisam responder

### Perguntas críticas

1. Toda cópia controlada pode ser rastreada individualmente?
2. A cópia em circulação corresponde à revisão vigente do documento?
3. Existem cópias obsoletas ainda em circulação?
4. Quem é responsável por cada cópia?
5. Onde cada cópia está localizada?
6. O que ocorre com as cópias anteriores quando uma nova revisão é liberada?
7. Existem cópias vencidas, canceladas ou sem baixa ainda consideradas ativas?
8. Existem cópias sem responsável ou sem localização conhecida?
9. Quem autorizou e quem realizou cada emissão?
10. É possível reconstruir toda a movimentação da cópia por uma trilha de auditoria?

## Dimensões de análise

- documento;
- revisão;
- projeto;
- setor;
- responsável;
- localização;
- tipo de cópia;
- status;
- motivo da emissão;
- usuário emissor;
- período;
- validade;
- criticidade documental.

## KPIs propostos

- total de cópias emitidas;
- cópias ativas;
- cópias vencidas;
- cópias obsoletas em circulação;
- cópias sem responsável;
- cópias sem localização;
- percentual de rastreabilidade completa;
- percentual de conformidade de revisão;
- tempo médio entre emissão e baixa;
- tempo médio de recolhimento após nova revisão;
- quantidade de documentos com cópias de múltiplas revisões simultaneamente ativas;
- quantidade de exceções críticas por setor/projeto.

## Estrutura do case

- `README.md` — visão geral;
- `modelo_coleta.csv` — cabeçalho mínimo para coleta;
- `schema.sql` — modelo relacional de referência;
- `consultas_sql.sql` — consultas de auditoria;
- `documentacao/perguntas-auditoria.md` — matriz de investigação;
- `documentacao/dicionario-dados.md` — campos e finalidade;
- `documentacao/kpis.md` — indicadores e regras;
- `prototipo/auditoria-copias-controladas.html` — protótipo visual.

## Próxima etapa

1. Mapear a fonte real dos dados.
2. Verificar quais campos já existem.
3. Classificar as perguntas como respondíveis, parcialmente respondíveis ou não respondíveis.
4. Tratar qualidade e integridade.
5. Construir a base analítica.
6. Executar auditoria exploratória.
7. Produzir relatório e dashboard.

## Agente responsável pela investigação

**Clara — Data Analysis & Diagnostic Strategist**

Clara transforma o problema em perguntas analíticas, KPIs, requisitos de dados, lacunas e evidências para decisão.
