# Fontes e rastreabilidade

## Fonte principal
- Instituição: Empresa de Pesquisa Energética (EPE), vinculada ao Ministério de Minas e Energia.
- Publicação: Balanço Energético Nacional 2025, ano-base 2024.
- Arquivo: Anexo IX - Balanços Consolidados em tep, 1970 a 2024.
- Página oficial: https://www.epe.gov.br/pt/publicacoes-dados-abertos/publicacoes/balanco-energetico-nacional-2025
- Arquivo oficial: https://www.epe.gov.br/sites-pt/publicacoes-dados-abertos/publicacoes/PublicacoesArquivos/publicacao-885/topico-766/Anexo%20IX%20-%20Balan%C3%A7os%20Consolidados%20%28em%20tep%29%201970%20a%202024.xlsx
- Licença informada pela página: Creative Commons Atribuição 4.0.
- Data de acesso: 28/07/2026.

## Tratamentos
- Recorte temporal: 2010 a 2024.
- Unidade mantida: `10³ tep` (mil toneladas equivalentes de petróleo).
- Produtos energéticos: colunas de fontes primárias e secundárias, excluindo colunas de total.
- Contas consumidas: Produção, Importação e Exportação.
- No BEN, exportações são apresentadas com sinal negativo por convenção contábil. O modelo mantém
  `valor_original_ben` e cria `valor_ktep` positivo para facilitar comparações visuais.
- O saldo físico é `exportação - importação`; não representa saldo comercial em dólares.

## Fontes complementares recomendadas
- ANEEL/SIGA: capacidade e cadastro de empreendimentos de geração:
  https://dadosabertos.aneel.gov.br/dataset/siga-sistema-de-informacoes-de-geracao-da-aneel
- ONS Dados Abertos: geração verificada e capacidade do SIN:
  https://dados.ons.org.br/
- MDIC/Comex Stat: valores monetários e quantidades do comércio exterior por NCM:
  https://comexstat.mdic.gov.br/
