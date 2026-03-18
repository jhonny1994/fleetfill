import { serve } from 'https://deno.land/std@0.224.0/http/server.ts'

serve(async () => {
  return new Response(
    JSON.stringify({
      function: 'scheduled-automation-tick',
      responsibilities: [
        'email outbox draining',
        'delivery grace-window expiry',
        'payment resubmission expiry',
        'stale queue lock recovery',
      ],
    }),
    {
      headers: { 'content-type': 'application/json' },
      status: 200,
    },
  )
})
