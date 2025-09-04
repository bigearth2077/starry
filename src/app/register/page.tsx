"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import { Label } from "@/components/ui/label";

export default function RegisterPage() {
  const router = useRouter();
  const [email, setEmail] = useState("");
  const [name, setName] = useState("");
  const [password, setPassword] = useState("");
  const [err, setErr] = useState("");
  const [loading, setLoading] = useState(false);

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    setLoading(true);
    setErr("");
    const r = await fetch("/api/auth/register", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, name, password }),
    });
    setLoading(false);

    if (!r.ok) {
      const j = await r.json().catch(() => ({}));
      setErr(j.error || "注册失败");
      return;
    }
    // 注册完直接跳到登录页
    router.push("/login");
  }

  return (
    <div className="min-h-dvh flex items-center justify-center p-4">
      <Card className="w-full max-w-sm">
        <CardContent className="p-6 space-y-4">
          <h1 className="text-xl font-semibold text-center">注册</h1>
          <form onSubmit={onSubmit} className="space-y-4">
            <div>
              <Label>邮箱</Label>
              <Input
                type="email"
                placeholder="you@example.com"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
              />
            </div>
            <div>
              <Label>姓名（可选）</Label>
              <Input
                placeholder="张老师"
                value={name}
                onChange={(e) => setName(e.target.value)}
              />
            </div>
            <div>
              <Label>密码</Label>
              <Input
                type="password"
                placeholder="至少8位"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
              />
            </div>
            {err && <p className="text-sm text-red-500">{err}</p>}
            <Button className="w-full" disabled={loading}>
              {loading ? "提交中..." : "创建账户"}
            </Button>
          </form>
          <p className="text-center text-sm">
            已有账号？{" "}
            <a className="underline" href="/login">
              去登录
            </a>
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
// 注册页：表单提交到注册 API，注册成功后跳转到登录页
