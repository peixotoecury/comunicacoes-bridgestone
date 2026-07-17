-- Rodar no SQL Editor do projeto Supabase "Valores" (sydamnqagkdmczmgkvso)
-- Padroniza o fluxo Pendente/Concluído (com botão "Concluir" e e-mail de
-- retorno pro advogado) também no Reporte de Decisão e no Reporte de Acordos
-- — mesmo padrão já usado em Kits e Inserção de Valores.

-- Reporte de Decisão: novo campo "Advogado Responsável" (lista, usado pra
-- achar o e-mail de retorno) + status/concluído_em.
alter table reportes_decisao add column if not exists advogado_responsavel text;
alter table reportes_decisao add column if not exists status text not null default 'Pendente';
alter table reportes_decisao add column if not exists concluido_em timestamptz;

-- Reporte de Acordos: "Concluir" preenche aprovacao_acordo (Sim/Não) e marca
-- status/concluído_em; advogado_responsavel já existia (lista).
alter table reportes_acordos add column if not exists status text not null default 'Pendente';
alter table reportes_acordos add column if not exists concluido_em timestamptz;
