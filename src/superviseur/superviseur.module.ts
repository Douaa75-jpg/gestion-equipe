import { Module } from '@nestjs/common';
import { SuperviseurService } from './superviseur.service';
import { SuperviseurController } from './superviseur.controller';

@Module({
  controllers: [SuperviseurController],
  providers: [SuperviseurService],
})
export class SuperviseurModule {}
