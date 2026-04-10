"use client";

import * as DialogPrimitive from "@radix-ui/react-dialog";
import * as React from "react";

import {
  Dialog,
  DialogClose,
  DialogOverlay,
  DialogPortal,
  DialogTitle,
  DialogTrigger,
} from "@/components/shared/dialog";
import { cn } from "@/lib/utils";

const Sheet = Dialog;
const SheetTrigger = DialogTrigger;
const SheetClose = DialogClose;
const SheetTitle = DialogTitle;

const sideClasses = {
  bottom: "inset-x-0 bottom-0 max-h-[85vh] rounded-t-[var(--radius-panel)] border-t",
  end: "inset-y-0 end-0 h-full w-[min(84vw,340px)] border-s",
  start: "inset-y-0 start-0 h-full w-[min(84vw,340px)] border-e",
  top: "inset-x-0 top-0 max-h-[85vh] rounded-b-[var(--radius-panel)] border-b",
} as const;

type SheetContentProps = React.ComponentPropsWithoutRef<typeof DialogPrimitive.Content> & {
  side?: keyof typeof sideClasses;
};

const SheetContent = React.forwardRef<
  React.ElementRef<typeof DialogPrimitive.Content>,
  SheetContentProps
>(({ className, children, side = "start", ...props }, ref) => (
  <DialogPortal>
    <DialogOverlay className="z-[120] lg:hidden" />
    <DialogPrimitive.Content
      ref={ref}
      className={cn(
        "fixed z-[121] flex flex-col overscroll-contain bg-[var(--color-background)] p-3 shadow-[var(--shadow-panel)] focus:outline-none lg:hidden",
        sideClasses[side],
        className,
      )}
      {...props}
    >
      {children}
    </DialogPrimitive.Content>
  </DialogPortal>
));
SheetContent.displayName = "SheetContent";

export { Sheet, SheetClose, SheetContent, SheetTitle, SheetTrigger };
