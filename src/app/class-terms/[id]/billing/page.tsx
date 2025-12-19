import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth-options";
import { redirect } from "next/navigation";
import { computeClassTermBilling } from "@/lib/billing";
import Link from "next/link";

function fmtDate(d: Date) {
  return new Date(d).toLocaleDateString();
}

export default async function BillingPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const session = await getServerSession(authOptions);
  if (!session) redirect("/login");
  const teacherId = (session.user as any).teacherId as string;

  const { termMeta, rows, classTermTotal } = await computeClassTermBilling(
    id,
    teacherId
  );

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-xl font-semibold">
            结算 · {termMeta.className} · {termMeta.semesterName}
          </h1>
          <p className="text-sm text-muted-foreground">
            {fmtDate(termMeta.span.start)} ~ {fmtDate(termMeta.span.end)} · 单次{" "}
            {termMeta.perSessionFee} {termMeta.currency}
            {" · "}课次 {termMeta.totalSessions} · 学生 {termMeta.studentCount}
          </p>
        </div>
        <div className="flex gap-2">
          <Link
            className="border rounded-md px-3 py-2 text-sm"
            href={`/api/class-terms/${termMeta.id}/export/billing`}
          >
            导出学生结算.xlsx
          </Link>
          <Link
            className="border rounded-md px-3 py-2 text-sm"
            href={`/api/class-terms/${termMeta.id}/export/matrix`}
          >
            导出点名矩阵.xlsx
          </Link>
        </div>
      </div>

      <div className="overflow-auto border rounded-md">
        <table className="min-w-[720px] w-full">
          <thead className="bg-gray-50">
            <tr className="text-left">
              <th className="px-3 py-2 border-b">学生</th>
              <th className="px-3 py-2 border-b">总课次</th>
              <th className="px-3 py-2 border-b">缺席</th>
              <th className="px-3 py-2 border-b">出勤</th>
              <th className="px-3 py-2 border-b">单次费用</th>
              <th className="px-3 py-2 border-b">应收</th>
            </tr>
          </thead>
          <tbody>
            {rows.length === 0 && (
              <tr>
                <td
                  className="px-3 py-3 text-sm text-muted-foreground"
                  colSpan={6}
                >
                  该班级学期暂无学生或暂无课次。
                </td>
              </tr>
            )}
            {rows.map((r) => (
              <tr key={r.studentId} className="border-b">
                <td className="px-3 py-2">{r.studentName}</td>
                <td className="px-3 py-2">{r.totalSessions}</td>
                <td className="px-3 py-2">{r.absences}</td>
                <td className="px-3 py-2">{r.attended}</td>
                <td className="px-3 py-2">
                  {r.perSessionFee} {r.currency}
                </td>
                <td className="px-3 py-2">
                  {r.payable} {r.currency}
                </td>
              </tr>
            ))}
          </tbody>
          <tfoot>
            <tr className="bg-gray-50">
              <td className="px-3 py-2 font-medium" colSpan={5}>
                合计
              </td>
              <td className="px-3 py-2 font-medium">
                {classTermTotal} {termMeta.currency}
              </td>
            </tr>
          </tfoot>
        </table>
      </div>

      <div>
        <Link
          href={`/class-terms/${termMeta.id}`}
          className="text-sm underline"
        >
          返回出勤矩阵
        </Link>
      </div>
    </div>
  );
}
