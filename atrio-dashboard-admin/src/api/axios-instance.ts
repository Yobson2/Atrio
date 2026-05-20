import axios from 'axios'
import { useAuthStore } from '@/stores/authStore'

/**
 * Decode a JWT payload without a library.
 * Returns null if the token is malformed.
 */
function decodeJwtPayload(
  token: string
): { exp?: number; [key: string]: unknown } | null {
  try {
    const base64 = token.split('.')[1]
    if (!base64) return null
    const json = atob(base64.replace(/-/g, '+').replace(/_/g, '/'))
    return JSON.parse(json) as { exp?: number }
  } catch {
    return null
  }
}

/** Returns true if the JWT has expired (or is malformed). */
function isTokenExpired(token: string): boolean {
  const payload = decodeJwtPayload(token)
  if (!payload?.exp) return false // no exp claim — assume valid
  return Date.now() >= payload.exp * 1000
}

// ─── Enforce HTTPS in production ─────────────────────────────
const baseURL = import.meta.env.VITE_API_URL || '/api'
if (
  import.meta.env.PROD &&
  typeof baseURL === 'string' &&
  baseURL.startsWith('http://')
) {
  throw new Error(
    'VITE_API_URL must use https:// in production builds.'
  )
}

const api = axios.create({
  baseURL,
  timeout: 30000,
  headers: {
    'Content-Type': 'application/json',
  },
})

// Request interceptor: check token expiry, then attach
api.interceptors.request.use(
  (config) => {
    const { accessToken, reset } = useAuthStore.getState().auth
    if (accessToken) {
      if (isTokenExpired(accessToken)) {
        reset()
        window.location.href = '/sign-in'
        return Promise.reject(new axios.Cancel('Token expired'))
      }
      config.headers.Authorization = `Bearer ${accessToken}`
    }

    // CSRF: attach token on state-changing requests
    if (['post', 'put', 'patch', 'delete'].includes(config.method ?? '')) {
      const csrfToken = document
        .querySelector('meta[name="csrf-token"]')
        ?.getAttribute('content')
      if (csrfToken) config.headers['X-CSRF-Token'] = csrfToken
    }

    return config
  },
  (error) => Promise.reject(error)
)

// Response interceptor: handle common errors
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      useAuthStore.getState().auth.reset()
    }
    return Promise.reject(error)
  }
)

export default api
