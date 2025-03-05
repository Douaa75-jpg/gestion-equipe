import { Module } from '@nestjs/common';
import { PointageService } from './pointage.service';
import { PointageController } from './pointage.controller';
import { PrismaModule } from 'src/prisma/prisma.module';

@Module({
  imports: [PrismaModule],
  controllers: [PointageController],
  providers: [PointageService],
})
export class PointageModule {}
