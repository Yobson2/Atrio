import { create } from 'zustand'

interface AuthUser {
  accountNo: string
  email: string
  role: string[]
  exp: number
}

interface AuthState {
  auth: {
    user: AuthUser | null
    setUser: (user: AuthUser | null) => void
    accessToken: string
    setAccessToken: (accessToken: string) => void
    resetAccessToken: () => void
    reset: () => void
  }
}

export const useAuthStore = create<AuthState>()((set) => ({
  auth: {
    user: null,
    setUser: (user) =>
      set((state) => ({ ...state, auth: { ...state.auth, user } })),
    accessToken: '',
    setAccessToken: (accessToken) =>
      set((state) => ({ ...state, auth: { ...state.auth, accessToken } })),
    resetAccessToken: () =>
      set((state) => ({ ...state, auth: { ...state.auth, accessToken: '' } })),
    reset: () =>
      set((state) => ({
        ...state,
        auth: { ...state.auth, user: null, accessToken: '' },
      })),
  },
}))

// ─── Idle session timeout (15 min) ─────────────────────────────
const SESSION_TIMEOUT_MS = 15 * 60 * 1000

let idleTimer: ReturnType<typeof setTimeout> | null = null

function resetIdleTimer() {
  if (idleTimer) clearTimeout(idleTimer)
  const token = useAuthStore.getState().auth.accessToken
  if (!token) return
  idleTimer = setTimeout(() => {
    useAuthStore.getState().auth.reset()
    window.location.href = '/sign-in'
  }, SESSION_TIMEOUT_MS)
}

if (typeof window !== 'undefined') {
  const events: (keyof WindowEventMap)[] = ['click', 'keypress', 'scroll', 'mousemove']
  events.forEach((evt) => window.addEventListener(evt, resetIdleTimer, { passive: true }))
  resetIdleTimer()
}
