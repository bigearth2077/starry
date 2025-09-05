"use client";

import { useEffect, useMemo, useState } from "react";

type Student = { id: string; name: string };
type Session = { id: string; date: string };

function fmtHead(dateISO: string) {
  const d = new Date(dateISO);
  const yy = String(d.getFullYear()).slice(2);
  const m = d.getMonth() + 1;
  const day = d.getDate();
  const wd = "日一二三四五六"[d.getDay()];
  return { top: `${yy}.${m}.${day}`, bottom: `周${wd}` };
}

export default function AttendanceMatrix({ termId }: { termId: string }) {
  const [loading, setLoading] = useState(true);
  const [err, setErr] = useState<string | null>(null);
  const [students, setStudents] = useState<Student[]>([]);
  const [sessions, setSessions] = useState<Session[]>([]);
  const [absentSet, setAbsentSet] = useState<Set<string>>(new Set()); // key = sessionId|studentId

  useEffect(() => {
    let cancel = false;
    (async () => {
      setLoading(true);
      setErr(null);
      try {
        const r = await fetch(`/api/class-terms/${termId}/matrix`, {
          cache: "no-store",
        });
        if (!r.ok) throw new Error(await r.text());
        const j = await r.json();
        if (cancel) return;
        setStudents(j.students as Student[]);
        setSessions(
          (j.sessions as any[]).map((s) => ({ id: s.id, date: s.date }))
        );
        const set = new Set<string>();
        (j.absences as Array<{ sessionId: string; studentId: string }>).forEach(
          (a) => {
            set.add(`${a.sessionId}|${a.studentId}`);
          }
        );
        setAbsentSet(set);
      } catch (e: any) {
        if (!cancel) setErr(e?.message || "加载失败");
      } finally {
        if (!cancel) setLoading(false);
      }
    })();
    return () => {
      cancel = true;
    };
  }, [termId]);

  const headers = useMemo(
    () => sessions.map((s) => ({ id: s.id, ...fmtHead(s.date) })),
    [sessions]
  );

  async function toggle(sessionId: string, studentId: string) {
    const key = `${sessionId}|${studentId}`;
    // 乐观更新
    setAbsentSet((prev) => {
      const n = new Set(prev);
      if (n.has(key)) n.delete(key);
      else n.add(key);
      return n;
    });
    try {
      const r = await fetch(`/api/sessions/${sessionId}/toggle-absence`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ studentId }),
      });
      if (!r.ok) {
        // 失败回滚
        setAbsentSet((prev) => {
          const n = new Set(prev);
          if (n.has(key)) n.delete(key);
          else n.add(key);
          return n;
        });
        const j = await r.json().catch(() => ({}));
        alert(j.error || "切换失败");
      }
    } catch {
      // 回滚
      setAbsentSet((prev) => {
        const n = new Set(prev);
        if (n.has(key)) n.delete(key);
        else n.add(key);
        return n;
      });
    }
  }

  if (loading)
    return <div className="text-sm text-muted-foreground">加载中...</div>;
  if (err) return <div className="text-sm text-red-600">{err}</div>;
  if (students.length === 0)
    return (
      <div className="text-sm text-muted-foreground">
        该班级学期尚无选课学生。
      </div>
    );
  if (sessions.length === 0)
    return (
      <div className="text-sm text-muted-foreground">
        该班级学期尚无课次，请点击右上角“管理课次”添加。
      </div>
    );

  // 统一的列宽
  const LEFT_COL_WIDTH = 100;
  const CELL_WIDTH = 100;

  return (
    <div className="w-full overflow-auto border rounded-md relative">
      {/* 顶部固定表头：两行（日期与周几），随横向滚动 */}
      <div className="min-w-max">
        {/* 表头行 */}
        <div
          className="grid"
          style={{
            gridTemplateColumns: `${LEFT_COL_WIDTH}px repeat(${sessions.length}, ${CELL_WIDTH}px)`,
          }}
        >
          {/* 左上角：既 sticky top 又 sticky left */}
          <div
            className="px-3 py-2 border-b border-r bg-gray-50 font-medium sticky top-0 left-0 z-30"
            style={{ width: LEFT_COL_WIDTH }}
          >
            学生
          </div>
          {headers.map((h) => (
            <div
              key={h.id}
              className="px-2 py-1 border-b border-r text-center bg-gray-50 sticky top-0 z-20"
              style={{ width: CELL_WIDTH }}
            >
              <div className="text-sm leading-5">{h.top}</div>
              <div className="text-[12px] text-muted-foreground leading-4">
                {h.bottom}
              </div>
            </div>
          ))}
        </div>

        {/* 数据行 */}
        {students.map((st) => (
          <div
            key={st.id}
            className="grid"
            style={{
              gridTemplateColumns: `${LEFT_COL_WIDTH}px repeat(${sessions.length}, ${CELL_WIDTH}px)`,
            }}
          >
            {/* 左侧学生名：sticky left */}
            <div
              className="px-3 py-2 border-b border-r bg-white sticky left-0 z-10 truncate"
              title={st.name}
              style={{ width: LEFT_COL_WIDTH }}
            >
              {st.name}
            </div>
            {sessions.map((s) => {
              const key = `${s.id}|${st.id}`;
              const absent = absentSet.has(key);
              return (
                <button
                  key={s.id}
                  onClick={() => toggle(s.id, st.id)}
                  className={`h-10 border-b border-r ${
                    absent ? "bg-red-200" : "bg-green-200"
                  } hover:opacity-80`}
                  title={
                    absent ? "缺席（点击设为出勤）" : "出勤（点击设为缺席）"
                  }
                  style={{ width: CELL_WIDTH }}
                />
              );
            })}
          </div>
        ))}
      </div>
    </div>
  );
}
