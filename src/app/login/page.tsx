// src/app/login/page.tsx
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth-options";
import { redirect } from "next/navigation";
import LoginForm from "./login-form-client";

export default async function LoginPage({
  searchParams,
}: {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
}) {
  const sp = await searchParams;
  const callbackUrl =
    typeof sp.callbackUrl === "string" && sp.callbackUrl.length > 0
      ? decodeURIComponent(sp.callbackUrl)
      : "/dashboard";

  // 关键：如果已经有会话，直接跳走，避免还待在 /login
  const session = await getServerSession(authOptions);
  if (session) redirect(callbackUrl);

  return <LoginForm callbackUrl={callbackUrl} />;
}
