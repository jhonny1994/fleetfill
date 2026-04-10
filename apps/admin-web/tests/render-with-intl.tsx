import type { ReactElement, ReactNode } from "react";
import { render } from "@testing-library/react";
import { NextIntlClientProvider } from "next-intl";

import messages from "@/messages/en";

type WrapperProps = {
  children: ReactNode;
};

function IntlWrapper({ children }: WrapperProps) {
  return (
    <NextIntlClientProvider locale="en" messages={messages}>
      {children}
    </NextIntlClientProvider>
  );
}

export function renderWithIntl(ui: ReactElement) {
  return render(ui, { wrapper: IntlWrapper });
}
