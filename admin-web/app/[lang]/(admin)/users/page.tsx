import { FilterBar } from "@/components/queues/filter-bar";
import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function UsersPage() {
  return (
    <div className="space-y-4">
      <FilterBar />
      <PlaceholderPage
        eyebrow="Users"
        title="User operations and lifecycle"
        body="User search, profile context, related bookings, and controlled suspend or reactivate actions will be wired here."
      />
    </div>
  );
}
