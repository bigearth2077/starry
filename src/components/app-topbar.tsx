"use client";

import { signOut } from "next-auth/react";
import Link from "next/link";

export default function AppTopbar() {
  return (
    <header className="w-full border-b">
      <div className="mx-auto max-w-4xl px-4 h-14 flex items-center justify-between">
        <Link href="/dashboard" className="font-semibold">
          记账出勤 · 老师端
        </Link>
        <nav className="flex items-center gap-3">
          <Link href="/dashboard" className="text-sm">
            学期
          </Link>
          <Link href="/classes" className="text-sm">
            班级
          </Link>
          {/* 以后加：班级、报表 */}
          <button
            onClick={() => signOut({ callbackUrl: "/login" })}
            className="text-sm border rounded-md px-3 py-1"
          >
            退出
          </button>
        </nav>
      </div>
    </header>
  );
}
// 顶部导航栏：品牌、导航链接、退出登录按钮
