import {
  IconBrowserCheck,
  IconCalendarEvent,
  IconChecklist,
  IconGift,
  IconLayoutDashboard,
  IconNotification,
  IconPackages,
  IconPalette,
  IconSettings,
  IconTool,
  IconUserCog,
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
              icon: IconUserCog,
            },
            {
              title: 'Account',
              url: '/settings/account',
              icon: IconTool,
            },
            {
              title: 'Appearance',
              url: '/settings/appearance',
              icon: IconPalette,
            },
            {
              title: 'Notifications',
              url: '/settings/notifications',
              icon: IconNotification,
            },
            {
              title: 'Display',
              url: '/settings/display',
              icon: IconBrowserCheck,
            },
          ],
        },
      ],
    },
  ],
}
