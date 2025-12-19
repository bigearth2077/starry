import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";

export async function DELETE(
  _: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { teacherId } = await requireTeacher();

    // 确认学期属于当前老师
    const sem = await prisma.semester.findFirst({
      where: { id: (await params).id, teacherId },
      select: { id: true },
    });
    if (!sem) {
      return NextResponse.json(
        { error: "学期不存在或无权限" },
        { status: 404 }
      );
    }

    // 删除学期（会级联删除关联的 ClassTerm / Session / Absence 等）
    await prisma.semester.delete({ where: { id: (await params).id } });

    return NextResponse.json({ ok: true });
  } catch (e) {
    if (e instanceof Unauthorized) {
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    }
    return NextResponse.json({ error: "删除失败" }, { status: 500 });
  }
}
