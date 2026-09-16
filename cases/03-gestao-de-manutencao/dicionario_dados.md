# Dicionário de Dados

| Tabela | Tipo | Granularidade | Papel |
|---|---|---|---|
| dim_unidade | Dimensão | Uma unidade | Localização industrial |
| dim_setor | Dimensão | Um setor | Área e centro de custo |
| dim_linha | Dimensão | Uma linha | Capacidade produtiva |
| dim_equipamento | Dimensão | Um equipamento | Cadastro técnico e criticidade |
| dim_tipo_manutencao | Dimensão | Um tipo | Preventiva, corretiva e demais classes |
| plano_preventivo | Operacional | Um plano por equipamento | Periodicidade e vencimento |
| ordem_servico | Operacional | Uma intervenção | Ciclo completo da manutenção |
| fato_falha | Fato | Uma falha registrada | Modo, componente, causa e severidade |
| fato_parada | Fato | Uma parada | Duração, impacto e custo |
| dim_colaborador | Dimensão | Um técnico fictício | Equipe, turno e custo-hora |
| fato_apontamento | Fato | Um apontamento | Horas e custo de mão de obra |
| dim_peca | Dimensão | Uma peça | Estoque, custo e criticidade |
| fato_consumo_peca | Fato | Um consumo | Quantidade e custo por OS |
| dim_fornecedor | Dimensão | Um fornecedor fictício | Prazo e avaliação |
| fato_servico_terceirizado | Fato | Um serviço contratado | Prazo, status e custo |
| fato_producao | Fato | Uma linha por mês | Produção, perdas e horas disponíveis |
| dim_calendario | Dimensão | Uma data | Filtros temporais |

## Regras principais

- Toda OS deve possuir equipamento e tipo de manutenção válidos.
- OS preventiva pode estar ligada a um plano preventivo.
- Data de conclusão não pode preceder abertura ou início.
- Parada deve possuir duração positiva e data final posterior à inicial.
- Custos e quantidades não podem ser negativos.
- Consumos e apontamentos devem estar vinculados a uma OS válida.
- Itens com estoque atual abaixo do mínimo devem gerar alerta.
- Indicadores devem respeitar o período e a granularidade de cada fato.
