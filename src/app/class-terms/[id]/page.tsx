import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth-options";
import { redirect } from "next/navigation";
import Link from "next/link";
import { prisma } from "@/lib/prisma";
import AttendanceMatrix from "./ui/attendance-matrix";
import ManageSessionsDialog from "./ui/manage-sessions-dialog";

export default async function ClassTermPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const session = await getServerSession(authOptions);
  if (!session) redirect("/login");
  const teacherId = (session.user as any).teacherId as string;

  const term = await prisma.classTerm.findFirst({
    where: { id: id, class: { teacherId } },
    select: {
      id: true,
      startDate: true,
      endDate: true,
      weekdays: true,
      perSessionFee: true,
      currency: true,
      class: { select: { id: true, name: true } },
      semester: { select: { id: true, name: true } },
      _count: { select: { sessions: true, enrollments: true } },
    },
  });
  if (!term) redirect("/dashboard");

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-xl font-semibold">
            {term.class.name} · {term.semester.name}
          </h1>
          <p className="text-sm text-muted-foreground">
            {new Date(term.startDate).toLocaleDateString()} ~{" "}
            {new Date(term.endDate).toLocaleDateString()}
            {" · "}周{term.weekdays.join("、")} · 单次{" "}
            {term.perSessionFee.toString()} {term.currency}
            {" · "}课次数：{term._count.sessions} · 学生：
            {term._count.enrollments}
          </p>
        </div>
        <Link
          className="border rounded-md px-3 py-2 text-sm"
          href={`/class-terms/${term.id}/billing`}
        >
          结算
        </Link>

        <ManageSessionsDialog
          termId={term.id}
          startDate={term.startDate}
          endDate={term.endDate}
        />
      </div>

      {/* 出勤矩阵 */}
      <AttendanceMatrix termId={term.id} />
    </div>
  );
}
