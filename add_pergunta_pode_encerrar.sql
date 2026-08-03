-- =====================================================================
-- Comunicações Bridgestone — ajuste do fluxo de Encerramentos
-- Rodar no SQL Editor do Supabase (projeto "Valores", sydamnqagkdmczmgkvso)
-- A tabela reportes_encerramentos já existe (rodou add_reportes_encerramentos.sql
-- antes) — isso só adiciona as 2 colunas novas do fluxo em 2 etapas
-- (advogado pergunta pra Gabi -> Gabi responde se pode encerrar).
-- =====================================================================

alter table reportes_encerramentos add column if not exists pergunta text;
alter table reportes_encerramentos add column if not exists pode_encerrar text;
