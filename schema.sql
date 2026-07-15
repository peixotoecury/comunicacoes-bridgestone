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
  laudo_periculosidade_motivo text,
  decisao_periculosidade_resultado text,
  decisao_periculosidade_data_inicio date,
  decisao_periculosidade_data_final date,
  decisao_periculosidade_motivo text,
  periculosidade_detalhamento_pos2016 text,

  -- Insalubridade
  laudo_insalubridade_resultado text,
  laudo_insalubridade_data_inicio date,
  laudo_insalubridade_data_final date,
  laudo_insalubridade_motivo text,
  laudo_insalubridade_outros text,
  decisao_insalubridade_resultado text,
  decisao_insalubridade_grau text,
  decisao_insalubridade_data_inicio date,
  decisao_insalubridade_data_final date,
  decisao_insalubridade_motivo text,
  decisao_insalubridade_agentes text,
  insalubridade_obs_epi text,
  insalubridade_analise_complementar text,

  -- Ergonômico / Perícia Médica
  laudo_ergonomico text,
  perito_medica text,
  data_pericia_medica text,
  medica_doenca text,
  medica_area_corpo text,
  medica_motivos text,
  medica_fonte_informacao text,
  medica_laudo_resultado text,

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

  -- Acórdão TRT
  acordao_trt_reclamada text,
  acordao_trt_data date,
  acordao_trt_turma text,
  acordao_trt_relator text,

  -- Acórdão TST
  acordao_tst text,
  acordao_tst_data date,
  acordao_tst_camara text,
  acordao_tst_ministro text,

  -- Execução / status
  execucao text,                          -- 'Sim' | 'Não'
  ultima_movimentacao text,

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
  link_calculo text,
  acima_400k boolean not null default false,  -- true se |diff_historico|, |diff_provisao| ou |diff_accrual| >= 400000; dispara nota pro Nicolau
  enviado_cliente text,                   -- 'Sim' | 'Não'
  justificativa_envio text,
  criado_em timestamptz not null default now()
);
alter table solicitacoes_insercao_valores enable row level security;
create policy "anon all" on solicitacoes_insercao_valores for all to anon using (true) with check (true);

-- Realtime: cada aba assina mudanças na sua tabela pra atualizar sozinha sem F5.
alter publication supabase_realtime add table comunicacoes_pericia;
alter publication supabase_realtime add table comunicacoes_calculos;
alter publication supabase_realtime add table reportes_decisao;
alter publication supabase_realtime add table reportes_acordos;
alter publication supabase_realtime add table solicitacoes_insercao_valores;
