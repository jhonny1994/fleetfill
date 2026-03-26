export const adminQueryKeys = {
  dashboard: ["admin", "dashboard"] as const,
  payments: (query?: string) => ["admin", "payments", query ?? ""] as const,
  verification: (query?: string) => ["admin", "verification", query ?? ""] as const,
  disputes: (query?: string) => ["admin", "disputes", query ?? ""] as const,
  payouts: (query?: string) => ["admin", "payouts", query ?? ""] as const,
  support: (status?: string, query?: string) =>
    ["admin", "support", status ?? "", query ?? ""] as const,
} as const;
