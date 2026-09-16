# Qualidade dos dados

- Registros por tabela: {'unidades': 6, 'localizacoes': 30, 'tipos_ativo': 15, 'fornecedores': 15, 'colaboradores': 1800, 'ativos': 4200, 'atribuicoes': 3008, 'movimentacoes': 6239, 'manutencoes': 3565, 'softwares': 12, 'contratos_licenca': 30, 'alocacoes_licenca': 3465}
- Integridade referencial, patrimônios e números de série validados.
- Hostname nulo é esperado para equipamentos sem identidade de rede.
- Atribuição nula é aceitável para estoque, manutenção, trânsito, ativos compartilhados e baixados.
- Depreciação linear: custo dividido pela vida útil, sem valor residual e com data de corte 30/06/2026.
- Limitações: não inclui impostos, leasing, centros de custo, descoberta automática, CMDB ou integração com MDM.
