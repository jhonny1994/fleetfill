"use client";

import {
  flexRender,
  getCoreRowModel,
  getSortedRowModel,
  type ColumnDef,
  type SortingState,
  useReactTable,
} from "@tanstack/react-table";
import { ArrowDown, ArrowUp, ArrowUpDown } from "lucide-react";
import { useState } from "react";

import { EmptyState } from "@/components/shared/empty-state";

export function AdminDataTable<TData>({
  data,
  columns,
  emptyTitle,
  emptyBody,
  emptyEyebrow,
}: {
  data: TData[];
  columns: ColumnDef<TData>[];
  emptyTitle: string;
  emptyBody: string;
  emptyEyebrow: string;
}) {
  const [sorting, setSorting] = useState<SortingState>([]);
  // eslint-disable-next-line react-hooks/incompatible-library
  const table = useReactTable({
    data,
    columns,
    state: { sorting },
    onSortingChange: setSorting,
    getCoreRowModel: getCoreRowModel(),
    getSortedRowModel: getSortedRowModel(),
  });

  if (data.length === 0) {
    return (
      <div className="table-shell p-4">
        <EmptyState eyebrow={emptyEyebrow} title={emptyTitle} body={emptyBody} />
      </div>
    );
  }

  return (
    <div className="table-shell">
      <table>
        <thead>
          {table.getHeaderGroups().map((headerGroup) => (
            <tr key={headerGroup.id}>
              {headerGroup.headers.map((header) => (
                <th key={header.id}>
                  {header.isPlaceholder ? null : header.column.getCanSort() ? (
                    <button
                      type="button"
                      onClick={header.column.getToggleSortingHandler()}
                      className="inline-flex items-center gap-2"
                    >
                      {flexRender(header.column.columnDef.header, header.getContext())}
                      <SortIcon direction={header.column.getIsSorted()} />
                    </button>
                  ) : (
                    flexRender(header.column.columnDef.header, header.getContext())
                  )}
                </th>
              ))}
            </tr>
          ))}
        </thead>
        <tbody>
          {table.getRowModel().rows.map((row) => (
            <tr key={row.id} className="hover:bg-white/65">
              {row.getVisibleCells().map((cell) => (
                <td key={cell.id} className="text-sm text-[var(--color-ink-base)]">
                  {flexRender(cell.column.columnDef.cell, cell.getContext())}
                </td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

function SortIcon({ direction }: { direction: false | "asc" | "desc" }) {
  if (direction === "asc") {
    return <ArrowUp className="size-4 shrink-0" />;
  }
  if (direction === "desc") {
    return <ArrowDown className="size-4 shrink-0" />;
  }
  return <ArrowUpDown className="size-4 shrink-0 opacity-60" />;
}
