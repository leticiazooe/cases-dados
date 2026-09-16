# Dicionário de dados

- `regimes` (4 linhas): regime_id, regime_tributario.
- `clientes` (600 linhas): cliente_id, codigo_cliente, regime_id, setor, uf, status.
- `responsaveis` (35 linhas): responsavel_id, codigo_responsavel, equipe, senioridade.
- `tipos_obrigacao` (12 linhas): tipo_obrigacao_id, obrigacao, periodicidade.
- `obrigacoes` (14,487 linhas): obrigacao_id, cliente_id, tipo_obrigacao_id, responsavel_id, competencia, data_limite, data_entrega, status, no_prazo.
- `documentos` (7,200 linhas): documento_id, cliente_id, competencia, tipo_documento, data_solicitacao, data_recebimento, status.
- `impostos` (7,200 linhas): imposto_id, cliente_id, competencia, tributo, valor_apurado, data_vencimento.
- `guias` (7,200 linhas): guia_id, imposto_id, valor, data_vencimento, data_pagamento, status.
- `pendencias` (1,635 linhas): pendencia_id, cliente_id, responsavel_id, data_abertura, tipo, prioridade, status.
- `honorarios` (7,200 linhas): honorario_id, cliente_id, competencia, valor, data_vencimento, data_pagamento, status.