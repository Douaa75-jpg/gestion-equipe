// في EmployeController (employe.controller.ts)
import { Controller, Get } from '@nestjs/common';
import { EmployeService } from './employe.service';

@Controller('employe')
export class EmployeController {
  constructor(private readonly employeService: EmployeService) {}

  @Get('list')
  async getEmployes() {
    return this.employeService.getAllEmployes();
  }
}
