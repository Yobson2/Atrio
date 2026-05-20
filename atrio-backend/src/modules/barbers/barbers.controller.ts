import {
  Controller,
  Get,
  Post,
  Patch,
  Delete,
  Body,
  Param,
  Query,
  UseGuards,
} from '@nestjs/common';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiBearerAuth,
} from '@nestjs/swagger';
import { BarbersService } from './barbers.service';
import { CreateBarberDto } from './dto/create-barber.dto';
import { UpdateBarberDto } from './dto/update-barber.dto';
import { PaginationQueryDto } from '@common/dto/pagination.dto';
import { Roles } from '@common/decorators/roles.decorator';
import { RolesGuard } from '@common/guards/roles.guard';
import { UserRole } from '@common/constants/roles.constant';

@ApiTags('Barbers')
@ApiBearerAuth('JWT-auth')
@Controller('api')
export class BarbersController {
  constructor(private readonly barbersService: BarbersService) {}

  @Post('salons/:salonId/barbers')
  @UseGuards(RolesGuard)
  @Roles(UserRole.SUPER_ADMIN, UserRole.ADMIN, UserRole.MANAGER)
  @ApiOperation({ summary: 'Add barber to salon' })
  @ApiResponse({ status: 201, description: 'Barber created' })
  create(
    @Param('salonId') salonId: string,
    @Body() dto: CreateBarberDto,
  ) {
    return this.barbersService.create({ ...dto, salonId });
  }

  @Get('salons/:salonId/barbers')
  @ApiOperation({ summary: 'List barbers for a salon' })
  @ApiResponse({ status: 200, description: 'Paginated barber list' })
  findBySalon(
    @Param('salonId') salonId: string,
    @Query() query: PaginationQueryDto,
  ) {
    return this.barbersService.findBySalon(salonId, query);
  }

  @Get('barbers/:id')
  @ApiOperation({ summary: 'Get barber by ID' })
  findOne(@Param('id') id: string) {
    return this.barbersService.findOne(id);
  }

  @Patch('barbers/:id')
  @UseGuards(RolesGuard)
  @Roles(UserRole.SUPER_ADMIN, UserRole.ADMIN, UserRole.MANAGER)
  @ApiOperation({ summary: 'Update barber' })
  update(@Param('id') id: string, @Body() dto: UpdateBarberDto) {
    return this.barbersService.update(id, dto);
  }

  @Delete('barbers/:id')
  @UseGuards(RolesGuard)
  @Roles(UserRole.SUPER_ADMIN, UserRole.ADMIN, UserRole.MANAGER)
  @ApiOperation({ summary: 'Soft-delete barber' })
  remove(@Param('id') id: string) {
    return this.barbersService.remove(id);
  }
}
