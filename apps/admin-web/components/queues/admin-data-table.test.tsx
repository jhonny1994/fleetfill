import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import type { ColumnDef } from "@tanstack/react-table";
import { describe, expect, it } from "vitest";

import { AdminDataTable } from "@/components/queues/admin-data-table";

type Row = {
  name: string;
  age: number;
};

const columns: ColumnDef<Row>[] = [
  {
    accessorKey: "name",
    header: "Name",
  },
  {
    accessorKey: "age",
    header: "Age",
  },
];

describe("AdminDataTable", () => {
  it("sorts rows when a sortable header is clicked", async () => {
    const user = userEvent.setup();

    render(
      <AdminDataTable
        data={[
          { name: "Bravo", age: 32 },
          { name: "Alpha", age: 24 },
        ]}
        columns={columns}
        emptyEyebrow="Queue"
        emptyTitle="Empty"
        emptyBody="Nothing here"
      />,
    );

    await user.click(screen.getByRole("button", { name: /name/i }));

    const cells = screen.getAllByRole("cell");
    expect(cells[0]).toHaveTextContent("Alpha");
    expect(cells[2]).toHaveTextContent("Bravo");
  });

  it("shows the shared empty state when no rows exist", () => {
    render(
      <AdminDataTable<Row>
        data={[]}
        columns={columns}
        emptyEyebrow="Queue"
        emptyTitle="Empty"
        emptyBody="Nothing here"
      />,
    );

    expect(screen.getByText("Empty")).toBeInTheDocument();
    expect(screen.getByText("Nothing here")).toBeInTheDocument();
  });
});
