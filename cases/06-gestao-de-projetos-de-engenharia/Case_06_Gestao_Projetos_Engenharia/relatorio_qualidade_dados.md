# Relatório de qualidade dos dados

- Data de corte: 2026-06-30.
- Projetos: 36.
- Atividades: 572.
- Registros de custo: 1500.
- Apontamentos de horas: 2578.
- Integridade referencial: validada pelo SQLite (`PRAGMA foreign_key_check`).
- Chaves primárias e códigos de projeto/atividade: únicos.
- Nulos esperados: datas reais de itens não iniciados ou ainda não concluídos.
- Domínios: percentuais, probabilidade, impacto e indicadores binários protegidos por `CHECK`.
- Regra de atenção: mudanças podem ter impacto de custo negativo quando representam economia.
- Limitação proposital: o case não contém baseline versionada nem valor agregado (PV/EV/AC) por pacote de trabalho.
