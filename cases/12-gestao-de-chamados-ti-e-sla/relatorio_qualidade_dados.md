# Qualidade dos dados

- Registros: {'unidades': 6, 'equipes': 5, 'categorias': 10, 'politicas_sla': 4, 'usuarios': 1200, 'tecnicos': 45, 'chamados': 6000, 'interacoes': 15115, 'satisfacao': 3189}
- Integridade referencial e chaves validadas.
- Datas de resolução e fechamento nulas são esperadas em chamados ainda abertos.
- Pesquisa de satisfação é opcional e possui no máximo uma resposta por chamado.
- Reincidência: mesmo usuário e categoria em janela de até 30 dias, conforme regra sintética.
- Tempos foram calculados em horas corridas; em produção, recomenda-se calendário de horas úteis.
- Limitações: sem custo por hora, ativos de CMDB, mudanças, problemas, conhecimento e contratos externos.
