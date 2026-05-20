import {
  IsString,
  IsOptional,
  IsBoolean,
  IsArray,
  MinLength,
} from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateBarberDto {
  @ApiProperty({ description: 'Salon this barber belongs to' })
  @IsString()
  salonId: string;

  @ApiProperty({ example: 'James Smith' })
  @IsString()
  @MinLength(2)
  name: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  photoUrl?: string;

  @ApiPropertyOptional({ type: [String], example: ['fade', 'beard trim'] })
  @IsOptional()
  @IsArray()
  specialties?: string[];

  @ApiPropertyOptional({ example: 'senior' })
  @IsOptional()
  @IsString()
  tier?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  userId?: string;
}
