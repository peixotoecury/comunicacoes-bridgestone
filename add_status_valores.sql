-- Rodar no SQL Editor do projeto Supabase "Valores" (sydamnqagkdmczmgkvso)
-- Adiciona o controle de status (Pendente/Concluído) e o carimbo de última
-- atualização na tabela solicitacoes_insercao_valores. Antes, cada envio do
-- formulário criava uma linha nova e desconectada mesmo pro mesmo processo
-- (ex: Cálculo depois Mudança de Fase virava 2 linhas sem relação); agora,
-- enquanto a solicitação do processo estiver "Pendente", o Cálculo, a
-- Inserção de Valores e a Mudança de Fase atualizam a MESMA linha. Quando a
-- assistente confirma a inserção (botão "Concluir"), a linha vira
-- "Concluído" e passa a ser só histórico (a próxima solicitação do mesmo
-- processo abre uma linha nova).

alter table solicitacoes_insercao_valores add column if not exists status text not null default 'Pendente';
alter table solicitacoes_insercao_valores add column if not exists concluido_em timestamptz;
alter table solicitacoes_insercao_valores add column if not exists atualizado_em timestamptz not null default now();
