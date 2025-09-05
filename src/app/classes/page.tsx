import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth-options";
import { redirect } from "next/navigation";
import Link from "next/link";
import { prisma } from "@/lib/prisma";
import NewClassForm from "./new-form";


export default async function ClassesPage() {
  const session = await getServerSession(authOptions);
  if (!session) redirect("/login");
  const teacherId = (session.user as any).teacherId as string;

  const items = await prisma.class.findMany({
    where: { teacherId },
    orderBy: { name: "asc" },
    select: {
      id: true,
      name: true,
      createdAt: true,
      _count: { select: { classTerms: true } },
    },
  });

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-xl font-semibold">班级管理</h1>
        <Link href="/dashboard" className="text-sm underline">
          返回学期
        </Link>
      </div>

      <section className="rounded-md border">
        <div className="p-4 border-b font-medium">新建班级</div>
        <div className="p-4">
          <NewClassForm />
        </div>
      </section>

      <section className="rounded-md border">
        <div className="p-4 border-b font-medium">我的班级</div>
        <div className="divide-y">
          {items.length === 0 && (
            <div className="p-4 text-sm text-muted-foreground">
              还没有班级，先创建一个吧。
            </div>
          )}
          {items.map((c) => (
            <ClassRow key={c.id} c={c} />
          ))}
        </div>
      </section>
    </div>
  );
}

function ClassRow({ c }: { c: any }) {
  async function del() {
    "use server";
    await fetch(`/api/classes/${c.id}`, { method: "DELETE" });
  }

  return (
    <div className="p-4 flex items-center justify-between">
      <div className="space-y-1">
        <div className="font-medium">
          <Link href={`/classes/${c.id}`} className="underline">
            {c.name}
          </Link>
        </div>
        <div className="text-xs text-muted-foreground">
          已创建的学期安排：{c._count.classTerms}
        </div>
      </div>
      <form action={del}>
        <button className="text-sm text-red-600 hover:underline" type="submit">
          删除
        </button>
      </form>
    </div>
  );
}
