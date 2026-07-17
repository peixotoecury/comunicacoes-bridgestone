-- =====================================================================
-- Comunicações Bridgestone — schema Supabase (projeto "Valores", sydamnqagkdmczmgkvso)
-- Rodar no SQL Editor do Supabase (mesmo projeto usado pelo Controle de
-- Inserção de Cálculos). RLS aberta pro anon, mesmo padrão já em uso.
-- =====================================================================

create table if not exists comunicacoes_pericia (
  id bigint generated always as identity primary key,
  numero_processo text not null,
  nome_reclamante text not null,
  tipo_empregado text not null,           -- 'Terceiro' | 'Próprio'
  tipo_pericia text not null,             -- 'Médica' | 'Técnica' | 'Ergonômica'
  data_horario_pericia text not null,     -- formato livre "dd/mm/aaaa 00:00hrs"
  endereco_pericia text not null,
  nome_perito text not null,
  link_integra text not null,
  texto_email text not null,
  observacoes_adicionais text,
  advogado_responsavel text not null,
  destinatarios text not null,            -- snapshot de quem recebeu (auditoria)
  criado_em timestamptz not null default now()
);
alter table comunicacoes_pericia enable row level security;
create policy "anon all" on comunicacoes_pericia for all to anon using (true) with check (true);

create table if not exists comunicacoes_calculos (
  id bigint generated always as identity primary key,
  numero_processo text not null,
  nome_reclamante text not null,
  tipo_subsidio text not null,
  link_documentos text not null,
  prazo_envio date not null,
  outros_detalhes text,
  responsavel_sigla text not null,
  criado_em timestamptz not null default now()
);
alter table comunicacoes_calculos enable row level security;
create policy "anon all" on comunicacoes_calculos for all to anon using (true) with check (true);

