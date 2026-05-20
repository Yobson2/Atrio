import ContentSection from '../components/content-section'
import { NotificationsForm } from './notifications-form'

export default function SettingsNotifications() {
  return (
    <ContentSection
      title='Notifications'
      desc='Choose what you want to be notified about.'
    >
      <NotificationsForm />
    </ContentSection>
  )
}
