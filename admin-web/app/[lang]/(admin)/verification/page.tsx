import { FilterBar } from "@/components/queues/filter-bar";
import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function VerificationPage() {
  return (
    <div className="space-y-4">
      <FilterBar />
      <PlaceholderPage
        eyebrow="Verification"
        title="Unified carrier verification queue"
        body="Driver and vehicle document review will be grouped here, with missing-document summaries, packet aging, and controlled approval flows."
      />
    </div>
  );
}
