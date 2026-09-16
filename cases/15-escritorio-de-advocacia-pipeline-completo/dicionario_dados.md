# Dicionário de dados

- `areas_juridicas` (8 linhas): area_id, area_juridica.
- `clientes` (700 linhas): cliente_id, codigo_cliente, tipo_pessoa, uf, data_cadastro, status.
- `advogados` (40 linhas): advogado_id, codigo_advogado, area_id, senioridade, valor_hora.
- `processos` (2,200 linhas): processo_id, codigo_processo, cliente_id, area_id, advogado_id, data_abertura, data_encerramento, status, risco, valor_causa, desfecho.
- `prazos` (5,529 linhas): prazo_id, processo_id, tipo_prazo, data_vencimento, data_conclusao, status, prioridade.
- `audiencias` (1,546 linhas): audiencia_id, processo_id, data_audiencia, tipo, modalidade, status, resultado.
- `movimentacoes` (7,664 linhas): movimentacao_id, processo_id, data_movimentacao, tipo, origem.
- `honorarios` (2,200 linhas): honorario_id, processo_id, modelo_cobranca, valor_contratado, percentual_exito, data_contrato, status.
- `pagamentos` (6,540 linhas): pagamento_id, honorario_id, parcela, valor, data_vencimento, data_pagamento, status.