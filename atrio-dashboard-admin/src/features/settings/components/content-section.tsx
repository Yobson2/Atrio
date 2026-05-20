import { ScrollArea } from '@/components/ui/scroll-area'

interface ContentSectionProps {
  title: string
  desc: string
  children: React.JSX.Element
}

export default function ContentSection({
  title,
  desc,
  children,
}: ContentSectionProps) {
  return (
    <div className='flex flex-1 flex-col'>
      <div className='flex-none'>
        <h3 className='text-lg font-semibold tracking-tight'>{title}</h3>
        <p className='text-muted-foreground text-sm'>{desc}</p>
      </div>
      <ScrollArea className='faded-bottom mt-6 h-full w-full scroll-smooth pr-4 pb-28'>
        <div className='-mx-1 px-1.5 lg:max-w-2xl'>{children}</div>
      </ScrollArea>
    </div>
  )
}
