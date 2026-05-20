import { z } from 'zod'
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import { ChevronDownIcon } from '@radix-ui/react-icons'
import { IconCheck, IconLoader2 } from '@tabler/icons-react'
import { toast } from 'sonner'
import { fonts } from '@/config/fonts'
import { cn } from '@/lib/utils'
import { useUnsavedChanges } from '@/hooks/use-unsaved-changes'
import { useFont } from '@/context/font-context'
import { useTheme } from '@/context/theme-context'
import { Button, buttonVariants } from '@/components/ui/button'
import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from '@/components/ui/form'
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import SettingsSection from '../components/settings-section'

const preferencesSchema = z.object({
  theme: z.enum(['light', 'dark', 'system']),
  font: z.enum(fonts),
  language: z.string(),
  dateFormat: z.string(),
  timeFormat: z.string(),
})

type PreferencesFormValues = z.infer<typeof preferencesSchema>

export default function PreferencesForm() {
  const { font, setFont } = useFont()
  const { theme, setTheme } = useTheme()

  const form = useForm<PreferencesFormValues>({
    resolver: zodResolver(preferencesSchema),
    defaultValues: {
      theme: theme as 'light' | 'dark' | 'system',
      font,
      language: 'en',
      dateFormat: 'DD/MM/YYYY',
      timeFormat: '24h',
    },
  })

  useUnsavedChanges(form.formState.isDirty)

  async function onSubmit(data: PreferencesFormValues) {
    if (data.font !== font) setFont(data.font)
    if (data.theme !== theme) setTheme(data.theme)
    await new Promise((resolve) => setTimeout(resolve, 400))
    toast.success('Preferences updated')
    form.reset(data)
  }

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-6'>
        <SettingsSection
          title='Appearance'
          description='Customize the look and feel of the dashboard.'
        >
          <div className='space-y-6'>
            <FormField
              control={form.control}
              name='theme'
              render={({ field }) => (
                <FormItem className='space-y-1'>
                  <FormLabel>Theme</FormLabel>
                  <FormDescription>
                    Select the theme for the dashboard.
                  </FormDescription>
                  <FormMessage />
                  <RadioGroup
                    onValueChange={field.onChange}
                    defaultValue={field.value}
                    className='grid max-w-lg grid-cols-3 gap-4 pt-2'
                  >
                    <FormItem>
                      <FormLabel className='[&:has([data-state=checked])>div]:border-primary'>
                        <FormControl>
                          <RadioGroupItem value='light' className='sr-only' />
                        </FormControl>
                        <div className='border-muted hover:border-accent items-center rounded-xl border-2 p-1'>
                          <div className='space-y-2 rounded-lg bg-[#ecedef] p-2'>
                            <div className='space-y-2 rounded-md bg-white p-2'>
                              <div className='h-2 w-[60px] rounded-lg bg-[#ecedef]' />
                              <div className='h-2 w-[80px] rounded-lg bg-[#ecedef]' />
                            </div>
                            <div className='flex items-center space-x-2 rounded-md bg-white p-2'>
                              <div className='h-4 w-4 rounded-full bg-[#ecedef]' />
                              <div className='h-2 w-[60px] rounded-lg bg-[#ecedef]' />
                            </div>
                          </div>
                        </div>
                        <span className='block w-full p-2 text-center text-sm font-normal'>
                          Light
                        </span>
                      </FormLabel>
                    </FormItem>

                    <FormItem>
                      <FormLabel className='[&:has([data-state=checked])>div]:border-primary'>
                        <FormControl>
                          <RadioGroupItem value='dark' className='sr-only' />
                        </FormControl>
                        <div className='border-muted bg-popover hover:bg-accent hover:text-accent-foreground items-center rounded-xl border-2 p-1'>
                          <div className='space-y-2 rounded-lg bg-slate-950 p-2'>
                            <div className='space-y-2 rounded-md bg-slate-800 p-2'>
                              <div className='h-2 w-[60px] rounded-lg bg-slate-400' />
                              <div className='h-2 w-[80px] rounded-lg bg-slate-400' />
                            </div>
                            <div className='flex items-center space-x-2 rounded-md bg-slate-800 p-2'>
                              <div className='h-4 w-4 rounded-full bg-slate-400' />
                              <div className='h-2 w-[60px] rounded-lg bg-slate-400' />
                            </div>
                          </div>
                        </div>
                        <span className='block w-full p-2 text-center text-sm font-normal'>
                          Dark
                        </span>
                      </FormLabel>
                    </FormItem>

                    <FormItem>
                      <FormLabel className='[&:has([data-state=checked])>div]:border-primary'>
                        <FormControl>
                          <RadioGroupItem value='system' className='sr-only' />
                        </FormControl>
                        <div className='border-muted hover:border-accent items-center overflow-hidden rounded-xl border-2 p-1'>
                          <div className='flex rounded-lg'>
                            <div className='w-1/2 space-y-2 bg-[#ecedef] p-2'>
                              <div className='space-y-2 rounded-l-md bg-white p-2'>
                                <div className='h-2 w-[30px] rounded-lg bg-[#ecedef]' />
                                <div className='h-2 w-[40px] rounded-lg bg-[#ecedef]' />
                              </div>
                              <div className='flex items-center space-x-1 rounded-l-md bg-white p-2'>
                                <div className='h-4 w-4 rounded-full bg-[#ecedef]' />
                                <div className='h-2 w-[20px] rounded-lg bg-[#ecedef]' />
                              </div>
                            </div>
                            <div className='w-1/2 space-y-2 bg-slate-950 p-2'>
                              <div className='space-y-2 rounded-r-md bg-slate-800 p-2'>
                                <div className='h-2 w-[30px] rounded-lg bg-slate-400' />
                                <div className='h-2 w-[40px] rounded-lg bg-slate-400' />
                              </div>
                              <div className='flex items-center space-x-1 rounded-r-md bg-slate-800 p-2'>
                                <div className='h-4 w-4 rounded-full bg-slate-400' />
                                <div className='h-2 w-[20px] rounded-lg bg-slate-400' />
                              </div>
                            </div>
                          </div>
                        </div>
                        <span className='block w-full p-2 text-center text-sm font-normal'>
                          System
                        </span>
                      </FormLabel>
                    </FormItem>
                  </RadioGroup>
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name='font'
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Font</FormLabel>
                  <div className='relative w-max'>
                    <FormControl>
                      <select
                        className={cn(
                          buttonVariants({ variant: 'outline' }),
                          'w-[200px] appearance-none font-normal capitalize'
                        )}
                        {...field}
                      >
                        {fonts.map((f) => (
                          <option key={f} value={f}>
                            {f}
                          </option>
                        ))}
                      </select>
                    </FormControl>
                    <ChevronDownIcon className='absolute top-2.5 right-3 h-4 w-4 opacity-50' />
                  </div>
                  <FormDescription>
                    Set the font used across the dashboard.
                  </FormDescription>
                  <FormMessage />
                </FormItem>
              )}
            />
          </div>
        </SettingsSection>

        <SettingsSection
          title='Regional'
          description='Language, date, and time preferences.'
        >
          <div className='space-y-6'>
            <FormField
              control={form.control}
              name='language'
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Language</FormLabel>
                  <Select
                    onValueChange={field.onChange}
                    defaultValue={field.value}
                  >
                    <FormControl>
                      <SelectTrigger className='w-[200px]'>
                        <SelectValue placeholder='Select language' />
                      </SelectTrigger>
                    </FormControl>
                    <SelectContent>
                      <SelectItem value='en'>English</SelectItem>
                      <SelectItem value='fr'>French</SelectItem>
                    </SelectContent>
                  </Select>
                  <FormDescription>
                    The language used throughout the dashboard.
                  </FormDescription>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name='dateFormat'
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Date format</FormLabel>
                  <Select
                    onValueChange={field.onChange}
                    defaultValue={field.value}
                  >
                    <FormControl>
                      <SelectTrigger className='w-[200px]'>
                        <SelectValue />
                      </SelectTrigger>
                    </FormControl>
                    <SelectContent>
                      <SelectItem value='DD/MM/YYYY'>DD/MM/YYYY</SelectItem>
                      <SelectItem value='MM/DD/YYYY'>MM/DD/YYYY</SelectItem>
                      <SelectItem value='YYYY-MM-DD'>YYYY-MM-DD</SelectItem>
                    </SelectContent>
                  </Select>
                  <FormDescription>
                    How dates appear in bookings and reports.
                  </FormDescription>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name='timeFormat'
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Time format</FormLabel>
                  <Select
                    onValueChange={field.onChange}
                    defaultValue={field.value}
                  >
                    <FormControl>
                      <SelectTrigger className='w-[200px]'>
                        <SelectValue />
                      </SelectTrigger>
                    </FormControl>
                    <SelectContent>
                      <SelectItem value='24h'>24-hour (14:00)</SelectItem>
                      <SelectItem value='12h'>12-hour (2:00 PM)</SelectItem>
                    </SelectContent>
                  </Select>
                  <FormDescription>
                    How times appear in schedules and bookings.
                  </FormDescription>
                  <FormMessage />
                </FormItem>
              )}
            />
          </div>
        </SettingsSection>

        <Button
          type='submit'
          disabled={!form.formState.isDirty || form.formState.isSubmitting}
        >
          {form.formState.isSubmitting ? (
            <>
              <IconLoader2 className='animate-spin' size={16} />
              Saving...
            </>
          ) : form.formState.isSubmitSuccessful && !form.formState.isDirty ? (
            <>
              <IconCheck size={16} />
              Saved
            </>
          ) : (
            'Save preferences'
          )}
        </Button>
      </form>
    </Form>
  )
}
