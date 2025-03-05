/*
  Warnings:

  - Added the required column `personnelId` to the `Pointage` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Pointage" ADD COLUMN     "personnelId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Pointage" ADD CONSTRAINT "Pointage_personnelId_fkey" FOREIGN KEY ("personnelId") REFERENCES "Personnel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
