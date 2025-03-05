// create-pointage.dto.ts
import { IsNotEmpty, IsString, IsOptional, IsDateString, IsNumber } from 'class-validator';

export class CreatePointageDto {
  @IsNotEmpty() @IsNumber()
  personnelId: number; // ID du personnel (employé)

  @IsNotEmpty() @IsString()
  empreinteDigitale: string;

  @IsNotEmpty() @IsDateString()
  heureArrivee: string;

  @IsOptional() @IsDateString()
  heureDepart?: string;
}
