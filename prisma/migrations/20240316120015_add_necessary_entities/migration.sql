/*
  Warnings:

  - A unique constraint covering the columns `[monobankJarId]` on the table `Jar` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[monobankLongJarId]` on the table `Jar` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[fundraisingId]` on the table `Jar` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `amount` to the `Jar` table without a default value. This is not possible if the table is not empty.
  - Added the required column `blago` to the `Jar` table without a default value. This is not possible if the table is not empty.
  - Added the required column `closed` to the `Jar` table without a default value. This is not possible if the table is not empty.
  - Added the required column `currency` to the `Jar` table without a default value. This is not possible if the table is not empty.
  - Added the required column `description` to the `Jar` table without a default value. This is not possible if the table is not empty.
  - Added the required column `fundraisingId` to the `Jar` table without a default value. This is not possible if the table is not empty.
  - Added the required column `goal` to the `Jar` table without a default value. This is not possible if the table is not empty.
  - Added the required column `monobankJarId` to the `Jar` table without a default value. This is not possible if the table is not empty.
  - Added the required column `monobankLongJarId` to the `Jar` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ownerFullName` to the `Jar` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ownerIcon` to the `Jar` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ownerName` to the `Jar` table without a default value. This is not possible if the table is not empty.
  - Added the required column `title` to the `Jar` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `role` on the `User` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('ADMIN', 'MODERATOR', 'PARTICIPANT', 'VIEWER');

-- AlterTable
ALTER TABLE "Jar" ADD COLUMN     "amount" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "blago" BOOLEAN NOT NULL,
ADD COLUMN     "closed" BOOLEAN NOT NULL,
ADD COLUMN     "currency" INTEGER NOT NULL,
ADD COLUMN     "description" TEXT NOT NULL,
ADD COLUMN     "fundraisingId" TEXT NOT NULL,
ADD COLUMN     "goal" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "monobankJarId" TEXT NOT NULL,
ADD COLUMN     "monobankLongJarId" TEXT NOT NULL,
ADD COLUMN     "ownerFullName" TEXT NOT NULL,
ADD COLUMN     "ownerIcon" TEXT NOT NULL,
ADD COLUMN     "ownerName" TEXT NOT NULL,
ADD COLUMN     "title" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "role",
ADD COLUMN     "role" "UserRole" NOT NULL;

-- DropEnum
DROP TYPE "Role";

-- CreateTable
CREATE TABLE "UserFundraising" (
    "id" TEXT NOT NULL,
    "socialMedia" TEXT[],
    "goal" DOUBLE PRECISION NOT NULL,
    "fundraisingName" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "fundraisingId" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "photos" TEXT[],
    "planningRaffles" BOOLEAN NOT NULL,
    "collectedTotal" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "UserFundraising_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Fundraising" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "beneficiaries" TEXT[],
    "goal" DOUBLE PRECISION NOT NULL,
    "photos" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Fundraising_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Goods" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "beneficiare" TEXT NOT NULL,
    "buyLinks" TEXT[],
    "photos" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "fundRaisingId" TEXT NOT NULL,

    CONSTRAINT "Goods_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Receipt" (
    "id" TEXT NOT NULL,
    "purchaseLinks" TEXT[],
    "photos" TEXT[],
    "pdf" TEXT[],
    "fundRaisingId" TEXT NOT NULL,

    CONSTRAINT "Receipt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Comment" (
    "id" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "goodsId" TEXT NOT NULL,

    CONSTRAINT "Comment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_GoodsToReceipt" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "UserFundraising_id_key" ON "UserFundraising"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Fundraising_id_key" ON "Fundraising"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Goods_id_key" ON "Goods"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Goods_fundRaisingId_key" ON "Goods"("fundRaisingId");

-- CreateIndex
CREATE UNIQUE INDEX "Receipt_id_key" ON "Receipt"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Receipt_fundRaisingId_key" ON "Receipt"("fundRaisingId");

-- CreateIndex
CREATE UNIQUE INDEX "Comment_id_key" ON "Comment"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Comment_goodsId_key" ON "Comment"("goodsId");

-- CreateIndex
CREATE UNIQUE INDEX "_GoodsToReceipt_AB_unique" ON "_GoodsToReceipt"("A", "B");

-- CreateIndex
CREATE INDEX "_GoodsToReceipt_B_index" ON "_GoodsToReceipt"("B");

-- CreateIndex
CREATE UNIQUE INDEX "Jar_monobankJarId_key" ON "Jar"("monobankJarId");

-- CreateIndex
CREATE UNIQUE INDEX "Jar_monobankLongJarId_key" ON "Jar"("monobankLongJarId");

-- CreateIndex
CREATE UNIQUE INDEX "Jar_fundraisingId_key" ON "Jar"("fundraisingId");

-- AddForeignKey
ALTER TABLE "UserFundraising" ADD CONSTRAINT "UserFundraising_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserFundraising" ADD CONSTRAINT "UserFundraising_fundraisingId_fkey" FOREIGN KEY ("fundraisingId") REFERENCES "Fundraising"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Jar" ADD CONSTRAINT "Jar_fundraisingId_fkey" FOREIGN KEY ("fundraisingId") REFERENCES "UserFundraising"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Goods" ADD CONSTRAINT "Goods_fundRaisingId_fkey" FOREIGN KEY ("fundRaisingId") REFERENCES "Fundraising"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Receipt" ADD CONSTRAINT "Receipt_fundRaisingId_fkey" FOREIGN KEY ("fundRaisingId") REFERENCES "Fundraising"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_goodsId_fkey" FOREIGN KEY ("goodsId") REFERENCES "Goods"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GoodsToReceipt" ADD CONSTRAINT "_GoodsToReceipt_A_fkey" FOREIGN KEY ("A") REFERENCES "Goods"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_GoodsToReceipt" ADD CONSTRAINT "_GoodsToReceipt_B_fkey" FOREIGN KEY ("B") REFERENCES "Receipt"("id") ON DELETE CASCADE ON UPDATE CASCADE;
