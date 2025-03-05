-- CreateEnum
CREATE TYPE "StatutConge" AS ENUM ('en_attente', 'approuve', 'rejete');

-- CreateEnum
CREATE TYPE "EtatEquipement" AS ENUM ('disponible', 'en_maintenance', 'utilise');

-- CreateTable
CREATE TABLE "Personnel" (
    "id" SERIAL NOT NULL,
    "nom" TEXT NOT NULL,
    "prenom" TEXT NOT NULL,
    "email" TEXT NOT NULL,

    CONSTRAINT "Personnel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AzureAD" (
    "idPersonnel" INTEGER NOT NULL,

    CONSTRAINT "AzureAD_pkey" PRIMARY KEY ("idPersonnel")
);

-- CreateTable
CREATE TABLE "Employe" (
    "idPersonnel" INTEGER NOT NULL,
    "superviseurId" INTEGER NOT NULL,

    CONSTRAINT "Employe_pkey" PRIMARY KEY ("idPersonnel")
);

-- CreateTable
CREATE TABLE "RH" (
    "idPersonnel" INTEGER NOT NULL,

    CONSTRAINT "RH_pkey" PRIMARY KEY ("idPersonnel")
);

-- CreateTable
CREATE TABLE "Superviseur" (
    "idPersonnel" INTEGER NOT NULL,

    CONSTRAINT "Superviseur_pkey" PRIMARY KEY ("idPersonnel")
);

-- CreateTable
CREATE TABLE "Administrateur" (
    "idPersonnel" INTEGER NOT NULL,

    CONSTRAINT "Administrateur_pkey" PRIMARY KEY ("idPersonnel")
);

-- CreateTable
CREATE TABLE "conge" (
    "id" SERIAL NOT NULL,
    "dateDebut" TIMESTAMP(3) NOT NULL,
    "dateFin" TIMESTAMP(3) NOT NULL,
    "statut" "StatutConge" NOT NULL,
    "idEmploye" INTEGER NOT NULL,

    CONSTRAINT "conge_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Equipement" (
    "id" SERIAL NOT NULL,
    "nom" TEXT NOT NULL,
    "etat" "EtatEquipement" NOT NULL,
    "employeAssigner" INTEGER,

    CONSTRAINT "Equipement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HistoriqueAssignation" (
    "id" SERIAL NOT NULL,
    "dateDebut" TIMESTAMP(3) NOT NULL,
    "dateFin" TIMESTAMP(3) NOT NULL,
    "employeId" INTEGER NOT NULL,
    "equipementId" INTEGER NOT NULL,

    CONSTRAINT "HistoriqueAssignation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pointage" (
    "id" SERIAL NOT NULL,
    "heureArrivee" TIMESTAMP(3) NOT NULL,
    "heureDepart" TIMESTAMP(3) NOT NULL,
    "employeId" INTEGER NOT NULL,
    "empreinteDigitale" TEXT NOT NULL,

    CONSTRAINT "Pointage_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Personnel_email_key" ON "Personnel"("email");

-- AddForeignKey
ALTER TABLE "AzureAD" ADD CONSTRAINT "AzureAD_idPersonnel_fkey" FOREIGN KEY ("idPersonnel") REFERENCES "Personnel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Employe" ADD CONSTRAINT "Employe_idPersonnel_fkey" FOREIGN KEY ("idPersonnel") REFERENCES "Personnel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Employe" ADD CONSTRAINT "Employe_superviseurId_fkey" FOREIGN KEY ("superviseurId") REFERENCES "Superviseur"("idPersonnel") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RH" ADD CONSTRAINT "RH_idPersonnel_fkey" FOREIGN KEY ("idPersonnel") REFERENCES "Personnel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Superviseur" ADD CONSTRAINT "Superviseur_idPersonnel_fkey" FOREIGN KEY ("idPersonnel") REFERENCES "Personnel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Administrateur" ADD CONSTRAINT "Administrateur_idPersonnel_fkey" FOREIGN KEY ("idPersonnel") REFERENCES "Personnel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "conge" ADD CONSTRAINT "conge_idEmploye_fkey" FOREIGN KEY ("idEmploye") REFERENCES "Employe"("idPersonnel") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Equipement" ADD CONSTRAINT "Equipement_employeAssigner_fkey" FOREIGN KEY ("employeAssigner") REFERENCES "Employe"("idPersonnel") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HistoriqueAssignation" ADD CONSTRAINT "HistoriqueAssignation_employeId_fkey" FOREIGN KEY ("employeId") REFERENCES "Employe"("idPersonnel") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HistoriqueAssignation" ADD CONSTRAINT "HistoriqueAssignation_equipementId_fkey" FOREIGN KEY ("equipementId") REFERENCES "Equipement"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pointage" ADD CONSTRAINT "Pointage_employeId_fkey" FOREIGN KEY ("employeId") REFERENCES "Employe"("idPersonnel") ON DELETE RESTRICT ON UPDATE CASCADE;
