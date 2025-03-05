import { Injectable, BadRequestException } from '@nestjs/common';
import { CreatePointageDto } from 'src/pointage/dto/create-pointage.dto';
import { PrismaService } from 'src/prisma/prisma.service'; // PrismaService pour accéder au Prisma Client

@Injectable()
export class EmployeService {
  constructor(private prisma: PrismaService) {}

  // Fonction pour gérer le pointage des employés
  async pointage(dto: CreatePointageDto) {
    const { empreinteDigitale, heureArrivee, heureDepart, personnelId } = dto;
  
    // Vérification que l'employé existe
    const employe = await this.prisma.employe.findUnique({
      where: { id: personnelId },
      include: { personnel: true },
    });
  
    if (!employe || !employe.personnel) {
      throw new BadRequestException("L'employé avec cet ID n'existe pas ou l'employé n'a pas de personnel associé.");
    }
  
    // Création du pointage dans la base de données
    return await this.prisma.pointage.create({
      data: {
        employeId: employe.id,  // Utiliser employe.id pour l'ID de l'employé
        empreinteDigitale,
        heureArrivee: new Date(heureArrivee),
        heureDepart: heureDepart ? new Date(heureDepart) : null,
        date: new Date(),
        personnelId: employe.personnelId,
      },
    });
  }
  

  async getAllEmployes() {
    return await this.prisma.employe.findMany({
      include: { personnel: true },  // Inclure la relation avec Personnel
    });
  }
  

  // Fonction pour récupérer l'historique des pointages d'un employé
  async historiquePointage(id: number) {
    return await this.prisma.pointage.findMany({
      where: { employeId: id },  // Filtrer les pointages par ID de l'employé
    });
  }

  // Demander un congé pour un employé
  async demandeConge(id: number, dateDebut: Date, dateFin: Date, motif?: string) {
    // Création de la demande de congé
    const demande = await this.prisma.demande.create({
      data: {
        employeId: id,
        dateDebut,
        dateFin,
        statut: 'EN_ATTENTE',  // Statut initial pour la demande de congé
        motif: motif || null,  // Motif facultatif pour la demande de congé
      },
    });
    return demande;
  }

  // Récupérer l'historique des congés d'un employé
  async historiqueConges(id: number) {
    return await this.prisma.demande.findMany({
      where: { employeId: id },  // Filtrer par ID de l'employé
    });
  }

  // Demander une autorisation de sortie pour un employé
  async demandeSortie(id: number, heureDebut: Date, heureFin: Date) {
    const dateActuelle = new Date();  // Utiliser la date actuelle comme date de début et de fin

    // Créer la demande d'autorisation de sortie associée à l'employé
    const demande = await this.prisma.demande.create({
      data: {
        employeId: id,
        dateDebut: dateActuelle,  // Utilisation de la date actuelle pour la demande
        dateFin: dateActuelle,    // Date de fin de la demande est aussi la date actuelle
        heureDebut,              // Heure de début de la sortie
        heureFin,                // Heure de fin de la sortie
        statut: 'EN_ATTENTE',    // Statut initial de la demande
      },
    });

    // Créer l'autorisation de sortie liée à la demande
    const autorisation = await this.prisma.autorisationSortie.create({
      data: {
        demandeId: demande.id,    // ID de la demande associée
        heureDebut,               // Heure de début
        heureFin,                 // Heure de fin
        statut: 'EN_ATTENTE',     // Statut initial
      },
    });

    return autorisation;
  }
}
