import { FilterBar } from "@/components/queues/filter-bar";
import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function SupportPage() {
  return (
    <div className="space-y-4">
      <FilterBar />
      <PlaceholderPage
        eyebrow="Support"
        title="Support queue workspace"
        body="This route will stay ticket-first, using New and Seen read-state language and linked booking or payment context."
      />
    </div>
  );
}
