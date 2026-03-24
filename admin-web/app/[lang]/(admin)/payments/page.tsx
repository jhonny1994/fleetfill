import { FilterBar } from "@/components/queues/filter-bar";
import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function PaymentsPage() {
  return (
    <div className="space-y-4">
      <FilterBar />
      <PlaceholderPage
        eyebrow="Payments"
        title="Payment-proof review queue"
        body="This route is reserved for dense proof review with booking context, aging, and controlled approve or reject actions."
      />
    </div>
  );
}
