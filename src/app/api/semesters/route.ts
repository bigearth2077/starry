// src/app/api/semesters/route.ts
import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";
import { z } from "zod";

const Body = z.object({ name: z.string().min(1) });

export async function POST(req: NextRequest) {
  try {
    const { teacherId } = await requireTeacher();
    const data = Body.parse(await req.json());
    const created = await prisma.semester.create({
      data: { teacherId, name: data.name },
    });
    return NextResponse.json(created, { status: 201 });
  } catch (e) {
    if (e instanceof Unauthorized)
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    return NextResponse.json({ error: "创建失败" }, { status: 500 });
  }
}
