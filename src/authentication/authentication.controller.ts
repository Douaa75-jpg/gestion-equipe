import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards } from '@nestjs/common';
import { AuthenticationService } from './authentication.service';
import { CreateAuthenticationDto } from './dto/create-authentication.dto';
import { UpdateAuthenticationDto } from './dto/update-authentication.dto';
import { LoginResponseDto } from './dto/login-response.dto';
import { ApiTags, ApiBearerAuth, ApiResponse } from '@nestjs/swagger';
import { JwtAuthGuard } from './guards/jwt-auth.guard'; // Importer le JwtAuthGuard

@Controller('authentication')
export class AuthenticationController {
  constructor(private readonly authenticationService: AuthenticationService) {}

  // Route pour la connexion (pas besoin de protection ici, car l'utilisateur s'authentifie)
  @Post('login')
  async login(
    @Body() createAuthenticationDto: CreateAuthenticationDto, // Contient l'email et le mot de passe
  ): Promise<LoginResponseDto> {
    const { email, password } = createAuthenticationDto;
    const result = await this.authenticationService.login(email, password);
    return result; // Renvoie le token JWT
  }

  // Route protégée : nécessite une authentification JWT pour y accéder
  @UseGuards(JwtAuthGuard)
  @Get()
  @ApiBearerAuth()  // إضافة توثيق Bearer
  @ApiResponse({ status: 200, description: 'Successfully fetched data' })
  @ApiResponse({ status: 401, description: 'Unauthorized' })
  findAll() {
    return this.authenticationService.findAll(); // Exemple de route protégée
  }

  @UseGuards(JwtAuthGuard)
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.authenticationService.findOne(+id); // Exemple de route protégée
  }

  // Routes non protégées pour la mise à jour et la suppression
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateAuthenticationDto: UpdateAuthenticationDto) {
    return this.authenticationService.update(+id, updateAuthenticationDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.authenticationService.remove(+id);
  }
}
