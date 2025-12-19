import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";
import { z } from "zod";

const Body = z.object({ studentId: z.string() });

export async function POST(
  req: NextRequest,
  { params }: { params: Promise<{ sessionId: string }> }
) {
  try {
    const { teacherId } = await requireTeacher();
    const { studentId } = Body.parse(await req.json());

    // 权限校验：session 归属 & 学生须是该 term 的学生
    const session = await prisma.classSession.findFirst({
      where: {
        id: (await params).sessionId,
        classTerm: { class: { teacherId } },
      },
      select: { id: true, classTermId: true },
    });
    if (!session)
      return NextResponse.json({ error: "不存在或无权限" }, { status: 404 });

    const enrolled = await prisma.enrollment.findFirst({
      where: { classTermId: session.classTermId, studentId },
      select: { studentId: true },
    });
    if (!enrolled)
      return NextResponse.json(
        { error: "该学生未在此班级学期选课" },
        { status: 400 }
      );

    const existing = await prisma.absence.findUnique({
      where: { sessionId_studentId: { sessionId: session.id, studentId } },
      select: { id: true },
    });

    if (existing) {
      await prisma.absence.delete({ where: { id: existing.id } });
      return NextResponse.json({ absent: false });
    } else {
      await prisma.absence.create({
        data: { sessionId: session.id, studentId },
      });
      return NextResponse.json({ absent: true });
    }
  } catch (e) {
    if (e instanceof Unauthorized)
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    return NextResponse.json({ error: "切换失败" }, { status: 500 });
  }
}
