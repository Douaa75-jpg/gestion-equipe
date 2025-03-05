import { Controller, Post, Body, Get, Query, Param } from '@nestjs/common';
import { PointageService } from './pointage.service';
import { CreatePointageDto } from './dto/create-pointage.dto'; // إذا كنت تستخدم DTOs

@Controller('pointage')
export class PointageController {
  constructor(private readonly pointageService: PointageService) {}

  // تعديل طريقة إدخال تسجيل الحضور
  @Post()
  enregistrerPointage(@Body() createPointageDto: CreatePointageDto) {
    return this.pointageService.enregistrerPointage(createPointageDto);
  }

  // تعديل الـ Param لضمان تمرير `personnelId` كعدد صحيح
  @Get(':personnelId')
  findAllPointages(@Param('personnelId') personnelId: string) {
    return this.pointageService.historiquePointage(+personnelId); // تحويل `personnelId` إلى رقم
  }

  // تحسين الاستعلام من خلال Query
  @Get('historique')
  async historiquePointage(@Query('id') id: string) {
    return this.pointageService.historiquePointage(+id); // تحويل `id` إلى رقم
  }
}
