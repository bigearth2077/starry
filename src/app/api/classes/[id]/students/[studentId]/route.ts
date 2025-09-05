import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";
import { z } from "zod";

const RenameBody = z.object({
  name: z.string().min(1),
});

function normalizeName(s: string) {
  const filtered = s
    .trim()
    .replace(/[^A-Za-z.\-\s]/g, "")
    .replace(/\s+/g, " ");
  return filtered;
}

export async function PATCH(
  req: NextRequest,
  { params }: { params: { classId: string; studentId: string } }
) {
  try {
    const { teacherId } = await requireTeacher();
    const cls = await prisma.class.findFirst({
      where: { id: params.classId, teacherId },
      select: { id: true },
    });
    if (!cls)
      return NextResponse.json(
        { error: "班级不存在或无权限" },
        { status: 404 }
      );

    const body = RenameBody.parse(await req.json());
    const name = normalizeName(body.name);
    if (!name) return NextResponse.json({ error: "无效名字" }, { status: 400 });

    // 冲突校验（同班内重名）
    const conflict = await prisma.student.findFirst({
      where: { classId: cls.id, name, NOT: { id: params.studentId } },
      select: { id: true },
    });
    if (conflict)
      return NextResponse.json(
        { error: "同班内已存在同名学生" },
        { status: 409 }
      );

    const updated = await prisma.student.update({
      where: { id: params.studentId },
      data: { name },
      select: { id: true, name: true },
    });
    return NextResponse.json(updated);
  } catch (e) {
    if (e instanceof Unauthorized)
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    return NextResponse.json({ error: "重命名失败" }, { status: 500 });
  }
}

export async function DELETE(
  _: NextRequest,
  { params }: { params: { classId: string; studentId: string } }
) {
  try {
    const { teacherId } = await requireTeacher();
    const own = await prisma.student.findFirst({
      where: { id: params.studentId, class: { id: params.classId, teacherId } },
      select: { id: true },
    });
    if (!own)
      return NextResponse.json(
        { error: "学生不存在或无权限" },
        { status: 404 }
      );

    await prisma.student.delete({ where: { id: params.studentId } });
    return NextResponse.json({ ok: true });
  } catch (e) {
    if (e instanceof Unauthorized)
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    return NextResponse.json({ error: "删除失败" }, { status: 500 });
  }
}
