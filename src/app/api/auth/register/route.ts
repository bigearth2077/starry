import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { z } from "zod";
import bcrypt from "bcryptjs";

const RegisterSchema = z.object({
  email: z.string().email(),
  name: z.string().min(1).optional(),
  password: z.string().min(8, "密码至少8位"),
});

export async function POST(req: Request) {
  try {
    const body = await req.json();
    const data = RegisterSchema.parse(body);

    const exists = await prisma.teacher.findUnique({
      where: { email: data.email },
    });
    if (exists) {
      return NextResponse.json({ error: "该邮箱已被注册" }, { status: 409 });
    }

    const passwordHash = await bcrypt.hash(data.password, 12);

    const teacher = await prisma.teacher.create({
      data: {
        email: data.email,
        name: data.name ?? null,
        passwordHash,
      },
      select: { id: true, email: true, name: true, createdAt: true },
    });

    return NextResponse.json({ ok: true, teacher }, { status: 201 });
  } catch (err: any) {
    if (err?.name === "ZodError") {
      return NextResponse.json(
        { error: err.issues?.[0]?.message ?? "参数错误" },
        { status: 400 }
      );
    }
    return NextResponse.json({ error: "注册失败" }, { status: 500 });
  }
}
// 处理注册逻辑：验证参数、检查邮箱唯一、哈希密码、创建教师记录
