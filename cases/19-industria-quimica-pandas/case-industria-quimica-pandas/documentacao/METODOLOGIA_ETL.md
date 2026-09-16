# Metodologia ETL com pandas

+1. **Ingestão:** CSVs preservados em `dados_brutos`, com `sep=";"`, decimal brasileiro e datas dia/mês/ano.
+2. **Profiling:** contagem, nulidade, duplicidade, tipos e limites de domínio.
+3. **Padronização:** nomes de colunas, textos, datas, booleanos e valores numéricos.
+4. **Qualidade:** chave única, obrigatoriedade, quantidade positiva, pH entre 0 e 14 e integridade referencial.
+5. **Quarentena:** registros inválidos não desaparecem; são publicados em arquivo de rejeitados.
+6. **Enriquecimento:** margem, OTIF, produtividade, rendimento e intensidade ambiental.
+7. **Publicação:** CSVs tratados, mart mensal e SQLite.
+8. **Reconciliação:** volumes antes/depois e motivos de descarte registrados no relatório de qualidade.
+
+Em produção, a evolução natural seria incluir testes com pytest/Pandera, logs estruturados, carga incremental, orquestração e controle de schema.
+