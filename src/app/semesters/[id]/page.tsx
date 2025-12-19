import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth-options";
import { redirect } from "next/navigation";
import { prisma } from "@/lib/prisma";
import { Prisma } from "@prisma/client";
import { revalidatePath } from "next/cache";
import { enumerateWeekdayDates } from "@/lib/schedule";
import Link from "next/link";
import ClassTermForm from "./term-form";

function fmt(d?: Date | null) {
  if (!d) return "-";
  return new Date(d).toLocaleDateString();
}

export default async function SemesterDetailPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const session = await getServerSession(authOptions);
  if (!session) redirect("/login");
  const teacherId = (session.user as any).teacherId as string;

  // 学期信息
  const { id } = await params;
  const semester = await prisma.semester.findFirst({
    where: { id: id, teacherId },
    select: { id: true, name: true },
  });
  if (!semester) redirect("/dashboard");

  // 聚合本学期的范围
  const agg = await prisma.classTerm.aggregate({
    where: { semesterId: semester.id, class: { teacherId } },
    _min: { startDate: true },
    _max: { endDate: true },
  });

  // 本学期下的所有 ClassTerm（带一些统计）
  const terms = await prisma.classTerm.findMany({
    where: { semesterId: semester.id, class: { teacherId } },
    orderBy: { createdAt: "desc" },
    include: {
      class: { select: { id: true, name: true } },
      _count: { select: { sessions: true, enrollments: true } },
    },
  });

  // 老师自己的班级（表单下拉）
  const classes = await prisma.class.findMany({
    where: { teacherId },
    orderBy: { name: "asc" },
    select: { id: true, name: true },
  });

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-xl font-semibold">学期：{semester.name}</h1>
        <Link href="/dashboard" className="text-sm underline">
          返回
        </Link>
      </div>

      <div className="rounded-md border p-4">
        <div className="text-sm text-muted-foreground">
          本学期范围（由班级学期决定）：{fmt(agg._min.startDate)} ~{" "}
          {fmt(agg._max.endDate)}
        </div>
      </div>

      <section className="rounded-md border">
        <div className="p-4 border-b font-medium">
          为此学期创建“班级学期（ClassTerm）”
        </div>
        <div className="p-4">
          <ClassTermForm semesterId={semester.id} classes={classes} />
        </div>
      </section>

      <section className="rounded-md border">
        <div className="p-4 border-b font-medium">本学期的班级安排</div>
        <div className="divide-y">
          {terms.length === 0 && (
            <div className="p-4 text-sm text-muted-foreground">
              暂无安排，先在上面创建一个。
            </div>
          )}
          {terms.map((t) => (
            <TermRow key={t.id} term={t} />
          ))}
        </div>
      </section>
    </div>
  );
}

function TermRow({ term }: { term: any }) {
  // 生成课次
  async function generate() {
    "use server";
    const session = await getServerSession(authOptions);
    if (!session) throw new Error("未登录");
    const teacherId = (session.user as any).teacherId as string;

    const t = await prisma.classTerm.findFirst({
      where: { id: term.id, class: { teacherId } },
      select: {
        id: true,
        startDate: true,
        endDate: true,
        weekdays: true,
        semesterId: true,
      },
    });
    if (!t) throw new Error("不存在或无权限");

    const dates = enumerateWeekdayDates(t.startDate, t.endDate, t.weekdays);
    const ops = dates.map((d) =>
      prisma.classSession.upsert({
        where: { classTermId_date: { classTermId: t.id, date: d } },
        update: {},
        create: { classTermId: t.id, date: d },
      })
    );
    await prisma.$transaction(ops);

    revalidatePath(`/semesters/${t.semesterId}`);
  }

  // 修改单次费用
  async function updateFee(formData: FormData) {
    "use server";
    const session = await getServerSession(authOptions);
    if (!session) throw new Error("未登录");
    const teacherId = (session.user as any).teacherId as string;

    const feeStr = String(formData.get("perSessionFee") ?? "").trim();
    if (!feeStr) throw new Error("请输入费用");
    // 允许小数；>= 0
    const feeNum = Number(feeStr);
    if (!Number.isFinite(feeNum) || feeNum < 0)
      throw new Error("费用格式不合法");

    // 校验归属
    const t = await prisma.classTerm.findFirst({
      where: { id: term.id, class: { teacherId } },
      select: { id: true, semesterId: true },
    });
    if (!t) throw new Error("不存在或无权限");

    // 更新费用（Decimal）
    await prisma.classTerm.update({
      where: { id: t.id },
      data: { perSessionFee: new Prisma.Decimal(feeStr) },
    });

    revalidatePath(`/semesters/${t.semesterId}`);
  }

  // 删除班级学期（会级联删除课次/缺席/选课）
  async function remove() {
    "use server";
    const session = await getServerSession(authOptions);
    if (!session) throw new Error("未登录");
    const teacherId = (session.user as any).teacherId as string;

    const t = await prisma.classTerm.findFirst({
      where: { id: term.id, class: { teacherId } },
      select: { id: true, semesterId: true },
    });
    if (!t) throw new Error("不存在或无权限");

    await prisma.classTerm.delete({ where: { id: t.id } });
    revalidatePath(`/semesters/${t.semesterId}`);
  }

  return (
    <div className="p-4 flex items-center justify-between">
      <div className="space-y-1">
        <div className="font-medium">{term.class.name}</div>
        <div className="text-sm text-muted-foreground">
          {new Date(term.startDate).toLocaleDateString()} ~{" "}
          {new Date(term.endDate).toLocaleDateString()}
          {" · "}周{term.weekdays.join("、")}
          {" · "}单次 {term.perSessionFee.toString()} {term.currency}
        </div>
        <div className="text-xs text-muted-foreground">
          课次数：{term._count.sessions} · 已选学生：{term._count.enrollments}
        </div>
      </div>

      <div className="flex items-center gap-2">
        {/* 修改费用（小表单） */}
        <form action={updateFee} className="flex items-center gap-2">
          <input
            type="number"
            name="perSessionFee"
            step="0.01"
            min="0"
            defaultValue={term.perSessionFee.toString()}
            className="w-24 border rounded-md px-2 py-1 text-sm"
            title="单次课程费用"
          />
          <button type="submit" className="text-sm border rounded-md px-3 py-1">
            修改费用
          </button>
        </form>

        {/* 生成课次 */}
        <form action={generate}>
          <button type="submit" className="text-sm border rounded-md px-3 py-1">
            生成课次
          </button>
        </form>

        {/* 进入矩阵 / 结算 */}
        <Link
          href={`/class-terms/${term.id}`}
          className="text-sm border rounded-md px-3 py-1"
        >
          进入矩阵
        </Link>
        <Link
          href={`/class-terms/${term.id}/billing`}
          className="text-sm border rounded-md px-3 py-1"
        >
          结算
        </Link>

        {/* 删除按钮 */}
        <form action={remove}>
          <button
            type="submit"
            className="text-sm text-red-600 border rounded-md px-3 py-1"
          >
            删除
          </button>
        </form>
      </div>
    </div>
  );
}
