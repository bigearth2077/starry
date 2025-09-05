"use client";
import { useState } from "react";

export default function NewClassForm() {
  const [name, setName] = useState("");
  const [err, setErr] = useState("");
  const [loading, setLoading] = useState(false);

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    setErr("");
    setLoading(true);

    const r = await fetch("/api/classes", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ name }),
    });
    setLoading(false);

    if (!r.ok) {
      const j = await r.json().catch(() => ({}));
      setErr(j.error || "创建失败");
      return;
    }
    setName("");
    location.reload();
  }

  return (
    <form
      onSubmit={onSubmit}
      className="flex gap-2 items-start flex-col sm:flex-row"
    >
      <input
        className="border rounded-md px-3 py-2 w-full sm:w-64"
        placeholder="例如：高一(1)班"
        value={name}
        onChange={(e) => setName(e.target.value)}
        required
      />
      <button className="border rounded-md px-3 py-2" disabled={loading}>
        {loading ? "创建中..." : "创建班级"}
      </button>
      {err && <p className="text-sm text-red-600">{err}</p>}
    </form>
  );
}
