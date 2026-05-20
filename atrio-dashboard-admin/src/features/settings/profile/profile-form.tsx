import { z } from 'zod'
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import { IconCheck, IconLoader2 } from '@tabler/icons-react'
import { toast } from 'sonner'
import { useAuthStore } from '@/stores/authStore'
import { useUnsavedChanges } from '@/hooks/use-unsaved-changes'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from '@/components/ui/form'
import { Input } from '@/components/ui/input'
import { Textarea } from '@/components/ui/textarea'
import AvatarUpload from '../components/avatar-upload'

const profileFormSchema = z.object({
  fullName: z
    .string()
    .min(2, 'Name must be at least 2 characters.')
    .max(50, 'Name must not exceed 50 characters.'),
  phone: z
    .string()
    .max(20, 'Phone number is too long.')
    .optional()
    .or(z.literal('')),
  bio: z
    .string()
    .max(280, 'Bio must not exceed 280 characters.')
    .optional()
    .or(z.literal('')),
})

type ProfileFormValues = z.infer<typeof profileFormSchema>

export default function ProfileForm() {
  const user = useAuthStore((s) => s.auth.user)

  const form = useForm<ProfileFormValues>({
    resolver: zodResolver(profileFormSchema),
    defaultValues: {
      fullName: '',
      phone: '',
      bio: '',
    },
    mode: 'onChange',
  })

  useUnsavedChanges(form.formState.isDirty)

  async function onSubmit(data: ProfileFormValues) {
    await new Promise((resolve) => setTimeout(resolve, 800))
    toast.success('Profile updated successfully')
    form.reset(data)
  }

  const initials = (user?.email ?? 'A').charAt(0).toUpperCase()
  const roles = user?.role ?? ['Admin']

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className='space-y-8'>
        <div className='flex items-center gap-6'>
          <AvatarUpload
            fallback={initials}
            onFileSelect={() => {
              /* will integrate with API */
            }}
          />
          <div className='space-y-1'>
            <p className='text-sm font-medium'>{user?.email ?? 'admin@atrio.com'}</p>
            <div className='flex gap-2'>
              {roles.map((role) => (
                <Badge key={role} variant='secondary' className='capitalize'>
                  {role}
                </Badge>
              ))}
            </div>
          </div>
        </div>

        <FormField
          control={form.control}
          name='fullName'
          render={({ field }) => (
            <FormItem>
              <FormLabel>Full name</FormLabel>
              <FormControl>
                <Input
                  placeholder='Your full name'
                  maxLength={50}
                  {...field}
                />
              </FormControl>
              <FormDescription>
                This name will appear on your profile and in communications.
              </FormDescription>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name='phone'
          render={({ field }) => (
            <FormItem>
              <FormLabel>Phone number</FormLabel>
              <FormControl>
                <Input
                  placeholder='+1 (555) 000-0000'
                  type='tel'
                  maxLength={20}
                  {...field}
                />
              </FormControl>
              <FormDescription>
                Used for appointment reminders and account recovery.
              </FormDescription>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name='bio'
          render={({ field }) => (
            <FormItem>
              <FormLabel>Bio</FormLabel>
              <FormControl>
                <Textarea
                  placeholder='Describe your role at the salon...'
                  className='resize-none'
                  maxLength={280}
                  {...field}
                />
              </FormControl>
              <FormDescription>
                A short description visible to your team.
              </FormDescription>
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
              Saving...
            </>
          ) : form.formState.isSubmitSuccessful && !form.formState.isDirty ? (
            <>
              <IconCheck size={16} />
              Saved
            </>
          ) : (
            'Save changes'
          )}
        </Button>
      </form>
    </Form>
  )
}
