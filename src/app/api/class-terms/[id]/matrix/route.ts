import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";

export async function GET(
  _: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { teacherId } = await requireTeacher();

    const { id } = await params;

    const term = await prisma.classTerm.findFirst({
      where: { id: id, class: { teacherId } },
      select: {
        id: true,
        startDate: true,
        endDate: true,
        weekdays: true,
        perSessionFee: true,
        currency: true,
        class: { select: { id: true, name: true } },
        semester: { select: { id: true, name: true } },
      },
    });
    if (!term)
      return NextResponse.json({ error: "不存在或无权限" }, { status: 404 });

    const sessions = await prisma.classSession.findMany({
      where: { classTermId: term.id },
      orderBy: { date: "asc" },
      select: { id: true, date: true },
    });

    const students = await prisma.enrollment.findMany({
      where: { classTermId: term.id },
      select: { student: { select: { id: true, name: true } } },
      orderBy: { student: { name: "asc" } },
    });

    const absences = await prisma.absence.findMany({
      where: { session: { classTermId: term.id } },
      select: { sessionId: true, studentId: true },
    });

    return NextResponse.json({
      term,
      sessions,
      students: students.map((s) => s.student),
      absences,
    });
  } catch (e) {
    if (e instanceof Unauthorized)
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    return NextResponse.json({ error: "加载失败" }, { status: 500 });
  }
}
