import { PDFDocument, StandardFonts } from 'https://esm.sh/pdf-lib@1.17.1'

import { createServiceClient, jsonResponse, requiredEnv } from '../_shared/email-runtime.ts'

type GeneratedDocumentRow = {
  id: string
  booking_id: string | null
  document_type: string
  storage_path: string
  version: number
  status: string
}

type BookingRow = {
  id: string
  tracking_number: string
  payment_reference: string
  shipper_total_dzd: number
  carrier_payout_dzd: number
  created_at: string
  shipper_id: string
  carrier_id: string
}

type ProfileRow = {
  id: string
  email: string
  full_name: string | null
  company_name: string | null
}

function formatMoney(value: number) {
  return `${value.toFixed(2)} DZD`
}

function displayName(profile: ProfileRow | null) {
  if (profile == null) {
    return '-'
  }
  return profile.company_name?.trim() || profile.full_name?.trim() ||
    profile.email
}

function documentTitle(documentType: string) {
  switch (documentType) {
    case 'booking_invoice':
      return 'Booking Invoice'
    case 'payment_receipt':
      return 'Payment Receipt'
    case 'payout_receipt':
      return 'Payout Receipt'
    default:
      return 'Generated Document'
  }
}

function hexDigest(bytes: Uint8Array) {
  return Array.from(bytes)
    .map((value) => value.toString(16).padStart(2, '0'))
    .join('')
}

async function sha256Hex(bytes: Uint8Array) {
  const digestBytes = new Uint8Array(bytes.byteLength)
  digestBytes.set(bytes)
  const digest = await crypto.subtle.digest(
    'SHA-256',
    digestBytes,
  )
  return hexDigest(new Uint8Array(digest))
}

async function renderDocumentPdf(params: {
  document: GeneratedDocumentRow
  booking: BookingRow
  shipper: ProfileRow | null
  carrier: ProfileRow | null
  payoutReference?: string | null
}) {
  const { document, booking, shipper, carrier, payoutReference } = params
  const pdf = await PDFDocument.create()
  const page = pdf.addPage([595.28, 841.89])
  const titleFont = await pdf.embedFont(StandardFonts.HelveticaBold)
  const bodyFont = await pdf.embedFont(StandardFonts.Helvetica)

  const title = documentTitle(document.document_type)

  const lines = [
    `Document type: ${title}`,
    `Document version: ${document.version}`,
    `Tracking number: ${booking.tracking_number}`,
    `Payment reference: ${booking.payment_reference}`,
    `Booking created at: ${booking.created_at}`,
    `Shipper: ${displayName(shipper)}`,
    `Carrier: ${displayName(carrier)}`,
    document.document_type === 'payout_receipt'
      ? `Carrier payout: ${formatMoney(booking.carrier_payout_dzd)}`
      : `Total amount: ${formatMoney(booking.shipper_total_dzd)}`,
    'FleetFill generated this document from canonical system records.',
  ]

  if (payoutReference != null && payoutReference.trim().length > 0) {
    lines.splice(
      lines.length - 1,
      0,
      `External reference: ${payoutReference.trim()}`,
    )
  }

  page.drawText('FleetFill', {
    x: 48,
    y: 780,
    size: 22,
    font: titleFont,
  })
  page.drawText(title, {
    x: 48,
    y: 748,
    size: 18,
    font: titleFont,
  })

  let y = 708
  for (const line of lines) {
    page.drawText(line, {
      x: 48,
      y,
      size: 12,
      font: bodyFont,
    })
    y -= 24
  }

  return await pdf.save()
}

async function enqueueDocumentAvailabilityEmail(params: {
  serviceClient: ReturnType<typeof createServiceClient>
  profile: ProfileRow
  booking: BookingRow
  document: GeneratedDocumentRow
}) {
  const { serviceClient, profile, booking, document } = params
  await serviceClient.rpc('enqueue_transactional_email', {
    p_event_key: 'generated_document_available',
    p_profile_id: profile.id,
    p_recipient_email: profile.email,
    p_booking_id: booking.id,
    p_template_key: 'generated_document_available',
    p_locale: null,
    p_payload_snapshot: {
      booking_id: booking.id,
      booking_reference: booking.tracking_number,
      document_id: document.id,
      document_type: document.document_type,
      document_route: `/shared/generated-document/${document.id}`,
    },
    p_dedupe_key: `generated_document_available:${document.id}`,
    p_priority: 'normal',
  })
}