create table if not exists reportes_decisao (
  id bigint generated always as identity primary key,
  numero_processo text not null,
  nome_reclamante text,
  advogado_parte_contraria text,

  -- Periculosidade
  perito_peri text,
  data_pericia_peri text,
  pericia_dia_adicional text,
  laudo_periculosidade_resultado text,
  laudo_periculosidade_data_inicio date,
  laudo_periculosidade_data_final date,
  laudo_periculosidade_motivo text,          -- checkboxes: pode ter varios, separados por ", "
  laudo_periculosidade_detalhamento text,    -- detalhe livre sobre a periculosidade (area/atividade especifica, etc.)
  laudo_periculosidade_fundamentacao text,   -- por que o laudo foi favoravel, se aplicavel
  decisao_periculosidade_igual_laudo text,   -- 'Sim' | 'Não' | 'Parcialmente' (comparado ao laudo)

  -- Insalubridade
  laudo_insalubridade_resultado text,
  laudo_insalubridade_data_inicio date,
  laudo_insalubridade_data_final date,
  laudo_insalubridade_motivo text,           -- checkboxes: pode ter varios, separados por ", "
  laudo_insalubridade_detalhamento text,     -- detalhe livre (ex: qual agente quimico, falta de creme, motivo da condenacao)
  laudo_insalubridade_outros text,
  laudo_insalubridade_fundamentacao text,    -- por que o laudo foi favoravel, se aplicavel
  decisao_insalubridade_igual_laudo text,    -- 'Sim' | 'Não' | 'Parcialmente' (comparado ao laudo)
  sentenca_embargos text,                    -- 'Sim' | 'Não'

  -- Guias RO (HISTÓRICO — removido do formulário, movido pra kits_pagamento;
  -- colunas mantidas só pra não perder os dados já preenchidos antes da mudança)
  ro_gdj_valor numeric,
  ro_gdj_vencimento date,
  ro_gru_valor numeric,
  ro_gru_vencimento date,
  ro_custas_valor numeric,
  ro_custas_vencimento date,

  -- Ergonômico / Perícia Médica
  laudo_ergonomico text,
  perito_medica text,
  data_pericia_medica text,
  medica_doenca text,                        -- checkboxes: pode ter varias, separadas por ", "
  medica_area_corpo text,                    -- checkboxes: pode ter varias, separadas por ", "
  medica_motivos text,
  medica_fonte_informacao text,              -- 'Petição Inicial' | 'Laudo Pericial'
  medica_laudo_resultado text,
  medica_fundamentacao text,                 -- por que o laudo foi favoravel, se aplicavel

  -- Sentença
  sentenca_resultado text,
  sentenca_data date,
  sentenca_juiz text,
  sentenca_reintegracao text,             -- 'Sim' | 'Não'
  sentenca_reintegracao_resultado text,   -- 'Deferida' | 'Indeferida' | 'Parcialmente Deferida' | 'Pendente'
  sentenca_reintegracao_nota text,
  coisa_julgada text,                     -- 'Sim' | 'Não'
  coisa_julgada_resultado text,
  coisa_julgada_motivo text,
  envio_cliente text,                     -- 'Sim' | 'Não' (só registro, não trava nada)
  inserir_gerencia text,                  -- 'Sim' | 'Não' -- inclui a Shana como destinatária dos e-mails de decisão quando 'Sim'
  sentenca_pedidos_deferidos text,
  sentenca_pedidos_indeferidos text,
  sentenca_causa_raiz text,
  sentenca_principal_favoravel text,
  sentenca_principal_desfavoravel text,
  sentenca_obrigacao_fazer text,

  -- Acórdão TRT
  acordao_trt_reclamada text,
  acordao_trt_data date,
  acordao_trt_turma text,
  acordao_trt_relator text,
  acordao_trt_resumo text,
  trt_embargos text,                         -- 'Sim' | 'Não'
  recurso_revista_resultado text,            -- 'Admitido' | 'Denegado Seguimento' | 'Pendente'

  -- Guias RR e AI (HISTÓRICO — removido do formulário, movido pra kits_pagamento;
  -- colunas mantidas só pra não perder os dados já preenchidos antes da mudança)
  rr_gdj_valor numeric,
  rr_gdj_vencimento date,
  rr_gru_valor numeric,
  rr_gru_vencimento date,
  rr_custas_valor numeric,
  rr_custas_vencimento date,
  ai_gdj_valor numeric,
  ai_gdj_vencimento date,
  ai_gru_valor numeric,
  ai_gru_vencimento date,
  ai_custas_valor numeric,
  ai_custas_vencimento date,

  -- Acórdão TST
  acordao_tst text,
  acordao_tst_data date,
  acordao_tst_camara text,
  acordao_tst_ministro text,
  acordao_tst_resumo text,
  tst_embargos text,                         -- 'Sim' | 'Não'

  -- Execução / status
  execucao text,                          -- 'Sim' | 'Não'
  ultima_movimentacao text,
  execucao_resumo text,

  -- Execução — Valores: cada item é independente e opcional (valor + data),
  -- preenchido só quando aplicável ao caso (movido de solicitacoes_insercao_valores).
  exec_calculo_reclamante_valor numeric,
  exec_calculo_reclamante_data date,
  exec_calculo_reclamada_valor numeric,
  exec_calculo_reclamada_data date,
  exec_pagamento_valor numeric,
  exec_pagamento_data date,
  exec_inss_valor numeric,
  exec_inss_data date,
  exec_garantia_valor numeric,
  exec_garantia_data date,
  exec_custas_valor numeric,
  exec_custas_data date,
  exec_gru_valor numeric,
  exec_gru_data date,
  exec_homologacao_calculos text,         -- 'Sim' | 'Não' -- Sentença de Liquidação / Homologação dos Cálculos
  exec_valor_homologado numeric,
  exec_valor_homologado_data date,
  exec_solicitacao_pagamento text,        -- 'Sim' | 'Não'
  exec_solicitacao_pagamento_data date,

  responsavel_sigla text,
  criado_em timestamptz not null default now(),
  atualizado_em timestamptz not null default now()
);
alter table reportes_decisao enable row level security;
create policy "anon all" on reportes_decisao for all to anon using (true) with check (true);

