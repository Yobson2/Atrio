import {
  Controller,
  Get,
  Post,
  Patch,
  Delete,
  Body,
  Param,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiBearerAuth,
} from '@nestjs/swagger';
import { ReviewsService } from './reviews.service';
import { CreateReviewDto } from './dto/create-review.dto';
import { PaginationQueryDto } from '@common/dto/pagination.dto';
import { Roles } from '@common/decorators/roles.decorator';
import { RolesGuard } from '@common/guards/roles.guard';
import { UserRole } from '@common/constants/roles.constant';

@ApiTags('Reviews')
@ApiBearerAuth('JWT-auth')
@Controller('api')
export class ReviewsController {
  constructor(private readonly reviewsService: ReviewsService) {}

  @Post('salons/:salonId/reviews')
  @UseGuards(RolesGuard)
  @Roles(UserRole.CLIENT)
  @ApiOperation({ summary: 'Create a review for a salon' })
  @ApiResponse({ status: 201, description: 'Review created' })
  create(
    @Param('salonId') salonId: string,
    @Body() dto: CreateReviewDto,
    @Req() req: any,
  ) {
    return this.reviewsService.create(
      { ...dto, salonId },
      req.user?.userId,
    );
  }

  @Get('salons/:salonId/reviews')
  @ApiOperation({ summary: 'List reviews for a salon' })
  findBySalon(
    @Param('salonId') salonId: string,
    @Query() query: PaginationQueryDto,
  ) {
    return this.reviewsService.findBySalon(salonId, query);
  }

  @Get('reviews/:id')
  @ApiOperation({ summary: 'Get review by ID' })
  findOne(@Param('id') id: string) {
    return this.reviewsService.findOne(id);
  }

  @Patch('reviews/:id/reply')
  @UseGuards(RolesGuard)
  @Roles(UserRole.SUPER_ADMIN, UserRole.ADMIN, UserRole.MANAGER)
  @ApiOperation({ summary: 'Reply to a review' })
  reply(@Param('id') id: string, @Body('reply') reply: string) {
    return this.reviewsService.reply(id, reply);
  }

  @Patch('reviews/:id/flag')
  @UseGuards(RolesGuard)
  @Roles(UserRole.SUPER_ADMIN, UserRole.ADMIN)
  @ApiOperation({ summary: 'Flag/unflag a review' })
  flag(@Param('id') id: string, @Body('flagged') flagged: boolean) {
    return this.reviewsService.flag(id, flagged);
  }

  @Delete('reviews/:id')
  @UseGuards(RolesGuard)
  @Roles(UserRole.SUPER_ADMIN, UserRole.ADMIN)
  @ApiOperation({ summary: 'Soft-delete review' })
  remove(@Param('id') id: string) {
    return this.reviewsService.remove(id);
  }
}
