import { Skeleton } from '@/components/ui/skeleton'

interface TableSkeletonProps {
  columns?: number
  rows?: number
}

export function TableSkeleton({ columns = 5, rows = 8 }: TableSkeletonProps) {
  return (
    <div className='space-y-4'>
      {/* Toolbar skeleton */}
      <div className='flex items-center justify-between'>
        <div className='flex items-center gap-2'>
          <Skeleton className='h-9 w-[250px]' />
          <Skeleton className='h-9 w-[100px]' />
          <Skeleton className='h-9 w-[100px]' />
        </div>
        <Skeleton className='h-9 w-[100px]' />
      </div>

      {/* Table skeleton */}
      <div className='rounded-md border'>
        {/* Header */}
        <div className='border-b p-4'>
          <div className='flex gap-4'>
            {Array.from({ length: columns }).map((_, i) => (
              <Skeleton
                key={`header-${i}`}
                className='h-4 flex-1'
              />
            ))}
          </div>
        </div>

        {/* Rows */}
        {Array.from({ length: rows }).map((_, rowIndex) => (
          <div
            key={`row-${rowIndex}`}
            className='border-b p-4 last:border-0'
          >
            <div className='flex items-center gap-4'>
              {Array.from({ length: columns }).map((_, colIndex) => (
                <Skeleton
                  key={`cell-${rowIndex}-${colIndex}`}
                  className='h-4 flex-1'
                />
              ))}
            </div>
          </div>
        ))}
      </div>

      {/* Pagination skeleton */}
      <div className='flex items-center justify-between'>
        <Skeleton className='h-4 w-[200px]' />
        <div className='flex gap-2'>
          <Skeleton className='h-9 w-9' />
          <Skeleton className='h-9 w-9' />
          <Skeleton className='h-9 w-9' />
          <Skeleton className='h-9 w-9' />
        </div>
      </div>
    </div>
  )
}
