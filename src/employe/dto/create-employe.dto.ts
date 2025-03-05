import { IsNotEmpty, IsString, IsOptional, IsDateString, IsNumber } from 'class-validator';

export class CreateEmployeDto {
  
  @IsNotEmpty() @IsString()
  nom: string;

  @IsNotEmpty() @IsString()
  prenom: string;

  @IsNotEmpty() @IsString()
  email: string;

  @IsNotEmpty() @IsString()
  password: string;

  @IsNotEmpty() @IsString()
  numTel: string;
}
