import { Test, TestingModule } from '@nestjs/testing';
import { SuperviseurService } from './superviseur.service';

describe('SuperviseurService', () => {
  let service: SuperviseurService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [SuperviseurService],
    }).compile();

    service = module.get<SuperviseurService>(SuperviseurService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
