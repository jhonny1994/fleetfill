import { FilterBar } from "@/components/queues/filter-bar";
import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function PayoutsPage() {
  return (
    <div className="space-y-4">
      <FilterBar />
      <PlaceholderPage
        eyebrow="Payouts"
        title="Carrier payout queue"
        body="Eligible payouts, readiness context, and controlled release actions will live here once the detail workspace is wired."
      />
    </div>
  );
}
