import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";
import { z } from "zod";

const CreateBody = z.object({ name: z.string().min(1) });

export async function POST(req: NextRequest) {
  try {
    const { teacherId } = await requireTeacher();
    const data = CreateBody.parse(await req.json());

    const exists = await prisma.class.findFirst({
      where: { teacherId, name: data.name },
      select: { id: true },
    });
    if (exists) {
      return NextResponse.json({ error: "同名班级已存在" }, { status: 409 });
    }

    const created = await prisma.class.create({
      data: { teacherId, name: data.name },
      select: { id: true, name: true, createdAt: true },
    });
    return NextResponse.json(created, { status: 201 });
  } catch (e) {
    if (e instanceof Unauthorized)
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    return NextResponse.json({ error: "创建失败" }, { status: 500 });
  }
}

export async function GET() {
  try {
    const { teacherId } = await requireTeacher();
    const items = await prisma.class.findMany({
      where: { teacherId },
      orderBy: { name: "asc" },
      select: {
        id: true,
        name: true,
        createdAt: true,
        _count: { select: { classTerms: true } }, // 展示该班级下已有多少个学期安排
      },
    });
    return NextResponse.json({ items });
  } catch {
    return NextResponse.json({ error: "未登录" }, { status: 401 });
  }
}
