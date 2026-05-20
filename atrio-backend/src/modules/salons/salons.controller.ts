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
import { SalonsService } from './salons.service';
import { CreateSalonDto } from './dto/create-salon.dto';
import { UpdateSalonDto } from './dto/update-salon.dto';
import { PaginationQueryDto } from '@common/dto/pagination.dto';
import { Roles } from '@common/decorators/roles.decorator';
import { RolesGuard } from '@common/guards/roles.guard';
import { UserRole } from '@common/constants/roles.constant';

@ApiTags('Salons')
@ApiBearerAuth('JWT-auth')
@Controller('api/salons')
export class SalonsController {
  constructor(private readonly salonsService: SalonsService) {}

  @Post()
  @UseGuards(RolesGuard)
  @Roles(UserRole.SUPER_ADMIN, UserRole.ADMIN)
  @ApiOperation({ summary: 'Create a new salon' })
  @ApiResponse({ status: 201, description: 'Salon created' })
  create(@Body() dto: CreateSalonDto) {
    return this.salonsService.create(dto);
  }

  @Get()
  @ApiOperation({ summary: 'List all salons (paginated)' })
  @ApiResponse({ status: 200, description: 'Paginated salon list' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.salonsService.findAll(query);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get salon by ID' })
  @ApiResponse({ status: 200, description: 'Salon found' })
  @ApiResponse({ status: 404, description: 'Salon not found' })
  findOne(@Param('id') id: string) {
    return this.salonsService.findOne(id);
  }

  @Patch(':id')
  @UseGuards(RolesGuard)
  @Roles(UserRole.SUPER_ADMIN, UserRole.ADMIN, UserRole.MANAGER)
  @ApiOperation({ summary: 'Update salon' })
  @ApiResponse({ status: 200, description: 'Salon updated' })
  update(@Param('id') id: string, @Body() dto: UpdateSalonDto) {
    return this.salonsService.update(id, dto);
  }

  @Delete(':id')
  @UseGuards(RolesGuard)
  @Roles(UserRole.SUPER_ADMIN)
  @ApiOperation({ summary: 'Soft-delete salon (super admin only)' })
  @ApiResponse({ status: 200, description: 'Salon deleted' })
  remove(@Param('id') id: string) {
    return this.salonsService.remove(id);
  }
}
