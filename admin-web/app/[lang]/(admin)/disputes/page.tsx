import { FilterBar } from "@/components/queues/filter-bar";
import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function DisputesPage() {
  return (
    <div className="space-y-4">
      <FilterBar />
      <PlaceholderPage
        eyebrow="Disputes"
        title="Dispute operations queue"
        body="Booking, payment, and evidence context will come together here so operators can resolve disputes without switching tools."
      />
    </div>
  );
}