create table if not exists reportes_acordos (
  id bigint generated always as identity primary key,
  numero_processo text not null,
  nome_reclamante text,
  reclamada text,
  departamento text,
  comarca text,
  escritorio text,
  vara text,
  advogado_responsavel text,

  -- Negociação
  status_acordo text,
  status_homologacao text,
  tem_contraproposta text,                -- 'Sim' | 'Não'
  proposta numeric,
  negociacao_em text,
  justificativa text,
  pautao text,

  -- Valores
  total_provavel numeric,
  total_accrual numeric,
  valor_pago numeric,
  economia numeric,
  percentual_economia numeric,
  classificacao_economia text,

  -- Datas
  data_protocolo_acordo date,
  data_pagamento date,

  -- Aprovações
  solicitamos_autorizacao text,           -- 'Sim' | 'Não'
  aprovacao_acordo text,                  -- 'Sim' | 'Não' | 'Pendente'
  informacoes_adicionais text,

  criado_em timestamptz not null default now(),
  atualizado_em timestamptz not null default now()
);
alter table reportes_acordos enable row level security;
create policy "anon all" on reportes_acordos for all to anon using (true) with check (true);

-- Kits e Solicitações de Pagamento: pedido independente do advogado pra Gabi
-- (GDJ/GRU/Custas de Acordo, RO, RR, AI, Embargos à Execução, Depósitos e
-- Convolação de Depósitos). Fluxo: advogado solicita -> Gabi dá OK -> concluído
-- -> e-mail de retorno automático pro advogado solicitante.
create table if not exists kits_pagamento (
  id bigint generated always as identity primary key,
  numero_processo text,
  nome_reclamante text,
  advogado_solicitante text,
  tipo_solicitacao text,   -- 'Acordo' | 'GDJ' | 'Recurso Ordinário' | 'Recurso de Revista' | 'Agravo de Instrumento' | 'Embargos à Execução' | 'Depósito de Recurso Ordinário' | 'Depósito de Recurso de Revista' | 'Convolação de Depósitos'
  valor numeric,
  data_referencia date,    -- vencimento da guia ou data do depósito, conforme o tipo
  resumo text,
  status text not null default 'Pendente',   -- 'Pendente' | 'Concluído'
  concluido_em timestamptz,
  criado_em timestamptz not null default now()
);
alter table kits_pagamento enable row level security;
create policy "anon all" on kits_pagamento for all to anon using (true) with check (true);

create table if not exists solicitacoes_insercao_valores (
  id bigint generated always as identity primary key,
  numero_processo text not null,
  nome_reclamante text not null,
  reclamada text,
  vara_turma_camara text,
  comarca text,
  uf text,
  advogado_solicitante text,
  assistente_responsavel text,
  tipo_decisao text,
  tipo_calculo text,
  data_calculo date,
  revisado text,                          -- 'Sim' | 'Não'
  justificativa_revisao text,
  inserido_lm text,                       -- 'Sim' | 'Não'
  data_insercao_lm date,
  inserido_sistema text,                  -- 'Sim' | 'Não'
  data_insercao_sistema date,
  valor_atual_historico numeric,
  valor_novo_historico numeric,
  diff_historico numeric,
  valor_atual_provisao numeric,
  valor_novo_provisao numeric,
  diff_provisao numeric,
  valor_atual_accrual numeric,
  valor_novo_accrual numeric,
  diff_accrual numeric,
  fase_atual text,                        -- mudança de fase mesmo sem alteração de valores (ex: muda o % de provisão)
  nova_fase text,

  -- Execução (HISTÓRICO — campo removido do formulário, movido pra reportes_decisao;
  -- colunas mantidas só pra não perder os dados já preenchidos antes da mudança):
  -- cada item era independente e opcional (valor + data), preenchido só quando
  -- aplicável ao caso.
  exec_calculo_reclamante_valor numeric,
  exec_calculo_reclamante_data date,
  exec_calculo_reclamada_valor numeric,
  exec_calculo_reclamada_data date,
  exec_pagamento_valor numeric,
  exec_pagamento_data date,
  exec_inss_valor numeric,
  exec_inss_data date,
  exec_garantia_valor numeric,
  exec_garantia_data date,
  exec_custas_valor numeric,
  exec_custas_data date,
  exec_gru_valor numeric,
  exec_gru_data date,
  exec_homologacao_calculos text,         -- 'Sim' | 'Não' -- Sentença de Liquidação / Homologação dos Cálculos
  exec_solicitacao_pagamento text,        -- 'Sim' | 'Não'
  exec_solicitacao_pagamento_data date,

  link_calculo text,
  acima_400k boolean not null default false,  -- true se |diff_historico|, |diff_provisao| ou |diff_accrual| >= 400000; dispara nota pro Nicolau
  enviado_cliente text,                   -- 'Sim' | 'Não'
  justificativa_envio text,
  criado_em timestamptz not null default now()
);
alter table solicitacoes_insercao_valores enable row level security;
create policy "anon all" on solicitacoes_insercao_valores for all to anon using (true) with check (true);

