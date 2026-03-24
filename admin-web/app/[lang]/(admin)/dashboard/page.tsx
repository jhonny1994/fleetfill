import { FilterBar } from "@/components/queues/filter-bar";
import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function DashboardPage() {
  return (
    <div className="space-y-4">
      <FilterBar />
      <PlaceholderPage
        eyebrow="Control tower"
        title="The FleetFill operations desk starts here."
        body="Backlog strips, aging, exceptions, and jump points will land here. The shell is already locked to the calm, queue-first admin direction."
      />
    </div>
  );
}
