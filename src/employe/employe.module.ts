import { Module } from '@nestjs/common';
import { EmployeService } from './employe.service';
import { EmployeController } from './employe.controller';
import { PointageModule } from 'src/pointage/pointage.module'; // استيراد PointageModule
import { PrismaModule } from 'src/prisma/prisma.module';

@Module({
  imports: [PointageModule, PrismaModule], // استيراد PointageModule للتفاعل مع خدمات الحضور
  controllers: [EmployeController],
  providers: [EmployeService],
})
export class EmployeModule {}
