-- fornecedores com atraso
SELECT fornecedor_id, COUNT(*) entregas, AVG(entrega_no_prazo) otif FROM fato_compras GROUP BY fornecedor_id ORDER BY otif;

-- perdas por produto
SELECT produto_id, SUM(refugo_kg) refugo_kg, AVG(refugo_pct) refugo_pct FROM fato_producao GROUP BY produto_id ORDER BY refugo_kg DESC;
