# Dicionário de dados

## Dimensões

- `dim_area`: áreas responsáveis e respectivas diretorias.
- `dim_cliente`: clientes internos e externos, setor e região.
- `dim_tipo_projeto`: classificação do projeto e natureza do investimento.
- `dim_recurso`: profissionais, função, capacidade semanal e custo-hora.

## Fatos

- `fato_projeto`: uma linha por projeto; datas, status, progresso, orçamento, prioridade e objetivo.
- `fato_atividade`: uma linha por atividade do cronograma; fase, responsável, datas, horas e caminho crítico.
- `fato_marco`: uma linha por marco/gate; datas planejada e real.
- `fato_alocacao`: uma linha por vínculo projeto-recurso, com percentual de alocação.
- `fato_risco`: uma linha por risco; probabilidade, impacto, score e resposta.
- `fato_custo`: uma linha por projeto, competência e categoria de custo.
- `fato_mudanca`: uma linha por solicitação de mudança; impactos de custo e prazo.
- `fato_apontamento_horas`: uma linha por projeto, recurso e competência.

## Regras principais

- `score de risco = probabilidade x impacto`, em escala de 1 a 25.
- Datas reais vazias são esperadas para itens ainda não iniciados ou não concluídos.
- Percentuais são armazenados de 0 a 100 nas tabelas operacionais.
- A data de corte do case é 2026-06-30.
- Custos negativos em mudanças representam redução estimada; custos reais nunca são negativos.
