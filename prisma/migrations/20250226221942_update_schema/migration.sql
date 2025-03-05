/*
  Warnings:

  - You are about to drop the `Employes` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `HistoriqueAssignation` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `HistoriqueSortie` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `date` to the `Pointage` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "StatutAutorisation" AS ENUM ('en_attente', 'approuve', 'rejete');

-- DropForeignKey
ALTER TABLE "Conge" DROP CONSTRAINT "Conge_idEmploye_fkey";

-- DropForeignKey
ALTER TABLE "Employes" DROP CONSTRAINT "Employes_idPersonnel_fkey";

-- DropForeignKey
ALTER TABLE "Employes" DROP CONSTRAINT "Employes_superviseurId_fkey";

-- DropForeignKey
ALTER TABLE "HistoriqueAssignation" DROP CONSTRAINT "HistoriqueAssignation_employeId_fkey";

-- DropForeignKey
ALTER TABLE "HistoriqueSortie" DROP CONSTRAINT "HistoriqueSortie_employeId_fkey";

-- DropForeignKey
ALTER TABLE "Pointage" DROP CONSTRAINT "Pointage_employeId_fkey";

-- AlterTable
ALTER TABLE "Pointage" ADD COLUMN     "date" TIMESTAMP(3) NOT NULL;

-- DropTable
DROP TABLE "Employes";

-- DropTable
DROP TABLE "HistoriqueAssignation";

-- DropTable
DROP TABLE "HistoriqueSortie";

-- CreateTable
CREATE TABLE "Employe" (
    "idPersonnel" INTEGER NOT NULL,
    "superviseurId" INTEGER NOT NULL,

    CONSTRAINT "Employe_pkey" PRIMARY KEY ("idPersonnel")
);

-- CreateTable
CREATE TABLE "AutorisationSortie" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "heureDebut" TIMESTAMP(3) NOT NULL,
    "heureFin" TIMESTAMP(3) NOT NULL,
    "statut" "StatutAutorisation" NOT NULL,
    "idEmploye" INTEGER NOT NULL,

    CONSTRAINT "AutorisationSortie_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Notification" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "idEmploye" INTEGER NOT NULL,

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Rapport" (
    "id" SERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "contenu" TEXT NOT NULL,

    CONSTRAINT "Rapport_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "IntegrationMicrosoft" (
    "id" SERIAL NOT NULL,
    "typeIntegration" TEXT NOT NULL,
    "employeId" INTEGER,

    CONSTRAINT "IntegrationMicrosoft_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "IntegrationMicrosoft_employeId_key" ON "IntegrationMicrosoft"("employeId");

-- AddForeignKey
ALTER TABLE "Employe" ADD CONSTRAINT "Employe_idPersonnel_fkey" FOREIGN KEY ("idPersonnel") REFERENCES "Personnel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Employe" ADD CONSTRAINT "Employe_superviseurId_fkey" FOREIGN KEY ("superviseurId") REFERENCES "Superviseur"("idPersonnel") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Conge" ADD CONSTRAINT "Conge_idEmploye_fkey" FOREIGN KEY ("idEmploye") REFERENCES "Employe"("idPersonnel") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AutorisationSortie" ADD CONSTRAINT "AutorisationSortie_idEmploye_fkey" FOREIGN KEY ("idEmploye") REFERENCES "Employe"("idPersonnel") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pointage" ADD CONSTRAINT "Pointage_employeId_fkey" FOREIGN KEY ("employeId") REFERENCES "Employe"("idPersonnel") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_idEmploye_fkey" FOREIGN KEY ("idEmploye") REFERENCES "Employe"("idPersonnel") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IntegrationMicrosoft" ADD CONSTRAINT "IntegrationMicrosoft_employeId_fkey" FOREIGN KEY ("employeId") REFERENCES "Employe"("idPersonnel") ON DELETE SET NULL ON UPDATE CASCADE;
