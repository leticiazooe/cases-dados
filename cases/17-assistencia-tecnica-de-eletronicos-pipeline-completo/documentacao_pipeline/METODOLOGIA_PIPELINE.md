# Pipeline completo - Case_17_Assistencia_Tecnica_de_Eletronicos

+## Arquitetura
+`dados_brutos` -> validação pandas -> `dados_rejeitados` -> `dados_tratados_pipeline` -> SQLite.
+
+## O que praticar
+- leitura de CSV com separador ponto e vírgula e decimal brasileiro;
+- profiling de tipos, nulos e duplicidades;
+- limpeza de espaços e padronização de datas;
+- regras de obrigatoriedade, chaves primárias e valores não negativos;
+- validação de chaves estrangeiras em segunda passagem;
+- quarentena com motivo de rejeição;
+- reconciliação das quantidades esperadas por tabela;
+- publicação idempotente em CSV e SQLite.
+
+## Execução
+```bash
+pip install -r src/requirements.txt
+python src/pipeline_pandas.py
+```
+
+O pipeline somente conclui com sucesso quando todas as tabelas reconciliam com a referência.
+