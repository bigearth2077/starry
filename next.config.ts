import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  /* config options here */
  eslint: {
    // 生产构建时忽略 ESLint（代码仍会在本地或CI跑 lint）
    ignoreDuringBuilds: true,
  },
  typedRoutes: false,
};

export default nextConfig;
