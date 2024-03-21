/*
  Warnings:

  - You are about to drop the `comments` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `fundraisings` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `goods` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `jars` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `participants` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `receipts` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user_fundraisings` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "comments" DROP CONSTRAINT "comments_goodsId_fkey";

-- DropForeignKey
ALTER TABLE "goods" DROP CONSTRAINT "goods_fundRaisingId_fkey";

-- DropForeignKey
ALTER TABLE "jars" DROP CONSTRAINT "jars_participantId_fkey";

-- DropForeignKey
ALTER TABLE "participants" DROP CONSTRAINT "participants_fundraisingId_fkey";

-- DropForeignKey
ALTER TABLE "receipts" DROP CONSTRAINT "receipts_goodsId_fkey";

-- DropForeignKey
ALTER TABLE "user_fundraisings" DROP CONSTRAINT "user_fundraisings_fundraisingId_fkey";

-- DropForeignKey
ALTER TABLE "user_fundraisings" DROP CONSTRAINT "user_fundraisings_userId_fkey";

-- DropTable
DROP TABLE "comments";

-- DropTable
DROP TABLE "fundraisings";

-- DropTable
DROP TABLE "goods";

-- DropTable
DROP TABLE "jars";

-- DropTable
DROP TABLE "participants";

-- DropTable
DROP TABLE "receipts";

-- DropTable
DROP TABLE "user_fundraisings";

-- DropTable
DROP TABLE "users";

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "nickname" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "UserRole" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Participant" (
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

    CONSTRAINT "Participant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserFundraising" (
    "userId" TEXT NOT NULL,
    "fundraisingId" TEXT NOT NULL,

    CONSTRAINT "UserFundraising_pkey" PRIMARY KEY ("userId","fundraisingId")
);

-- CreateTable
CREATE TABLE "Fundraising" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "beneficiaries" JSONB[],
    "goal" DOUBLE PRECISION NOT NULL,
    "photos" JSONB[],
    "resultPdf" JSONB[],
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
    "buyLinks" JSONB[],
    "photos" JSONB[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "fundRaisingId" TEXT NOT NULL,

    CONSTRAINT "Goods_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Receipt" (
    "id" TEXT NOT NULL,
    "purchaseLinks" JSONB[],
    "photos" JSONB[],
    "pdf" JSONB[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "goodsId" TEXT NOT NULL,

    CONSTRAINT "Receipt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Jar" (
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
    "type" "JarType" NOT NULL,
    "fundraisingId" TEXT NOT NULL,
    "participantId" TEXT NOT NULL,

    CONSTRAINT "Jar_pkey" PRIMARY KEY ("id")
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

-- CreateIndex
CREATE UNIQUE INDEX "User_nickname_key" ON "User"("nickname");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Goods_fundRaisingId_key" ON "Goods"("fundRaisingId");

-- CreateIndex
CREATE UNIQUE INDEX "Jar_monoJarId_key" ON "Jar"("monoJarId");

-- CreateIndex
CREATE UNIQUE INDEX "Jar_monoLongJarId_key" ON "Jar"("monoLongJarId");

-- CreateIndex
CREATE UNIQUE INDEX "Jar_participantId_key" ON "Jar"("participantId");

-- CreateIndex
CREATE UNIQUE INDEX "Comment_goodsId_key" ON "Comment"("goodsId");

-- AddForeignKey
ALTER TABLE "Participant" ADD CONSTRAINT "Participant_fundraisingId_fkey" FOREIGN KEY ("fundraisingId") REFERENCES "Fundraising"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserFundraising" ADD CONSTRAINT "UserFundraising_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserFundraising" ADD CONSTRAINT "UserFundraising_fundraisingId_fkey" FOREIGN KEY ("fundraisingId") REFERENCES "Fundraising"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Goods" ADD CONSTRAINT "Goods_fundRaisingId_fkey" FOREIGN KEY ("fundRaisingId") REFERENCES "Fundraising"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Receipt" ADD CONSTRAINT "Receipt_goodsId_fkey" FOREIGN KEY ("goodsId") REFERENCES "Goods"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Jar" ADD CONSTRAINT "Jar_participantId_fkey" FOREIGN KEY ("participantId") REFERENCES "Participant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_goodsId_fkey" FOREIGN KEY ("goodsId") REFERENCES "Goods"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
