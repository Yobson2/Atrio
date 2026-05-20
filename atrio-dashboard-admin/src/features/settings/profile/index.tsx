import ContentSection from '../components/content-section'
import ProfileForm from './profile-form'

export default function SettingsProfile() {
  return (
    <ContentSection
      title='Profile'
      desc='Manage your personal information and how others see you.'
    >
      <ProfileForm />
    </ContentSection>
  )
}
