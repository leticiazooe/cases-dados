# Dicionário de Dados

As tabelas `dim_*` descrevem cadastros e as tabelas `fato_*` registram eventos mensuráveis. As chaves `id_*` conectam as entidades. Consulte `schema.sql` para tipos, chaves e cardinalidades.

## Regras

- Identificadores devem ser únicos;
- Datas e quantidades devem ser válidas;
- Custos e volumes não podem ser negativos;
- Todo fato deve possuir dimensões correspondentes;
- Indicadores devem respeitar período e granularidade.
