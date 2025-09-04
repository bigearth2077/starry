/*
  Warnings:

  - Added the required column `passwordHash` to the `Teacher` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."Teacher" ADD COLUMN     "passwordHash" TEXT NOT NULL;
