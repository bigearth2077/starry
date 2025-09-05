import { prisma } from "@/lib/prisma";
import { Decimal } from "@prisma/client/runtime/library";

export async function computeClassTermBilling(
  termId: string,
  teacherId: string
) {
  const term = await prisma.classTerm.findFirst({
    where: { id: termId, class: { teacherId } },
    include: {
      class: { select: { id: true, name: true } },
      semester: { select: { id: true, name: true } },
      sessions: { include: { absences: true } },
      enrollments: {
        include: { student: { select: { id: true, name: true } } },
      },
    },
  });
  if (!term) throw new Error("ClassTerm not found or no access");

  const perFee = new Decimal(term.perSessionFee.toString());
  const totalSessions = term.sessions.length;

  // 缺席计数
  const absents = new Map<string, number>();
  for (const s of term.sessions) {
    for (const a of s.absences) {
      absents.set(a.studentId, (absents.get(a.studentId) ?? 0) + 1);
    }
  }

  const rows = term.enrollments
    .map((enr) => {
      const studentId = enr.student.id;
      const studentName = enr.student.name;
      const a = absents.get(studentId) ?? 0;
      const attended = Math.max(0, totalSessions - a);
      const payable = perFee.mul(attended);
      return {
        studentId,
        studentName,
        totalSessions,
        absences: a,
        attended,
        perSessionFee: perFee.toString(), // 字符串，避免精度丢失
        payable: payable.toString(),
        currency: term.currency,
      };
    })
    .sort((x, y) => x.studentName.localeCompare(y.studentName));

  const classTermTotal = rows.reduce((sum, r) => sum + Number(r.payable), 0);

  return {
    termMeta: {
      id: term.id,
      className: term.class.name,
      semesterName: term.semester.name,
      span: { start: term.startDate, end: term.endDate },
      perSessionFee: perFee.toString(),
      currency: term.currency,
      totalSessions,
      studentCount: rows.length,
    },
    rows,
    classTermTotal,
    // 供矩阵导出使用
    sessions: term.sessions
      .map((s) => ({ id: s.id, date: s.date }))
      .sort((a, b) => a.date.getTime() - b.date.getTime()),
    enrollments: term.enrollments.map((e) => ({
      id: e.student.id,
      name: e.student.name,
    })),
    absencesRaw: term.sessions.flatMap((s) =>
      s.absences.map((a) => ({ sessionId: s.id, studentId: a.studentId }))
    ),
  };
}
