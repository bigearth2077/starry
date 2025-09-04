import { getServerSession } from "next-auth";
import { redirect } from "next/navigation";

export default async function DashboardPage() {
  const session = await getServerSession();
  if (!session) redirect("/login");

  return (
    <div className="p-4">
      <h1 className="text-xl font-semibold">
        欢迎，{session.user?.name || session.user?.email}
      </h1>
      <p className="text-sm text-muted-foreground mt-2">
        这是受保护的页面，后续在这里放“学期/班级”概览。
      </p>
    </div>
  );
}
// 仪表盘首页：保护路由，显示欢迎信息
