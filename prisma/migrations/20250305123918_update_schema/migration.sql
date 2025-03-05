/*
  Warnings:

  - You are about to drop the column `personnelId` on the `Pointage` table. All the data in the column will be lost.
  - The `statut` column on the `Pointage` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "StatutPresence" AS ENUM ('PRESENT', 'ABSENT', 'RETARD');

-- DropForeignKey
ALTER TABLE "Pointage" DROP CONSTRAINT "Pointage_personnelId_fkey";

-- AlterTable
ALTER TABLE "Pointage" DROP COLUMN "personnelId",
ALTER COLUMN "heureArrivee" SET DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "date" SET DEFAULT CURRENT_TIMESTAMP,
DROP COLUMN "statut",
ADD COLUMN     "statut" "StatutPresence" NOT NULL DEFAULT 'PRESENT';

-- AddForeignKey
ALTER TABLE "Pointage" ADD CONSTRAINT "Pointage_personnelId_fkey" FOREIGN KEY ("employeId") REFERENCES "Personnel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
