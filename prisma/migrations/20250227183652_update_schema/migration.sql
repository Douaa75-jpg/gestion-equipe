/*
  Warnings:

  - The primary key for the `Administrateur` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idPersonnel` on the `Administrateur` table. All the data in the column will be lost.
  - You are about to drop the column `date` on the `AutorisationSortie` table. All the data in the column will be lost.
  - You are about to drop the column `idEmploye` on the `AutorisationSortie` table. All the data in the column will be lost.
  - You are about to drop the column `statut` on the `AutorisationSortie` table. All the data in the column will be lost.
  - You are about to drop the column `dateDebut` on the `Conge` table. All the data in the column will be lost.
  - You are about to drop the column `dateFin` on the `Conge` table. All the data in the column will be lost.
  - You are about to drop the column `idEmploye` on the `Conge` table. All the data in the column will be lost.
  - You are about to drop the column `statut` on the `Conge` table. All the data in the column will be lost.
  - The primary key for the `Employe` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idPersonnel` on the `Employe` table. All the data in the column will be lost.
  - You are about to drop the column `idEmploye` on the `Notification` table. All the data in the column will be lost.
  - You are about to drop the column `role` on the `Personnel` table. All the data in the column will be lost.
  - The primary key for the `RH` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idPersonnel` on the `RH` table. All the data in the column will be lost.
  - The primary key for the `Superviseur` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idPersonnel` on the `Superviseur` table. All the data in the column will be lost.
  - You are about to drop the `AzureAD` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `IntegrationMicrosoft` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[personnelId]` on the table `Administrateur` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[personnelId]` on the table `Employe` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[personnelId]` on the table `RH` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[personnelId]` on the table `Superviseur` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `personnelId` to the `Administrateur` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `Conge` table without a default value. This is not possible if the table is not empty.
  - Added the required column `personnelId` to the `Employe` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dateNess` to the `Personnel` table without a default value. This is not possible if the table is not empty.
  - Added the required column `personnelId` to the `RH` table without a default value. This is not possible if the table is not empty.
  - Added the required column `rhId` to the `Rapport` table without a default value. This is not possible if the table is not empty.
  - Added the required column `idEquipe` to the `Superviseur` table without a default value. This is not possible if the table is not empty.
  - Added the required column `personnelId` to the `Superviseur` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "StatutDemande" AS ENUM ('EN_ATTENTE', 'APPROUVE', 'REJETE');

-- DropForeignKey
ALTER TABLE "Administrateur" DROP CONSTRAINT "Administrateur_idPersonnel_fkey";

-- DropForeignKey
ALTER TABLE "AutorisationSortie" DROP CONSTRAINT "AutorisationSortie_idEmploye_fkey";

-- DropForeignKey
ALTER TABLE "AzureAD" DROP CONSTRAINT "AzureAD_idPersonnel_fkey";

-- DropForeignKey
ALTER TABLE "Conge" DROP CONSTRAINT "Conge_idEmploye_fkey";

-- DropForeignKey
ALTER TABLE "Employe" DROP CONSTRAINT "Employe_idPersonnel_fkey";

-- DropForeignKey
ALTER TABLE "Employe" DROP CONSTRAINT "Employe_superviseurId_fkey";

-- DropForeignKey
ALTER TABLE "IntegrationMicrosoft" DROP CONSTRAINT "IntegrationMicrosoft_employeId_fkey";

-- DropForeignKey
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_idEmploye_fkey";

-- DropForeignKey
ALTER TABLE "Pointage" DROP CONSTRAINT "Pointage_employeId_fkey";

-- DropForeignKey
ALTER TABLE "RH" DROP CONSTRAINT "RH_idPersonnel_fkey";

-- DropForeignKey
ALTER TABLE "Superviseur" DROP CONSTRAINT "Superviseur_idPersonnel_fkey";

-- AlterTable
ALTER TABLE "Administrateur" DROP CONSTRAINT "Administrateur_pkey",
DROP COLUMN "idPersonnel",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "personnelId" INTEGER NOT NULL,
ADD CONSTRAINT "Administrateur_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "AutorisationSortie" DROP COLUMN "date",
DROP COLUMN "idEmploye",
DROP COLUMN "statut";

-- AlterTable
ALTER TABLE "Conge" DROP COLUMN "dateDebut",
DROP COLUMN "dateFin",
DROP COLUMN "idEmploye",
DROP COLUMN "statut",
ADD COLUMN     "type" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Employe" DROP CONSTRAINT "Employe_pkey",
DROP COLUMN "idPersonnel",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "personnelId" INTEGER NOT NULL,
ALTER COLUMN "superviseurId" DROP NOT NULL,
ADD CONSTRAINT "Employe_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Notification" DROP COLUMN "idEmploye";

-- AlterTable
ALTER TABLE "Personnel" DROP COLUMN "role",
ADD COLUMN     "azureAD" TEXT,
ADD COLUMN     "dateNess" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "numTel" TEXT;

-- AlterTable
ALTER TABLE "Pointage" ALTER COLUMN "heureDepart" DROP NOT NULL;

-- AlterTable
ALTER TABLE "RH" DROP CONSTRAINT "RH_pkey",
DROP COLUMN "idPersonnel",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "personnelId" INTEGER NOT NULL,
ADD CONSTRAINT "RH_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Rapport" ADD COLUMN     "rhId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Superviseur" DROP CONSTRAINT "Superviseur_pkey",
DROP COLUMN "idPersonnel",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "idEquipe" INTEGER NOT NULL,
ADD COLUMN     "personnelId" INTEGER NOT NULL,
ADD CONSTRAINT "Superviseur_pkey" PRIMARY KEY ("id");

-- DropTable
DROP TABLE "AzureAD";

-- DropTable
DROP TABLE "IntegrationMicrosoft";

-- DropEnum
DROP TYPE "Role";

-- DropEnum
DROP TYPE "StatutAutorisation";

-- DropEnum
DROP TYPE "StatutConge";

-- CreateTable
CREATE TABLE "Demande" (
    "id" SERIAL NOT NULL,
    "dateDebut" TIMESTAMP(3) NOT NULL,
    "dateFin" TIMESTAMP(3) NOT NULL,
    "employeId" INTEGER NOT NULL,
    "statut" "StatutDemande" NOT NULL,

    CONSTRAINT "Demande_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Administrateur_personnelId_key" ON "Administrateur"("personnelId");

-- CreateIndex
CREATE UNIQUE INDEX "Employe_personnelId_key" ON "Employe"("personnelId");

-- CreateIndex
CREATE UNIQUE INDEX "RH_personnelId_key" ON "RH"("personnelId");

-- CreateIndex
CREATE UNIQUE INDEX "Superviseur_personnelId_key" ON "Superviseur"("personnelId");

-- AddForeignKey
ALTER TABLE "Employe" ADD CONSTRAINT "Employe_superviseurId_fkey" FOREIGN KEY ("superviseurId") REFERENCES "Superviseur"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Employe" ADD CONSTRAINT "Employe_personnelId_fkey" FOREIGN KEY ("personnelId") REFERENCES "Personnel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Superviseur" ADD CONSTRAINT "Superviseur_personnelId_fkey" FOREIGN KEY ("personnelId") REFERENCES "Personnel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RH" ADD CONSTRAINT "RH_personnelId_fkey" FOREIGN KEY ("personnelId") REFERENCES "Personnel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Administrateur" ADD CONSTRAINT "Administrateur_personnelId_fkey" FOREIGN KEY ("personnelId") REFERENCES "Personnel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pointage" ADD CONSTRAINT "Pointage_employeId_fkey" FOREIGN KEY ("employeId") REFERENCES "Employe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Demande" ADD CONSTRAINT "Demande_employeId_fkey" FOREIGN KEY ("employeId") REFERENCES "Employe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Conge" ADD CONSTRAINT "Conge_id_fkey" FOREIGN KEY ("id") REFERENCES "Demande"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AutorisationSortie" ADD CONSTRAINT "AutorisationSortie_id_fkey" FOREIGN KEY ("id") REFERENCES "Demande"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rapport" ADD CONSTRAINT "Rapport_rhId_fkey" FOREIGN KEY ("rhId") REFERENCES "RH"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
