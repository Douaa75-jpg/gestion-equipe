/*
  Warnings:

  - Added the required column `password` to the `Personnel` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Personnel" ADD COLUMN     "password" TEXT NOT NULL;
