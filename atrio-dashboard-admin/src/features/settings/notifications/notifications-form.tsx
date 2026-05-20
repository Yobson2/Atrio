import { useState } from 'react'
import { IconCheck, IconLoader2 } from '@tabler/icons-react'
import { toast } from 'sonner'
import { Button } from '@/components/ui/button'
import SettingsSection from '../components/settings-section'
import SettingsSwitchRow from '../components/settings-switch-row'

interface NotificationPreferences {
  newBooking: boolean
  cancellation: boolean
  rescheduling: boolean
  upcomingReminder: boolean
  newClient: boolean
  clientMessages: boolean
  paymentReceived: boolean
  paymentFailed: boolean
  refundProcessed: boolean
  securityAlerts: boolean
  staffChanges: boolean
  systemUpdates: boolean
}

const defaultPreferences: NotificationPreferences = {
  newBooking: true,
  cancellation: true,
  rescheduling: true,
  upcomingReminder: true,
  newClient: true,
  clientMessages: false,
  paymentReceived: true,
  paymentFailed: true,
  refundProcessed: false,
  securityAlerts: true,
  staffChanges: false,
  systemUpdates: false,
}

export function NotificationsForm() {
  const [prefs, setPrefs] = useState(defaultPreferences)
  const [saving, setSaving] = useState(false)
  const [saved, setSaved] = useState(false)

  function toggle(key: keyof NotificationPreferences) {
    setPrefs((prev) => ({ ...prev, [key]: !prev[key] }))
    setSaved(false)
  }

  async function handleSave() {
    setSaving(true)
    await new Promise((resolve) => setTimeout(resolve, 800))
    setSaving(false)
    setSaved(true)
    toast.success('Notification preferences updated')
    setTimeout(() => setSaved(false), 2000)
  }

  return (
    <div className='space-y-6'>
      <SettingsSection
        title='Appointments'
        description='Stay on top of your booking schedule.'
      >
        <div>
          <SettingsSwitchRow
            title='New booking'
            description='When a client books an appointment'
            checked={prefs.newBooking}
            onCheckedChange={() => toggle('newBooking')}
          />
          <SettingsSwitchRow
            title='Cancellation'
            description='When a booking is cancelled'
            checked={prefs.cancellation}
            onCheckedChange={() => toggle('cancellation')}
          />
          <SettingsSwitchRow
            title='Rescheduling'
            description='When a booking is rescheduled'
            checked={prefs.rescheduling}
            onCheckedChange={() => toggle('rescheduling')}
          />
          <SettingsSwitchRow
            title='Upcoming reminder'
            description='Reminder before an upcoming appointment'
            checked={prefs.upcomingReminder}
            onCheckedChange={() => toggle('upcomingReminder')}
          />
        </div>
      </SettingsSection>

      <SettingsSection
        title='Clients'
        description='Know when clients interact with your business.'
      >
        <div>
          <SettingsSwitchRow
            title='New registration'
            description='When a new client creates an account'
            checked={prefs.newClient}
            onCheckedChange={() => toggle('newClient')}
          />
          <SettingsSwitchRow
            title='Client messages'
            description='When a client sends you a message'
            checked={prefs.clientMessages}
            onCheckedChange={() => toggle('clientMessages')}
          />
        </div>
      </SettingsSection>

      <SettingsSection
        title='Payments'
        description='Track payment activity in real time.'
      >
        <div>
          <SettingsSwitchRow
            title='Payment received'
            description='When a payment is successfully processed'
            checked={prefs.paymentReceived}
            onCheckedChange={() => toggle('paymentReceived')}
          />
          <SettingsSwitchRow
            title='Payment failed'
            description='When a payment attempt fails'
            checked={prefs.paymentFailed}
            onCheckedChange={() => toggle('paymentFailed')}
          />
          <SettingsSwitchRow
            title='Refund processed'
            description='When a refund is issued to a client'
            checked={prefs.refundProcessed}
            onCheckedChange={() => toggle('refundProcessed')}
          />
        </div>
      </SettingsSection>

      <SettingsSection
        title='System'
        description='Important account and platform updates.'
      >
        <div>
          <SettingsSwitchRow
            title='Security alerts'
            description='Suspicious activity and security events'
            checked={prefs.securityAlerts}
            onCheckedChange={() => toggle('securityAlerts')}
            disabled
          />
          <SettingsSwitchRow
            title='Staff changes'
            description='When team members are added or removed'
            checked={prefs.staffChanges}
            onCheckedChange={() => toggle('staffChanges')}
          />
          <SettingsSwitchRow
            title='System updates'
            description='New features and platform changes'
            checked={prefs.systemUpdates}
            onCheckedChange={() => toggle('systemUpdates')}
          />
        </div>
      </SettingsSection>

      <Button onClick={handleSave} disabled={saving}>
        {saving ? (
          <>
            <IconLoader2 className='animate-spin' size={16} />
            Saving...
          </>
        ) : saved ? (
          <>
            <IconCheck size={16} />
            Saved
          </>
        ) : (
          'Save preferences'
        )}
      </Button>
    </div>
  )
}
