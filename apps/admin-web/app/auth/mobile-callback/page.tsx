export default function MobileAuthCallbackPage() {
  return (
    <main className="mx-auto flex min-h-screen max-w-2xl flex-col items-center justify-center px-6 py-16 text-center">
      <div className="space-y-4">
        <h1 className="text-3xl font-semibold tracking-tight text-slate-950">
          Continue in FleetFill
        </h1>
        <p className="text-base leading-7 text-slate-600">
          If the FleetFill Android app is installed, this link should open it
          automatically. If it does not, return to the app and try signing in
          again from there.
        </p>
      </div>
    </main>
  );
}
