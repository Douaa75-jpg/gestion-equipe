/*
  Warnings:

  - Added the required column `role` to the `Personnel` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Role" AS ENUM ('employe', 'RH', 'Superviseur', 'Administrateur');

-- AlterTable
ALTER TABLE "Personnel" ADD COLUMN     "role" "Role" NOT NULL;
