// src/app/login/page.tsx
import LoginForm from "./login-form-client";

export default async function LoginPage({
  searchParams,
}: {
  // Next 15：searchParams 是 Promise，需要 await
  searchParams: Promise<Record<string, string | string[] | undefined>>;
}) {
  const sp = await searchParams;
  const callbackUrl =
    typeof sp.callbackUrl === "string" && sp.callbackUrl.length > 0
      ? sp.callbackUrl
      : "/dashboard";

  return <LoginForm callbackUrl={callbackUrl} />;
}
