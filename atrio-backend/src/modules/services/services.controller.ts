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
import { ServicesService } from './services.service';
import { CreateServiceDto } from './dto/create-service.dto';
import { UpdateServiceDto } from './dto/update-service.dto';
import { PaginationQueryDto } from '@common/dto/pagination.dto';
import { Roles } from '@common/decorators/roles.decorator';
import { RolesGuard } from '@common/guards/roles.guard';
import { UserRole } from '@common/constants/roles.constant';

@ApiTags('Services')
@ApiBearerAuth('JWT-auth')
@Controller('api')
export class ServicesController {
  constructor(private readonly servicesService: ServicesService) {}

  @Post('salons/:salonId/services')
  @UseGuards(RolesGuard)
  @Roles(UserRole.SUPER_ADMIN, UserRole.ADMIN, UserRole.MANAGER)
  @ApiOperation({ summary: 'Add service to salon' })
  @ApiResponse({ status: 201, description: 'Service created' })
  create(
    @Param('salonId') salonId: string,
    @Body() dto: CreateServiceDto,
  ) {
    return this.servicesService.create({ ...dto, salonId });
  }

  @Get('salons/:salonId/services')
  @ApiOperation({ summary: 'List services for a salon' })
  @ApiResponse({ status: 200, description: 'Paginated service list' })
  findBySalon(
    @Param('salonId') salonId: string,
    @Query() query: PaginationQueryDto,
  ) {
    return this.servicesService.findBySalon(salonId, query);
  }

  @Get('services/:id')
  @ApiOperation({ summary: 'Get service by ID' })
  findOne(@Param('id') id: string) {
    return this.servicesService.findOne(id);
  }

  @Patch('services/:id')
  @UseGuards(RolesGuard)
  @Roles(UserRole.SUPER_ADMIN, UserRole.ADMIN, UserRole.MANAGER)
  @ApiOperation({ summary: 'Update service' })
  update(@Param('id') id: string, @Body() dto: UpdateServiceDto) {
    return this.servicesService.update(id, dto);
  }

  @Delete('services/:id')
  @UseGuards(RolesGuard)
  @Roles(UserRole.SUPER_ADMIN, UserRole.ADMIN, UserRole.MANAGER)
  @ApiOperation({ summary: 'Soft-delete service' })
  remove(@Param('id') id: string) {
    return this.servicesService.remove(id);
  }
}
