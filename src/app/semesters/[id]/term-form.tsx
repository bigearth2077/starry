"use client";

import { useState } from "react";

const WEEKDAYS = [
  { label: "日", value: 0 },
  { label: "一", value: 1 },
  { label: "二", value: 2 },
  { label: "三", value: 3 },
  { label: "四", value: 4 },
  { label: "五", value: 5 },
  { label: "六", value: 6 },
];

export default function ClassTermForm({
  semesterId,
  classes,
}: {
  semesterId: string;
  classes: { id: string; name: string }[];
}) {
  const [selectedWeekdays, setSelectedWeekdays] = useState<number[]>([]);
  const [loading, setLoading] = useState(false);
  const [err, setErr] = useState("");

  async function onSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    setErr("");
    setLoading(true);

    const fd = new FormData(e.currentTarget);
    const body = {
      classId: String(fd.get("classId") || ""),
      semesterId,
      startDate: String(fd.get("startDate") || ""),
      endDate: String(fd.get("endDate") || ""),
      weekdays: selectedWeekdays,
      perSessionFee: String(fd.get("perSessionFee") || ""),
      currency: String(fd.get("currency") || "CNY"),
    };

    const r = await fetch("/api/class-terms", {
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
    // 刷新当前页
    location.reload();
  }

  return (
    <form onSubmit={onSubmit} className="space-y-4">
      <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
        <div>
          <label className="block text-sm mb-1">班级</label>
          <select
            name="classId"
            className="w-full border rounded-md px-3 py-2"
            required
          >
            <option value="">请选择班级</option>
            {classes.map((c) => (
              <option key={c.id} value={c.id}>
                {c.name}
              </option>
            ))}
          </select>
        </div>
        <div>
          <label className="block text-sm mb-1">单次课程费用</label>
          <input
            name="perSessionFee"
            placeholder="100.00"
            className="w-full border rounded-md px-3 py-2"
            required
          />
        </div>
        <div>
          <label className="block text-sm mb-1">开始日期</label>
          <input
            type="date"
            name="startDate"
            className="w-full border rounded-md px-3 py-2"
            required
          />
        </div>
        <div>
          <label className="block text-sm mb-1">结束日期</label>
          <input
            type="date"
            name="endDate"
            className="w-full border rounded-md px-3 py-2"
            required
          />
        </div>
      </div>

      <div>
        <label className="block text-sm mb-1">每周上课日</label>
        <div className="flex flex-wrap gap-3">
          {WEEKDAYS.map((w) => (
            <label key={w.value} className="flex items-center gap-2 text-sm">
              <input
                type="checkbox"
                checked={selectedWeekdays.includes(w.value)}
                onChange={(e) => {
                  const checked = e.target.checked;
                  setSelectedWeekdays((prev) =>
                    checked
                      ? [...prev, w.value]
                      : prev.filter((x) => x !== w.value)
                  );
                }}
              />
              周{w.label}
            </label>
          ))}
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
        <div>
          <label className="block text-sm mb-1">货币</label>
          <input
            name="currency"
            defaultValue="CNY"
            className="w-full border rounded-md px-3 py-2"
          />
        </div>
      </div>

      {err && <p className="text-sm text-red-600">{err}</p>}
      <button className="border rounded-md px-3 py-2" disabled={loading}>
        {loading ? "创建中..." : "创建班级学期"}
      </button>
    </form>
  );
}
