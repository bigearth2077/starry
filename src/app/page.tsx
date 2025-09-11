// app/page.tsx
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth-options";
import { redirect } from "next/navigation";

export default async function Home() {
  const session = await getServerSession(authOptions);
  if (session) {
    redirect("/dashboard"); // 已登录 -> 仪表盘
  }
  redirect("/login"); // 未登录 -> 登录页
}
