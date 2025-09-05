import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth-options";

export class Unauthorized extends Error {}

export async function requireTeacher() {
  const session = await getServerSession(authOptions);
  if (!session || !(session.user as any)?.teacherId) {
    throw new Unauthorized("Unauthorized");
  }
  const teacherId = (session.user as any).teacherId as string;
  return { teacherId, session };
}
