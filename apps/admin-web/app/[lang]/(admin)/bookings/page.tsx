import { getMessages } from "next-intl/server";
import Link from "next/link";

import { AdminFilterBar } from "@/components/queues/admin-filter-bar";
import { EmptyState } from "@/components/shared/empty-state";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatCurrencyDzd, formatDateTime } from "@/lib/formatting/formatters";
import { formatTemplate, getEnumLabel } from "@/lib/i18n/admin-ui";
import { resolveAppLocale } from "@/lib/i18n/config";
import { asAdminMessages } from "@/lib/i18n/messages";
import { bookingIndexStatuses, fetchBookingIndexPage } from "@/lib/queries/admin-operations";

function buildPageHref(
  locale: string,
  {
    q,
    status,
  }: {
    q?: string;
    status?: string;
  },
  page: number,
) {
  const params = new URLSearchParams();

  if (q?.trim()) {
    params.set("q", q.trim());
  }

  if (status?.trim()) {
    params.set("status", status.trim());
  }

  if (page > 1) {
    params.set("page", String(page));
  }

  const query = params.toString();
  return query ? `/${locale}/bookings?${query}` : `/${locale}/bookings`;
}

export default async function BookingsPage({
  params,
  searchParams,
}: {
  params: Promise<{ lang: string }>;
  searchParams: Promise<{ q?: string; status?: string; page?: string }>;
}) {
  const [{ lang }, filters] = await Promise.all([params, searchParams]);
  const locale = resolveAppLocale(lang);
  const query = filters.q?.trim();
  const status = filters.status?.trim();
  const requestedPage = Math.max(1, Number(filters.page ?? "1") || 1);
  const { ui, dictionary } = asAdminMessages(await getMessages({ locale }));
  const snapshot = await fetchBookingIndexPage({
    query,
    status,
    page: requestedPage,
  });
  const summaryFrom = snapshot.total === 0 ? 0 : (snapshot.page - 1) * snapshot.pageSize + 1;
  const summaryTo = snapshot.total === 0 ? 0 : Math.min(snapshot.page * snapshot.pageSize, snapshot.total);
  const hasFilters = Boolean(query || status);
  const emptyTitle = hasFilters ? ui.pages.bookingsList.filteredEmptyTitle : ui.pages.bookingsList.emptyTitle;
  const emptyBody = hasFilters ? ui.pages.bookingsList.filteredEmptyBody : ui.pages.bookingsList.emptyBody;

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">{ui.pages.bookingsList.eyebrow}</p>
        <div className="flex flex-wrap items-start justify-between gap-4">
          <div className="space-y-2">
            <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.bookingsList.title}</h1>
            <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">{ui.pages.bookingsList.body}</p>
            <p className="text-sm font-medium text-[var(--color-ink-strong)]">
              {formatTemplate(ui.pages.bookingsList.resultsSummary, {
                from: summaryFrom,
                to: summaryTo,
                total: snapshot.total,
              })}
            </p>
          </div>
          <div className="rounded-[20px] border border-[var(--color-border)] bg-white/65 px-4 py-3 text-sm text-[var(--color-ink-muted)]">
            <p>{ui.pages.bookingsList.sidebarHint}</p>
          </div>
        </div>
      </section>

      <AdminFilterBar
        pathname={`/${locale}/bookings`}
        query={query}
        status={status}
        locale={locale}
        statusOptions={bookingIndexStatuses.map((value) => ({
          value,
          label: getEnumLabel(locale, "booking", value),
        }))}
        labels={{
          searchPlaceholder: ui.pages.bookingsList.searchPlaceholder,
          status: ui.labels.state,
          allStatuses: dictionary.common.allStatuses,
          apply: dictionary.common.apply,
          reset: dictionary.common.reset,
          query: dictionary.common.query,
          clearAll: dictionary.common.clearAll,
          refresh: dictionary.common.refresh,
          refreshAriaLabel: dictionary.common.refreshQueue,
        }}
      />

      {snapshot.items.length === 0 ? (
        <div className="table-shell p-4">
          <EmptyState eyebrow={ui.pages.bookingsList.eyebrow} title={emptyTitle} body={emptyBody} />
        </div>
      ) : (
        <section className="panel space-y-4 p-4">
          <div className="table-shell">
            <table>
              <thead>
                <tr>
                  <th>{ui.pages.bookingsList.bookingLabel}</th>
                  <th>{ui.labels.state}</th>
                  <th>{ui.pages.bookingsList.routeLabel}</th>
                  <th>{ui.pages.bookingsList.partiesLabel}</th>
                  <th>{ui.pages.bookingsList.amountsLabel}</th>
                  <th>{ui.labels.created}</th>
                  <th />
                </tr>
              </thead>
              <tbody>
                {snapshot.items.map((booking) => (
                  <tr key={booking.id}>
                    <td>
                      <div className="space-y-1">
                        <Link
                          href={`/${locale}/bookings/${booking.id}`}
                          className="font-semibold text-[var(--color-ink-strong)] underline-offset-4 hover:underline"
                        >
                          {booking.trackingNumber}
                        </Link>
                        <p className="text-xs text-[var(--color-ink-muted)]">
                          {formatTemplate(ui.pages.bookingsList.paymentReference, { reference: booking.paymentReference })}
                        </p>
                        {booking.shipmentDescription ? (
                          <p className="text-xs text-[var(--color-ink-muted)]">{booking.shipmentDescription}</p>
                        ) : null}
                      </div>
                    </td>
                    <td>
                      <div className="flex flex-wrap gap-2">
                        <StatusBadge label={getEnumLabel(locale, "booking", booking.bookingStatus)} tone="neutral" />
                        <StatusBadge
                          label={getEnumLabel(locale, "payment", booking.paymentStatus)}
                          tone={booking.paymentStatus === "secured" ? "success" : booking.paymentStatus === "rejected" ? "danger" : "warning"}
                        />
                      </div>
                    </td>
                    <td className="text-sm text-[var(--color-ink-strong)]">
                      <div className="space-y-1">
                        <p>
                          {booking.originLabel} {"->"} {booking.destinationLabel}
                        </p>
                        <p className="text-xs text-[var(--color-ink-muted)]">{booking.shipmentId}</p>
                      </div>
                    </td>
                    <td className="text-sm">
                      <div className="space-y-1">
                        <p className="font-medium text-[var(--color-ink-strong)]">{booking.shipperName}</p>
                        <p className="text-xs text-[var(--color-ink-muted)]">{booking.carrierName}</p>
                      </div>
                    </td>
                    <td className="text-sm">
                      <div className="space-y-1">
                        <p>{formatCurrencyDzd(booking.shipperTotalDzd)}</p>
                        <p className="text-xs text-[var(--color-ink-muted)]">{formatCurrencyDzd(booking.carrierPayoutDzd)}</p>
                      </div>
                    </td>
                    <td className="text-sm text-[var(--color-ink-muted)]">{formatDateTime(booking.createdAt, locale)}</td>
                    <td>
                      <div className="flex flex-wrap gap-2">
                        <Link className="button-secondary" href={`/${locale}/bookings/${booking.id}`}>
                          {ui.actions.openDetail}
                        </Link>
                        <Link className="button-secondary" href={`/${locale}/shipments/${booking.shipmentId}`}>
                          {ui.actions.shipmentDetail}
                        </Link>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          <div className="flex flex-wrap items-center justify-between gap-3 border-t border-[var(--color-border)] pt-4">
            <p className="text-sm text-[var(--color-ink-muted)]">
              {ui.pages.audit.page} {snapshot.page} / {snapshot.totalPages} • {snapshot.total} {ui.pages.audit.total}
            </p>
            <div className="flex gap-2">
              {snapshot.page > 1 ? (
                <Link className="button-secondary" href={buildPageHref(locale, { q: query, status }, snapshot.page - 1)}>
                  {ui.pages.audit.previous}
                </Link>
              ) : null}
              {snapshot.page < snapshot.totalPages ? (
                <Link className="button-secondary" href={buildPageHref(locale, { q: query, status }, snapshot.page + 1)}>
                  {ui.pages.audit.next}
                </Link>
              ) : null}
            </div>
          </div>
        </section>
      )}
    </div>
  );
}
