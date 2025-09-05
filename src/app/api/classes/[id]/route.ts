import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";
import { z } from "zod";

export async function GET(
  _: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const { teacherId } = await requireTeacher();
    const item = await prisma.class.findFirst({
      where: { id: params.id, teacherId },
      select: {
        id: true,
        name: true,
        createdAt: true,
        _count: { select: { classTerms: true } },
      },
    });
    if (!item)
      return NextResponse.json({ error: "不存在或无权限" }, { status: 404 });
    return NextResponse.json(item);
  } catch {
    return NextResponse.json({ error: "未登录" }, { status: 401 });
  }
}

const PatchBody = z.object({ name: z.string().min(1) });

export async function PATCH(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const { teacherId } = await requireTeacher();
    const data = PatchBody.parse(await req.json());

    // 同名校验
    const conflict = await prisma.class.findFirst({
      where: { teacherId, name: data.name, NOT: { id: params.id } },
      select: { id: true },
    });
    if (conflict)
      return NextResponse.json({ error: "同名班级已存在" }, { status: 409 });

    const updated = await prisma.class.update({
      where: { id: params.id },
      data: { name: data.name },
      select: { id: true, name: true, createdAt: true },
    });
    return NextResponse.json(updated);
  } catch (e) {
    if (e instanceof Unauthorized)
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    return NextResponse.json({ error: "更新失败" }, { status: 500 });
  }
}

export async function DELETE(
  _: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const { teacherId } = await requireTeacher();
    // 只允许删除自己的班级
    const own = await prisma.class.findFirst({
      where: { id: params.id, teacherId },
      select: { id: true },
    });
    if (!own)
      return NextResponse.json({ error: "不存在或无权限" }, { status: 404 });

    // 如果不想允许删除已有关联学期安排的班级，先检查：
    // const cnt = await prisma.classTerm.count({ where: { classId: params.id } });
    // if (cnt > 0) return NextResponse.json({ error: "该班级已有学期安排，不能删除" }, { status: 409 });

    await prisma.class.delete({ where: { id: params.id } });
    return NextResponse.json({ ok: true });
  } catch (e) {
    if (e instanceof Unauthorized)
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    return NextResponse.json({ error: "删除失败" }, { status: 500 });
  }
}
