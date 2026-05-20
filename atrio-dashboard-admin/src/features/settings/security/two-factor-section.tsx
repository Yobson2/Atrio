import { useState } from 'react'
import { IconCheck, IconLoader2, IconShieldCheck } from '@tabler/icons-react'
import { toast } from 'sonner'
import { Button } from '@/components/ui/button'
import {
  InputOTP,
  InputOTPGroup,
  InputOTPSeparator,
  InputOTPSlot,
} from '@/components/ui/input-otp'
import SettingsSection from '../components/settings-section'

type TwoFactorState = 'disabled' | 'setup' | 'verifying' | 'enabled'

export default function TwoFactorSection() {
  const [state, setState] = useState<TwoFactorState>('disabled')
  const [otp, setOtp] = useState('')

  async function handleEnable() {
    setState('setup')
  }

  async function handleVerify() {
    if (otp.length !== 6) return
    setState('verifying')
    await new Promise((resolve) => setTimeout(resolve, 1000))
    setState('enabled')
    toast.success('Two-factor authentication enabled')
    setOtp('')
  }

  async function handleDisable() {
    setState('disabled')
    toast.success('Two-factor authentication disabled')
  }

  return (
    <SettingsSection
      title='Two-factor authentication'
      description='Add an extra layer of security to your account.'
    >
      {state === 'disabled' && (
        <div className='flex items-center justify-between'>
          <div className='flex items-center gap-3'>
            <div className='bg-muted flex size-10 items-center justify-center rounded-xl'>
              <IconShieldCheck size={20} className='text-muted-foreground' />
            </div>
            <div>
              <p className='text-sm font-medium'>2FA is not enabled</p>
              <p className='text-muted-foreground text-xs'>
                Protect your account with a one-time code.
              </p>
            </div>
          </div>
          <Button variant='outline' onClick={handleEnable}>
            Enable
          </Button>
        </div>
      )}

      {state === 'setup' && (
        <div className='space-y-4'>
          <div className='bg-muted/80 flex items-center justify-center rounded-xl p-6'>
            <div className='flex size-40 items-center justify-center rounded-xl bg-white'>
              <p className='text-muted-foreground text-center text-xs'>
                QR code placeholder
                <br />
                (connect authenticator app)
              </p>
            </div>
          </div>
          <div className='space-y-2'>
            <p className='text-sm font-medium'>
              Enter the 6-digit code from your authenticator app
            </p>
            <InputOTP maxLength={6} value={otp} onChange={setOtp}>
              <InputOTPGroup>
                <InputOTPSlot index={0} />
                <InputOTPSlot index={1} />
                <InputOTPSlot index={2} />
              </InputOTPGroup>
              <InputOTPSeparator />
              <InputOTPGroup>
                <InputOTPSlot index={3} />
                <InputOTPSlot index={4} />
                <InputOTPSlot index={5} />
              </InputOTPGroup>
            </InputOTP>
          </div>
          <div className='flex gap-2'>
            <Button onClick={handleVerify} disabled={otp.length !== 6}>
              Verify and activate
            </Button>
            <Button variant='ghost' onClick={() => setState('disabled')}>
              Cancel
            </Button>
          </div>
        </div>
      )}

      {state === 'verifying' && (
        <div className='flex items-center gap-3 py-4'>
          <IconLoader2 className='animate-spin' size={20} />
          <p className='text-sm'>Verifying code...</p>
        </div>
      )}

      {state === 'enabled' && (
        <div className='flex items-center justify-between'>
          <div className='flex items-center gap-3'>
            <div className='flex size-10 items-center justify-center rounded-xl bg-green-500/10'>
              <IconCheck size={20} className='text-green-600 dark:text-green-400' />
            </div>
            <div>
              <p className='text-sm font-medium'>2FA is enabled</p>
              <p className='text-muted-foreground text-xs'>
                Your account is protected with two-factor authentication.
              </p>
            </div>
          </div>
          <Button variant='outline' onClick={handleDisable}>
            Disable
          </Button>
        </div>
      )}
    </SettingsSection>
  )
}
