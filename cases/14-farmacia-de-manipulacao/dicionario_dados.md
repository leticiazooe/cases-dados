# Dicionário

- `dim_filial`: filial_id, filial, cidade, uf.
- `dim_medico`: medico_id, codigo, nome_ficticio, especialidade, registro_ficticio, conselho.
- `dim_paciente`: paciente_id, codigo_anonimo, idade, genero, regiao, alergia_declarada.
- `dim_fornecedor`: fornecedor_id, fornecedor, categoria, status_homologacao, score_qualidade.
- `dim_insumo`: insumo_id, insumo, categoria, unidade_medida, armazenamento, validade_meses.
- `fato_lote_insumo`: lote_id, insumo_id, fornecedor_id, codigo_lote, recebimento, validade, quantidade_recebida, saldo_atual, status, resultado_identidade.
- `dim_formula`: formula_id, formula, forma_farmaceutica, quantidade_padrao, validade_dias.
- `fato_componente_formula`: componente_id, formula_id, insumo_id, quantidade, unidade.
- `fato_prescricao`: prescricao_id, codigo, paciente_id, medico_id, formula_id, data_emissao, validade_receita, quantidade, status, via_uso.
- `fato_pedido`: pedido_id, codigo, prescricao_id, filial_id, data_recebimento, data_prometida, status, valor_bruto, desconto, valor_liquido, canal.
- `fato_producao`: producao_id, pedido_id, lote_manipulado, inicio, fim, farmaceutico_ficticio, status, tempo_producao_dias, desvio.
- `fato_controle_qualidade`: controle_id, producao_id, data_controle, resultado, observacao, responsavel_ficticio, liberado.
- `fato_venda`: venda_id, pedido_id, data_venda, receita, custo_estimado, tipo.
- `fato_entrega`: entrega_id, pedido_id, data_prometida, data_entrega, modalidade, status, no_prazo.
- `fato_pagamento`: pagamento_id, pedido_id, forma_pagamento, valor, data_pagamento, status.
