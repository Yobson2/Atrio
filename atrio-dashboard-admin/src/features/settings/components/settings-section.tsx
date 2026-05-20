interface SettingsSectionProps {
  title: string
  description?: string
  children: React.ReactNode
}

export default function SettingsSection({
  title,
  description,
  children,
}: SettingsSectionProps) {
  return (
    <div className='rounded-xl bg-muted/50 p-6'>
      <div className='space-y-1'>
        <h4 className='text-sm font-semibold tracking-tight'>{title}</h4>
        {description && (
          <p className='text-muted-foreground text-xs'>{description}</p>
        )}
      </div>
      <div className='pt-4'>{children}</div>
    </div>
  )
}
