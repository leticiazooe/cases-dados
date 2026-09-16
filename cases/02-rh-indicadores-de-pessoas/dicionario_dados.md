# Dicionário de Dados

## dim_unidade

Cadastro das unidades organizacionais. Chave: `id_unidade`.

Campos: unidade, cidade, UF e região.

## dim_setor

Cadastro de setores e diretorias. Chave: `id_setor`.

## dim_cargo

Cadastro de cargos, nível e faixa salarial. Chave: `id_cargo`.

Regra: salário mínimo não pode superar o máximo.

## colaborador

Cadastro mestre fictício de colaboradores. Chave: `id_colaborador`. Chaves estrangeiras: unidade, setor, cargo e gestor.

Granularidade: um registro por colaborador. A matrícula é única. `status_colaborador` aceita Ativo ou Desligado. Um colaborador desligado deve possuir `data_desligamento`.

## fato_movimentacao

Registra admissão, promoção e desligamento. Chave: `id_movimentacao`.

Granularidade: um registro por movimentação de colaborador.

## fato_ausencia

Registra afastamentos, faltas, atrasos e consultas. Chave: `id_ausencia`.

Granularidade: um evento de ausência por colaborador. As horas e o custo estimado não podem ser negativos.

## fato_hora_extra

Registra horas extras por data, colaborador e tipo de adicional. Chave: `id_hora_extra`.

Granularidade: um lançamento de hora extra. Apenas lançamentos aprovados devem compor o custo oficial.

## dim_treinamento

Catálogo de treinamentos. Chave: `id_treinamento`.

Indica categoria, carga horária, obrigatoriedade e validade.

## fato_participacao_treinamento

Registra a participação do colaborador. Chave: `id_participacao`.

Granularidade: uma participação por colaborador e treinamento. A nota deve ser preenchida somente após avaliação/conclusão.

## fato_avaliacao_desempenho

Registra avaliações por ciclo anual. Chave: `id_avaliacao`.

Granularidade: uma avaliação por colaborador e ano. Notas variam de 0 a 5. A nota final combina resultados e competências.

## Relacionamentos

- Unidade 1:N Colaborador;
- Setor 1:N Colaborador;
- Cargo 1:N Colaborador;
- Colaborador 1:N Movimentação;
- Colaborador 1:N Ausência;
- Colaborador 1:N Hora extra;
- Colaborador 1:N Participação em treinamento;
- Treinamento 1:N Participação;
- Colaborador 1:N Avaliação de desempenho;
- Colaborador 1:N Colaborador, no relacionamento gestor–liderado.
