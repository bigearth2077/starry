import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { requireTeacher, Unauthorized } from "@/lib/require-teacher";
import { z } from "zod";

const Body = z.object({
  dates: z.array(z.string().regex(/^\d{4}-\d{2}-\d{2}$/)).min(0),
});

function asUTCDate(isoDate: string) {
  // 以本地00:00为准也行，这里用 Date 构建，避免时区偏差导致的“前一天/后一天”问题
  const [y, m, d] = isoDate.split("-").map(Number);
  return new Date(Date.UTC(y, m - 1, d));
}

export async function PUT(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { teacherId } = await requireTeacher();
    const data = Body.parse(await req.json());

    const { id } = await params;
    const term = await prisma.classTerm.findFirst({
      where: { id: id, class: { teacherId } },
      select: { id: true },
    });
    if (!term)
      return NextResponse.json({ error: "不存在或无权限" }, { status: 404 });

    const existing = await prisma.classSession.findMany({
      where: { classTermId: term.id },
      select: { id: true, date: true },
    });

    const existingKey = new Map(
      existing.map((s) => [s.date.toISOString().slice(0, 10), s])
    );
    const desiredSet = new Set(data.dates);

    // 计算新增与删除
    const toCreateDates = data.dates.filter((d) => !existingKey.has(d));
    const toRemoveIds = existing
      .filter((s) => !desiredSet.has(s.date.toISOString().slice(0, 10)))
      .map((s) => s.id);

    if (toCreateDates.length > 0) {
      await prisma.classSession.createMany({
        data: toCreateDates.map((d) => ({
          classTermId: term.id,
          date: asUTCDate(d),
        })),
      });
    }
    if (toRemoveIds.length > 0) {
      await prisma.classSession.deleteMany({
        where: { id: { in: toRemoveIds } },
      });
    }

    const total = await prisma.classSession.count({
      where: { classTermId: term.id },
    });
    return NextResponse.json({
      added: toCreateDates.length,
      removed: toRemoveIds.length,
      total,
    });
  } catch (e) {
    if (e instanceof Unauthorized)
      return NextResponse.json({ error: "未登录" }, { status: 401 });
    return NextResponse.json({ error: "更新失败" }, { status: 500 });
  }
}
