import { createFileRoute } from '@tanstack/react-router'
import Loyalty from '@/features/loyalty'

export const Route = createFileRoute('/_authenticated/loyalty/')({
  component: Loyalty,
})
