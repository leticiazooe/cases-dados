# Dicionário de dados

- `tipos_equipamento` (10 linhas): tipo_id, tipo_equipamento.
- `marcas` (12 linhas): marca_id, marca.
- `clientes` (1,200 linhas): cliente_id, codigo_cliente, tipo_cliente, uf.
- `tecnicos` (25 linhas): tecnico_id, codigo_tecnico, especialidade, senioridade.
- `pecas` (80 linhas): peca_id, peca, categoria, custo_unitario, estoque_atual.
- `equipamentos` (4,000 linhas): equipamento_id, cliente_id, tipo_id, marca_id, modelo, numero_serie_ficticio, ano_fabricacao.
- `ordens_servico` (4,000 linhas): os_id, codigo_os, equipamento_id, tecnico_id, data_abertura, data_prometida, data_fechamento, status, dentro_sla, canal.
- `diagnosticos` (4,000 linhas): diagnostico_id, os_id, defeito_relatado, causa, taxa_diagnostico, data_diagnostico.
- `orcamentos` (4,000 linhas): orcamento_id, os_id, valor_pecas, valor_mao_obra, valor_total, data_orcamento, status.
- `reparos` (3,225 linhas): reparo_id, os_id, data_inicio, data_fim, solucao, horas_tecnicas, resultado.
- `pecas_utilizadas` (6,424 linhas): uso_id, reparo_id, peca_id, quantidade, custo_total.
- `garantias` (3,225 linhas): garantia_id, reparo_id, inicio, fim, status, retorno.
- `avaliacoes` (2,407 linhas): avaliacao_id, os_id, nota_atendimento, nota_servico, comentario_categoria, data_avaliacao.