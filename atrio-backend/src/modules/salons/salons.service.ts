import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, IsNull } from 'typeorm';
import { Salon } from './entities/salon.entity';
import { CreateSalonDto } from './dto/create-salon.dto';
import { UpdateSalonDto } from './dto/update-salon.dto';
import {
  PaginationQueryDto,
  PaginatedResponseDto,
} from '@common/dto/pagination.dto';
import { HttpException, HttpStatus } from '@nestjs/common';

@Injectable()
export class SalonsService {
  private readonly logger = new Logger(SalonsService.name);

  constructor(
    @InjectRepository(Salon)
    private readonly salonRepository: Repository<Salon>,
  ) {}

  async create(dto: CreateSalonDto): Promise<Salon> {
    const salon = this.salonRepository.create(dto);
    const saved = await this.salonRepository.save(salon);
    this.logger.log(`Salon created: ${saved.id}`);
    return saved;
  }

  async findAll(
    query: PaginationQueryDto,
  ): Promise<PaginatedResponseDto<Salon>> {
    const page = query.page ?? 1;
    const limit = query.limit ?? 10;

    const [salons, total] = await this.salonRepository.findAndCount({
      where: { deletedAt: IsNull() },
      skip: (page - 1) * limit,
      take: limit,
      order: { createdAt: 'DESC' },
    });

    return new PaginatedResponseDto(salons, total, page, limit);
  }

  async findOne(id: string): Promise<Salon> {
    const salon = await this.salonRepository.findOne({
      where: { id, deletedAt: IsNull() },
    });
    if (!salon) {
      throw new HttpException('Salon not found', HttpStatus.NOT_FOUND);
    }
    return salon;
  }

  async update(id: string, dto: UpdateSalonDto): Promise<Salon> {
    const salon = await this.findOne(id);
    Object.assign(salon, dto);
    return this.salonRepository.save(salon);
  }

  async remove(id: string): Promise<void> {
    const salon = await this.findOne(id);
    salon.deletedAt = new Date();
    salon.isActive = false;
    await this.salonRepository.save(salon);
    this.logger.log(`Salon soft-deleted: ${id}`);
  }
}
