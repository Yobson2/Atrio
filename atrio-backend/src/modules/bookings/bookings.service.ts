import { Injectable, Logger, HttpException, HttpStatus } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Booking, BookingStatus } from './entities/booking.entity';
import { CreateBookingDto } from './dto/create-booking.dto';
import { UpdateBookingDto } from './dto/update-booking.dto';
import {
  PaginationQueryDto,
  PaginatedResponseDto,
} from '@common/dto/pagination.dto';

@Injectable()
export class BookingsService {
  private readonly logger = new Logger(BookingsService.name);

  constructor(
    @InjectRepository(Booking)
    private readonly bookingRepository: Repository<Booking>,
  ) {}

  async create(dto: CreateBookingDto, clientId: string): Promise<Booking> {
    const booking = this.bookingRepository.create({
      ...dto,
      clientId,
      status: BookingStatus.PENDING,
    });
    const saved = await this.bookingRepository.save(booking);
    this.logger.log(`Booking created: ${saved.id}`);
    return saved;
  }

  async findAll(
    query: PaginationQueryDto,
    filters?: { salonId?: string; clientId?: string; status?: BookingStatus },
  ): Promise<PaginatedResponseDto<Booking>> {
    const page = query.page ?? 1;
    const limit = query.limit ?? 10;

    const where: Record<string, unknown> = {};
    if (filters?.salonId) where.salonId = filters.salonId;
    if (filters?.clientId) where.clientId = filters.clientId;
    if (filters?.status) where.status = filters.status;

    const [bookings, total] = await this.bookingRepository.findAndCount({
      where,
      skip: (page - 1) * limit,
      take: limit,
      order: { createdAt: 'DESC' },
    });

    return new PaginatedResponseDto(bookings, total, page, limit);
  }

  async findOne(id: string): Promise<Booking> {
    const booking = await this.bookingRepository.findOne({ where: { id } });
    if (!booking) {
      throw new HttpException('Booking not found', HttpStatus.NOT_FOUND);
    }
    return booking;
  }

  async update(id: string, dto: UpdateBookingDto): Promise<Booking> {
    const booking = await this.findOne(id);
    Object.assign(booking, dto);
    return this.bookingRepository.save(booking);
  }

  async cancel(id: string, reason?: string): Promise<Booking> {
    const booking = await this.findOne(id);
    booking.status = BookingStatus.CANCELLED;
    booking.cancelledAt = new Date();
    if (reason) booking.notes = reason;
    return this.bookingRepository.save(booking);
  }
}
