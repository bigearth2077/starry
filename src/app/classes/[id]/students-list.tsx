"use client";
import { useState } from "react";

export default function StudentsList({
  classId,
  items,
}: {
  classId: string;
  items: { id: string; name: string }[];
}) {
  return (
    <div className="divide-y">
      {items.length === 0 && (
        <div className="p-4 text-sm text-muted-foreground">
          暂无学生，先在上面导入。
        </div>
      )}
      {items.map((s) => (
        <StudentRow key={s.id} classId={classId} student={s} />
      ))}
    </div>
  );
}

function StudentRow({
  classId,
  student,
}: {
  classId: string;
  student: { id: string; name: string };
}) {
  const [name, setName] = useState(student.name);
  const [saving, setSaving] = useState(false);
  const [err, setErr] = useState<string | null>(null);
  const [delLoading, setDelLoading] = useState(false);

  async function save() {
    setErr(null);
    setSaving(true);
    const r = await fetch(`/api/classes/${classId}/students/${student.id}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ name }),
    });
    setSaving(false);
    if (!r.ok) {
      const j = await r.json().catch(() => ({}));
      setErr(j.error || "重命名失败");
      return;
    }
    // 刷新或本地更新都行，这里简单刷新
    location.reload();
  }

  async function del() {
    if (
      !confirm(
        `确定删除学生 ${student.name} 吗？此操作会删除其选课与缺席记录。`
      )
    )
      return;
    setDelLoading(true);
    const r = await fetch(`/api/classes/${classId}/students/${student.id}`, {
      method: "DELETE",
    });
    setDelLoading(false);
    if (!r.ok) {
      const j = await r.json().catch(() => ({}));
      alert(j.error || "删除失败");
      return;
    }
    location.reload();
  }

  return (
    <div className="p-3 flex items-center justify-between gap-3">
      <input
        className="border rounded-md px-2 py-1 w-full sm:w-64"
        value={name}
        onChange={(e) => setName(e.target.value)}
      />
      <div className="flex items-center gap-2">
        <button
          className="border rounded-md px-3 py-1 text-sm"
          onClick={save}
          disabled={saving}
        >
          保存
        </button>
        <button
          className="text-sm text-red-600"
          onClick={del}
          disabled={delLoading}
        >
          删除
        </button>
      </div>
      {err && <p className="text-xs text-red-600">{err}</p>}
    </div>
  );
}
