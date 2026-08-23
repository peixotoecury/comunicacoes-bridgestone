-- Rodar no SQL Editor do projeto Supabase "Valores" (sydamnqagkdmczmgkvso)
-- Kits: terceira etapa do trâmite — depois que a Gabi conclui e manda o
-- e-mail de validação (com o Excel BSBR), o advogado confirma que conferiu
-- e o status vira 'Validado', encerrando o trâmite (Pendente → Concluído → Validado).

alter table kits_pagamento add column if not exists validado_em timestamptz;
