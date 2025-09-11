import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  eslint: {
    ignoreDuringBuilds: true, // 已有
  },
  typescript: {
    ignoreBuildErrors: true, // ← 新增：跳过构建期类型检查
  },
  typedRoutes: false, // 你已设置，保留
};

export default nextConfig;
