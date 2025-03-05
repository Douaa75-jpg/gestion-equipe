import { Test, TestingModule } from '@nestjs/testing';
import { SuperviseurController } from './superviseur.controller';
import { SuperviseurService } from './superviseur.service';

describe('SuperviseurController', () => {
  let controller: SuperviseurController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [SuperviseurController],
      providers: [SuperviseurService],
    }).compile();

    controller = module.get<SuperviseurController>(SuperviseurController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
