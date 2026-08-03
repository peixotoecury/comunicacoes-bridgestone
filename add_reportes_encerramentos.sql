-- =====================================================================
-- Comunicações Bridgestone — aba Encerramentos (Convolação de Depósitos)
-- Rodar no SQL Editor do Supabase (projeto "Valores", sydamnqagkdmczmgkvso)
-- =====================================================================

create table if not exists reportes_encerramentos (
  id bigint generated always as identity primary key,
  numero_processo text not null,
  nome_reclamante text not null,
  advogado_responsavel text not null,
  pergunta text,           -- observação/contexto que o advogado escreve ao perguntar pra Gabi

  -- Status: 'Pendente' até a Gabi responder se pode encerrar (modal "Responder").
  -- Se ela disser "Sim", entra com os dados da convolação e o sistema marca
  -- 'Concluído' e manda pro Grupo Bridgestone. Se "Não", o retorno vai só pro
  -- advogado e o registro continua 'Pendente' (ela pode voltar depois).
  status text not null default 'Pendente',    -- 'Pendente' | 'Concluído'
  pode_encerrar text,      -- 'Sim' | 'Não' — resposta da Gabi
  concluido_em timestamptz,

  convolacao_dr_dj_principal numeric,
  convolacao_dr_dj_juros numeric,
  convolacao_dr_dj numeric,
  data_convolacao date,
  tipo text,              -- 'Depósito de Garantia' | 'Depósito Judicial' | 'Execução' | 'Pagamento'
  tipo_pagamento text,    -- mesma lista de Tipo de Solicitação usada em kits_pagamento

  informacoes_depositos text,
  obs_assistentes text,

  criado_em timestamptz not null default now(),
  atualizado_em timestamptz not null default now()
);
alter table reportes_encerramentos enable row level security;
create policy "anon all" on reportes_encerramentos for all to anon using (true) with check (true);
