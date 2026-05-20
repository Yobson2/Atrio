import { useState } from 'react'
import {
  IconDeviceDesktop,
  IconDeviceMobile,
  IconMapPin,
} from '@tabler/icons-react'
import { toast } from 'sonner'
import { Button } from '@/components/ui/button'
import SettingsSection from '../components/settings-section'

interface Session {
  id: string
  device: string
  type: 'desktop' | 'mobile'
  ip: string
  location: string
  lastActive: string
  current: boolean
}

const mockSessions: Session[] = [
  {
    id: '1',
    device: 'Chrome on Windows',
    type: 'desktop',
    ip: '192.168.1.1',
    location: 'Paris, France',
    lastActive: 'Now',
    current: true,
  },
  {
    id: '2',
    device: 'Safari on iPhone',
    type: 'mobile',
    ip: '10.0.0.42',
    location: 'Paris, France',
    lastActive: '2 hours ago',
    current: false,
  },
  {
    id: '3',
    device: 'Firefox on macOS',
    type: 'desktop',
    ip: '172.16.0.5',
    location: 'Lyon, France',
    lastActive: '3 days ago',
    current: false,
  },
]

export default function ActiveSessions() {
  const [sessions, setSessions] = useState(mockSessions)

  function handleRevoke(id: string) {
    setSessions((prev) => prev.filter((s) => s.id !== id))
    toast.success('Session revoked')
  }

  return (
    <SettingsSection
      title='Active sessions'
      description='Devices where you are currently signed in.'
    >
      <div className='space-y-1'>
        {sessions.map((session) => (
          <div
            key={session.id}
            className='flex items-center justify-between py-3'
          >
            <div className='flex items-center gap-3'>
              <div className='bg-muted flex size-10 items-center justify-center rounded-xl'>
                {session.type === 'desktop' ? (
                  <IconDeviceDesktop size={18} className='text-muted-foreground' />
                ) : (
                  <IconDeviceMobile size={18} className='text-muted-foreground' />
                )}
              </div>
              <div>
                <p className='text-sm font-medium'>
                  {session.device}
                  {session.current && (
                    <span className='text-muted-foreground ml-2 text-xs font-normal'>
                      (this device)
                    </span>
                  )}
                </p>
                <div className='text-muted-foreground flex items-center gap-2 text-xs'>
                  <span>{session.ip}</span>
                  <span className='text-muted-foreground/50'>&middot;</span>
                  <IconMapPin size={12} />
                  <span>{session.location}</span>
                  <span className='text-muted-foreground/50'>&middot;</span>
                  <span>{session.lastActive}</span>
                </div>
              </div>
            </div>
            {!session.current && (
              <Button
                variant='ghost'
                size='sm'
                className='text-destructive hover:text-destructive'
                onClick={() => handleRevoke(session.id)}
              >
                Revoke
              </Button>
            )}
          </div>
        ))}
      </div>
    </SettingsSection>
  )
}
