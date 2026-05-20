import { IconInbox } from '@tabler/icons-react'
import { AnimatedContainer } from '@/components/motion/animated-container'
import { Button } from '@/components/ui/button'

interface EmptyStateProps {
  icon?: React.ElementType
  title?: string
  description?: string
  actionLabel?: string
  onAction?: () => void
}

export function EmptyState({
  icon: Icon = IconInbox,
  title = 'No results found',
  description = 'Try adjusting your search or filters.',
  actionLabel,
  onAction,
}: EmptyStateProps) {
  return (
    <AnimatedContainer
      variant='fadeSlideUp'
      className='flex flex-col items-center justify-center py-16 text-center'
    >
      <div className='bg-muted mb-4 rounded-full p-4'>
        <Icon className='text-muted-foreground h-8 w-8' />
      </div>
      <h3 className='text-lg font-semibold'>{title}</h3>
      <p className='text-muted-foreground mt-1 max-w-sm text-sm'>
        {description}
      </p>
      {actionLabel && onAction && (
        <Button className='mt-4' onClick={onAction}>
          {actionLabel}
        </Button>
      )}
    </AnimatedContainer>
  )
}
