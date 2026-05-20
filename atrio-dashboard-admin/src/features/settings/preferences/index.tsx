import ContentSection from '../components/content-section'
import PreferencesForm from './preferences-form'

export default function SettingsPreferences() {
  return (
    <ContentSection
      title='Preferences'
      desc='Customize appearance, language, and regional settings.'
    >
      <PreferencesForm />
    </ContentSection>
  )
}
