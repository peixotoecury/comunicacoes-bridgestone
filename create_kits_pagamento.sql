-- Rodar no SQL Editor do projeto Supabase "Valores" (sydamnqagkdmczmgkvso)
-- Cria a tabela da aba Kits e Solicitações de Pagamento

create table if not exists kits_pagamento (
  id bigint generated always as identity primary key,
  numero_processo text,
  nome_reclamante text,
  advogado_solicitante text,
  tipo_solicitacao text,
  valor numeric,
  data_referencia date,
  resumo text,
  status text not null default 'Pendente',
  concluido_em timestamptz,
  criado_em timestamptz not null default now()
);

alter table kits_pagamento enable row level security;
create policy "anon all" on kits_pagamento for all to anon using (true) with check (true);
alter publication supabase_realtime add table kits_pagamento;
