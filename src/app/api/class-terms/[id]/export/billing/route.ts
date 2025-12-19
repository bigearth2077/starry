// src/app/api/class-terms/[id]/export/billing/route.ts
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";
import { computeClassTermBilling } from "@/lib/billing";
import ExcelJS from "exceljs";

export const runtime = "nodejs"; // 确保不是 Edge
export const dynamic = "force-dynamic"; // 避免缓存

export async function GET(
  _: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { teacherId } = await requireTeacher();
    const { termMeta, rows, classTermTotal } = await computeClassTermBilling(
      (
        await params
      ).id,
      teacherId
    );

    const wb = new ExcelJS.Workbook();
    wb.creator = "Starry";
    const ws = wb.addWorksheet("学生结算");

    ws.columns = [
      { header: "学生", key: "name", width: 20 },
      { header: "总课次", key: "total", width: 10 },
      { header: "缺席", key: "absences", width: 10 },
      { header: "出勤", key: "attended", width: 10 },
      { header: "单次费用", key: "per", width: 12 },
      { header: "应收", key: "payable", width: 12 },
      { header: "货币", key: "ccy", width: 8 },
    ];

    ws.addRow([
      "班级",
      termMeta.className,
      "学期",
      termMeta.semesterName,
      "时间",
      new Date(termMeta.span.start).toLocaleDateString() +
        " ~ " +
        new Date(termMeta.span.end).toLocaleDateString(),
    ]);
    ws.addRow([]);
    ws.addRow(ws.columns.map((c) => c?.header));
    ws.getRow(3).font = { bold: true };

    for (const r of rows) {
      ws.addRow({
        name: r.studentName,
        total: r.totalSessions,
        absences: r.absences,
        attended: r.attended,
        per: r.perSessionFee,
        payable: r.payable,
        ccy: r.currency,
      });
    }

    ws.addRow([]);
    const totalRow = ws.addRow([
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
      `${termMeta.className}-${termMeta.semesterName}-学生结算.xlsx`
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
    console.error("Export billing.xlsx failed:", e);
    return new Response(JSON.stringify({ error: "导出失败" }), { status: 500 });
  }
}
