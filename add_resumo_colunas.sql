-- Rodar no SQL Editor do projeto Supabase "Valores" (sydamnqagkdmczmgkvso)
-- Adiciona os campos de Resumo (Acórdão TRT, Acórdão TST e Execução) e o bloco
-- de valores de Execução (movido da aba Inserção de Valores) na tabela reportes_decisao

alter table reportes_decisao add column if not exists acordao_trt_resumo text;
alter table reportes_decisao add column if not exists acordao_tst_resumo text;
alter table reportes_decisao add column if not exists execucao_resumo text;

alter table reportes_decisao add column if not exists exec_calculo_reclamante_valor numeric;
alter table reportes_decisao add column if not exists exec_calculo_reclamante_data date;
alter table reportes_decisao add column if not exists exec_calculo_reclamada_valor numeric;
alter table reportes_decisao add column if not exists exec_calculo_reclamada_data date;
alter table reportes_decisao add column if not exists exec_pagamento_valor numeric;
alter table reportes_decisao add column if not exists exec_pagamento_data date;
alter table reportes_decisao add column if not exists exec_inss_valor numeric;
alter table reportes_decisao add column if not exists exec_inss_data date;
alter table reportes_decisao add column if not exists exec_garantia_valor numeric;
alter table reportes_decisao add column if not exists exec_garantia_data date;
alter table reportes_decisao add column if not exists exec_custas_valor numeric;
alter table reportes_decisao add column if not exists exec_custas_data date;
alter table reportes_decisao add column if not exists exec_gru_valor numeric;
alter table reportes_decisao add column if not exists exec_gru_data date;
alter table reportes_decisao add column if not exists exec_homologacao_calculos text;
alter table reportes_decisao add column if not exists exec_valor_homologado numeric;
alter table reportes_decisao add column if not exists exec_valor_homologado_data date;
alter table reportes_decisao add column if not exists exec_solicitacao_pagamento text;
alter table reportes_decisao add column if not exists exec_solicitacao_pagamento_data date;
