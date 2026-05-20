import { Injectable, Logger, HttpException, HttpStatus } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, IsNull } from 'typeorm';
import { Barber } from './entities/barber.entity';
import { CreateBarberDto } from './dto/create-barber.dto';
import { UpdateBarberDto } from './dto/update-barber.dto';
import {
  PaginationQueryDto,
  PaginatedResponseDto,
} from '@common/dto/pagination.dto';

@Injectable()
export class BarbersService {
  private readonly logger = new Logger(BarbersService.name);

  constructor(
    @InjectRepository(Barber)
    private readonly barberRepository: Repository<Barber>,
  ) {}

  async create(dto: CreateBarberDto): Promise<Barber> {
    const barber = this.barberRepository.create(dto);
    const saved = await this.barberRepository.save(barber);
    this.logger.log(`Barber created: ${saved.id} for salon ${dto.salonId}`);
    return saved;
  }

  async findBySalon(
    salonId: string,
    query: PaginationQueryDto,
  ): Promise<PaginatedResponseDto<Barber>> {
    const page = query.page ?? 1;
    const limit = query.limit ?? 10;

    const [barbers, total] = await this.barberRepository.findAndCount({
      where: { salonId, deletedAt: IsNull() },
      skip: (page - 1) * limit,
      take: limit,
      order: { name: 'ASC' },
    });

    return new PaginatedResponseDto(barbers, total, page, limit);
  }

  async findOne(id: string): Promise<Barber> {
    const barber = await this.barberRepository.findOne({
      where: { id, deletedAt: IsNull() },
    });
    if (!barber) {
      throw new HttpException('Barber not found', HttpStatus.NOT_FOUND);
    }
    return barber;
  }

  async update(id: string, dto: UpdateBarberDto): Promise<Barber> {
    const barber = await this.findOne(id);
    Object.assign(barber, dto);
    return this.barberRepository.save(barber);
  }

  async remove(id: string): Promise<void> {
    const barber = await this.findOne(id);
    barber.deletedAt = new Date();
    await this.barberRepository.save(barber);
    this.logger.log(`Barber soft-deleted: ${id}`);
  }
}
