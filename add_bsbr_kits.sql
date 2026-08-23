-- Rodar no SQL Editor do projeto Supabase "Valores" (sydamnqagkdmczmgkvso)
-- Kits: campos do e-mail de validação que a Gabi envia pro advogado depois
-- de processar o kit no modelo BSBR (Complaint identification + Payment
-- information), preenchidos na conclusão do kit (não na solicitação).

alter table kits_pagamento add column if not exists cost_center text;
alter table kits_pagamento add column if not exists court_number text;
alter table kits_pagamento add column if not exists location text;
alter table kits_pagamento add column if not exists accrual numeric;
alter table kits_pagamento add column if not exists type_of_payment_desc text;
alter table kits_pagamento add column if not exists reference_number text;
alter table kits_pagamento add column if not exists guarantee_payment text;
alter table kits_pagamento add column if not exists account_number text;
alter table kits_pagamento add column if not exists deposit_slip text;
