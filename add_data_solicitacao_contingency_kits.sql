-- Rodar no SQL Editor do projeto Supabase "Valores" (sydamnqagkdmczmgkvso)
-- Kits: adiciona a Data da Solicitação (separada da Data de vencimento/depósito)
-- e se o pagamento é pro Contingency ou pro Forecast.

alter table kits_pagamento add column if not exists data_solicitacao date;
alter table kits_pagamento add column if not exists contingency_forecast text;
