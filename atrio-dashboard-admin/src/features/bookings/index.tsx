import {
  IconCalendarEvent,
  IconClock,
  IconCurrencyDollar,
  IconCheck,
} from '@tabler/icons-react'
import { Header } from '@/components/layout/header'
import { Main } from '@/components/layout/main'
import { AnimatedContainer } from '@/components/motion/animated-container'
import {
  StaggerContainer,
  StaggerItem,
} from '@/components/motion/stagger-container'
import { ProfileDropdown } from '@/components/profile-dropdown'
import { Search } from '@/components/search'
import { ThemeSwitch } from '@/components/theme-switch'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { EmptyState } from '@/components/empty-state'

const stats = [
  {
    title: 'Total Bookings',
    value: '1,284',
    change: '+12% from last month',
    icon: IconCalendarEvent,
  },
  {
    title: 'Pending',
    value: '42',
    change: '6 require confirmation',
    icon: IconClock,
  },
  {
    title: 'Completed',
    value: '1,180',
    change: '+8% from last month',
    icon: IconCheck,
  },
  {
    title: 'Revenue',
    value: '$32,450',
    change: '+15.3% from last month',
    icon: IconCurrencyDollar,
  },
]

export default function Bookings() {
  return (
    <>
      <Header fixed>
        <Search />
        <div className='ml-auto flex items-center space-x-4'>
          <ThemeSwitch />
          <ProfileDropdown />
        </div>
      </Header>

      <Main>
        <div className='mb-2 flex items-center justify-between space-y-2'>
          <div>
            <h1 className='text-2xl font-bold tracking-tight'>Bookings</h1>
            <p className='text-muted-foreground'>
              Manage salon appointments and reservations.
            </p>
          </div>
        </div>

        <StaggerContainer className='grid gap-4 sm:grid-cols-2 lg:grid-cols-4'>
          {stats.map((stat) => (
            <StaggerItem key={stat.title}>
              <Card>
                <CardHeader className='flex flex-row items-center justify-between space-y-0 pb-2'>
                  <CardTitle className='text-sm font-medium'>
                    {stat.title}
                  </CardTitle>
                  <stat.icon className='text-muted-foreground h-4 w-4' />
                </CardHeader>
                <CardContent>
                  <div className='text-2xl font-bold'>{stat.value}</div>
                  <p className='text-muted-foreground text-xs'>{stat.change}</p>
                </CardContent>
              </Card>
            </StaggerItem>
          ))}
        </StaggerContainer>

        <AnimatedContainer variant='fadeSlideUp' delay={0.2}>
          <div className='mt-6'>
            <Card>
              <CardContent className='pt-6'>
                <EmptyState
                  icon={IconCalendarEvent}
                  title='No bookings yet'
                  description='Bookings will appear here once clients start scheduling appointments. Connect your booking system to get started.'
                  actionLabel='Connect Booking System'
                  onAction={() => {}}
                />
              </CardContent>
            </Card>
          </div>
        </AnimatedContainer>
      </Main>
    </>
  )
}
