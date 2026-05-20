import {
  IconGift,
  IconCrown,
  IconCoins,
  IconTrophy,
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
    title: 'Active Members',
    value: '2,890',
    change: '+340 this month',
    icon: IconCrown,
  },
  {
    title: 'Points Issued',
    value: '145.2K',
    change: '+22% from last month',
    icon: IconCoins,
  },
  {
    title: 'Rewards Redeemed',
    value: '892',
    change: '+15% from last month',
    icon: IconGift,
  },
  {
    title: 'Top Tier Members',
    value: '234',
    change: 'Gold & Platinum',
    icon: IconTrophy,
  },
]

export default function Loyalty() {
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
            <h1 className='text-2xl font-bold tracking-tight'>
              Loyalty Program
            </h1>
            <p className='text-muted-foreground'>
              Manage rewards, tiers, and member engagement.
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
                  icon={IconGift}
                  title='Loyalty program not configured'
                  description='Set up your loyalty tiers, point rules, and rewards to start engaging your clients.'
                  actionLabel='Configure Program'
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
