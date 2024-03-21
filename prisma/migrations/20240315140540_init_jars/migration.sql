-- CreateTable
CREATE TABLE "Jar" (
    "id" TEXT NOT NULL,

    CONSTRAINT "Jar_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Jar_id_key" ON "Jar"("id");
