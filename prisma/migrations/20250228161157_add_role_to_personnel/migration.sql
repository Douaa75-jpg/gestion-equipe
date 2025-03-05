/*
  Warnings:

  - You are about to drop the column `dateNess` on the `Personnel` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "Role" AS ENUM ('EMPLOYE', 'SUPERVISEUR', 'RH', 'ADMINISTRATEUR');

-- AlterTable
ALTER TABLE "Personnel" DROP COLUMN "dateNess",
ADD COLUMN     "role" "Role" NOT NULL DEFAULT 'EMPLOYE';
