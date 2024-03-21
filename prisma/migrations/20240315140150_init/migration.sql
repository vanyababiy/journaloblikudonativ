/*
  Warnings:

  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "User1" (
    "id" TEXT NOT NULL,
    "nickname" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User1_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User1_id_key" ON "User1"("id");

-- CreateIndex
CREATE UNIQUE INDEX "User1_nickname_key" ON "User1"("nickname");

-- CreateIndex
CREATE UNIQUE INDEX "User1_email_key" ON "User1"("email");