-- Forecast Atual: snapshot mensal por processo (Histórico/Provisão/Accrual "Atual"),
-- extraído do arquivo "Forecast - Mês.aaaa - Vfinal.xlsx" enviado ao cliente. Cada
-- upload da aba Forecast Atual APAGA tudo e insere de novo — só existe o mês mais
-- recente, nunca histórico de meses anteriores. Alimenta o autopreenchimento de
-- "Valor Atual" (Histórico/Provisão/Accrual) na aba Inserção de Valores, por Processo.
-- v2: todas as ~85 colunas do arquivo de Forecast (não só as 6 usadas no autopreenchimento
-- do "Valor Atual"), a pedido da usuária. Nomes traduzidos/esclarecidos a partir dos
-- cabeçalhos originais em inglês do arquivo; várias colunas do arquivo se repetem com o
-- MESMO nome (ex.: "Plaintiff"/"Defendant" aparecem 4x, "Deposit at the Court's disposal?"
-- aparece 6x) — por isso o parser (index.html) lê por POSIÇÃO relativa à coluna "Process",
-- não pelo nome do cabeçalho, e cada ocorrência ganhou um nome de coluna distinto aqui.
drop table if exists forecast_atual;
create table forecast_atual (
  processo text primary key,
  escritorio text,
  assessed_status text,
  status_processo text,
  data_distribuicao text,
  data_ajuizamento text,
  data_encerramento text,
  rl text,
  centro_custo text,
  data_admissao text,
  data_demissao text,
  cargo text,
  tipo_salario text,
  departamento_1 text,
  departamento_2 text,
  business text,
  tipo_caso text,
  revised text,
  forecast_grupo text,
  cidade text,
  uf text,
  reclamante text,
  cpf_reclamante text,
  advogado_reclamante text,
  reclamada text,
  terceirizacao text,
  empresa text,
  empresa_status text,
  fase_atual text,
  fase_atual_divisao text,
  historico_percentual_atual numeric,
  historico_atual numeric,
  correcao_atual numeric,
  correcao_percentual_atual numeric,
  juros_atual numeric,
  juros_percentual_atual numeric,
  provisao_atual numeric,
  correcao_juros_percentual_atual numeric,
  total_possivel_atual numeric,
  total_remoto_atual numeric,
  accrual_atual numeric,
  fase_anterior text,
  fase_anterior_divisao text,
  historico_percentual_anterior numeric,
  historico_anterior numeric,
  correcao_anterior numeric,
  correcao_percentual_anterior numeric,
  juros_anterior numeric,
  juros_percentual_anterior numeric,
  provisao_anterior numeric,
  correcao_juros_percentual_anterior numeric,
  total_possivel_anterior numeric,
  total_remoto_anterior numeric,
  accrual_anterior numeric,
  diferenca_accrual numeric,
  diferenca_juros_correcao numeric,
  diferenca_historico numeric,
  mudanca_fase text,
  mudanca_fase_detalhe text,
  ajuste text,
  pagamentos_liberacao_depositos numeric,
  pagamento_historico_inss_honorarios_ir numeric,
  baixa_recursal_pagamento numeric,
  deposito_garantia_valor numeric,
  deposito_garantia_data text,
  deposito_garantia_disposicao_1 text,
  deposito_garantia_disposicao_2 text,
  deposito_garantia_comparativo text,
  deposito_garantia_reclamante numeric,
  deposito_garantia_reclamada numeric,
  deposito_pagamento_valor numeric,
  deposito_pagamento_data text,
  deposito_pagamento_disposicao_1 text,
  deposito_pagamento_disposicao_2 text,
  deposito_pagamento_comparativo text,
  deposito_pagamento_reclamante numeric,
  deposito_pagamento_reclamada numeric,
  deposito_recursal_valor numeric,
  deposito_recursal_disposicao_1 text,
  deposito_recursal_disposicao_2 text,
  deposito_recursal_comparativo text,
  deposito_recursal_reclamante numeric,
  deposito_recursal_reclamada numeric,
  apontamentos_depositos text,
  observacoes text,
  atualizado_em timestamptz not null default now()
);
alter table forecast_atual enable row level security;
create policy "anon all" on forecast_atual for all to anon using (true) with check (true);

