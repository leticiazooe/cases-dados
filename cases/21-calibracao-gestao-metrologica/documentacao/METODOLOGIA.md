# Metodologia - Calibracao e Gestao Metrologica

Este case usa uma estrutura de dados sintéticos para estudo. A versão presente neste repositório foi recuperada a partir dos bancos, planilhas e arquivos brutos preservados.

## Fluxo

1. Dados brutos em `dados_brutos/`.
2. Registros rejeitados em `dados_rejeitados/`.
3. Dados tratados em `dados_tratados_pipeline/`.
4. Base de referência em `dados_tratados_referencia/`.
5. SQLite para análise relacional.
6. Excel, SQL e DAX para exploração e dashboards.

## Validação

Os CSVs tratados foram reexportados da base SQLite preservada para eliminar o truncamento do ZIP histórico.
