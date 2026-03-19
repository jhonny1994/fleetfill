create extension if not exists pgcrypto;

do $$ begin
  create type public.app_role as enum ('shipper', 'carrier', 'admin');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.verification_status as enum ('pending', 'verified', 'rejected');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.payment_rail as enum ('ccp', 'dahabia', 'bank');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.platform_environment as enum ('staging', 'production');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.verification_document_entity_type as enum ('profile', 'vehicle');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.shipment_status as enum ('draft', 'booked', 'cancelled');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.booking_status as enum (
    'pending_payment',
    'payment_under_review',
    'confirmed',
    'picked_up',
    'in_transit',
    'delivered_pending_review',
    'completed',
    'cancelled',
    'disputed'
  );
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.payment_status as enum (
    'unpaid',
    'proof_submitted',
    'under_verification',
    'secured',
    'rejected',
    'refunded',
    'released_to_carrier'
  );
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.tracking_event_visibility as enum ('internal', 'user_visible');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.ledger_direction as enum ('debit', 'credit');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.dispute_status as enum ('open', 'resolved');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.transfer_status as enum ('pending', 'sent', 'failed', 'cancelled');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.email_delivery_status as enum (
    'queued',
    'sending',
    'sent',
    'delivered',
    'opened',
    'clicked',
    'soft_failed',
    'hard_failed',
    'bounced',
    'suppressed'
  );
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.email_outbox_status as enum (
    'queued',
    'processing',
    'sent_to_provider',
    'retry_scheduled',
    'dead_letter',
    'cancelled'
  );
exception
  when duplicate_object then null;
end $$;

create or replace function public.set_updated_at()
returns trigger
language plpgsql
set search_path = public
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;
