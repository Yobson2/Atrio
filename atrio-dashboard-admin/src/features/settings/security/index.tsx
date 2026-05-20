import ContentSection from '../components/content-section'
import ActiveSessions from './active-sessions'
import ChangePasswordForm from './change-password-form'
import LoginHistory from './login-history'
import TwoFactorSection from './two-factor-section'

export default function SettingsSecurity() {
  return (
    <ContentSection
      title='Security'
      desc='Manage your password, two-factor authentication, and sessions.'
    >
      <div className='space-y-6'>
        <ChangePasswordForm />
        <TwoFactorSection />
        <ActiveSessions />
        <LoginHistory />
      </div>
    </ContentSection>
  )
}
