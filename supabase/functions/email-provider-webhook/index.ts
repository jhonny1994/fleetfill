import { serve } from 'https://deno.land/std@0.224.0/http/server.ts'

serve(async () => {
  return new Response(
    JSON.stringify({
      function: 'email-provider-webhook',
      responsibilities: [
        'verify provider webhook authenticity when supported',
        'apply idempotent provider status updates',
        'handle out-of-order provider events safely',
      ],
    }),
    {
      headers: { 'content-type': 'application/json' },
      status: 200,
    },
  )
})
