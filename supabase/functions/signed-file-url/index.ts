import { serve } from 'https://deno.land/std@0.224.0/http/server.ts'

serve(async () => {
  return new Response(
    JSON.stringify({
      function: 'signed-file-url',
      responsibilities: [
        'validate actor authorization before issuing a signed URL',
        'keep signed URLs short-lived',
        'avoid exposing raw storage paths to the client',
      ],
    }),
    {
      headers: { 'content-type': 'application/json' },
      status: 200,
    },
  )
})
