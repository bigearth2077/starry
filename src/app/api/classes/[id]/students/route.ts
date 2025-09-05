import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";
import { z } from "zod";

// GET: 列出该班学生
export async function GET(
  _: NextRequest,
  { params }: { params: { classId: string } }
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

    const items = await prisma.student.findMany({
      where: { classId: cls.id },
      orderBy: { name: "asc" },
      select: { id: true, name: true, createdAt: true },
    });
    return NextResponse.json({ items });
  } catch {
    return NextResponse.json({ error: "未登录" }, { status: 401 });
  }
}

// POST: 批量导入（纯文本，每行一个名字）
const ImportBody = z.object({
  text: z.string().min(1, "请输入至少一个名字"),
});

function normalizeLine(s: string) {
  // 去前后空白，中间多空格压缩为单空格；仅保留字母/空格/连字符/点
  const trimmed = s.trim();
  if (!trimmed) return "";
  // 你可以根据需要更严格：这里只允许 A-Z a-z 空格 - .
  const filtered = trimmed.replace(/[^A-Za-z.\-\s]/g, "");
  return filtered.replace(/\s+/g, " ");
}

export async function POST(
  req: NextRequest,
  { params }: { params: { classId: string } }
) {
  try {
    const { teacherId } = await requireTeacher();
    const data = ImportBody.parse(await req.json());

    // 班级归属校验
    const cls = await prisma.class.findFirst({
      where: { id: params.classId, teacherId },
      select: { id: true },
    });
    if (!cls)
      return NextResponse.json(
        { error: "班级不存在或无权限" },
        { status: 404 }
      );

    // 解析行
    const lines = data.text.split(/\r?\n/);
    const names = Array.from(new Set(lines.map(normalizeLine).filter(Boolean)));

    if (names.length === 0) {
      return NextResponse.json({ error: "没有有效的名字" }, { status: 400 });
    }

    // 读已有重名，避免报错
    const existing = await prisma.student.findMany({
      where: { classId: cls.id, name: { in: names } },
      select: { name: true },
    });
    const existingSet = new Set(existing.map((e) => e.name));
    const toCreate = names.filter((n) => !existingSet.has(n));

    if (toCreate.length === 0) {
      return NextResponse.json({ imported: 0, skipped: names.length });
    }

    await prisma.student.createMany({
      data: toCreate.map((n) => ({ classId: cls.id, name: n })),
    });

    return NextResponse.json({
      imported: toCreate.length,
      skipped: names.length - toCreate.length,
    });
  } catch (e) {
    if (e instanceof Unauthorized)
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    return NextResponse.json({ error: "导入失败" }, { status: 500 });
  }
}
