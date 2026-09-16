# Dicionário

- `dim_unidade`: unidade_id, unidade, cidade, uf.
- `dim_localizacao`: localizacao_id, unidade_id, local, area.
- `dim_tipo_ativo`: tipo_id, tipo, categoria, vida_util_anos.
- `dim_fornecedor`: fornecedor_id, fornecedor.
- `dim_colaborador`: colaborador_id, registro, nome, unidade_id, area, status.
- `fato_ativo`: ativo_id, patrimonio, tipo_id, fornecedor_id, modelo, numero_serie, hostname, localizacao_id, data_compra, custo_aquisicao, fim_garantia, vida_util_anos, valor_contabil, status, estado_conservacao, perfil_uso.
- `fato_atribuicao`: atribuicao_id, ativo_id, colaborador_id, data_inicio, data_fim, observacao.
- `fato_movimentacao`: movimentacao_id, ativo_id, data_movimentacao, origem_id, destino_id, tipo, responsavel.
- `fato_manutencao`: manutencao_id, ativo_id, data_manutencao, tipo, status, custo, motivo, indisponibilidade_dias.
- `dim_software`: software_id, software, categoria, fornecedor_id, modelo_licenciamento.
- `fato_contrato_licenca`: contrato_id, software_id, codigo, quantidade_adquirida, custo_total, data_inicio, data_fim, status.
- `fato_alocacao_licenca`: alocacao_id, contrato_id, colaborador_id, ativo_id, data_alocacao, status.
