// src/authentication/jwt.strategy.ts

import { Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(private jwtService: JwtService) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: 'your-secret-key', // Assurez-vous que la clé secrète soit sécurisée, vous pouvez la mettre dans un fichier de configuration.
    });
  }

  // Cette méthode est appelée après l'extraction et la validation du JWT
  async validate(payload: any) {
    // Vous pouvez effectuer des actions supplémentaires avec le payload, par exemple, récupérer un utilisateur depuis la base de données
    return { userId: payload.sub, email: payload.email };
  }
}
