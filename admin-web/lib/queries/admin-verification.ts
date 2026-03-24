import { createSupabaseServerClient } from "@/lib/supabase/server";
import { createSignedFileUrl } from "@/lib/queries/signed-files";

type ProfileRow = {
  id: string;
  email: string;
  full_name: string | null;
  company_name: string | null;
  verification_status: string;
};

type VehicleRow = {
  id: string;
  carrier_id: string;
  plate_number: string;
  vehicle_type: string;
};

type VerificationDocument = {
  id: string;
  owner_profile_id: string;
  entity_type: "profile" | "vehicle";
  entity_id: string;
  document_type: string;
  storage_path: string;
  status: string;
  rejection_reason: string | null;
  content_type: string | null;
  reviewed_at: string | null;
  created_at: string | null;
};

export type VerificationDocumentDetail = VerificationDocument & {
  label: string;
  signedUrl: string | null;
};

export type AdminVerificationDetail = {
  profile: ProfileRow;
  vehicles: VehicleRow[];
  documents: VerificationDocumentDetail[];
  auditLogs: Array<{
    id: string;
    action: string;
    outcome: string;
    reason: string | null;
    created_at: string | null;
  }>;
};

function documentLabel(documentType: string) {
  switch (documentType) {
    case "driver_identity_or_license":
      return "Driver license";
    case "truck_registration":
      return "Registration card";
    case "truck_insurance":
      return "Insurance";
    case "truck_technical_inspection":
      return "Technical inspection";
    default:
      return documentType;
  }
}

export async function fetchVerificationDetail(carrierId: string): Promise<AdminVerificationDetail | null> {
  const supabase = await createSupabaseServerClient();
  const { data: profile, error: profileError } = await supabase
    .from("profiles")
    .select("id, email, full_name, company_name, verification_status")
    .eq("id", carrierId)
    .maybeSingle();

  if (profileError) {
    throw profileError;
  }
  if (!profile) {
    return null;
  }

  const { data: vehicles, error: vehicleError } = await supabase
    .from("vehicles")
    .select("id, carrier_id, plate_number, vehicle_type")
    .eq("carrier_id", carrierId)
    .order("updated_at", { ascending: false });

  if (vehicleError) {
    throw vehicleError;
  }

  const vehicleRows = (vehicles ?? []) as VehicleRow[];
  const entityFilters = [
    `and(entity_type.eq.profile,entity_id.eq.${carrierId})`,
    ...vehicleRows.map((vehicle) => `and(entity_type.eq.vehicle,entity_id.eq.${vehicle.id})`),
  ];

  const { data: documents, error: documentError } = await supabase
    .from("verification_documents")
    .select(
      "id, owner_profile_id, entity_type, entity_id, document_type, storage_path, status, rejection_reason, content_type, reviewed_at, created_at",
    )
    .or(entityFilters.join(","))
    .order("created_at", { ascending: false });

  if (documentError) {
    throw documentError;
  }

  const latestDocumentMap = new Map<string, VerificationDocument>();
  for (const row of (documents ?? []) as VerificationDocument[]) {
    const key = `${row.entity_type}:${row.entity_id}:${row.document_type}`;
    if (!latestDocumentMap.has(key)) {
      latestDocumentMap.set(key, row);
    }
  }

  const documentList = [...latestDocumentMap.values()];
  const signedUrls = await Promise.all(
    documentList.map((document) => createSignedFileUrl("verification-documents", document.storage_path)),
  );

  const { data: auditLogs } = await supabase
    .from("admin_audit_logs")
    .select("id, action, outcome, reason, created_at")
    .in("action", [
      "verification_document_approved",
      "verification_document_rejected",
      "verification_packet_approved",
    ])
    .order("created_at", { ascending: false })
    .limit(20);

  return {
    profile: profile as ProfileRow,
    vehicles: vehicleRows,
    documents: documentList.map((document, index) => ({
      ...document,
      label: documentLabel(document.document_type),
      signedUrl: signedUrls[index],
    })),
    auditLogs: ((auditLogs ?? []) as Array<{
      id: string;
      action: string;
      outcome: string;
      reason: string | null;
      created_at: string | null;
    }>).filter((log) => Boolean(log)),
  };
}
