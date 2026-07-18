-- Rodar no SQL Editor do projeto Supabase "Valores" (sydamnqagkdmczmgkvso)
-- Kits: adiciona se a Convolação (de Depósitos, ou de Garantia da Execução
-- quando convolada) foi Integral ou Parcial, junto com o split Reclamante/
-- Reclamada já existente.

alter table kits_pagamento add column if not exists convolacao_tipo text;
