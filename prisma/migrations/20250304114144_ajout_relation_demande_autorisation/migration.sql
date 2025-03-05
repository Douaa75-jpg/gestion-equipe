/*
  Warnings:

  - Added the required column `demandeId` to the `AutorisationSortie` table without a default value. This is not possible if the table is not empty.
  - Added the required column `statut` to the `AutorisationSortie` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "AutorisationSortie" ADD COLUMN     "demandeId" INTEGER NOT NULL,
ADD COLUMN     "statut" TEXT NOT NULL;
