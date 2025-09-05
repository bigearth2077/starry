// src/app/api/class-terms/[id]/export/matrix/route.ts
import ExcelJS from "exceljs";
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";
import { computeClassTermBilling } from "@/lib/billing";

export const runtime = "nodejs";
export const dynamic = "force-dynamic";

function head2(d: Date) {
  const yy = String(d.getFullYear()).slice(2);
  const m = d.getMonth() + 1;
  const day = d.getDate();
  const wd = "日一二三四五六"[d.getDay()];
  return { top: `${yy}.${m}.${day}`, bottom: `周${wd}` };
}

export async function GET(_: Request, { params }: { params: { id: string } }) {
  try {
    const { teacherId } = await requireTeacher();
    const data = await computeClassTermBilling(params.id, teacherId);
    const {
      termMeta,
      rows,
      classTermTotal,
      sessions,
      enrollments,
      absencesRaw,
    } = data;

    const absentSet = new Set(
      absencesRaw.map((a) => `${a.sessionId}|${a.studentId}`)
    );

    const wb = new ExcelJS.Workbook();
    wb.creator = "Starry";

    // Sheet 1: 矩阵
    const ws = wb.addWorksheet("点名矩阵", {
      views: [{ state: "frozen", xSplit: 1, ySplit: 2 }],
    });
    const headTop = ["学生", ...sessions.map((s) => head2(s.date).top)];
    const headBottom = ["", ...sessions.map((s) => head2(s.date).bottom)];
    ws.addRow([
      `班级：${termMeta.className}`,
      `学期：${termMeta.semesterName}`,
      `时间：${new Date(termMeta.span.start).toLocaleDateString()} ~ ${new Date(
        termMeta.span.end
      ).toLocaleDateString()}`,
    ]);
    ws.addRow([]);
    ws.addRow(headTop);
    ws.addRow(headBottom);
    ws.getRow(3).font = { bold: true };
    ws.getRow(4).font = { color: { argb: "FF666666" } };
    ws.getColumn(1).width = 18;
    for (let i = 2; i <= sessions.length + 1; i++) ws.getColumn(i).width = 10;

    const green: ExcelJS.Fill = {
      type: "pattern",
      pattern: "solid",
      fgColor: { argb: "FFC6EFCE" },
    }; // 出勤
    const red: ExcelJS.Fill = {
      type: "pattern",
      pattern: "solid",
      fgColor: { argb: "FFFFC7CE" },
    }; // 缺席  
    const center = { vertical: "middle", horizontal: "center" } as const;

    for (const stu of enrollments) {
      const row = ws.addRow([stu.name, ...sessions.map(() => "")]);
      row.height = 18;
      for (let j = 0; j < sessions.length; j++) {
        const sess = sessions[j];
        const cell = row.getCell(j + 2);
        const absent = absentSet.has(`${sess.id}|${stu.id}`);
        cell.value = absent ? "缺席" : "出勤";
        cell.alignment = center;
        cell.fill = absent ? red : green;
      }
    }

    // Sheet 2: 统计
    const st = wb.addWorksheet("统计");
    st.columns = [
      { header: "学生", key: "name", width: 20 },
      { header: "总课次", key: "total", width: 10 },
      { header: "缺席", key: "absences", width: 10 },
      { header: "出勤", key: "attended", width: 10 },
      { header: "单次费用", key: "per", width: 12 },
      { header: "应收", key: "payable", width: 12 },
      { header: "货币", key: "ccy", width: 8 },
    ];
    st.addRow([
      "班级",
      termMeta.className,
      "学期",
      termMeta.semesterName,
      "时间",
      new Date(termMeta.span.start).toLocaleDateString() +
        " ~ " +
        new Date(termMeta.span.end).toLocaleDateString(),
    ]);
    st.addRow([]);
    st.addRow(st.columns.map((c) => c?.header));
    st.getRow(3).font = { bold: true };

    for (const r of rows) {
      st.addRow({
        name: r.studentName,
        total: r.totalSessions,
        absences: r.absences,
        attended: r.attended,
        per: r.perSessionFee,
        payable: r.payable,
        ccy: r.currency,
      });
    }
    st.addRow([]);
    const totalRow = st.addRow([
      "合计",
      "",
      "",
      "",
      "",
      classTermTotal,
      termMeta.currency,
    ]);
    totalRow.font = { bold: true };

    const buf = await wb.xlsx.writeBuffer();
    const filename = encodeURIComponent(
      `${termMeta.className}-${termMeta.semesterName}-点名矩阵.xlsx`
    );

    return new Response(buf, {
      headers: {
        "Content-Type":
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        "Content-Disposition": `attachment; filename*=UTF-8''${filename}`,
        "Cache-Control": "no-store",
      },
    });
  } catch (e: any) {
    if (e instanceof Unauthorized) {
      return new Response(JSON.stringify({ error: "未登录" }), { status: 401 });
    }
    console.error("Export matrix.xlsx failed:", e);
    return new Response(JSON.stringify({ error: "导出失败" }), { status: 500 });
  }
}
