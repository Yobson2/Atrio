import { Injectable, Logger, HttpException, HttpStatus } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, IsNull } from 'typeorm';
import { SalonService } from './entities/salon-service.entity';
import { CreateServiceDto } from './dto/create-service.dto';
import { UpdateServiceDto } from './dto/update-service.dto';
import {
  PaginationQueryDto,
  PaginatedResponseDto,
} from '@common/dto/pagination.dto';

@Injectable()
export class ServicesService {
  private readonly logger = new Logger(ServicesService.name);

  constructor(
    @InjectRepository(SalonService)
    private readonly serviceRepository: Repository<SalonService>,
  ) {}

  async create(dto: CreateServiceDto): Promise<SalonService> {
    const service = this.serviceRepository.create(dto);
    const saved = await this.serviceRepository.save(service);
    this.logger.log(`Service created: ${saved.id} for salon ${dto.salonId}`);
    return saved;
  }

  async findBySalon(
    salonId: string,
    query: PaginationQueryDto,
  ): Promise<PaginatedResponseDto<SalonService>> {
    const page = query.page ?? 1;
    const limit = query.limit ?? 10;

    const [services, total] = await this.serviceRepository.findAndCount({
      where: { salonId, deletedAt: IsNull() },
      skip: (page - 1) * limit,
      take: limit,
      order: { name: 'ASC' },
    });

    return new PaginatedResponseDto(services, total, page, limit);
  }

  async findOne(id: string): Promise<SalonService> {
    const service = await this.serviceRepository.findOne({
      where: { id, deletedAt: IsNull() },
    });
    if (!service) {
      throw new HttpException('Service not found', HttpStatus.NOT_FOUND);
    }
    return service;
  }

  async update(id: string, dto: UpdateServiceDto): Promise<SalonService> {
    const service = await this.findOne(id);
    Object.assign(service, dto);
    return this.serviceRepository.save(service);
  }

  async remove(id: string): Promise<void> {
    const service = await this.findOne(id);
    service.deletedAt = new Date();
    service.isActive = false;
    await this.serviceRepository.save(service);
    this.logger.log(`Service soft-deleted: ${id}`);
  }
}
