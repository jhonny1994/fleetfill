import { z } from "zod";

export const paymentApproveSchema = z.object({
  verifiedAmountDzd: z.coerce.number().positive(),
  verifiedReference: z.string().trim().max(120).optional().or(z.literal("")),
  decisionNote: z.string().trim().max(500).optional().or(z.literal("")),
});

export const paymentRejectSchema = z.object({
  rejectionReason: z.string().trim().min(3).max(240),
  decisionNote: z.string().trim().max(500).optional().or(z.literal("")),
});

export const verificationReviewSchema = z.object({
  documentId: z.string().uuid(),
  status: z.enum(["verified", "rejected"]),
  reason: z.string().trim().max(240).optional().or(z.literal("")),
});

export const disputeCompleteSchema = z.object({
  resolutionNote: z.string().trim().max(500).optional().or(z.literal("")),
});

export const disputeRefundSchema = z.object({
  refundAmountDzd: z.coerce.number().positive(),
  refundReason: z.string().trim().min(3).max(240),
  externalReference: z.string().trim().max(120).optional().or(z.literal("")),
  resolutionNote: z.string().trim().max(500).optional().or(z.literal("")),
});

export const payoutReleaseSchema = z.object({
  externalReference: z.string().trim().max(120).optional().or(z.literal("")),
  note: z.string().trim().max(500).optional().or(z.literal("")),
});

export const supportReplySchema = z.object({
  message: z.string().trim().min(3).max(4000),
});

export const supportStatusSchema = z.object({
  status: z.enum(["open", "in_progress", "waiting_for_user", "resolved", "closed"]),
  priority: z.enum(["normal", "high", "urgent"]).optional(),
});
