import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth-options";
import { redirect } from "next/navigation";
import Link from "next/link";
import { prisma } from "@/lib/prisma";
import RenameForm from "./rename-form";
import ImportStudentsForm from "./import-students-form";
import StudentsList from "./students-list";
import TermEnrollments from "./term-enrollments";

export default async function ClassDetailPage({
  params,
}: {
  params: { id: string };
}) {
  const session = await getServerSession(authOptions);
  if (!session) redirect("/login");
  const teacherId = (session.user as any).teacherId as string;

  const cls = await prisma.class.findFirst({
    where: { id: params.id, teacherId },
    select: {
      id: true,
      name: true,
      createdAt: true,
      classTerms: {
        orderBy: { startDate: "desc" },
        select: {
          id: true,
          startDate: true,
          endDate: true,
          weekdays: true,
          perSessionFee: true,
          currency: true,
          semester: { select: { id: true, name: true } },
          _count: { select: { sessions: true, enrollments: true } },
        },
      },
      students: {
        orderBy: { name: "asc" },
        select: { id: true, name: true, createdAt: true },
      },
    },
  });

  if (!cls) redirect("/classes");

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-xl font-semibold">班级：{cls.name}</h1>
        <Link href="/classes" className="text-sm underline">
          返回班级列表
        </Link>
      </div>

      <section className="rounded-md border">
        <div className="p-4 border-b font-medium">重命名</div>
        <div className="p-4">
          <RenameForm id={cls.id} currentName={cls.name} />
        </div>
      </section>

      <section className="rounded-md border">
        <div className="p-4 border-b font-medium">
          已有学期安排（ClassTerm）
        </div>
        <div className="divide-y">
          {cls.classTerms.length === 0 && (
            <div className="p-4 text-sm text-muted-foreground">
              暂未创建学期安排。可在“某个学期详情页”中为此班级创建。
            </div>
          )}
          {cls.classTerms.map((t) => (
            <div key={t.id} className="p-4 space-y-3 border-b last:border-b-0">
              <div className="font-medium">{t.semester.name}</div>
              <div className="text-sm text-muted-foreground">
                {new Date(t.startDate).toLocaleDateString()} ~{" "}
                {new Date(t.endDate).toLocaleDateString()}
                {" · "}周{t.weekdays.join("、")}
                {" · "}单次 {t.perSessionFee.toString()} {t.currency}
              </div>
              <div className="text-xs text-muted-foreground">
                课次数：{t._count.sessions} · 已选学生：{t._count.enrollments}
              </div>

              {/* 这里是新增的入口按钮们 */}
              <div className="flex flex-wrap items-center gap-2">
                <Link
                  href={`/class-terms/${t.id}`}
                  className="border rounded-md px-3 py-1 text-sm"
                >
                  出勤矩阵
                </Link>

                <Link
                  href={`/semesters/${t.semester.id}`}
                  className="border rounded-md px-3 py-1 text-sm"
                >
                  去该学期
                </Link>

                {/* 可选：一键重新生成课次（幂等），需要时保留 */}
                {/* <form action={async () => {
        "use server";
        await fetch(`/api/class-terms/${t.id}/generate-sessions`, { method: "POST" });
      }}>
        <button type="submit" className="border rounded-md px-3 py-1 text-sm">
          重新生成课次
        </button>
      </form> */}
              </div>

              {/* 选课管理 */}
              <div className="mt-2">
                <div className="mb-1 font-medium text-sm">
                  选课管理（从本班学生中勾选）：
                </div>
                <TermEnrollments
                  classId={cls.id}
                  termId={t.id}
                  allStudents={cls.students}
                />
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="rounded-md border">
        <div className="p-4 border-b font-medium">学生管理</div>
        <div className="p-4 grid grid-cols-1 lg:grid-cols-2 gap-6">
          <div>
            <div className="mb-2 font-medium">批量导入</div>
            <ImportStudentsForm classId={cls.id} />
          </div>
          <div>
            <div className="mb-2 font-medium">学生列表</div>
            <StudentsList classId={cls.id} items={cls.students} />
          </div>
        </div>
      </section>
    </div>
  );
}
