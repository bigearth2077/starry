"use client";

import { useEffect, useMemo, useState } from "react";
import {
  addMonths,
  startOfMonth,
  endOfMonth,
  eachDayOfInterval,
  isSameMonth,
  isBefore,
  isAfter,
  format,
} from "date-fns";

function iso(d: Date) {
  return format(d, "yyyy-MM-dd");
}

export default function ManageSessionsDialog({
  termId,
  startDate,
  endDate,
}: {
  termId: string;
  startDate: string | Date;
  endDate: string | Date;
}) {
  const [open, setOpen] = useState(false);
  const start = new Date(startDate);
  const end = new Date(endDate);
  const [month, setMonth] = useState<Date>(startOfMonth(start));
  const [selected, setSelected] = useState<Set<string>>(new Set()); // yyyy-MM-dd
  const [loading, setLoading] = useState(false);

  // 打开时拉当前课次，初始化 selected
  useEffect(() => {
    if (!open) return;
    let cancel = false;
    (async () => {
      setLoading(true);
      try {
        const r = await fetch(`/api/class-terms/${termId}/matrix`, {
          cache: "no-store",
        });
        const j = await r.json();
        if (cancel) return;
        const set = new Set<string>();
        (j.sessions as Array<{ date: string }>).forEach((s) => {
          const d = new Date(s.date);
          const yyyy = d.getFullYear();
          const mm = String(d.getMonth() + 1).padStart(2, "0");
          const dd = String(d.getDate()).padStart(2, "0");
          set.add(`${yyyy}-${mm}-${dd}`);
        });
        setSelected(set);
      } finally {
        if (!cancel) setLoading(false);
      }
    })();
    return () => {
      cancel = true;
    };
  }, [open, termId]);

  const days = useMemo(() => {
    const mStart = startOfMonth(month);
    const mEnd = endOfMonth(month);
    return eachDayOfInterval({ start: mStart, end: mEnd }).map((d) => ({
      date: d,
      inRange: !isBefore(d, start) && !isAfter(d, end),
      isCurrentMonth: isSameMonth(d, month),
      iso: iso(d),
      label: d.getDate(),
    }));
  }, [month, start, end]);

  function toggle(d: string, enabled: boolean) {
    setSelected((prev) => {
      const n = new Set(prev);
      if (enabled) {
        if (n.has(d)) n.delete(d);
        else n.add(d);
      }
      return n;
    });
  }

  async function save() {
    const dates = Array.from(selected).sort();
    const r = await fetch(`/api/class-terms/${termId}/sessions`, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ dates }),
    });
    if (!r.ok) {
      const j = await r.json().catch(() => ({}));
      alert(j.error || "保存失败");
      return;
    }
    setOpen(false);
    // 简单处理：整页刷新。你也可以在父组件传入回调，局部刷新矩阵数据。
    location.reload();
  }

  function prevMonth() {
    const next = addMonths(month, -1);
    if (isBefore(endOfMonth(next), start)) return;
    setMonth(next);
  }
  function nextMonth() {
    const next = addMonths(month, 1);
    if (isAfter(startOfMonth(next), end)) return;
    setMonth(next);
  }

  return (
    <div>
      <button
        className="border rounded-md px-3 py-2 text-sm"
        onClick={() => setOpen(true)}
      >
        管理课次
      </button>
      {open && (
        <div className="fixed inset-0 bg-black/40 flex items-center justify-center z-50">
          <div className="bg-white rounded-lg w-[90vw] max-w-3xl p-4 space-y-3">
            <div className="flex items-center justify-between">
              <div className="font-medium">在日历中勾选/取消课次</div>
              <button className="text-sm" onClick={() => setOpen(false)}>
                关闭
              </button>
            </div>

            <div className="flex items-center justify-between">
              <button
                className="text-sm border rounded px-2 py-1"
                onClick={prevMonth}
              >
                上个月
              </button>
              <div className="text-sm">{format(month, "yyyy年MM月")}</div>
              <button
                className="text-sm border rounded px-2 py-1"
                onClick={nextMonth}
              >
                下个月
              </button>
            </div>

            <div className="grid grid-cols-7 gap-1">
              {["日", "一", "二", "三", "四", "五", "六"].map((w) => (
                <div
                  key={w}
                  className="text-center text-xs text-muted-foreground py-1"
                >
                  {w}
                </div>
              ))}
              {days.map((d) => {
                const enabled = d.inRange && d.isCurrentMonth;
                const active = selected.has(d.iso);
                return (
                  <button
                    key={d.iso}
                    className={`h-10 rounded border text-sm ${
                      enabled
                        ? active
                          ? "bg-green-200"
                          : "bg-white"
                        : "bg-gray-100 text-gray-400"
                    } `}
                    disabled={!enabled || loading}
                    onClick={() => toggle(d.iso, enabled)}
                    title={d.iso}
                  >
                    {d.label}
                  </button>
                );
              })}
            </div>

            <div className="flex items-center justify-end gap-2">
              <button
                className="border rounded-md px-3 py-2 text-sm"
                onClick={() => setOpen(false)}
              >
                取消
              </button>
              <button
                className="border rounded-md px-3 py-2 text-sm"
                onClick={save}
                disabled={loading}
              >
                {loading ? "保存中..." : "保存"}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
