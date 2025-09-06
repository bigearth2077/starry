"use client";
import { useEffect, useState } from "react";

export default function ImportStudentsForm({ classId }: { classId: string }) {
  const [text, setText] = useState("");
  const [msg, setMsg] = useState<string | null>(null);
  const [err, setErr] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  // 切换班级时，重置本地状态，避免把上一班的数据提交到新班
  useEffect(() => {
    setText("");
    setMsg(null);
    setErr(null);
    setLoading(false);
  }, [classId]);

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    setMsg(null);
    setErr(null);
    setLoading(true);

    try {
      console.log("classId", classId);
      const r = await fetch(`/api/classes/${classId}/students`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ text }),
      });
      const j = await r.json().catch(() => ({}));
      if (!r.ok) {
        setErr(j.error || "导入失败");
      } else {
        setMsg(`已导入 ${j.imported} 个，跳过 ${j.skipped} 个`);
        setText("");
        // 刷新以拉取最新 students 列表
        location.reload();
      }
    } catch (e) {
      setErr("网络错误");
    } finally {
      setLoading(false);
    }
  }

  return (
    <form onSubmit={onSubmit} className="space-y-3">
      <p className="text-sm text-muted-foreground">
        文本批量导入：每行一个英文名（允许字母、空格、连字符、点）。同班内重名会自动跳过。
      </p>
      <textarea
        className="w-full border rounded-md p-2 min-h-32"
        placeholder={`Alice\nBob\nCharlie`}
        value={text}
        onChange={(e) => setText(e.target.value)}
        required
      />
      <button className="border rounded-md px-3 py-2" disabled={loading}>
        {loading ? "导入中..." : "导入学生"}
      </button>
      {msg && <p className="text-sm text-green-600">{msg}</p>}
      {err && <p className="text-sm text-red-600">{err}</p>}
    </form>
  );
}
