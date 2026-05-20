import {
  IconBell,
  IconCalendarEvent,
  IconChecklist,
  IconGift,
  IconLayoutDashboard,
  IconLock,
  IconPackages,
  IconSettings,
  IconUser,
  IconUserHeart,
  IconUsers,
} from '@tabler/icons-react'
import { Logo } from '@/components/logo'
import { type SidebarData } from '../types'

export const sidebarData: SidebarData = {
  user: {
    name: 'Admin',
    email: 'admin@example.com',
    avatar: '/avatars/shadcn.jpg',
  },
  teams: [
    {
      name: 'Atrio',
      logo: Logo,
      plan: 'Salon Management',
    },
  ],
  navGroups: [
    {
      title: 'General',
      items: [
        {
          title: 'Dashboard',
          url: '/dashboard',
          icon: IconLayoutDashboard,
        },
        {
          title: 'Bookings',
          url: '/bookings',
          icon: IconCalendarEvent,
        },
        {
          title: 'Clients',
          url: '/clients',
          icon: IconUserHeart,
        },
        {
          title: 'Users',
          url: '/users',
          icon: IconUsers,
        },
        {
          title: 'Tasks',
          url: '/tasks',
          icon: IconChecklist,
        },
      ],
    },
    {
      title: 'Engagement',
      items: [
        {
          title: 'Loyalty',
          url: '/loyalty',
          icon: IconGift,
        },
        {
          title: 'Apps',
          url: '/apps',
          icon: IconPackages,
        },
      ],
    },
    {
      title: 'Other',
      items: [
        {
          title: 'Settings',
          icon: IconSettings,
          items: [
            {
              title: 'Profile',
              url: '/settings',
              icon: IconUser,
            },
            {
              title: 'Security',
              url: '/settings/security',
              icon: IconLock,
            },
            {
              title: 'Notifications',
              url: '/settings/notifications',
              icon: IconBell,
            },
            {
              title: 'Preferences',
              url: '/settings/preferences',
              icon: IconSettings,
            },
          ],
        },
      ],
    },
  ],
}
