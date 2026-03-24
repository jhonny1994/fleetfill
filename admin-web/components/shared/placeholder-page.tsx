import { ArrowRight } from "lucide-react";

import { EmptyState } from "@/components/shared/empty-state";
import { StatusBadge } from "@/components/shared/status-badge";

export function PlaceholderPage({
  locale = "en",
  eyebrow,
  title,
  body,
}: {
  locale?: string;
  eyebrow: string;
  title: string;
  body: string;
}) {
  const copy =
    locale === "ar"
      ? {
          scaffolded: "مهيأ",
          ready: "جاهز لربط الطابور",
          descriptionText:
            "هذا المسار يملك بالفعل هيكل الصفحة وتباعدها بالشكل الصحيح. الخطوة التالية هي ربط مصدر البيانات الحقيقي للطابور أو مساحة العمل.",
          note: "ملاحظة تنفيذية",
          noteBody: "حافظ على هذا المسار موجهاً بالجدول والإجراء، ولا تستبدله ببطاقات كبيرة مبالغ فيها.",
        }
      : locale === "fr"
        ? {
            scaffolded: "Prepare",
            ready: "Pret pour brancher la file",
            descriptionText:
              "Cette route a deja la bonne structure d'ecran et le bon contrat d'espacement. L'etape suivante consiste a brancher la vraie source de donnees de file ou d'espace de travail.",
            note: "Note implementation",
            noteBody: "Gardez cette route orientee table et action. Ne la remplacez pas par de grandes cartes.",
          }
        : {
            scaffolded: "Scaffolded",
            ready: "Ready for queue wiring",
            descriptionText:
              "This route already has the right shell and spacing contract. The next step is to connect the real queue or workspace data source.",
            note: "Implementation note",
            noteBody: "Keep this route table-first and action-first. Do not replace it with oversized cards.",
          };

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap items-center gap-3">
        <p className="eyebrow">{eyebrow}</p>
        <StatusBadge label={copy.scaffolded} tone="warning" />
      </div>
      <EmptyState eyebrow={eyebrow} title={title} body={body} />
      <section className="panel grid gap-4 p-5 lg:grid-cols-[1.2fr_0.8fr]">
        <div className="space-y-2">
          <h3 className="text-lg font-semibold text-[var(--color-ink-strong)]">
            {copy.ready}
          </h3>
          <p className="text-sm text-[var(--color-ink-muted)]">
            {copy.descriptionText}
          </p>
        </div>
        <div className="rounded-[22px] border border-[var(--color-border)] bg-white/65 p-4">
          <div className="flex items-center justify-between text-sm font-medium text-[var(--color-ink-base)]">
            <span>{copy.note}</span>
            <ArrowRight className="rtl-flip size-4" />
          </div>
          <p className="mt-3 text-sm text-[var(--color-ink-muted)]">
            {copy.noteBody}
          </p>
        </div>
      </section>
    </div>
  );
}
