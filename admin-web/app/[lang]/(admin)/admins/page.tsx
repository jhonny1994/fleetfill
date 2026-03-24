import { FilterBar } from "@/components/queues/filter-bar";
import { PlaceholderPage } from "@/components/shared/placeholder-page";

export default function AdminsPage() {
  return (
    <div className="space-y-4">
      <FilterBar />
      <PlaceholderPage
        eyebrow="Admins"
        title="Admin governance"
        body="This section is reserved for active admins, invitations, role changes, and the last-super-admin safety rules."
      />
    </div>
  );
}
