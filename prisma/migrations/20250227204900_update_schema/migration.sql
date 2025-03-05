/*
  Warnings:

  - You are about to drop the column `azureAD` on the `Personnel` table. All the data in the column will be lost.
  - You are about to drop the column `dateNess` on the `Personnel` table. All the data in the column will be lost.
  - You are about to drop the column `numTel` on the `Personnel` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Personnel" DROP COLUMN "azureAD",
DROP COLUMN "dateNess",
DROP COLUMN "numTel";
