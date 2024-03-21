/*
  Warnings:

  - You are about to drop the column `fundraisingId` on the `Jar` table. All the data in the column will be lost.
  - You are about to drop the `UserFundraising` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[participantId]` on the table `Jar` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `participantId` to the `Jar` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Jar" DROP CONSTRAINT "Jar_fundraisingId_fkey";

-- DropForeignKey
ALTER TABLE "UserFundraising" DROP CONSTRAINT "UserFundraising_fundraisingId_fkey";

-- DropForeignKey
ALTER TABLE "UserFundraising" DROP CONSTRAINT "UserFundraising_userId_fkey";

-- DropIndex
DROP INDEX "Jar_fundraisingId_key";

-- AlterTable
ALTER TABLE "Jar" DROP COLUMN "fundraisingId",
ADD COLUMN     "participantId" TEXT NOT NULL;

-- DropTable
DROP TABLE "UserFundraising";

-- CreateTable
CREATE TABLE "Participant" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "socialMedia" TEXT[],
    "goal" DOUBLE PRECISION NOT NULL,
    "fundraisingName" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "photos" TEXT[],
    "planningRaffles" BOOLEAN NOT NULL,
    "collectedTotal" DOUBLE PRECISION NOT NULL,
    "fundraisingId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Participant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_FundraisingToUser" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Participant_id_key" ON "Participant"("id");

-- CreateIndex
CREATE UNIQUE INDEX "_FundraisingToUser_AB_unique" ON "_FundraisingToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_FundraisingToUser_B_index" ON "_FundraisingToUser"("B");

-- CreateIndex
CREATE UNIQUE INDEX "Jar_participantId_key" ON "Jar"("participantId");

-- AddForeignKey
ALTER TABLE "Participant" ADD CONSTRAINT "Participant_fundraisingId_fkey" FOREIGN KEY ("fundraisingId") REFERENCES "Fundraising"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Jar" ADD CONSTRAINT "Jar_participantId_fkey" FOREIGN KEY ("participantId") REFERENCES "Participant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FundraisingToUser" ADD CONSTRAINT "_FundraisingToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "Fundraising"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FundraisingToUser" ADD CONSTRAINT "_FundraisingToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
