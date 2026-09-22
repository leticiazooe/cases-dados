# Dicionário de Dados

| Campo | Tipo sugerido | Obrigatório | Finalidade |
|---|---|---:|---|
| copia_id | TEXT | Sim | Identificador único da cópia |
| documento_id | TEXT | Sim | Chave do documento |
| codigo_documento | TEXT | Sim | Código empresarial |
| titulo_documento | TEXT | Sim | Identificação legível |
| revisao_copia | TEXT | Sim | Revisão impressa/emitida |
| revisao_vigente | TEXT | Sim | Revisão atualmente válida |
| tipo_copia | TEXT | Sim | Controlada / não controlada |
| data_emissao | DATETIME | Sim | Momento da emissão |
| validade_ate | DATETIME | Não | Data limite de validade |
| status_copia | TEXT | Sim | Ativa, devolvida, vencida, cancelada, destruída, substituída |
| solicitante | TEXT | Não | Quem solicitou |
| aprovador | TEXT | Não | Quem autorizou |
| usuario_emissor | TEXT | Sim | Quem realizou a emissão |
| responsavel | TEXT | Sim para controlada | Custodiante atual |
| setor | TEXT | Não | Área responsável |
| projeto | TEXT | Não | Projeto associado |
| localizacao | TEXT | Sim para controlada | Local físico ou destino |
| motivo_emissao | TEXT | Não | Finalidade da cópia |
| quantidade_autorizada | INTEGER | Não | Quantidade aprovada |
| numero_copia | INTEGER | Não | Número sequencial dentro da emissão |
| criticidade | TEXT | Não | Alta, média, baixa |
| data_baixa | DATETIME | Não | Encerramento da circulação |
| motivo_baixa | TEXT | Não | Devolução, destruição, substituição etc. |
| copia_substituta_id | TEXT | Não | Nova cópia quando houver substituição |
| ultima_movimentacao | DATETIME | Não | Último evento registrado |

## Regras mínimas de qualidade

1. `copia_id` deve ser único.
2. Toda cópia controlada ativa deve possuir `responsavel` e `localizacao`.
3. `revisao_copia` deve ser comparável com `revisao_vigente`.
4. Uma cópia com `status_copia = Ativa` não deve possuir `data_baixa`.
5. Uma cópia baixada deve possuir `data_baixa` e `motivo_baixa`.
6. Se houver validade, cópias vencidas não devem permanecer ativas sem exceção formal.
