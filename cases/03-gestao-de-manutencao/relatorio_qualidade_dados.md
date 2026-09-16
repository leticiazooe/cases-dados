# Relatório de Qualidade dos Dados

Validações realizadas na geração do case:

- Integridade referencial: nenhuma chave estrangeira inválida;
- Identificadores de equipamentos, OS, peças e matrículas: únicos;
- Datas de conclusão: posteriores ao início;
- Duração das paradas: positiva;
- Custos, horas, quantidades e estoques: não negativos;
- Consumos e apontamentos: vinculados a ordens existentes;
- Falhas: vinculadas a equipamentos e ordens existentes;
- Produção: quantidade produzida não superior à planejada;
- Calendário: cobertura contínua entre 2023 e 2025.

Alertas intencionais para análise:

- Planos preventivos vencidos;
- Equipamentos temporariamente em manutenção ou inativos;
- Peças abaixo do estoque mínimo;
- Ordens aguardando peças;
- Falhas recorrentes;
- Ordens marcadas como retrabalho.

Esses alertas representam situações de negócio, não erros de integridade.
