# Relatório de qualidade

- Registros por tabela: {'fontes': 8, 'regioes': 5, 'usinas': 36, 'geracao_mensal': 1080, 'custos': 4320, 'emissoes': 1080, 'indisponibilidades': 619, 'clientes': 80, 'contratos': 220, 'investimentos': 180}
- Integridade referencial: validada no SQLite.
- Chaves primárias: únicas e não nulas.
- Valores físicos: geração, custos, emissões e durações não negativos.
- Datas: padrão ISO `AAAA-MM-DD`; competência mensal de janeiro/2024 a junho/2026.
- Premissas: intensidade é sintética e simplificada; nuclear classificada como não renovável,
  embora tenha baixa emissão operacional; biomassa possui emissão operacional modelada.
- Limitações: não inclui mercado horário, transmissão, armazenamento, certificados, ciclo de vida
  completo, preço spot ou projeções meteorológicas.
