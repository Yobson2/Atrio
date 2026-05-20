import { useState } from 'react'
import { z } from 'zod'
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import { IconCheck, IconEye, IconEyeOff, IconLoader2 } from '@tabler/icons-react'
import { toast } from 'sonner'
import { cn } from '@/lib/utils'
import { Button } from '@/components/ui/button'
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from '@/components/ui/form'
import { Input } from '@/components/ui/input'
import SettingsSection from '../components/settings-section'

const passwordSchema = z
  .object({
    currentPassword: z.string().min(1, 'Current password is required.'),
    newPassword: z
      .string()
      .min(12, 'Password must be at least 12 characters.')
      .max(128, 'Password must be at most 128 characters.')
      .regex(/[A-Z]/, 'Must contain an uppercase letter.')
      .regex(/[a-z]/, 'Must contain a lowercase letter.')
      .regex(/[0-9]/, 'Must contain a digit.')
      .regex(/[^A-Za-z0-9]/, 'Must contain a special character.'),
    confirmPassword: z.string(),
  })
  .refine((data) => data.newPassword === data.confirmPassword, {
    message: 'Passwords do not match.',
    path: ['confirmPassword'],
  })

type PasswordFormValues = z.infer<typeof passwordSchema>

const strengthRules = [
  { label: '12+ characters', test: (v: string) => v.length >= 12 },
  { label: 'Uppercase', test: (v: string) => /[A-Z]/.test(v) },
  { label: 'Lowercase', test: (v: string) => /[a-z]/.test(v) },
  { label: 'Number', test: (v: string) => /[0-9]/.test(v) },
  { label: 'Special character', test: (v: string) => /[^A-Za-z0-9]/.test(v) },
]

function PasswordStrength({ value }: { value: string }) {
  const passed = strengthRules.filter((r) => r.test(value)).length
  const percent = (passed / strengthRules.length) * 100
  const color =
    passed <= 2
      ? 'bg-destructive'
      : passed <= 3
        ? 'bg-orange-500'
        : passed <= 4
          ? 'bg-yellow-500'
          : 'bg-green-500'

  return (
    <div className='space-y-2'>
      <div className='bg-muted h-1.5 w-full rounded-full'>
        <div
          className={cn('h-full rounded-full transition-all', color)}
          style={{ width: `${percent}%` }}
        />
      </div>
      <div className='flex flex-wrap gap-x-4 gap-y-1'>
        {strengthRules.map((rule) => (
          <span
            key={rule.label}
            className={cn(
              'text-xs',
              rule.test(value)
                ? 'text-green-600 dark:text-green-400'
                : 'text-muted-foreground'
            )}
          >
            {rule.test(value) ? '\u2713' : '\u2022'} {rule.label}
          </span>
        ))}
      </div>
    </div>
  )
}

function PasswordInput({
  ...props
}: React.ComponentProps<typeof Input>) {
  const [visible, setVisible] = useState(false)
  return (
    <div className='relative'>
      <Input type={visible ? 'text' : 'password'} {...props} />
      <button
        type='button'
        className='text-muted-foreground hover:text-foreground absolute top-1/2 right-3 -translate-y-1/2'
        onClick={() => setVisible(!visible)}
        tabIndex={-1}
      >
        {visible ? <IconEyeOff size={16} /> : <IconEye size={16} />}
      </button>
    </div>
  )
}

export default function ChangePasswordForm() {
  const form = useForm<PasswordFormValues>({
    resolver: zodResolver(passwordSchema),
    defaultValues: {
      currentPassword: '',
      newPassword: '',
      confirmPassword: '',
    },
  })

  const newPasswordValue = form.watch('newPassword')

  async function onSubmit() {
    await new Promise((resolve) => setTimeout(resolve, 800))
    toast.success('Password updated successfully')
    form.reset()
  }

  return (
    <SettingsSection
      title='Change password'
      description='Update your password to keep your account secure.'
    >
      <Form {...form}>
        <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-4'>
          <FormField
            control={form.control}
            name='currentPassword'
            render={({ field }) => (
              <FormItem>
                <FormLabel>Current password</FormLabel>
                <FormControl>
                  <PasswordInput
                    placeholder='Enter current password'
                    maxLength={128}
                    {...field}
                  />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />

          <FormField
            control={form.control}
            name='newPassword'
            render={({ field }) => (
              <FormItem>
                <FormLabel>New password</FormLabel>
                <FormControl>
                  <PasswordInput
                    placeholder='Enter new password'
                    maxLength={128}
                    {...field}
                  />
                </FormControl>
                {newPasswordValue && (
                  <PasswordStrength value={newPasswordValue} />
                )}
                <FormMessage />
              </FormItem>
            )}
          />

          <FormField
            control={form.control}
            name='confirmPassword'
            render={({ field }) => (
              <FormItem>
                <FormLabel>Confirm new password</FormLabel>
                <FormControl>
                  <PasswordInput
                    placeholder='Confirm new password'
                    maxLength={128}
                    {...field}
                  />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />

          <Button
            type='submit'
            disabled={!form.formState.isDirty || form.formState.isSubmitting}
          >
            {form.formState.isSubmitting ? (
              <>
                <IconLoader2 className='animate-spin' size={16} />
                Updating...
              </>
            ) : form.formState.isSubmitSuccessful &&
              !form.formState.isDirty ? (
              <>
                <IconCheck size={16} />
                Updated
              </>
            ) : (
              'Update password'
            )}
          </Button>
        </form>
      </Form>
    </SettingsSection>
  )
}
