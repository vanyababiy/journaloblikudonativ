/*
  Warnings:

  - You are about to drop the `Comment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Fundraising` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Goods` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Jar` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Participant` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Receipt` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_FundraisingToUser` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_GoodsToReceipt` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Comment" DROP CONSTRAINT "Comment_goodsId_fkey";

-- DropForeignKey
ALTER TABLE "Goods" DROP CONSTRAINT "Goods_fundRaisingId_fkey";

-- DropForeignKey
ALTER TABLE "Jar" DROP CONSTRAINT "Jar_participantId_fkey";

-- DropForeignKey
ALTER TABLE "Participant" DROP CONSTRAINT "Participant_fundraisingId_fkey";

-- DropForeignKey
ALTER TABLE "Receipt" DROP CONSTRAINT "Receipt_fundRaisingId_fkey";

-- DropForeignKey
ALTER TABLE "_FundraisingToUser" DROP CONSTRAINT "_FundraisingToUser_A_fkey";

-- DropForeignKey
ALTER TABLE "_FundraisingToUser" DROP CONSTRAINT "_FundraisingToUser_B_fkey";

-- DropForeignKey
ALTER TABLE "_GoodsToReceipt" DROP CONSTRAINT "_GoodsToReceipt_A_fkey";

-- DropForeignKey
ALTER TABLE "_GoodsToReceipt" DROP CONSTRAINT "_GoodsToReceipt_B_fkey";

-- DropTable
DROP TABLE "Comment";

-- DropTable
DROP TABLE "Fundraising";

-- DropTable
DROP TABLE "Goods";

-- DropTable
DROP TABLE "Jar";

-- DropTable
DROP TABLE "Participant";

-- DropTable
DROP TABLE "Receipt";

-- DropTable
DROP TABLE "User";

-- DropTable
DROP TABLE "_FundraisingToUser";

-- DropTable
DROP TABLE "_GoodsToReceipt";

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "nickname" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "UserRole" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "participants" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "socialMedia" JSONB NOT NULL,
    "goal" DOUBLE PRECISION NOT NULL,
    "fundraisingName" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "photos" JSONB NOT NULL,
    "planningRaffles" BOOLEAN NOT NULL,
    "collectedTotal" DOUBLE PRECISION NOT NULL,
    "fundraisingId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "participants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_fundraisings" (
    "userId" TEXT NOT NULL,
    "fundraisingId" TEXT NOT NULL,

    CONSTRAINT "user_fundraisings_pkey" PRIMARY KEY ("userId","fundraisingId")
);

-- CreateTable
CREATE TABLE "fundraisings" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "beneficiaries" JSONB[],
    "goal" DOUBLE PRECISION NOT NULL,
    "photos" JSONB[],
    "resultPdf" JSONB[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "fundraisings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "goods" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "beneficiare" TEXT NOT NULL,
    "buyLinks" JSONB[],
    "photos" JSONB[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "fundRaisingId" TEXT NOT NULL,

    CONSTRAINT "goods_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receipts" (
    "id" TEXT NOT NULL,
    "purchaseLinks" JSONB[],
    "photos" JSONB[],
    "pdf" JSONB[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "goodsId" TEXT NOT NULL,

    CONSTRAINT "receipts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "jars" (
    "id" TEXT NOT NULL,
    "monoJarId" TEXT NOT NULL,
    "monoLongJarId" TEXT NOT NULL,
    "monoAmount" DOUBLE PRECISION NOT NULL,
    "monoGoal" DOUBLE PRECISION NOT NULL,
    "monoOwnerIcon" TEXT NOT NULL,
    "monoTitle" TEXT NOT NULL,
    "monoOwnerName" TEXT NOT NULL,
    "monoCurrency" INTEGER NOT NULL,
    "monoDescription" TEXT NOT NULL,
    "monoBlago" BOOLEAN NOT NULL,
    "monoClosed" BOOLEAN NOT NULL,
    "participantId" TEXT NOT NULL,

    CONSTRAINT "jars_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "comments" (
    "id" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "goodsId" TEXT NOT NULL,

    CONSTRAINT "comments_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_nickname_key" ON "users"("nickname");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "goods_fundRaisingId_key" ON "goods"("fundRaisingId");

-- CreateIndex
CREATE UNIQUE INDEX "jars_monoJarId_key" ON "jars"("monoJarId");

-- CreateIndex
CREATE UNIQUE INDEX "jars_monoLongJarId_key" ON "jars"("monoLongJarId");

-- CreateIndex
CREATE UNIQUE INDEX "jars_participantId_key" ON "jars"("participantId");

-- CreateIndex
CREATE UNIQUE INDEX "comments_goodsId_key" ON "comments"("goodsId");

-- AddForeignKey
ALTER TABLE "participants" ADD CONSTRAINT "participants_fundraisingId_fkey" FOREIGN KEY ("fundraisingId") REFERENCES "fundraisings"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_fundraisings" ADD CONSTRAINT "user_fundraisings_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_fundraisings" ADD CONSTRAINT "user_fundraisings_fundraisingId_fkey" FOREIGN KEY ("fundraisingId") REFERENCES "fundraisings"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "goods" ADD CONSTRAINT "goods_fundRaisingId_fkey" FOREIGN KEY ("fundRaisingId") REFERENCES "fundraisings"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receipts" ADD CONSTRAINT "receipts_goodsId_fkey" FOREIGN KEY ("goodsId") REFERENCES "goods"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "jars" ADD CONSTRAINT "jars_participantId_fkey" FOREIGN KEY ("participantId") REFERENCES "participants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comments" ADD CONSTRAINT "comments_goodsId_fkey" FOREIGN KEY ("goodsId") REFERENCES "goods"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
