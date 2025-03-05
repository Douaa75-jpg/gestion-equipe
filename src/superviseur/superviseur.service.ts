import { Injectable } from '@nestjs/common';
import { CreateSuperviseurDto } from './dto/create-superviseur.dto';
import { UpdateSuperviseurDto } from './dto/update-superviseur.dto';

@Injectable()
export class SuperviseurService {
  create(createSuperviseurDto: CreateSuperviseurDto) {
    return 'This action adds a new superviseur';
  }

  findAll() {
    return `This action returns all superviseur`;
  }

  findOne(id: number) {
    return `This action returns a #${id} superviseur`;
  }

  update(id: number, updateSuperviseurDto: UpdateSuperviseurDto) {
    return `This action updates a #${id} superviseur`;
  }

  remove(id: number) {
    return `This action removes a #${id} superviseur`;
  }
}
