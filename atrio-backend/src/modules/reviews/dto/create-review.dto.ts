import { IsString, IsOptional, IsInt, Min, Max } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateReviewDto {
  @ApiProperty({ description: 'Salon ID' })
  @IsString()
  salonId: string;

  @ApiProperty({ example: 5, minimum: 1, maximum: 5 })
  @IsInt()
  @Min(1)
  @Max(5)
  rating: number;

  @ApiPropertyOptional({ example: 'Great service and friendly staff!' })
  @IsOptional()
  @IsString()
  content?: string;

  @ApiPropertyOptional({ description: 'Barber ID' })
  @IsOptional()
  @IsString()
  barberId?: string;

  @ApiPropertyOptional({ description: 'Booking ID' })
  @IsOptional()
  @IsString()
  bookingId?: string;
}
