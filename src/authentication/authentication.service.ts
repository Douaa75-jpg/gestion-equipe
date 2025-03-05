import { Injectable, NotFoundException, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from 'src/prisma/prisma.service'; // Assurez-vous que PrismaService est bien importé
import * as bcrypt from 'bcryptjs';
import { CreateAuthenticationDto } from './dto/create-authentication.dto';
import { UpdateAuthenticationDto } from './dto/update-authentication.dto';

@Injectable()
export class AuthenticationService {
  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService, // Injection de JwtService pour créer un JWT
  ) {}

  // Fonction pour valider un utilisateur avec son email et mot de passe
  async validateUser(email: string, password: string) {
    const user = await this.prisma.personnel.findUnique({
      where: { email },
    });

    if (!user) {
      throw new NotFoundException('Utilisateur non trouvé'); // L'utilisateur n'existe pas
    }

    const isPasswordValid = await bcrypt.compare(password, user.password);

    if (!isPasswordValid) {
      throw new UnauthorizedException('Mot de passe incorrect'); // Mot de passe incorrect
    }

    return user; // Retourne l'utilisateur après validation
  }

  // Fonction pour générer un token JWT après validation de l'utilisateur
  async login(email: string, password: string) {
    const user = await this.validateUser(email, password); // Valide l'utilisateur

    const payload = { email: user.email, sub: user.id }; // Création du payload pour JWT
    const access_token = this.jwtService.sign(payload); // Génère le token JWT

    return {
      access_token, // Retourne le token
    };
  }

  // Exemple de fonction pour ajouter une nouvelle authentification
  create(createAuthenticationDto: CreateAuthenticationDto) {
    return 'This action adds a new authentication'; // Logique à définir pour la création d'une authentification
  }

  // Exemple de fonction pour obtenir toutes les authentifications
  findAll() {
    return 'This action returns all authentication'; // Logique à définir pour retourner toutes les authentifications
  }

  // Exemple de fonction pour obtenir une authentification par son ID
  findOne(id: number) {
    return `This action returns a #${id} authentication`; // Logique à définir pour obtenir une authentification par son ID
  }

  // Exemple de fonction pour mettre à jour une authentification
  update(id: number, updateAuthenticationDto: UpdateAuthenticationDto) {
    return `This action updates a #${id} authentication`; // Logique à définir pour mettre à jour une authentification
  }

  // Exemple de fonction pour supprimer une authentification
  remove(id: number) {
    return `This action removes a #${id} authentication`; // Logique à définir pour supprimer une authentification
  }
}
