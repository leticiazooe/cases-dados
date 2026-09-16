# Case 02 — Recursos Humanos e Indicadores de Pessoas

Projeto fictício de dados desenvolvido para treinamento em Excel, SQL, modelagem relacional e Power BI.

## Problema de negócio

A empresa fictícia **NovaCore Indústrias** cresceu rapidamente e passou a administrar dados de pessoas em planilhas separadas. A direção precisa acompanhar admissões, desligamentos, turnover, absenteísmo, horas extras, treinamentos e desempenho de forma integrada para reduzir perdas, melhorar a retenção e apoiar decisões de liderança.

## Arquivos

| Arquivo | Finalidade |
|---|---|
| `case_rh_indicadores.xlsx` | Base Excel com dashboard, dimensões e fatos. |
| `case_rh_indicadores.db` | Banco SQLite pronto para consultas. |
| `schema.sql` | Criação das tabelas, relacionamentos, índices e view. |
| `consultas_sql.sql` | Consultas de negócio comentadas. |
| `diagrama_erd.svg` | Modelo entidade-relacionamento. |
| `dicionario_dados.md` | Definição das tabelas, campos e regras. |
| `case_e_desafios.md` | Contexto, objetivos, KPIs e exercícios. |

## Modelo

O modelo possui dimensões de unidade, setor, cargo e treinamento; cadastro central de colaboradores; e fatos separados para movimentações, ausências, horas extras, participações em treinamentos e avaliações de desempenho.

## Indicadores principais

- Headcount ativo;
- Admissões e desligamentos;
- Turnover geral;
- Horas ausentes e custo estimado;
- Horas extras e custo;
- Taxa de conclusão de treinamentos;
- Nota média de desempenho;
- Colaboradores com PDI;
- Distribuição por unidade, setor, cargo e modalidade.

## Uso sugerido

1. Explore a estrutura e as fórmulas do Excel.
2. Abra o banco no DBeaver ou DB Browser for SQLite.
3. Execute as consultas SQL e valide os totais.
4. Importe o banco no Power BI.
5. Recrie os relacionamentos indicados no ERD.
6. Construa as páginas de dashboard propostas nos desafios.

Todos os nomes e registros são fictícios e não possuem relação com pessoas ou empresas reais.
