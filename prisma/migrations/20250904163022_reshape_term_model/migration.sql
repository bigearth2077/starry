/*
  Warnings:

  - You are about to drop the column `perSessionFeeOverride` on the `Class` table. All the data in the column will be lost.
  - You are about to drop the column `semesterId` on the `Class` table. All the data in the column will be lost.
  - You are about to drop the column `weekdays` on the `Class` table. All the data in the column will be lost.
  - You are about to drop the column `classId` on the `ClassSession` table. All the data in the column will be lost.
  - You are about to drop the column `baseTuitionOverride` on the `Enrollment` table. All the data in the column will be lost.
  - You are about to drop the column `classId` on the `Enrollment` table. All the data in the column will be lost.
  - You are about to drop the column `baseTuition` on the `Semester` table. All the data in the column will be lost.
  - You are about to drop the column `currency` on the `Semester` table. All the data in the column will be lost.
  - You are about to drop the column `endDate` on the `Semester` table. All the data in the column will be lost.
  - You are about to drop the column `perSessionFee` on the `Semester` table. All the data in the column will be lost.
  - You are about to drop the column `startDate` on the `Semester` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[teacherId,name]` on the table `Class` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[classTermId,date]` on the table `ClassSession` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[studentId,classTermId]` on the table `Enrollment` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[teacherId,name]` on the table `Semester` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `classTermId` to the `ClassSession` table without a default value. This is not possible if the table is not empty.
  - Added the required column `classTermId` to the `Enrollment` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "public"."Class" DROP CONSTRAINT "Class_semesterId_fkey";

-- DropForeignKey
ALTER TABLE "public"."ClassSession" DROP CONSTRAINT "ClassSession_classId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Enrollment" DROP CONSTRAINT "Enrollment_classId_fkey";

-- DropIndex
DROP INDEX "public"."ClassSession_classId_date_key";

-- DropIndex
DROP INDEX "public"."Enrollment_studentId_classId_key";

-- AlterTable
ALTER TABLE "public"."Class" DROP COLUMN "perSessionFeeOverride",
DROP COLUMN "semesterId",
DROP COLUMN "weekdays";

-- AlterTable
ALTER TABLE "public"."ClassSession" DROP COLUMN "classId",
ADD COLUMN     "classTermId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "public"."Enrollment" DROP COLUMN "baseTuitionOverride",
DROP COLUMN "classId",
ADD COLUMN     "classTermId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "public"."Semester" DROP COLUMN "baseTuition",
DROP COLUMN "currency",
DROP COLUMN "endDate",
DROP COLUMN "perSessionFee",
DROP COLUMN "startDate";

-- CreateTable
CREATE TABLE "public"."ClassTerm" (
    "id" TEXT NOT NULL,
    "classId" TEXT NOT NULL,
    "semesterId" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "weekdays" INTEGER[],
    "perSessionFee" DECIMAL(10,2) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'CNY',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ClassTerm_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ClassTerm_classId_semesterId_startDate_endDate_key" ON "public"."ClassTerm"("classId", "semesterId", "startDate", "endDate");

-- CreateIndex
CREATE UNIQUE INDEX "Class_teacherId_name_key" ON "public"."Class"("teacherId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "ClassSession_classTermId_date_key" ON "public"."ClassSession"("classTermId", "date");

-- CreateIndex
CREATE UNIQUE INDEX "Enrollment_studentId_classTermId_key" ON "public"."Enrollment"("studentId", "classTermId");

-- CreateIndex
CREATE UNIQUE INDEX "Semester_teacherId_name_key" ON "public"."Semester"("teacherId", "name");

-- AddForeignKey
ALTER TABLE "public"."ClassTerm" ADD CONSTRAINT "ClassTerm_classId_fkey" FOREIGN KEY ("classId") REFERENCES "public"."Class"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ClassTerm" ADD CONSTRAINT "ClassTerm_semesterId_fkey" FOREIGN KEY ("semesterId") REFERENCES "public"."Semester"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ClassSession" ADD CONSTRAINT "ClassSession_classTermId_fkey" FOREIGN KEY ("classTermId") REFERENCES "public"."ClassTerm"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Enrollment" ADD CONSTRAINT "Enrollment_classTermId_fkey" FOREIGN KEY ("classTermId") REFERENCES "public"."ClassTerm"("id") ON DELETE CASCADE ON UPDATE CASCADE;
