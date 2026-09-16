# Case 03 - Gestão de Manutenção Preventiva e Corretiva

Case fictício para treinamento em Engenharia de Dados, SQL, Excel, Power BI, PCM e análise de confiabilidade.

## Conteúdo

- `case_manutencao.xlsx`: dashboard e 17 tabelas relacionadas;
- `case_manutencao.db`: banco SQLite;
- `schema.sql`: tabelas, chaves, índices e views;
- `consultas_sql.sql`: consultas analíticas comentadas;
- `medidas_dax.txt`: medidas sugeridas para Power BI;
- `diagrama_erd.svg`: modelo relacional;
- `dicionario_dados.md`: tabelas, granularidade e regras;
- `case_e_desafios.md`: contexto, indicadores, visões e perguntas;
- `relatorio_qualidade_dados.md`: validações executadas;
- `guia_manutencao_dashboard.pdf`: documentação visual do projeto.

## Modelo

O equipamento é a entidade central. Ordens de serviço vinculam tipos de manutenção e planos preventivos. Falhas, paradas, apontamentos, peças e serviços terceirizados são fatos relacionados às ordens. Produção permite medir disponibilidade e impacto operacional.

## Como usar

1. Explore o dashboard e as tabelas do Excel.
2. Abra o banco no DBeaver ou DB Browser for SQLite.
3. Execute as consultas SQL e valide os KPIs.
4. Importe o SQLite ou as abas do Excel no Power BI.
5. Recrie os relacionamentos conforme o ERD.
6. Desenvolva as seis visões indicadas no PDF.

Todos os nomes, equipamentos e valores são sintéticos.
