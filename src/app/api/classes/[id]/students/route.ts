// src/app/api/classes/[id]/students/route.ts   ← 注意路径名与 [id] 一致
import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";
import { z } from "zod";

export const runtime = "nodejs";

const ImportBody = z.object({
  text: z.string().min(1, "请输入至少一个名字"),
});

function normalizeLine(s: string) {
  const trimmed = s.trim();
  if (!trimmed) return "";
  const filtered = trimmed.replace(/[^A-Za-z.\-\s]/g, "");
  return filtered.replace(/\s+/g, " ");
}

// GET: 列出该班学生
export async function GET(
  _: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { teacherId } = await requireTeacher();
    const { id } = await params; // ← 这里是 id，不是 classId

    // 班级归属校验（按老师）
    const cls = await prisma.class.findFirst({
      where: { id, teacherId },
      select: { id: true },
    });
    if (!cls) {
      return NextResponse.json(
        { error: "班级不存在或无权限" },
        { status: 404 }
      );
    }

    const items = await prisma.student.findMany({
      where: { classId: cls.id, class: { teacherId } }, // 收紧到当前老师
      orderBy: { name: "asc" },
      select: { id: true, name: true, createdAt: true },
    });
    return NextResponse.json({ items });
  } catch {
    return NextResponse.json({ error: "未登录" }, { status: 401 });
  }
}

// POST: 批量导入
export async function POST(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { teacherId } = await requireTeacher();
    const { id } = await params; // ← 这里是 id，不是 classId
    const data = ImportBody.parse(await req.json());

    // 班级归属校验（按老师）
    const cls = await prisma.class.findFirst({
      where: { id, teacherId },
      select: { id: true },
    });
    if (!cls) {
      return NextResponse.json(
        { error: "班级不存在或无权限" },
        { status: 404 }
      );
    }

    const names = Array.from(
      new Set(data.text.split(/\r?\n/).map(normalizeLine).filter(Boolean))
    );

    if (names.length === 0) {
      return NextResponse.json({ error: "没有有效的名字" }, { status: 400 });
    }

    // 已有重名（同班）
    const existing = await prisma.student.findMany({
      where: { classId: cls.id, name: { in: names } },
      select: { name: true },
    });
    const existingSet = new Set(existing.map((e) => e.name));

    const toCreate = names.filter((n) => !existingSet.has(n));
    if (toCreate.length > 0) {
      await prisma.student.createMany({
        data: toCreate.map((n) => ({ classId: cls.id, name: n })),
      });
    }

    return NextResponse.json({
      imported: toCreate.length,
      skipped: names.length - toCreate.length,
    });
  } catch (e) {
    if (e instanceof Unauthorized) {
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    }
    return NextResponse.json({ error: "导入失败" }, { status: 500 });
  }
}
