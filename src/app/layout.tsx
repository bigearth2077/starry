import "./globals.css";
import { Providers } from "./providers";
import AppTopbar from "@/components/app-topbar";

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="zh-CN">
      <body>
        <Providers>
          <AppTopbar />
          <main className="mx-auto max-w-4xl px-4 py-6">{children}</main>
        </Providers>
      </body>
    </html>
  );
}
// 根布局：引入全局样式、提供者组件、顶部导航栏
