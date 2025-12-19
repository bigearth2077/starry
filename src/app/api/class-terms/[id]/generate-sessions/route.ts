// src/app/api/class-terms/[id]/generate-sessions/route.ts
import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";
import { enumerateWeekdayDates } from "@/lib/schedule";

export async function POST(
  _: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { teacherId } = await requireTeacher();

    const { id } = await params;
    const term = await prisma.classTerm.findFirst({
      where: { id: id, class: { teacherId } },
      select: { id: true, startDate: true, endDate: true, weekdays: true },
    });
    if (!term)
      return NextResponse.json({ error: "不存在或无权限" }, { status: 404 });

    const dates = enumerateWeekdayDates(
      term.startDate,
      term.endDate,
      term.weekdays
    );
    const ops = dates.map((d) =>
      prisma.classSession.upsert({
        where: { classTermId_date: { classTermId: term.id, date: d } },
        update: {},
        create: { classTermId: term.id, date: d },
      })
    );
    await prisma.$transaction(ops);

    // 返回当前总节数
    const total = await prisma.classSession.count({
      where: { classTermId: term.id },
    });
    return NextResponse.json({ created: dates.length, total });
  } catch (e) {
    if (e instanceof Unauthorized)
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    return NextResponse.json({ error: "生成失败" }, { status: 500 });
  }
}
