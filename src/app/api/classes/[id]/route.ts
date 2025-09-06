import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";
import { z } from "zod";

export async function GET(
  _: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { id } = await params; // ← await
    const { teacherId } = await requireTeacher();
    const item = await prisma.class.findFirst({
      where: { id, teacherId },
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
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { id } = await params; // ← await
    const { teacherId } = await requireTeacher();
    const data = PatchBody.parse(await req.json());

    const conflict = await prisma.class.findFirst({
      where: { teacherId, name: data.name, NOT: { id } },
      select: { id: true },
    });
    if (conflict)
      return NextResponse.json({ error: "同名班级已存在" }, { status: 409 });

    const updated = await prisma.class.update({
      where: { id },
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
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { id } = await params; // ← await
    const { teacherId } = await requireTeacher();

    const own = await prisma.class.findFirst({
      where: { id, teacherId },
      select: { id: true },
    });
    if (!own)
      return NextResponse.json({ error: "不存在或无权限" }, { status: 404 });

    // 如需限制“已有学期则不可删”，在这里先做 count 检查后返回 409
    await prisma.class.delete({ where: { id } });
    return NextResponse.json({ ok: true });
  } catch (e) {
    if (e instanceof Unauthorized)
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    return NextResponse.json({ error: "删除失败" }, { status: 500 });
  }
}
