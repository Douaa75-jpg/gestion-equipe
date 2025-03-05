import { IsEmail, IsEnum, IsNotEmpty, IsString, MinLength } from 'class-validator';
import { Role } from '@prisma/client'; // Importer l'énumération Role

export class CreatePersonnelDto {
  @IsNotEmpty()
  @IsString()
  nom: string;

  @IsNotEmpty()
  @IsString()
  prenom: string;

  @IsNotEmpty()
  @IsEmail()
  email: string;

  @IsNotEmpty()
  @IsString()
  @MinLength(6, { message: 'Le mot de passe doit comporter au moins 6 caractères.' })
  password: string;

  @IsNotEmpty()
  @IsString()
  numTel: string;

  @IsNotEmpty()
  @IsEnum(Role, { message: "Le rôle doit être EMPLOYE, SUPERVISEUR, RH ou ADMINISTRATEUR." })
  role: Role;

}
