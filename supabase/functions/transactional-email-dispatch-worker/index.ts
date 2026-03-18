import { serve } from 'https://deno.land/std@0.224.0/http/server.ts'

serve(async () => {
  return new Response(
    JSON.stringify({
      function: 'transactional-email-dispatch-worker',
      responsibilities: [
        'claim queued outbox jobs',
        'send transactional email through the configured provider',
        'update delivery logs or call RPC for updates',
      ],
    }),
    {
      headers: { 'content-type': 'application/json' },
      status: 200,
    },
  )
})
