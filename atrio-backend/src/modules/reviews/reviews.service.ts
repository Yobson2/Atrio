import { Injectable, Logger, HttpException, HttpStatus } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, IsNull } from 'typeorm';
import { Review } from './entities/review.entity';
import { CreateReviewDto } from './dto/create-review.dto';
import {
  PaginationQueryDto,
  PaginatedResponseDto,
} from '@common/dto/pagination.dto';

@Injectable()
export class ReviewsService {
  private readonly logger = new Logger(ReviewsService.name);

  constructor(
    @InjectRepository(Review)
    private readonly reviewRepository: Repository<Review>,
  ) {}

  async create(dto: CreateReviewDto, clientId: string): Promise<Review> {
    const review = this.reviewRepository.create({ ...dto, clientId });
    const saved = await this.reviewRepository.save(review);
    this.logger.log(`Review created: ${saved.id} for salon ${dto.salonId}`);
    return saved;
  }

  async findBySalon(
    salonId: string,
    query: PaginationQueryDto,
  ): Promise<PaginatedResponseDto<Review>> {
    const page = query.page ?? 1;
    const limit = query.limit ?? 10;

    const [reviews, total] = await this.reviewRepository.findAndCount({
      where: { salonId, deletedAt: IsNull() },
      skip: (page - 1) * limit,
      take: limit,
      order: { createdAt: 'DESC' },
    });

    return new PaginatedResponseDto(reviews, total, page, limit);
  }

  async findOne(id: string): Promise<Review> {
    const review = await this.reviewRepository.findOne({
      where: { id, deletedAt: IsNull() },
    });
    if (!review) {
      throw new HttpException('Review not found', HttpStatus.NOT_FOUND);
    }
    return review;
  }

  async reply(id: string, ownerReply: string): Promise<Review> {
    const review = await this.findOne(id);
    review.ownerReply = ownerReply;
    review.repliedAt = new Date();
    return this.reviewRepository.save(review);
  }

  async flag(id: string, flagged: boolean): Promise<Review> {
    const review = await this.findOne(id);
    review.isFlagged = flagged;
    return this.reviewRepository.save(review);
  }

  async remove(id: string): Promise<void> {
    const review = await this.findOne(id);
    review.deletedAt = new Date();
    await this.reviewRepository.save(review);
    this.logger.log(`Review soft-deleted: ${id}`);
  }
}
