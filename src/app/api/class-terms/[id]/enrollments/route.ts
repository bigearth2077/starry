import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";
import { z } from "zod";

// GET: 列出该 term 已选学生
export async function GET(
  _: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const { teacherId } = await requireTeacher();

    // 校验 term 归属（通过 class.teacherId）
    const term = await prisma.classTerm.findFirst({
      where: { id: params.id, class: { teacherId } },
      select: { id: true, classId: true },
    });
    if (!term)
      return NextResponse.json({ error: "不存在或无权限" }, { status: 404 });

    const items = await prisma.enrollment.findMany({
      where: { classTermId: term.id },
      select: {
        studentId: true,
        student: { select: { id: true, name: true } },
      },
      orderBy: { student: { name: "asc" } },
    });

    return NextResponse.json({
      items: items.map((e) => ({ id: e.student.id, name: e.student.name })),
    });
  } catch {
    return NextResponse.json({ error: "未登录" }, { status: 401 });
  }
}

const Body = z.object({
  studentIds: z.array(z.string()).min(1),
});

// POST: 批量添加选课（幂等，已存在的跳过）
export async function POST(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const { teacherId } = await requireTeacher();
    const data = Body.parse(await req.json());

    const term = await prisma.classTerm.findFirst({
      where: { id: params.id, class: { teacherId } },
      select: { id: true, classId: true },
    });
    if (!term)
      return NextResponse.json({ error: "不存在或无权限" }, { status: 404 });

    // 只允许添加“本班”的学生
    const validStudents = await prisma.student.findMany({
      where: { id: { in: data.studentIds }, classId: term.classId },
      select: { id: true },
    });
    const validIds = new Set(validStudents.map((s) => s.id));
    const toAdd = Array.from(validIds).map((id) => ({
      classTermId: term.id,
      studentId: id,
    }));

    if (toAdd.length === 0)
      return NextResponse.json({ added: 0, skipped: data.studentIds.length });

    // 过滤掉已存在的
    const existing = await prisma.enrollment.findMany({
      where: { classTermId: term.id, studentId: { in: Array.from(validIds) } },
      select: { studentId: true },
    });
    const existSet = new Set(existing.map((e) => e.studentId));
    const finalAdd = toAdd.filter((x) => !existSet.has(x.studentId));

    if (finalAdd.length > 0) {
      await prisma.enrollment.createMany({
        data: finalAdd,
        skipDuplicates: true,
      });
    }

    return NextResponse.json({
      added: finalAdd.length,
      skipped: data.studentIds.length - finalAdd.length,
    });
  } catch (e) {
    if (e instanceof Unauthorized)
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    return NextResponse.json({ error: "添加失败" }, { status: 500 });
  }
}

// DELETE: 批量移除选课（不存在的忽略）
export async function DELETE(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const { teacherId } = await requireTeacher();
    const data = Body.parse(await req.json());

    const term = await prisma.classTerm.findFirst({
      where: { id: params.id, class: { teacherId } },
      select: { id: true, classId: true },
    });
    if (!term)
      return NextResponse.json({ error: "不存在或无权限" }, { status: 404 });

    // 仅移除本班学生（防御性）
    const validStudents = await prisma.student.findMany({
      where: { id: { in: data.studentIds }, classId: term.classId },
      select: { id: true },
    });

    const r = await prisma.enrollment.deleteMany({
      where: {
        classTermId: term.id,
        studentId: { in: validStudents.map((s) => s.id) },
      },
    });

    return NextResponse.json({ removed: r.count });
  } catch (e) {
    if (e instanceof Unauthorized)
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    return NextResponse.json({ error: "移除失败" }, { status: 500 });
  }
}
