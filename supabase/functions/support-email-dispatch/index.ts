import { serve } from 'https://deno.land/std@0.224.0/http/server.ts'

serve(async () => {
  return new Response(
    JSON.stringify({
      function: 'support-email-dispatch',
      responsibilities: [
        'send support acknowledgement emails',
        'use validated server-side template variables',
        'keep support email logic outside the client',
      ],
    }),
    {
      headers: { 'content-type': 'application/json' },
      status: 200,
    },
  )
})
