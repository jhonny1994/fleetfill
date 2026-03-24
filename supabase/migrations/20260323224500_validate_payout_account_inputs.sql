create or replace function public.validate_payout_account_inputs()
returns trigger
language plpgsql
set search_path = public
as $$
begin
  if new.account_type not in ('ccp'::public.payment_rail, 'bank'::public.payment_rail) then
    raise exception 'Unsupported payout account type';
  end if;

  if new.account_type = 'bank'::public.payment_rail
      and nullif(btrim(coalesce(new.bank_or_ccp_name, '')), '') is null then
    raise exception 'Bank name is required for bank payout accounts';
  end if;

  if new.account_type = 'ccp'::public.payment_rail then
    new.bank_or_ccp_name := null;
  end if;

  return new;
end;
$$;

drop trigger if exists payout_accounts_validate_inputs on public.payout_accounts;
create trigger payout_accounts_validate_inputs
before insert or update on public.payout_accounts
for each row
execute function public.validate_payout_account_inputs();
