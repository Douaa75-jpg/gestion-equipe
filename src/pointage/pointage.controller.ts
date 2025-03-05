// pointage.controller.ts
import { Controller, Post, Get, Body, Param } from '@nestjs/common';
import { PointageService } from './pointage.service';
import { CreatePointageDto } from './dto/create-pointage.dto';

@Controller('pointage')
export class PointageController {
  constructor(private readonly pointageService: PointageService) {}

  @Post('enregistrer')
  async enregistrer(@Body() dto: CreatePointageDto) {
    return this.pointageService.enregistrerPointage(dto);
  }

  @Get('historique/:id')
  async historique(@Param('id') id: string) {
    return this.pointageService.getHistoriquePointage(Number(id));
  }
}