# Dicionário

- `dim_unidade`: unidade_id, unidade, cidade, uf.
- `dim_equipe`: equipe_id, equipe, escopo.
- `dim_categoria`: categoria_id, categoria, grupo, equipe_id.
- `dim_politica_sla`: prioridade_id, prioridade, sla_resposta_h, sla_resolucao_h.
- `dim_usuario`: usuario_id, registro, usuario, unidade_id, area.
- `dim_tecnico`: tecnico_id, registro, tecnico, equipe_id, senioridade.
- `fato_chamado`: chamado_id, protocolo, usuario_id, categoria_id, abertura, primeira_resposta, resolucao, fechamento, prioridade_id, equipe_id, tecnico_id, status, titulo, canal, tempo_resposta_h, tempo_resolucao_h, sla_resposta_cumprido, sla_resolucao_cumprido, reincidente, chamado_original_id, solucao.
- `fato_interacao`: interacao_id, chamado_id, data_interacao, tipo, autor_tipo, duracao_min.
- `fato_satisfacao`: pesquisa_id, chamado_id, nota, classificacao, data_resposta.
