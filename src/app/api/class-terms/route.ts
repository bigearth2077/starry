// src/app/api/class-terms/route.ts
import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";
import { z } from "zod";

const Body = z.object({
  classId: z.string(),
  semesterId: z.string(),
  startDate: z.string(),
  endDate: z.string(),
  weekdays: z.array(z.number().int().min(0).max(6)).min(1),
  perSessionFee: z.string(),
  currency: z.string().default("CNY"),
});

export async function POST(req: NextRequest) {
  try {
    const { teacherId } = await requireTeacher();
    const data = Body.parse(await req.json());

    const ownClass = await prisma.class.findFirst({
      where: { id: data.classId, teacherId },
      select: { id: true },
    });
    if (!ownClass)
      return NextResponse.json(
        { error: "班级不存在或无权限" },
        { status: 404 }
      );

    const ownSem = await prisma.semester.findFirst({
      where: { id: data.semesterId, teacherId },
      select: { id: true },
    });
    if (!ownSem)
      return NextResponse.json(
        { error: "学期不存在或无权限" },
        { status: 404 }
      );

    const created = await prisma.classTerm.create({
      data: {
        classId: data.classId,
        semesterId: data.semesterId,
        startDate: new Date(data.startDate),
        endDate: new Date(data.endDate),
        weekdays: data.weekdays,
        perSessionFee: data.perSessionFee,
        currency: data.currency,
      },
    });

    return NextResponse.json(created, { status: 201 });
  } catch (e) {
    if (e instanceof Unauthorized)
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    return NextResponse.json({ error: "创建失败" }, { status: 500 });
  }
}
