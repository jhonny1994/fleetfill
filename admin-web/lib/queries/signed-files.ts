import { createSupabaseServerClient } from "@/lib/supabase/server";

export async function createSignedFileUrl(bucketId: string, objectPath: string) {
  const supabase = await createSupabaseServerClient();
  const { data, error } = await supabase.functions.invoke("signed-file-url", {
    body: {
      bucket_id: bucketId,
      object_path: objectPath,
    },
  });

  if (error) {
    throw error;
  }

  const signedUrl = (data as { signed_url?: string } | null)?.signed_url;
  return signedUrl ?? null;
}
