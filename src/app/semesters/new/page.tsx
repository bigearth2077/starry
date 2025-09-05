"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

export default function NewSemesterPage() {
  const router = useRouter();
  const [loading, setLoading] = useState(false);
  const [err, setErr] = useState("");

  async function onSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    setErr("");
    setLoading(true);

    const form = new FormData(e.currentTarget);
    const body = {
      name: String(form.get("name") || ""),
    };

    const r = await fetch("/api/semesters", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
    });

    setLoading(false);
    if (!r.ok) {
      const j = await r.json().catch(() => ({}));
      setErr(j.error || "创建失败");
      return;
    }
    router.push("/dashboard");
  }

  return (
    <div className="max-w-md">
      <h1 className="text-xl font-semibold mb-4">新建学期</h1>
      <form onSubmit={onSubmit} className="space-y-4">
        <div>
          <label className="block text-sm mb-1">名称</label>
          <input
            name="name"
            className="w-full border rounded-md px-3 py-2"
            placeholder="例如：2025 春季"
            required
          />
        </div>

        {err && <p className="text-sm text-red-600">{err}</p>}
        <button className="border rounded-md px-3 py-2" disabled={loading}>
          {loading ? "创建中..." : "创建"}
        </button>

        <p className="text-xs text-muted-foreground">
          提示：起止时间、上课日与单次费用会在「班级学期（ClassTerm）」里设置。
        </p>
      </form>
    </div>
  );
}
