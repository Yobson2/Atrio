import { IconCheck, IconX } from '@tabler/icons-react'
import { Badge } from '@/components/ui/badge'
import SettingsSection from '../components/settings-section'

interface LoginEntry {
  id: string
  date: string
  ip: string
  device: string
  status: 'success' | 'failed'
}

const mockHistory: LoginEntry[] = [
  {
    id: '1',
    date: 'May 20, 2026 at 09:14 AM',
    ip: '192.168.1.1',
    device: 'Chrome on Windows',
    status: 'success',
  },
  {
    id: '2',
    date: 'May 19, 2026 at 11:02 PM',
    ip: '10.0.0.42',
    device: 'Safari on iPhone',
    status: 'success',
  },
  {
    id: '3',
    date: 'May 18, 2026 at 03:45 PM',
    ip: '203.0.113.50',
    device: 'Unknown browser',
    status: 'failed',
  },
  {
    id: '4',
    date: 'May 17, 2026 at 08:30 AM',
    ip: '192.168.1.1',
    device: 'Chrome on Windows',
    status: 'success',
  },
  {
    id: '5',
    date: 'May 16, 2026 at 02:15 PM',
    ip: '172.16.0.5',
    device: 'Firefox on macOS',
    status: 'success',
  },
]

export default function LoginHistory() {
  return (
    <SettingsSection
      title='Login history'
      description='Recent sign-in activity on your account.'
    >
      <div className='space-y-1'>
        {mockHistory.map((entry) => (
          <div
            key={entry.id}
            className='flex items-center justify-between py-3'
          >
            <div className='space-y-0.5'>
              <p className='text-sm font-medium'>{entry.device}</p>
              <div className='text-muted-foreground flex items-center gap-2 text-xs'>
                <span>{entry.ip}</span>
                <span className='text-muted-foreground/50'>&middot;</span>
                <span>{entry.date}</span>
              </div>
            </div>
            <Badge
              variant={entry.status === 'success' ? 'secondary' : 'destructive'}
              className='gap-1'
            >
              {entry.status === 'success' ? (
                <IconCheck size={12} />
              ) : (
                <IconX size={12} />
              )}
              {entry.status === 'success' ? 'Success' : 'Failed'}
            </Badge>
          </div>
        ))}
      </div>
    </SettingsSection>
  )
}
