import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { RapportService } from './rapport.service';
import { CreateRapportDto } from './dto/create-rapport.dto';
import { UpdateRapportDto } from './dto/update-rapport.dto';

@Controller('rapport')
export class RapportController {
  constructor(private readonly rapportService: RapportService) {}

  @Post()
  create(@Body() createRapportDto: CreateRapportDto) {
    return this.rapportService.create(createRapportDto);
  }

  @Get()
  findAll() {
    return this.rapportService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.rapportService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateRapportDto: UpdateRapportDto) {
    return this.rapportService.update(+id, updateRapportDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.rapportService.remove(+id);
  }
}