-- Realtime: cada aba assina mudanças na sua tabela pra atualizar sozinha sem F5.
alter publication supabase_realtime add table comunicacoes_pericia;
alter publication supabase_realtime add table comunicacoes_calculos;
alter publication supabase_realtime add table reportes_decisao;
alter publication supabase_realtime add table reportes_acordos;
alter publication supabase_realtime add table kits_pagamento;
alter publication supabase_realtime add table solicitacoes_insercao_valores;
alter publication supabase_realtime add table forecast_atual;

-- =====================================================================
-- Migração: campos "Mudança de Fase" na aba Inserção de Valores (rodar só
-- se a tabela solicitacoes_insercao_valores já existir sem essas colunas).
-- =====================================================================
alter table solicitacoes_insercao_valores add column if not exists fase_atual text;
alter table solicitacoes_insercao_valores add column if not exists nova_fase text;

-- =====================================================================
-- Migração: campos "Execução" na aba Inserção de Valores (rodar só se a
-- tabela solicitacoes_insercao_valores já existir sem essas colunas).
-- =====================================================================
alter table solicitacoes_insercao_valores add column if not exists exec_calculo_reclamante_valor numeric;
alter table solicitacoes_insercao_valores add column if not exists exec_calculo_reclamante_data date;
alter table solicitacoes_insercao_valores add column if not exists exec_calculo_reclamada_valor numeric;
alter table solicitacoes_insercao_valores add column if not exists exec_calculo_reclamada_data date;
alter table solicitacoes_insercao_valores add column if not exists exec_pagamento_valor numeric;
alter table solicitacoes_insercao_valores add column if not exists exec_pagamento_data date;
alter table solicitacoes_insercao_valores add column if not exists exec_inss_valor numeric;
alter table solicitacoes_insercao_valores add column if not exists exec_inss_data date;
alter table solicitacoes_insercao_valores add column if not exists exec_garantia_valor numeric;
alter table solicitacoes_insercao_valores add column if not exists exec_garantia_data date;
alter table solicitacoes_insercao_valores add column if not exists exec_custas_valor numeric;
alter table solicitacoes_insercao_valores add column if not exists exec_custas_data date;
alter table solicitacoes_insercao_valores add column if not exists exec_gru_valor numeric;
alter table solicitacoes_insercao_valores add column if not exists exec_gru_data date;
alter table solicitacoes_insercao_valores add column if not exists exec_homologacao_calculos text;
alter table solicitacoes_insercao_valores add column if not exists exec_solicitacao_pagamento text;
alter table solicitacoes_insercao_valores add column if not exists exec_solicitacao_pagamento_data date;
