import { AxiosError } from 'axios'
import { toast } from 'sonner'

const SAFE_MESSAGES: Record<number, string> = {
  400: 'Invalid request. Please check your input.',
  401: 'Session expired. Please sign in again.',
  403: 'You do not have permission to perform this action.',
  404: 'The requested resource was not found.',
  409: 'A conflict occurred. Please refresh and try again.',
  422: 'Please check your input and try again.',
  429: 'Too many requests. Please wait a moment.',
  500: 'Something went wrong. Please try again later.',
}

export function handleServerError(error: unknown) {
  let errMsg = SAFE_MESSAGES[500]!

  if (
    error &&
    typeof error === 'object' &&
    'status' in error &&
    Number(error.status) === 204
  ) {
    errMsg = 'Content not found.'
  }

  if (error instanceof AxiosError) {
    const status = error.response?.status ?? 500
    errMsg = SAFE_MESSAGES[status] ?? SAFE_MESSAGES[500]!
  }

  toast.error(errMsg)
}
