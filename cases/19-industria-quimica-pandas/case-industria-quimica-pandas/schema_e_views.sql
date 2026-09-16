-- Case 19 - Industria Quimica
CREATE VIEW vw_margem_produto AS
SELECT p.produto, p.familia, SUM(v.receita_liquida) receita, SUM(v.margem) margem, SUM(v.margem)/NULLIF(SUM(v.receita_liquida),0) margem_pct
FROM fato_vendas v JOIN dim_produtos p ON p.produto_id=v.produto_id WHERE v.status <> 'Cancelado' GROUP BY p.produto,p.familia;
