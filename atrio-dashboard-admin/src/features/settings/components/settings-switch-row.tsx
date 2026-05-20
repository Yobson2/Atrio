import { Switch } from '@/components/ui/switch'

interface SettingsSwitchRowProps {
  title: string
  description: string
  checked: boolean
  onCheckedChange: (checked: boolean) => void
  disabled?: boolean
}

export default function SettingsSwitchRow({
  title,
  description,
  checked,
  onCheckedChange,
  disabled,
}: SettingsSwitchRowProps) {
  return (
    <div className='flex items-center justify-between py-3'>
      <div className='space-y-0.5 pr-4'>
        <p className='text-sm font-medium'>{title}</p>
        <p className='text-muted-foreground text-xs'>{description}</p>
      </div>
      <Switch
        checked={checked}
        onCheckedChange={onCheckedChange}
        disabled={disabled}
      />
    </div>
  )
}
