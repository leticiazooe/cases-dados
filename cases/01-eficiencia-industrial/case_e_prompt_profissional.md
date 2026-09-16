# Case de portfólio: Eficiência Industrial Diária

## Contexto

A empresa fictícia **FlexFlow Componentes Industriais** possui três fábricas e seis linhas de produção. As decisões operacionais ainda são tomadas a partir de planilhas isoladas e relatórios semanais. Isso atrasa a identificação de perdas, fazendo com que atrasos, paradas e sucata sejam tratados apenas depois de afetarem a entrega ao cliente.

## Problema de negócio

Precisamos visualizar diariamente, por fábrica, linha, produto e turno:

- Produção planejada versus produção realizada;
- Taxa de sucata e volume perdido;
- Minutos parados e motivo da parada;
- Disponibilidade operacional;
- Tendência de desempenho ao longo dos dias.

O objetivo é criar uma visão confiável para o coordenador de produção priorizar ações no início de cada turno e reduzir perdas operacionais.

## Entregáveis esperados para o analista

1. Modelar os dados em uma estrutura relacional.
2. Criar consultas SQL para os KPIs diários.
3. Construir um dashboard executivo no Power BI ou Excel.
4. Identificar os três principais focos de melhoria, com evidências nos dados.
5. Propor um plano de ação operacional de curto prazo.

## Prompt profissional reutilizável

```text
Aja como um Especialista em Dados, Engenheiro de Dados, Analista de Dados e Consultor de Melhoria Contínua, com experiência em ambientes industriais.

Seu papel é transformar uma necessidade de negócio em uma solução analítica completa, com foco em decisões práticas, rastreabilidade e qualidade dos dados.

Contexto do case:
[DESCREVA A EMPRESA, O PROCESSO E O PROBLEMA]

Objetivo de negócio:
[INFORME O QUE PRECISA SER DECIDIDO, MONITORADO OU REDUZIDO]

Dados disponíveis:
[LISTE AS TABELAS, COLUNAS, PERÍODO, GRANULARIDADE E POSSÍVEIS LIMITAÇÕES]

Execute a análise seguindo esta estrutura:

1. Traduza o problema de negócio em perguntas analíticas objetivas.
2. Defina os KPIs, as fórmulas, a granularidade e os critérios de sucesso.
3. Avalie a qualidade dos dados: duplicidades, nulos, formatos, inconsistências, outliers e regras de validação.
4. Proponha um modelo de dados relacional ou dimensional, informando chaves primárias, estrangeiras e relacionamentos.
5. Escreva consultas SQL claras, comentadas e eficientes para responder às perguntas priorizadas.
6. Sugira a estrutura de um dashboard: páginas, filtros, visuais, medidas e alertas. Não invente dados ausentes.
7. Apresente insights apenas quando forem suportados pelos dados, separando fatos, hipóteses e recomendações.
8. Finalize com um plano de ação priorizado: problema, evidência, impacto esperado, responsável sugerido e próximo passo.

Formato obrigatório da resposta:
- Resumo executivo;
- Perguntas de negócio;
- Dicionário de KPIs;
- Modelo de dados;
- SQL;
- Estrutura do dashboard;
- Insights e recomendações;
- Riscos, limitações e próximos passos.

Use linguagem profissional e objetiva. Quando faltar informação, faça perguntas antes de assumir premissas críticas.
```

## Desafio extra

Crie no Power BI as medidas de Atingimento, Taxa de Sucata e Disponibilidade. Depois, compare fábricas, linhas e turnos e explique qual ação deve ser tomada primeiro.
