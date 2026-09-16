# Dicionário de dados

- `dim_fonte_energia`: fonte_id, fonte, classificacao, fator_emissao_tco2_mwh, custo_variavel_ref, despachabilidade_pct.
- `dim_regiao`: regiao_id, regiao, uf_referencia, caracteristica.
- `dim_usina`: usina_id, codigo, usina, fonte_id, regiao_id, capacidade_mw, data_operacao, status, empresa.
- `fato_geracao_mensal`: geracao_id, usina_id, competencia, horas_periodo, geracao_bruta_mwh, geracao_liquida_mwh, perdas_mwh, corte_mwh, fator_capacidade, disponibilidade, indice_recurso.
- `fato_custo`: custo_id, usina_id, competencia, categoria, valor_rs.
- `fato_emissao`: emissao_id, usina_id, competencia, emissoes_tco2e, intensidade_tco2_mwh, escopo.
- `fato_indisponibilidade`: evento_id, usina_id, data_inicio, duracao_horas, tipo, causa, energia_nao_gerada_mwh.
- `dim_cliente`: cliente_id, cliente, segmento, mercado.
- `fato_contrato`: contrato_id, usina_id, cliente_id, data_inicio, data_fim, volume_mwh, preco_rs_mwh, receita_contratada_rs, status.
- `fato_investimento`: investimento_id, usina_id, tipo, status, orcamento_rs, realizado_rs, data_inicio, progresso_pct.
