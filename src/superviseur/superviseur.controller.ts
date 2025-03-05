import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { SuperviseurService } from './superviseur.service';
import { CreateSuperviseurDto } from './dto/create-superviseur.dto';
import { UpdateSuperviseurDto } from './dto/update-superviseur.dto';

@Controller('superviseur')
export class SuperviseurController {
  constructor(private readonly superviseurService: SuperviseurService) {}

  @Post()
  create(@Body() createSuperviseurDto: CreateSuperviseurDto) {
    return this.superviseurService.create(createSuperviseurDto);
  }

  @Get()
  findAll() {
    return this.superviseurService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.superviseurService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateSuperviseurDto: UpdateSuperviseurDto) {
    return this.superviseurService.update(+id, updateSuperviseurDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.superviseurService.remove(+id);
  }
}
