import { HTMLAttributes, useState } from 'react'
import { z } from 'zod'
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import { Link, useNavigate, useSearch } from '@tanstack/react-router'
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
import { PasswordInput } from '@/components/password-input'
import { toast } from 'sonner'
import { useAuthStore } from '@/stores/authStore'

type UserAuthFormProps = HTMLAttributes<HTMLFormElement>

const formSchema = z.object({
  email: z
    .string()
    .min(1, { message: 'Please enter your email' })
    .email({ message: 'Invalid email address' }),
  password: z
    .string()
    .min(1, {
      message: 'Please enter your password',
    })
    .min(12, {
      message: 'Password must be at least 12 characters long',
    })
    .max(128, {
      message: 'Password must be at most 128 characters',
    })
    .regex(/[A-Z]/, { message: 'Must contain an uppercase letter' })
    .regex(/[a-z]/, { message: 'Must contain a lowercase letter' })
    .regex(/[0-9]/, { message: 'Must contain a digit' })
    .regex(/[^A-Za-z0-9]/, { message: 'Must contain a special character' }),
})

export function UserAuthForm({ className, ...props }: UserAuthFormProps) {
  const [isLoading, setIsLoading] = useState(false)
  const navigate = useNavigate()
  const { redirect } = useSearch({ from: '/(auth)/sign-in' })
  const { setAccessToken, setUser } = useAuthStore((s) => s.auth)

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      email: '',
      password: '',
    },
  })

  function onSubmit(_data: z.infer<typeof formSchema>) {
    setIsLoading(true)

    // TODO: Replace with actual API call
    // Example: await loginUser(data.email, data.password)

    // Simulate API call
    setTimeout(() => {
      setIsLoading(false)

      // TODO: Replace with real token from API response
      setAccessToken('demo-token')
      setUser({
        accountNo: '1',
        email: _data.email,
        role: ['admin'],
        exp: Date.now() + 3600 * 1000,
      })

      toast.success('Login successful', {
        description: 'Redirecting to dashboard...',
      })

      // Navigate to the redirect param or default to /dashboard
      const to = redirect && /^\/[a-zA-Z0-9\-_/]*$/.test(redirect)
        ? redirect
        : '/dashboard'
      navigate({ to })
    }, 1500)
  }

  return (
    <Form {...form}>
      <form
        onSubmit={form.handleSubmit(onSubmit)}
        className={cn('grid gap-3', className)}
        {...props}
      >
        <FormField
          control={form.control}
          name='email'
          render={({ field }) => (
            <FormItem>
              <FormLabel>Email</FormLabel>
              <FormControl>
                <Input placeholder='name@example.com' {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <FormField
          control={form.control}
          name='password'
          render={({ field }) => (
            <FormItem className='relative'>
              <FormLabel>Password</FormLabel>
              <FormControl>
                <PasswordInput placeholder='********' {...field} />
              </FormControl>
              <FormMessage />
              <Link
                to='/forgot-password'
                className='text-muted-foreground absolute -top-0.5 right-0 text-sm font-medium hover:opacity-75'
              >
                Forgot password?
              </Link>
            </FormItem>
          )}
        />
        <Button className='mt-2' disabled={isLoading}>
          Login
        </Button>

       
     
      </form>
    </Form>
  )
}
