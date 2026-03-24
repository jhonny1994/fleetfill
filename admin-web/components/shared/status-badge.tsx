import { cn } from "@/lib/utils";

type Tone = "neutral" | "success" | "warning" | "danger";

const toneClasses: Record<Tone, string> = {
  neutral: "bg-[var(--color-slate-100)] text-[var(--color-slate-700)]",
  success: "bg-[var(--color-green-100)] text-[var(--color-green-600)]",
  warning: "bg-[var(--color-amber-100)] text-[var(--color-amber-700)]",
  danger: "bg-[var(--color-red-100)] text-[var(--color-red-700)]",
};

export function StatusBadge({
  label,
  tone = "neutral",
}: {
  label: string;
  tone?: Tone;
}) {
  return <span className={cn("status-chip", toneClasses[tone])}>{label}</span>;
}
