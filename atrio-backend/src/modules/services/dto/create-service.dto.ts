import {
  IsString,
  IsNumber,
  IsOptional,
  IsBoolean,
  Min,
  Max,
  MinLength,
} from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateServiceDto {
  @ApiProperty({ description: 'Salon this service belongs to' })
  @IsString()
  salonId: string;

  @ApiProperty({ example: 'Classic Haircut' })
  @IsString()
  @MinLength(2)
  name: string;

  @ApiProperty({ example: 25.0 })
  @IsNumber()
  @Min(0)
  price: number;

  @ApiProperty({ example: 30 })
  @IsNumber()
  @Min(5)
  @Max(480)
  durationMinutes: number;

  @ApiPropertyOptional({ example: 'A classic gentleman haircut' })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  imageUrl?: string;

  @ApiPropertyOptional({ example: 'haircut' })
  @IsOptional()
  @IsString()
  category?: string;

  @ApiPropertyOptional({ example: 'premium' })
  @IsOptional()
  @IsString()
  tier?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  isPopular?: boolean;
}
