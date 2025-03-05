/*
  Warnings:

  - You are about to drop the column `equipementId` on the `HistoriqueAssignation` table. All the data in the column will be lost.
  - You are about to drop the `Employe` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Equipement` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `conge` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Employe" DROP CONSTRAINT "Employe_idPersonnel_fkey";

-- DropForeignKey
ALTER TABLE "Employe" DROP CONSTRAINT "Employe_superviseurId_fkey";

-- DropForeignKey
ALTER TABLE "Equipement" DROP CONSTRAINT "Equipement_employeAssigner_fkey";

-- DropForeignKey
ALTER TABLE "HistoriqueAssignation" DROP CONSTRAINT "HistoriqueAssignation_employeId_fkey";

-- DropForeignKey
ALTER TABLE "HistoriqueAssignation" DROP CONSTRAINT "HistoriqueAssignation_equipementId_fkey";

-- DropForeignKey
ALTER TABLE "Pointage" DROP CONSTRAINT "Pointage_employeId_fkey";

-- DropForeignKey
ALTER TABLE "conge" DROP CONSTRAINT "conge_idEmploye_fkey";

-- AlterTable
ALTER TABLE "HistoriqueAssignation" DROP COLUMN "equipementId";

-- DropTable
DROP TABLE "Employe";

-- DropTable
DROP TABLE "Equipement";

-- DropTable
DROP TABLE "conge";

-- DropEnum
DROP TYPE "EtatEquipement";

-- CreateTable
CREATE TABLE "Employes" (
    "idPersonnel" INTEGER NOT NULL,
    "superviseurId" INTEGER NOT NULL,

    CONSTRAINT "Employes_pkey" PRIMARY KEY ("idPersonnel")
);

-- CreateTable
CREATE TABLE "Conge" (
    "id" SERIAL NOT NULL,
    "dateDebut" TIMESTAMP(3) NOT NULL,
    "dateFin" TIMESTAMP(3) NOT NULL,
    "statut" "StatutConge" NOT NULL,
    "idEmploye" INTEGER NOT NULL,

    CONSTRAINT "Conge_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HistoriqueSortie" (
    "id" SERIAL NOT NULL,
    "dateSortie" TIMESTAMP(3) NOT NULL,
    "motif" TEXT NOT NULL,
    "employeId" INTEGER NOT NULL,

    CONSTRAINT "HistoriqueSortie_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Employes" ADD CONSTRAINT "Employes_idPersonnel_fkey" FOREIGN KEY ("idPersonnel") REFERENCES "Personnel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Employes" ADD CONSTRAINT "Employes_superviseurId_fkey" FOREIGN KEY ("superviseurId") REFERENCES "Superviseur"("idPersonnel") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Conge" ADD CONSTRAINT "Conge_idEmploye_fkey" FOREIGN KEY ("idEmploye") REFERENCES "Employes"("idPersonnel") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HistoriqueAssignation" ADD CONSTRAINT "HistoriqueAssignation_employeId_fkey" FOREIGN KEY ("employeId") REFERENCES "Employes"("idPersonnel") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HistoriqueSortie" ADD CONSTRAINT "HistoriqueSortie_employeId_fkey" FOREIGN KEY ("employeId") REFERENCES "Employes"("idPersonnel") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pointage" ADD CONSTRAINT "Pointage_employeId_fkey" FOREIGN KEY ("employeId") REFERENCES "Employes"("idPersonnel") ON DELETE RESTRICT ON UPDATE CASCADE;
