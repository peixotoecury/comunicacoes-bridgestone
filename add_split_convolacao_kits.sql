-- Rodar no SQL Editor do projeto Supabase "Valores" (sydamnqagkdmczmgkvso)
-- Kits: adiciona o split Reclamante/Reclamada usado na Convolação de
-- Depósitos (sempre) e na Garantia da Execução quando convolada em
-- pagamento (novo Tipo de Solicitação).

alter table kits_pagamento add column if not exists valor_reclamante numeric;
alter table kits_pagamento add column if not exists valor_reclamada numeric;
alter table kits_pagamento add column if not exists convolado text;
