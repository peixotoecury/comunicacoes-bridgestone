// ============================================================================
// Supabase Edge Function: extrair-valor-pdf
// ----------------------------------------------------------------------------
// Não faz deploy automático via git — este arquivo é só a FONTE, documentada
// no repositório. O deploy real acontece colando este código no painel do
// Supabase (Edge Functions > New function > extrair-valor-pdf > Deploy).
// A chave da Anthropic fica em Project Settings > Edge Functions > Secrets,
// nome ANTHROPIC_API_KEY — nunca neste arquivo, nunca no index.html.
// ============================================================================

const CORS_HEADERS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

const MODELO = "claude-sonnet-5";

function respostaJson(corpo: unknown, status = 200) {
  return new Response(JSON.stringify(corpo), {
    status,
    headers: { ...CORS_HEADERS, "Content-Type": "application/json" },
  });
}

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: CORS_HEADERS });
  }

  let body: { pdfUrl?: string; processo?: string };
  try {
    body = await req.json();
  } catch {
    return respostaJson({ error: "Corpo da requisição precisa ser JSON." }, 400);
  }

  const pdfUrl = (body.pdfUrl || "").trim();
  const processo = (body.processo || "").trim();

  if (!pdfUrl) {
    return respostaJson({ error: "Campo 'pdfUrl' é obrigatório." }, 400);
  }

  const apiKey = Deno.env.get("ANTHROPIC_API_KEY");
  if (!apiKey) {
    return respostaJson(
      { error: "ANTHROPIC_API_KEY não configurada nos Secrets desta função." },
      500,
    );
  }

  const prompt =
    `Você é um assistente jurídico especializado em cálculos e laudos trabalhistas. ` +
    `Analise o documento anexado${processo ? ` (referente ao processo ${processo})` : ""} ` +
    `e extraia as informações abaixo. Se algo não estiver no documento, use null — não invente valores.\n\n` +
    `Responda SOMENTE com um JSON válido, sem nenhum texto antes ou depois, neste formato exato:\n` +
    `{"valor_historico": <número ou null>, "data_base": "<dd/mm/aaaa ou null>", "trecho": "<citação curta do documento que comprova o valor, ou null>", "observacao": "<qualquer ressalva ou ambiguidade encontrada, ou null>"}`;

  let anthropicResp: Response;
  try {
    anthropicResp = await fetch("https://api.anthropic.com/v1/messages", {
      method: "POST",
      headers: {
        "x-api-key": apiKey,
        "anthropic-version": "2023-06-01",
        "content-type": "application/json",
      },
      body: JSON.stringify({
        model: MODELO,
        max_tokens: 1024,
        messages: [
          {
            role: "user",
            content: [
              { type: "document", source: { type: "url", url: pdfUrl } },
              { type: "text", text: prompt },
            ],
          },
        ],
      }),
    });
  } catch (err) {
    return respostaJson({ error: "Falha ao chamar a API da Anthropic.", detalhe: String(err) }, 502);
  }

  const data = await anthropicResp.json();

  if (!anthropicResp.ok) {
    return respostaJson({ error: "Erro retornado pela API da Anthropic.", detalhe: data }, 502);
  }

  const textoResposta: string = data?.content?.[0]?.text ?? "";
  let extraido: Record<string, unknown>;
  try {
    const match = textoResposta.match(/\{[\s\S]*\}/);
    extraido = match ? JSON.parse(match[0]) : { erro: "Não consegui interpretar a resposta da IA.", bruto: textoResposta };
  } catch {
    extraido = { erro: "Resposta da IA não veio em JSON válido.", bruto: textoResposta };
  }

  return respostaJson(extraido);
});