Deno.serve(async (req: Request) => {
  if (req.method !== 'POST') {
    return jsonResponse({ error: 'Method not allowed' }, 405)
  }

  try {
    const authorization = req.headers.get('Authorization')
    const expectedAuthorization = `Bearer ${requiredEnv('SUPABASE_SERVICE_ROLE_KEY')}`
    if (authorization !== expectedAuthorization) {
      return jsonResponse({ error: 'Unauthorized' }, 401)
    }

    const body = await req.json().catch(() => ({})) as { batch_size?: number }
    const batchSize = Math.max(1, Math.min(body.batch_size ?? 5, 20))
    const serviceClient = createServiceClient()

    const { data: documents, error: documentError } = await serviceClient
      .from('generated_documents')
      .select('id, booking_id, document_type, storage_path, version, status')
      .eq('status', 'pending')
      .order('created_at', { ascending: true })
      .limit(batchSize)

    if (documentError != null) {
      console.error(
        'generated-document-worker document query failed',
        documentError,
      )
      return jsonResponse({ error: 'Failed to load generated documents' }, 500)
    }

    const results: Array<Record<string, unknown>> = []
    for (const document of (documents ?? []) as GeneratedDocumentRow[]) {
      try {
        const { data: bookingData, error: bookingError } = await serviceClient
          .from('bookings')
          .select(
            'id, tracking_number, payment_reference, shipper_total_dzd, carrier_payout_dzd, created_at, shipper_id, carrier_id',
          )
          .eq('id', document.booking_id)
          .single<BookingRow>()

        if (bookingError != null || bookingData == null) {
          throw new Error(
            'booking_not_found:Booking data is unavailable for generated document',
          )
        }

        const booking = bookingData as BookingRow
        const profileIds = [booking.shipper_id, booking.carrier_id]
        const { data: profiles, error: profileError } = await serviceClient
          .from('profiles')
          .select('id, email, full_name, company_name')
          .in('id', profileIds)

        if (profileError != null) {
          throw new Error(
            'profile_lookup_failed:Profile data is unavailable for generated document',
          )
        }

        const profileMap = new Map<string, ProfileRow>()
        for (const item of (profiles ?? []) as ProfileRow[]) {
          profileMap.set(item.id, item)
        }

        let payoutReference: string | null = null
        if (document.document_type === 'payout_receipt') {
          const { data: payout, error: payoutError } = await serviceClient
            .from('payouts')
            .select('external_reference')
            .eq('booking_id', booking.id)
            .maybeSingle<{ external_reference: string | null }>()
          if (payoutError != null) {
            throw new Error(
              'payout_lookup_failed:Payout data is unavailable for generated document',
            )
          }
          payoutReference = payout?.external_reference ?? null
        }

        const pdfBytes = await renderDocumentPdf({
          document,
          booking,
          shipper: profileMap.get(booking.shipper_id) ?? null,
          carrier: profileMap.get(booking.carrier_id) ?? null,
          payoutReference,
        })

        const checksum = await sha256Hex(pdfBytes)
        const upload = await serviceClient.storage
          .from('generated-documents')
          .upload(document.storage_path, pdfBytes, {
            contentType: 'application/pdf',
            upsert: true,
          })

        if (upload.error != null) {
          throw new Error(`storage_upload_failed:${upload.error.message}`)
        }

        const { error: updateError } = await serviceClient
          .from('generated_documents')
          .update({
            status: 'ready',
            content_type: 'application/pdf',
            byte_size: pdfBytes.byteLength,
            checksum_sha256: checksum,
            available_at: new Date().toISOString(),
            failure_reason: null,
          })
          .eq('id', document.id)

        if (updateError != null) {
          throw new Error(`document_update_failed:${updateError.message}`)
        }

        const notificationProfile = document.document_type === 'payout_receipt'
          ? profileMap.get(booking.carrier_id) ?? null
          : profileMap.get(booking.shipper_id) ?? null

        if (notificationProfile != null) {
          await serviceClient.from('notifications').insert({
            profile_id: notificationProfile.id,
            type: 'generated_document_ready',
            title: 'generated_document_ready_title',
            body: 'generated_document_ready_body',
            data: {
              booking_id: booking.id,
              document_id: document.id,
              document_type: document.document_type,
            },
          })

          await enqueueDocumentAvailabilityEmail({
            serviceClient,
            profile: notificationProfile,
            booking,
            document,
          })
        }

        results.push({
          document_id: document.id,
          status: 'ready',
        })
      } catch (error) {
        const message = error instanceof Error
          ? error.message
          : 'generated_document_failed:Unknown error'
        const separatorIndex = message.indexOf(':')
        const failureReason = separatorIndex >= 0 ? message.slice(separatorIndex + 1) : message
        await serviceClient
          .from('generated_documents')
          .update({
            status: 'failed',
            failure_reason: failureReason,
            available_at: null,
          })
          .eq('id', document.id)
        results.push({
          document_id: document.id,
          status: 'failed',
          failure_reason: failureReason,
        })
      }
    }

    return jsonResponse({ processed_count: results.length, results })
  } catch (error) {
    console.error('generated-document-worker failed', error)
    return jsonResponse({ error: 'Internal server error' }, 500)
  }
})
