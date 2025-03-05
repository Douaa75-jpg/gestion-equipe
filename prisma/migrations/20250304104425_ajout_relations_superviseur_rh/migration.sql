-- AlterTable
ALTER TABLE "Demande" ADD COLUMN     "motif" TEXT,
ADD COLUMN     "rhId" INTEGER,
ADD COLUMN     "superviseurId" INTEGER;

-- AlterTable
ALTER TABLE "Pointage" ADD COLUMN     "statut" TEXT NOT NULL DEFAULT 'PRESENT';

-- AddForeignKey
ALTER TABLE "Demande" ADD CONSTRAINT "Demande_superviseurId_fkey" FOREIGN KEY ("superviseurId") REFERENCES "Superviseur"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Demande" ADD CONSTRAINT "Demande_rhId_fkey" FOREIGN KEY ("rhId") REFERENCES "RH"("id") ON DELETE SET NULL ON UPDATE CASCADE;
