/*
  Warnings:

  - A unique constraint covering the columns `[classId,name]` on the table `Student` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `classId` to the `Student` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."Student" ADD COLUMN     "classId" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Student_classId_name_key" ON "public"."Student"("classId", "name");

-- AddForeignKey
ALTER TABLE "public"."Student" ADD CONSTRAINT "Student_classId_fkey" FOREIGN KEY ("classId") REFERENCES "public"."Class"("id") ON DELETE CASCADE ON UPDATE CASCADE;
