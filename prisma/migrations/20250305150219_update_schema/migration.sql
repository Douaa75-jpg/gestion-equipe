/*
  Warnings:

  - Added the required column `personnelId` to the `Pointage` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Pointage" DROP CONSTRAINT "Pointage_employeId_fkey";

-- DropForeignKey
ALTER TABLE "Pointage" DROP CONSTRAINT "Pointage_personnelId_fkey";

-- AlterTable
ALTER TABLE "Pointage" ADD COLUMN     "personnelId" INTEGER NOT NULL,
ALTER COLUMN "employeId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Pointage" ADD CONSTRAINT "Pointage_employeId_fkey" FOREIGN KEY ("employeId") REFERENCES "Employe"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pointage" ADD CONSTRAINT "fk_pointage_personnel" FOREIGN KEY ("personnelId") REFERENCES "Personnel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
