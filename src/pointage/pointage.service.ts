import { Injectable, BadRequestException } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreatePointageDto } from './dto/create-pointage.dto';
import { Role } from '@prisma/client'; // تأكد من إضافة هذه السطر

@Injectable()
export class PointageService {
  constructor(private prisma: PrismaService) {}

  // تسجيل الحضور بناءً على `personnelId` والتأكد من أنه `Employe`
  async enregistrerPointage(dto: CreatePointageDto) {
    const { personnelId, empreinteDigitale, heureArrivee, heureDepart } = dto;
  
    // Vérification de l'existence de l'employé
    const personnel = await this.prisma.personnel.findUnique({
      where: { id: personnelId },
    });
  
    if (!personnel) {
      throw new BadRequestException("L'employé correspondant n'existe pas.");
    }
  
    if (personnel.role !== Role.EMPLOYE) {
      throw new BadRequestException("Seuls les employés peuvent enregistrer un pointage.");
    }
  
    // Vérification si l'employé existe dans la table Employe
    const employe = await this.prisma.employe.findUnique({
      where: { personnelId },  // Assurez-vous que l'employé existe
    });
  
    if (!employe) {
      throw new BadRequestException("L'employé associé à ce personnel n'existe pas.");
    }
  
    // Créer le pointage en utilisant `employeId` et `personnelId`
    return await this.prisma.pointage.create({
      data: {
        personnelId,  // Ajout de personnelId ici
        empreinteDigitale,
        heureArrivee: new Date(heureArrivee),
        heureDepart: heureDepart ? new Date(heureDepart) : null,
        date: new Date(),
      },
    });
  }
  
  
  

  // استرجاع سجل الحضور بناءً على `personnelId`
  async historiquePointage(personnelId: number) {
    return await this.prisma.pointage.findMany({
      where: { personnelId }, // التأكد من أن الحقل هو `personnelId` وليس `employeId`
    });
  }
}
