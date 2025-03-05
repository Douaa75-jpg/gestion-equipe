import { Injectable, NotFoundException , InternalServerErrorException , BadRequestException} from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreatePersonnelDto } from './dto/create-personnel.dto';
import { UpdatePersonnelDto } from './dto/update-personnel.dto';
import * as bcrypt from 'bcryptjs';
import { Role } from '@prisma/client'; // Assure-toi que cette ligne est présente

@Injectable()
export class PersonnelService {
  constructor(private readonly prisma: PrismaService) {}

  async findByRole(role: Role) {
    const personnels = await this.prisma.personnel.findMany({
      where: { role },
    });

    if (!personnels.length) {
      throw new NotFoundException(`Aucun personnel trouvé pour le rôle : ${role}`);
    }

    return personnels;
  }

  async create(data: CreatePersonnelDto) {
    const { nom, prenom, email, password, numTel, role } = data;
    const hashedPassword = await bcrypt.hash(password, 10);
    try {
      return await this.prisma.personnel.create({
        data: {
          nom,
          prenom,
          email,
          password: hashedPassword,
          numTel,
          role,
        },
      });
    } catch (error) {
      console.error('Error while creating personnel:', error);
      throw new InternalServerErrorException('Une erreur est survenue lors de la création du personnel');
    }
  }

  async findByEmail(email: string) {
    const personnel = await this.prisma.personnel.findUnique({
      where: { email },
    });
    if (!personnel) {
      throw new NotFoundException(`Aucun personnel trouvé avec l'email : ${email}`);
    }
    return personnel;
  }

  async findAll() {
    const personnels = await this.prisma.personnel.findMany();
    if (!personnels.length) {
      throw new NotFoundException('Aucun personnel trouvé.');
    }
    return personnels;
  }

  async findOne(id: number) {
    const personnel = await this.prisma.personnel.findUnique({ where: { id } });
    if (!personnel) {
      throw new NotFoundException(`Personnel avec l'ID ${id} introuvable.`);
    }
    return personnel;
  }

  async update(id: number, updatePersonnelDto: UpdatePersonnelDto) {
    console.log('🔹 Updating personnel:', id, updatePersonnelDto); // Debug
    
    const existingPersonnel = await this.prisma.personnel.findUnique({ where: { id } });
    if (!existingPersonnel) {
      throw new NotFoundException(`Personnel avec ID ${id} non trouvé`);
    }
  
    // Empêcher Prisma de recevoir un objet `data` vide
    if (Object.keys(updatePersonnelDto).length === 0) {
      throw new BadRequestException('Le corps de la requête ne peut pas être vide');
    }
  
    // Si le mot de passe est modifié, on le hache
    if (updatePersonnelDto.password) {
      updatePersonnelDto.password = await bcrypt.hash(updatePersonnelDto.password, 10);
    }
  
    return this.prisma.personnel.update({
      where: { id },
      data: { ...updatePersonnelDto },
    });
  }
  


  async remove(id: number) {
    const personnel = await this.findOne(id);
    if (!personnel) {
      throw new NotFoundException(`Personnel avec l'ID ${id} introuvable.`);
    }
    return this.prisma.personnel.delete({ where: { id } });
  }
}
