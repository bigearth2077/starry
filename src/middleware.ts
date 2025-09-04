import { withAuth } from "next-auth/middleware";
import type { NextRequest } from "next/server";

export default withAuth(
  // 你也可以在这里加 role 权限判断
  function middleware(req: NextRequest) {
    // 这里通常不用写逻辑，核心在下面 authorized 回调
  },
  {
    pages: {
      signIn: "/login",
    },
    callbacks: {
      authorized: ({ token, req }) => {
        const { pathname } = req.nextUrl;

        // 1) 放行认证端点
        if (pathname.startsWith("/api/auth")) return true;

        // 2) 其它受保护路径：要求已登录
        //   如果没有 token（未登录），NextAuth 会重定向到 /login
        return !!token;
      },
    },
  }
);

// 这里不要用负向前瞻，直接枚举需要保护的路径前缀
export const config = {
  matcher: [
    "/dashboard/:path*", // 你的受保护页面
    "/semesters/:path*",
    "/classes/:path*",
    "/api/:path*", // 保护所有 API ...
  ],
};
