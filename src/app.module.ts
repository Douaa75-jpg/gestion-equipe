import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PointageModule } from './pointage/pointage.module';
import { EmployeModule } from './employe/employe.module';
import { AutorisationSortieModule } from './autorisation-sortie/autorisation-sortie.module';
import { NotificationModule } from './notification/notification.module';
import { RapportModule } from './rapport/rapport.module';
import { CongeModule } from './conge/conge.module';
import { DemandeModule } from './demande/demande.module';
import { AdministrateurModule } from './administrateur/administrateur.module';
import { RhModule } from './rh/rh.module';
import { PersonnelModule } from './personnel/personnel.module';
import { SuperviseurModule } from './superviseur/superviseur.module';
import { AuthenticationModule } from './authentication/authentication.module'; // تأكد من استيراد AuthenticationModule

@Module({
  imports: [
    RhModule,
    AdministrateurModule,
    CongeModule,
    PointageModule,
    EmployeModule,
    AutorisationSortieModule,
    NotificationModule,
    PersonnelModule,
    DemandeModule,
    RapportModule,
    SuperviseurModule,
    AuthenticationModule, // إضافة AuthenticationModule هنا
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
