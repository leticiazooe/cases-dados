# Case Profissional de Dados — Eficiência Industrial

## Objetivo

Este pacote simula uma demanda real de dados: criar uma visão diária de produção, perdas e disponibilidade para apoiar decisões operacionais nas fábricas da empresa fictícia **FlexFlow Componentes Industriais**.

## Conteúdo do pacote

| Arquivo | Finalidade |
|---|---|
| `case_eficiencia_industrial.xlsx` | Base analítica, dimensões, tabela fato e dashboard inicial. |
| `case_eficiencia_industrial.db` | Banco SQLite pronto para consulta. |
| `schema.sql` | Script de criação das tabelas, índices e view de KPIs. |
| `diagrama_erd.svg` | Diagrama entidade-relacionamento do banco. |
| `case_e_prompt_profissional.md` | Contexto de negócio, desafios e prompt de análise. |

## Modelo relacional

O banco foi desenhado em modelo dimensional, separando registros transacionais de tabelas descritivas.

- `fato_producao`: um registro por **data, linha e turno**; contém medidas de produção, sucata e paradas.
- `dim_linha`: relaciona cada linha à sua fábrica.
- `dim_fabrica`: identifica unidade e estado.
- `dim_produto`: identifica produto, categoria e custo unitário.
- `dim_turno`: identifica o turno produtivo.
- `dim_motivo_parada`: classifica a origem e o tipo da parada.

### Relacionamentos

| Origem | Relacionamento | Destino |
|---|---|---|
| `dim_fabrica.id_fabrica` | 1:N | `dim_linha.id_fabrica` |
| `dim_linha.id_linha` | 1:N | `fato_producao.id_linha` |
| `dim_produto.id_produto` | 1:N | `fato_producao.id_produto` |
| `dim_turno.id_turno` | 1:N | `fato_producao.id_turno` |
| `dim_motivo_parada.id_motivo_parada` | 1:N opcional | `fato_producao.id_motivo_parada` |

## KPIs sugeridos

- **Atingimento:** quantidade produzida / quantidade planejada.
- **Taxa de sucata:** quantidade de sucata / quantidade produzida.
- **Disponibilidade:** 1 − minutos parados / minutos programados.
- **Minutos parados:** soma dos minutos de parada por recorte analisado.

## Como praticar

1. Abra o arquivo Excel para entender a estrutura e os indicadores.
2. Consulte o banco SQLite usando DBeaver, DB Browser for SQLite ou VS Code.
3. Execute o `schema.sql` em um banco vazio para reproduzir a estrutura.
4. Importe as tabelas no Power BI e recrie os relacionamentos do diagrama ERD.
5. Responda às perguntas de negócio do arquivo `case_e_prompt_profissional.md`.

## Observação

Todos os dados são sintéticos, criados apenas para estudo e portfólio. Não representam dados de uma empresa real.
