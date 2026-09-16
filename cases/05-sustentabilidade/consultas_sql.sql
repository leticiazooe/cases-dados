-- Consumo de energia por unidade
SELECT u.unidade,SUM(e.consumo_mwh) mwh,SUM(e.custo) custo FROM fato_consumo_energia e JOIN dim_unidade u ON u.id_unidade=e.id_unidade GROUP BY u.unidade;
-- Água e reuso
SELECT u.unidade,SUM(a.volume_m3) consumo,SUM(a.volume_reutilizado_m3) reuso FROM fato_consumo_agua a JOIN dim_unidade u ON u.id_unidade=a.id_unidade GROUP BY u.unidade;
-- Resíduos por destinação
SELECT destinacao,SUM(quantidade_ton) toneladas FROM fato_residuo GROUP BY destinacao;
-- Emissões por escopo
SELECT f.escopo,SUM(e.emissao_tco2e) tco2e FROM fato_emissao e JOIN dim_fonte_emissao f ON f.id_fonte_emissao=e.id_fonte_emissao GROUP BY f.escopo;
