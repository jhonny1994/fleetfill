import { z } from "zod";

export const adminInviteSchema = z.object({
  email: z.email().trim().max(320),
  role: z.enum(["super_admin", "ops_admin"]),
  expiresInHours: z.coerce.number().int().min(1).max(168),
});

export const adminRoleChangeSchema = z.object({
  role: z.enum(["super_admin", "ops_admin"]),
  reason: z.string().trim().max(500).optional().or(z.literal("")),
});

export const adminActivationSchema = z.object({
  isActive: z.boolean(),
  reason: z.string().trim().max(500).optional().or(z.literal("")),
});
