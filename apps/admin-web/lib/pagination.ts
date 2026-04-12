export function pageRange(page: number, pageSize: number) {
  const from = (page - 1) * pageSize;
  return { from, to: from + pageSize - 1 };
}

export function totalPages(total: number, pageSize: number) {
  return Math.max(1, Math.ceil(total / pageSize));
}

export function buildPageHref(
  pathname: string,
  params: URLSearchParams,
  page: number,
) {
  const next = new URLSearchParams(params);
  next.set("page", String(page));
  const serialized = next.toString();
  return serialized ? `${pathname}?${serialized}` : pathname;
}
