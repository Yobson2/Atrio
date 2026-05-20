import { IsString, IsOptional, IsDateString } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateBookingDto {
  @ApiProperty({ description: 'Salon ID' })
  @IsString()
  salonId: string;

  @ApiProperty({ description: 'Service ID' })
  @IsString()
  serviceId: string;

  @ApiPropertyOptional({ description: 'Preferred barber ID' })
  @IsOptional()
  @IsString()
  barberId?: string;

  @ApiProperty({ example: '2026-06-15', description: 'Booking date (YYYY-MM-DD)' })
  @IsDateString()
  date: string;

  @ApiProperty({ example: '14:00', description: 'Start time (HH:mm)' })
  @IsString()
  startTime: string;

  @ApiPropertyOptional({ description: 'Additional notes' })
  @IsOptional()
  @IsString()
  notes?: string;
}
