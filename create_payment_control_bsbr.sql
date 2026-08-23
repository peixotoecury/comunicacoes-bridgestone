-- Rodar no SQL Editor do projeto Supabase "Valores" (sydamnqagkdmczmgkvso)
-- Payment Control — espelha a estrutura real de PAYMENT CONTROL.xlsx (aba
-- "LABOR PAYMENT CONTROL"), alimentada automaticamente quando um Kit é
-- concluído (ver salvarConclusaoKit em index.html), sem substituir o que já
-- é salvo em kits_pagamento — é um destino adicional dos mesmos dados.

create table if not exists payment_control_bsbr (
  id bigint generated always as identity primary key,
  kit_id bigint references kits_pagamento(id),
  law_firm text default 'PEIXOTO',
  payment_request_date date,
  plaintiff text,
  court_number text,
  location text,
  claim_number text,
  cost_center text,
  accrual numeric,
  type_of_payment text,
  deadline date,
  payment_date date,
  value numeric,
  reference_number text,
  guarantee_payment text,
  account_number text,
  status text,
  status_date timestamptz,
  sap_voucher_number text,
  seguro text,
  enviado_recebido_escritorio text,
  elaw text,
  criado_em timestamptz default now()
);

alter table payment_control_bsbr enable row level security;
create policy "anon full access" on payment_control_bsbr for all to anon using (true) with check (true);
