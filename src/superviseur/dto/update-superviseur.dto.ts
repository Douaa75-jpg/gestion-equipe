import { PartialType } from '@nestjs/swagger';
import { CreateSuperviseurDto } from './create-superviseur.dto';

export class UpdateSuperviseurDto extends PartialType(CreateSuperviseurDto) {}
