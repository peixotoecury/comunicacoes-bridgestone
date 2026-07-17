-- Rodar no SQL Editor do projeto Supabase "Valores" (sydamnqagkdmczmgkvso)
-- Separa o envio de e-mail por seção (Laudo, Sentença, Acórdão, Execução) —
-- antes era um único par envio_cliente/inserir_gerencia pra todo o reporte;
-- agora cada seção decide independentemente se vai pro cliente e se inclui
-- a Shana (gerência). As colunas antigas envio_cliente/inserir_gerencia
-- continuam existindo só pra não perder o histórico já salvo antes da mudança.

alter table reportes_decisao add column if not exists envio_cliente_laudo text;
alter table reportes_decisao add column if not exists inserir_gerencia_laudo text;
alter table reportes_decisao add column if not exists envio_cliente_sentenca text;
alter table reportes_decisao add column if not exists inserir_gerencia_sentenca text;
alter table reportes_decisao add column if not exists envio_cliente_acordao text;
alter table reportes_decisao add column if not exists inserir_gerencia_acordao text;
alter table reportes_decisao add column if not exists envio_cliente_execucao text;
alter table reportes_decisao add column if not exists inserir_gerencia_execucao text;
