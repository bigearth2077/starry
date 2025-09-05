// src/app/(dashboard)/page.tsx
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth-options";
import { redirect } from "next/navigation";
import Link from "next/link";
import { prisma } from "@/lib/prisma";
import { revalidatePath } from "next/cache";

export default async function DashboardPage() {
  const session = await getServerSession(authOptions);
  if (!session) redirect("/login");
  const teacherId = (session.user as any).teacherId as string;

  // 学期基础信息
  const items = await prisma.semester.findMany({
    where: { teacherId },
    orderBy: { createdAt: "desc" },
    select: { id: true, name: true },
  });

  // 计算每个学期由 ClassTerm 聚合得到的起止范围
  const withRanges = await Promise.all(
    items.map(async (s) => {
      const agg = await prisma.classTerm.aggregate({
        where: { semesterId: s.id, class: { teacherId } },
        _min: { startDate: true },
        _max: { endDate: true },
      });
      return {
        ...s,
        startDateMin: agg._min.startDate ?? null,
        endDateMax: agg._max.endDate ?? null,
      };
    })
  );

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="text-xl font-semibold">学期</h1>
        <Link
          href="/semesters/new"
          className="border rounded-md px-3 py-2 text-sm"
        >
          新建学期
        </Link>
      </div>

      <div className="divide-y border rounded-md">
        {withRanges.length === 0 && (
          <div className="p-4 text-sm text-muted-foreground">
            暂无学期，先创建一个吧。
          </div>
        )}
        {withRanges.map((sem) => (
          <SemesterRow key={sem.id} sem={sem} />
        ))}
      </div>
    </div>
  );
}

function formatDateMaybe(d: string | Date | null | undefined) {
  if (!d) return "-";
  const date = new Date(d);
  return isNaN(date.getTime()) ? "-" : date.toLocaleDateString();
}

function SemesterRow({ sem }: { sem: any }) {
  async function onDelete() {
    "use server";
    const session = await getServerSession(authOptions);
    if (!session) {
      // 未登录直接返回，或抛错
      return;
    }
    const teacherId = (session.user as any).teacherId as string;

    // 权限校验：只能删除自己的学期
    const owned = await prisma.semester.findFirst({
      where: { id: sem.id, teacherId },
      select: { id: true },
    });
    if (!owned) {
      // 也可以 throw new Error("无权限");
      return;
    }

    await prisma.semester.delete({ where: { id: sem.id } });

    // 刷新 /dashboard 列表
    revalidatePath("/dashboard");
  }

  return (
    <div className="p-4 flex items-center justify-between">
      <div className="space-y-1">
        <div className="font-medium">
          <Link href={`/semesters/${sem.id}`} className="hover:underline">
            {sem.name}
          </Link>
        </div>
        <div className="text-sm text-muted-foreground">
          学期范围：{formatDateMaybe(sem.startDateMin)} ~{" "}
          {formatDateMaybe(sem.endDateMax)}
        </div>
      </div>
      <div className="flex items-center gap-3">
        <Link href={`/semesters/${sem.id}`} className="text-sm underline">
          详情
        </Link>
        <form action={onDelete}>
          <button
            className="text-sm text-red-600 hover:underline"
            type="submit"
          >
            删除
          </button>
        </form>
      </div>
    </div>
  );
}
