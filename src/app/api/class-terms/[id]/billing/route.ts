import { NextResponse } from "next/server";
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";
import { computeClassTermBilling } from "@/lib/billing";

export async function GET(
  _: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { id } = await params;
    const { teacherId } = await requireTeacher();
    const { termMeta, rows, classTermTotal } = await computeClassTermBilling(
      id,
      teacherId
    );
    return NextResponse.json({
      termMeta,
      students: rows,
      totalRevenue: classTermTotal,
      currency: termMeta.currency,
    });
  } catch (e) {
    if (e instanceof Unauthorized)
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    return NextResponse.json({ error: "计算失败" }, { status: 500 });
  }
}
