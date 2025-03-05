import { IsInt, IsString, IsOptional, IsDateString } from 'class-validator';

export class CreatePointageDto {
  @IsInt()
  personnelId: number;

  @IsString()
  empreinteDigitale: string;

  @IsDateString()
  heureArrivee: string;

  @IsOptional()
  @IsDateString()
  heureDepart?: string;
}
