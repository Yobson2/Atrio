export const ENDPOINTS = {
  AUTH: {
    LOGIN: '/auth/login',
    REGISTER: '/auth/register',
    LOGOUT: '/auth/logout',
    REFRESH: '/auth/refresh',
  },
  USERS: {
    LIST: '/users',
    DETAIL: (id: string) => `/users/${id}`,
  },
  TASKS: {
    LIST: '/tasks',
    DETAIL: (id: string) => `/tasks/${id}`,
  },
  SETTINGS: {
    PROFILE: '/settings/profile',
    AVATAR: '/settings/avatar',
    PASSWORD: '/settings/password',
    TWO_FACTOR: {
      ENABLE: '/settings/2fa/enable',
      VERIFY: '/settings/2fa/verify',
      DISABLE: '/settings/2fa/disable',
    },
    SESSIONS: '/settings/sessions',
    SESSION_REVOKE: (id: string) => `/settings/sessions/${id}`,
    LOGIN_HISTORY: '/settings/login-history',
    NOTIFICATIONS: '/settings/notifications',
    PREFERENCES: '/settings/preferences',
  },
} as const
