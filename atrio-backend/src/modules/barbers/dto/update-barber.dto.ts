import { PartialType, OmitType } from '@nestjs/swagger';
import { CreateBarberDto } from './create-barber.dto';
import { IsBoolean, IsOptional } from 'class-validator';
import { ApiPropertyOptional } from '@nestjs/swagger';

export class UpdateBarberDto extends PartialType(
  OmitType(CreateBarberDto, ['salonId'] as const),
) {
  @ApiPropertyOptional()
  @IsOptional()
  @IsBoolean()
  isAvailable?: boolean;
}
