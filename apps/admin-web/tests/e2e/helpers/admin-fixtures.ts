import fs from "node:fs/promises";
import path from "node:path";
import { execFile as execFileCallback } from "node:child_process";
import { promisify } from "node:util";

import { createClient } from "@supabase/supabase-js";

import type { Database } from "@/lib/supabase/database.types";
import {
  adminFixtureManifestPath,
  e2eFixtureEmails,
  e2eFixtureNames,
  e2eFixturePasswords,
  getSupabaseRuntimeEnv,
  repoRoot,
} from "@/tests/e2e/env";

const execFile = promisify(execFileCallback);

type FixtureManifest = {
  superAdmin: {
    email: string;
    password: string;
    profileId: string;
  };
  opsAdmin: {
    email: string;
    password: string;
    profileId: string;
  };
};

async function ensureDirectory(filePath: string) {
  await fs.mkdir(path.dirname(filePath), { recursive: true });
}

async function ensureAuthUser(
  supabase: ReturnType<typeof createClient<Database>>,
  {
    email,
    password,
    fullName,
  }: {
    email: string;
    password: string;
    fullName: string;
  },
) {
  const existingUsersResult = await supabase.auth.admin.listUsers();
  const existingUser = existingUsersResult.data?.users.find(
    (user) => user.email?.toLowerCase() === email.toLowerCase(),
  );

  if (existingUser?.id) {
    const updateResult = await supabase.auth.admin.updateUserById(existingUser.id, {
      email,
      password,
      email_confirm: true,
      user_metadata: {
        full_name: fullName,
      },
    });

    if (updateResult.error) {
      throw updateResult.error;
    }

    return existingUser.id;
  }

  const createResult = await supabase.auth.admin.createUser({
    email,
    password,
    email_confirm: true,
    user_metadata: {
      full_name: fullName,
    },
  });

  if (createResult.error || !createResult.data.user) {
    throw createResult.error ?? new Error(`Failed to create auth user for ${email}`);
  }

  return createResult.data.user.id;
}

function sqlLiteral(value: string) {
  return `'${value.replace(/'/g, "''")}'`;
}

function buildFixtureSql({
  superAdminId,
  opsAdminId,
}: {
  superAdminId: string;
  opsAdminId: string;
}) {
  return `
do $$
declare
  v_invitation_payload jsonb;
begin
  truncate table public.admin_audit_logs, public.admin_invitations, public.admin_accounts restart identity cascade;

  update public.platform_settings
  set updated_by = null
  where updated_by in (${sqlLiteral(superAdminId)}::uuid, ${sqlLiteral(opsAdminId)}::uuid);

  delete from public.profiles
  where id in (${sqlLiteral(superAdminId)}::uuid, ${sqlLiteral(opsAdminId)}::uuid);

  perform set_config('request.jwt.claim.sub', '', true);
  perform set_config('request.jwt.claim.role', 'service_role', true);
  perform set_config('request.jwt.claim.email', '', true);
  perform set_config('request.jwt.claims', '{"role":"service_role"}', true);

  perform public.bootstrap_first_super_admin(
    ${sqlLiteral(superAdminId)}::uuid,
    ${sqlLiteral(e2eFixtureNames.superAdmin)},
    '0771000001'
  );

  perform set_config('request.jwt.claim.sub', ${sqlLiteral(superAdminId)}, true);
  perform set_config('request.jwt.claim.role', 'authenticated', true);
  perform set_config('request.jwt.claim.email', ${sqlLiteral(e2eFixtureEmails.superAdmin)}, true);
  perform set_config(
    'request.jwt.claims',
    jsonb_build_object(
      'sub', ${sqlLiteral(superAdminId)},
      'role', 'authenticated',
      'email', ${sqlLiteral(e2eFixtureEmails.superAdmin)},
      'iat', extract(epoch from now())::bigint
    )::text,
    true
  );

  select public.create_admin_invitation(
    ${sqlLiteral(e2eFixtureEmails.opsAdmin)},
    'ops_admin',
    48
  )
  into v_invitation_payload;

  perform set_config('request.jwt.claim.sub', ${sqlLiteral(opsAdminId)}, true);
  perform set_config('request.jwt.claim.role', 'authenticated', true);
  perform set_config('request.jwt.claim.email', ${sqlLiteral(e2eFixtureEmails.opsAdmin)}, true);
  perform set_config(
    'request.jwt.claims',
    jsonb_build_object(
      'sub', ${sqlLiteral(opsAdminId)},
      'role', 'authenticated',
      'email', ${sqlLiteral(e2eFixtureEmails.opsAdmin)},
      'iat', extract(epoch from now())::bigint
    )::text,
    true
  );

  perform public.accept_admin_invitation(
    v_invitation_payload->>'token',
    ${sqlLiteral(e2eFixtureNames.opsAdmin)},
    '0771000002'
  );

  perform set_config('request.jwt.claim.sub', '', true);
  perform set_config('request.jwt.claim.role', 'service_role', true);
  perform set_config('request.jwt.claim.email', '', true);
  perform set_config('request.jwt.claims', '{"role":"service_role"}', true);

  insert into public.platform_settings (key, value, is_public, description, updated_by)
  values (
    'localization',
    jsonb_build_object('fallback_locale', 'en', 'enabled_locales', jsonb_build_array('en', 'fr', 'ar')),
    false,
    'Deterministic locale policy for admin-web Playwright coverage.',
    ${sqlLiteral(superAdminId)}::uuid
  )
  on conflict (key) do update
  set value = excluded.value,
      description = excluded.description,
      updated_by = excluded.updated_by,
      updated_at = now();
end
$$;
`;
}

export async function seedAdminFixtures() {
  const { secretKey, serviceRoleKey, url } = getSupabaseRuntimeEnv();
  const authAdminClient = createClient<Database>(url, secretKey || serviceRoleKey, {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  });

  const superAdminId = await ensureAuthUser(authAdminClient, {
    email: e2eFixtureEmails.superAdmin,
    password: e2eFixturePasswords.superAdmin,
    fullName: e2eFixtureNames.superAdmin,
  });
  const opsAdminId = await ensureAuthUser(authAdminClient, {
    email: e2eFixtureEmails.opsAdmin,
    password: e2eFixturePasswords.opsAdmin,
    fullName: e2eFixtureNames.opsAdmin,
  });

  const fixtureSqlPath = path.join(path.dirname(adminFixtureManifestPath), "admin-fixtures.sql");
  await ensureDirectory(fixtureSqlPath);
  await fs.writeFile(
    fixtureSqlPath,
    buildFixtureSql({
      superAdminId,
      opsAdminId,
    }),
    "utf8",
  );

  await execFile("supabase", ["db", "query", "--workdir", "backend", "--file", fixtureSqlPath], {
    cwd: repoRoot,
  });

  const manifest: FixtureManifest = {
    superAdmin: {
      email: e2eFixtureEmails.superAdmin,
      password: e2eFixturePasswords.superAdmin,
      profileId: superAdminId,
    },
    opsAdmin: {
      email: e2eFixtureEmails.opsAdmin,
      password: e2eFixturePasswords.opsAdmin,
      profileId: opsAdminId,
    },
  };

  await ensureDirectory(adminFixtureManifestPath);
  await fs.writeFile(adminFixtureManifestPath, JSON.stringify(manifest, null, 2), "utf8");

  return manifest;
}

export async function readAdminFixtureManifest() {
  return JSON.parse(await fs.readFile(adminFixtureManifestPath, "utf8")) as FixtureManifest;
}
