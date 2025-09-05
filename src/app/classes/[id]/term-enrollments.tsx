"use client";

import { useEffect, useMemo, useState } from "react";

type Student = { id: string; name: string };

export default function TermEnrollments({
  classId,
  termId,
  allStudents,
}: {
  classId: string;
  termId: string;
  allStudents: Student[]; // 本班全部学生（按 name 排序）
}) {
  const [enrolled, setEnrolled] = useState<Set<string>>(new Set());
  const [loading, setLoading] = useState(true);
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState<string | null>(null);

  // 初始拉取已选
  useEffect(() => {
    let cancelled = false;
    (async () => {
      setLoading(true);
      setErr(null);
      try {
        const r = await fetch(`/api/class-terms/${termId}/enrollments`, {
          cache: "no-store",
        });
        if (!r.ok) throw new Error(await r.text());
        const j = await r.json();
        const ids = new Set<string>((j.items as Student[]).map((s) => s.id));
        if (!cancelled) setEnrolled(ids);
      } catch (e: any) {
        if (!cancelled) setErr(e?.message || "加载失败");
      } finally {
        if (!cancelled) setLoading(false);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [termId]);

  // UI 勾选集合（可编辑）
  const [pending, setPending] = useState<Set<string>>(new Set());
  const [dirty, setDirty] = useState(false);

  // 初始化/同步 pending=已选
  useEffect(() => {
    setPending(new Set(enrolled));
    setDirty(false);
  }, [enrolled]);

  const toggleOne = (id: string) => {
    setPending((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      setDirty(true);
      return next;
    });
  };

  // —— 新增：全选/全不选/反选 —— //
  const selectAll = () => {
    setPending(new Set(allStudents.map((s) => s.id)));
    setDirty(true);
  };
  const selectNone = () => {
    setPending(new Set());
    setDirty(true);
  };
  const invertSelect = () => {
    const all = new Set(allStudents.map((s) => s.id));
    setPending((prev) => {
      const next = new Set<string>();
      for (const id of all) {
        if (!prev.has(id)) next.add(id);
      }
      setDirty(true);
      return next;
    });
  };

  const toAdd = useMemo(
    () => Array.from(pending).filter((id) => !enrolled.has(id)),
    [pending, enrolled]
  );
  const toRemove = useMemo(
    () => Array.from(enrolled).filter((id) => !pending.has(id)),
    [pending, enrolled]
  );

  async function saveChanges() {
    if (!dirty) return;
    setBusy(true);
    setErr(null);
    try {
      if (toAdd.length > 0) {
        const r = await fetch(`/api/class-terms/${termId}/enrollments`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ studentIds: toAdd }),
        });
        if (!r.ok) throw new Error((await r.json()).error || "添加失败");
      }
      if (toRemove.length > 0) {
        const r = await fetch(`/api/class-terms/${termId}/enrollments`, {
          method: "DELETE",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ studentIds: toRemove }),
        });
        if (!r.ok) throw new Error((await r.json()).error || "移除失败");
      }
      setEnrolled(new Set(pending)); // 持久化成功后更新基线
      setDirty(false);
    } catch (e: any) {
      setErr(e?.message || "保存失败");
    } finally {
      setBusy(false);
    }
  }

  if (loading)
    return <div className="text-sm text-muted-foreground">加载中...</div>;
  if (err) return <div className="text-sm text-red-600">{err}</div>;

  const allCount = allStudents.length;
  const selectedCount = pending.size;

  return (
    <div className="space-y-2">
      {/* 控制条：全选/全不选/反选 + 统计 */}
      <div className="flex flex-wrap items-center gap-2">
        <button
          className="border rounded-md px-2 py-1 text-sm"
          onClick={selectAll}
          disabled={busy || allCount === 0}
          title="将本班所有学生加入该班级学期"
        >
          全选
        </button>
        <button
          className="border rounded-md px-2 py-1 text-sm"
          onClick={selectNone}
          disabled={busy || allCount === 0}
        >
          全不选
        </button>
        <button
          className="border rounded-md px-2 py-1 text-sm"
          onClick={invertSelect}
          disabled={busy || allCount === 0}
          title="把未选改为选中，已选改为未选"
        >
          反选
        </button>

        <span className="text-xs text-muted-foreground ml-2">
          已选 {selectedCount} / {allCount}（新增 {toAdd.length}，移除{" "}
          {toRemove.length}）
        </span>

        <button
          className="border rounded-md px-3 py-1 text-sm ml-auto disabled:opacity-50"
          onClick={saveChanges}
          disabled={!dirty || busy}
        >
          {busy ? "保存中..." : "保存变更"}
        </button>
      </div>

      {/* 学生复选列表 */}
      <div className="max-h-56 overflow-auto border rounded-md p-2">
        {allStudents.length === 0 && (
          <div className="text-sm text-muted-foreground">
            该班暂无学生，请先在“学生管理”中导入。
          </div>
        )}
        {allStudents.map((s) => (
          <label key={s.id} className="flex items-center gap-2 py-1">
            <input
              type="checkbox"
              checked={pending.has(s.id)}
              onChange={() => toggleOne(s.id)}
            />
            <span className="text-sm">{s.name}</span>
          </label>
        ))}
      </div>
      {err && <p className="text-xs text-red-600">{err}</p>}
    </div>
  );
}
