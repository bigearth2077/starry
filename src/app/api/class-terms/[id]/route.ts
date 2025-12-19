// src/app/api/class-terms/[id]/route.ts
import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";
import { z } from "zod";

// 目前仅支持修改计费开关 billOnlyDone（布尔），需要的话可以继续加其他字段
const PatchBody = z.object({
  billOnlyDone: z.boolean().optional(),
  // 如需后续支持编辑 term 基本信息，可以按需解注：
  // startDate: z.string().optional(),
  // endDate: z.string().optional(),
  // weekdays: z.array(z.number().int().min(0).max(6)).optional(),
  // perSessionFee: z.string().optional(),
  // currency: z.string().optional(),
});

export async function DELETE(
  _: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { teacherId } = await requireTeacher();

    // 权限校验
    const { id } = await params;
    const term = await prisma.classTerm.findFirst({
      where: { id: id, class: { teacherId } },
      select: { id: true },
    });
    if (!term)
      return NextResponse.json({ error: "不存在或无权限" }, { status: 404 });

    // 注意：会级联删除 sessions/enrollments/absences（根据你 schema 的 onDelete: Cascade）
    await prisma.classTerm.delete({ where: { id: term.id } });

    return NextResponse.json({ ok: true });
  } catch (e) {
    if (e instanceof Unauthorized)
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    return NextResponse.json({ error: "删除失败" }, { status: 500 });
  }
}
