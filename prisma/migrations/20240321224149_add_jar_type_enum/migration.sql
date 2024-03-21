/*
  Warnings:

  - Added the required column `fundraisingId` to the `jars` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `jars` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "JarType" AS ENUM ('MAIN', 'SECONDARY');

-- AlterTable
ALTER TABLE "jars" ADD COLUMN     "fundraisingId" TEXT NOT NULL,
ADD COLUMN     "type" "JarType" NOT NULL;
