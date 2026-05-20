import {
  IconUserHeart,
  IconUserPlus,
  IconStar,
  IconRepeat,
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
    title: 'Total Clients',
    value: '3,842',
    change: '+120 this month',
    icon: IconUserHeart,
  },
  {
    title: 'New Clients',
    value: '284',
    change: '+18% from last month',
    icon: IconUserPlus,
  },
  {
    title: 'VIP Clients',
    value: '156',
    change: 'Top 5% spenders',
    icon: IconStar,
  },
  {
    title: 'Retention Rate',
    value: '87.4%',
    change: '+2.1% from last month',
    icon: IconRepeat,
  },
]

export default function Clients() {
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
            <h1 className='text-2xl font-bold tracking-tight'>Clients</h1>
            <p className='text-muted-foreground'>
              Manage your client base and relationships.
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
                  icon={IconUserHeart}
                  title='No clients yet'
                  description='Your client list will populate as customers book appointments and create accounts.'
                  actionLabel='Import Clients'
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
