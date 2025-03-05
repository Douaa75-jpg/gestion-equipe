/*
  Warnings:

  - Added the required column `dateNess` to the `Personnel` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Personnel" ADD COLUMN     "dateNess" TIMESTAMP(3) NOT NULL;
