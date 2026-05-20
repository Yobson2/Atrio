/**
 * Role Constants — Single Source of Truth for Atrio User Roles
 *
 * All role-related code MUST use these constants instead of hardcoded strings.
 */

export enum UserRole {
  SUPER_ADMIN = 'SUPER_ADMIN',
  ADMIN = 'ADMIN',
  MANAGER = 'MANAGER',
  CASHIER = 'CASHIER',
  CLIENT = 'CLIENT',
}

export enum UserStatus {
  ACTIVE = 'active',
  INACTIVE = 'inactive',
  INVITED = 'invited',
  SUSPENDED = 'suspended',
}

export const DEFAULT_ROLE = UserRole.CLIENT;

export const VALID_USER_ROLES: readonly UserRole[] = [
  UserRole.SUPER_ADMIN,
  UserRole.ADMIN,
  UserRole.MANAGER,
  UserRole.CASHIER,
  UserRole.CLIENT,
] as const;

export const ROLE_METADATA = {
  [UserRole.SUPER_ADMIN]: {
    displayName: 'Super Admin',
    description: 'Full platform access across all tenants',
  },
  [UserRole.ADMIN]: {
    displayName: 'Admin',
    description: 'Platform staff with operational access',
  },
  [UserRole.MANAGER]: {
    displayName: 'Manager',
    description: 'Salon owner/manager — manages own salon',
  },
  [UserRole.CASHIER]: {
    displayName: 'Cashier',
    description: 'Front-desk staff — manages queue and bookings',
  },
  [UserRole.CLIENT]: {
    displayName: 'Client',
    description: 'End-user who books services',
  },
} as const;

export function isUserRole(value: unknown): value is UserRole {
  return (
    typeof value === 'string' && VALID_USER_ROLES.includes(value as UserRole)
  );
}

export type UserRoleType = UserRole;
