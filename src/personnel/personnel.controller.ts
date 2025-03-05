import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { PersonnelService } from './personnel.service';
import { CreatePersonnelDto } from './dto/create-personnel.dto';
import { UpdatePersonnelDto } from './dto/update-personnel.dto';
import { ParseEnumPipe } from '@nestjs/common';
import { Role } from '@prisma/client'; // Assure-toi que cette ligne est présente


@Controller('personnel')
export class PersonnelController {
  constructor(private readonly personnelService: PersonnelService) {}

  @Post()
  create(@Body() createPersonnelDto: CreatePersonnelDto) {
    return this.personnelService.create(createPersonnelDto);
  }

  @Get()
  findAll() {
    return this.personnelService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.personnelService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updatePersonnelDto: UpdatePersonnelDto) {
  console.log('🔹 PATCH request for ID:', id);
  console.log('🔹 Received DTO:', updatePersonnelDto);
  
  return this.personnelService.update(+id, updatePersonnelDto);
}


  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.personnelService.remove(+id);
  }

  // Endpoint pour récupérer les personnels par rôle
  @Get('role/:role')
findByRole(@Param('role', new ParseEnumPipe(Role)) role: Role) {
  return this.personnelService.findByRole(role);
}

}
