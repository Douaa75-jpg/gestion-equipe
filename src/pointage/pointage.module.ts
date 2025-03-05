import { Module } from '@nestjs/common';
import { PointageService } from './pointage.service';
import { PointageController } from './pointage.controller';
import { PrismaModule } from 'src/prisma/prisma.module'; // استيراد Prisma Module

@Module({
  imports: [PrismaModule], // استيراد Prisma لتوفير الاتصال مع قاعدة البيانات
  controllers: [PointageController], 
  providers: [PointageService],
  exports: [PointageService], // تصدير PointageService لاستخدامه في Modules أخرى
})
export class PointageModule {}
