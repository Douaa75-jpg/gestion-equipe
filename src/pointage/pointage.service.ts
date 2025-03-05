// pointage.service.ts
import { Injectable, BadRequestException } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreatePointageDto } from './dto/create-pointage.dto';
import { Role } from '@prisma/client';

@Injectable()
export class PointageService {
  constructor(private prisma: PrismaService) {}

  async enregistrerPointage(dto: CreatePointageDto) {
    const { empreinteDigitale, heureArrivee, heureDepart, personnelId } = dto;
    
    // Vérifier si la personne est bien un employé
    const personnel = await this.prisma.personnel.findUnique({
      where: { id: personnelId },
    });
    
    if (!personnel || personnel.role !== Role.EMPLOYE) {
      throw new BadRequestException("L'ID fourni ne correspond pas à un employé valide.");
    }

    return await this.prisma.pointage.create({
      data: {
        personnelId,
        empreinteDigitale,
        heureArrivee: new Date(heureArrivee),
        heureDepart: heureDepart ? new Date(heureDepart) : null,
        date: new Date(),
      },
    });
  }

  async getHistoriquePointage(personnelId: number) {
    return await this.prisma.pointage.findMany({
      where: { personnelId },
      orderBy: { date: 'desc' },
    });
  }
}
