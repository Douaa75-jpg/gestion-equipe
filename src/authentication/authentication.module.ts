import { Module } from '@nestjs/common';
import { AuthenticationService } from './authentication.service';
import { AuthenticationController } from './authentication.controller';
import { JwtModule } from '@nestjs/jwt';
import { PrismaService } from 'src/prisma/prisma.service'; // Assurez-vous que PrismaService est importé
import { JwtStrategy } from './jwt.strategy'

@Module({
  imports: [
    JwtModule.register({
      secret: 'your-secret-key', // Assurez-vous d'utiliser une clé secrète sécurisée
      signOptions: { expiresIn: '1h' }, // Option pour la durée de validité du token
    }),
  ],
  controllers: [AuthenticationController],
  providers: [AuthenticationService, PrismaService , JwtStrategy], // Assurez-vous d'injecter PrismaService
})
export class AuthenticationModule {}
