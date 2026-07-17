-- Rodar no SQL Editor do projeto Supabase "Valores" (sydamnqagkdmczmgkvso)
-- Adiciona os campos de Resumo (Acórdão TRT, Acórdão TST e Execução) na tabela ja existente

alter table reportes_decisao add column if not exists acordao_trt_resumo text;
alter table reportes_decisao add column if not exists acordao_tst_resumo text;
alter table reportes_decisao add column if not exists execucao_resumo text;
