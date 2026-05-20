import { Controller, Get, Query, UseGuards } from '@nestjs/common';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiBearerAuth,
} from '@nestjs/swagger';
import { AuditLogService } from './audit-log.service';
import { PaginationQueryDto } from '@common/dto/pagination.dto';
import { Roles } from '@common/decorators/roles.decorator';
import { RolesGuard } from '@common/guards/roles.guard';
import { UserRole } from '@common/constants/roles.constant';

@ApiTags('Audit Log')
@ApiBearerAuth('JWT-auth')
@UseGuards(RolesGuard)
@Controller('api/audit-log')
export class AuditLogController {
  constructor(private readonly auditLogService: AuditLogService) {}

  @Get()
  @Roles(UserRole.SUPER_ADMIN)
  @ApiOperation({ summary: 'List audit log entries (super admin only)' })
  @ApiResponse({ status: 200, description: 'Paginated audit log' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.auditLogService.findAll(query);
  }
}
