import {
  Area,
  AreaChart,
  CartesianGrid,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from 'recharts'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'

const data = [
  { month: 'Jan', revenue: 4000, bookings: 240 },
  { month: 'Feb', revenue: 3200, bookings: 198 },
  { month: 'Mar', revenue: 5100, bookings: 320 },
  { month: 'Apr', revenue: 4800, bookings: 290 },
  { month: 'May', revenue: 6200, bookings: 410 },
  { month: 'Jun', revenue: 5800, bookings: 380 },
  { month: 'Jul', revenue: 7100, bookings: 450 },
  { month: 'Aug', revenue: 6900, bookings: 430 },
  { month: 'Sep', revenue: 7800, bookings: 510 },
  { month: 'Oct', revenue: 8200, bookings: 540 },
  { month: 'Nov', revenue: 7600, bookings: 490 },
  { month: 'Dec', revenue: 9100, bookings: 610 },
]

export function OverviewChart() {
  return (
    <Card>
      <CardHeader>
        <CardTitle>Revenue Overview</CardTitle>
      </CardHeader>
      <CardContent>
        <ResponsiveContainer width='100%' height={350}>
          <AreaChart data={data}>
            <defs>
              <linearGradient id='fillRevenue' x1='0' y1='0' x2='0' y2='1'>
                <stop offset='5%' stopColor='var(--color-chart-1)' stopOpacity={0.3} />
                <stop offset='95%' stopColor='var(--color-chart-1)' stopOpacity={0} />
              </linearGradient>
            </defs>
            <CartesianGrid
              strokeDasharray='3 3'
              stroke='var(--color-border)'
              vertical={false}
            />
            <XAxis
              dataKey='month'
              stroke='var(--color-muted-foreground)'
              fontSize={12}
              tickLine={false}
              axisLine={false}
            />
            <YAxis
              stroke='var(--color-muted-foreground)'
              fontSize={12}
              tickLine={false}
              axisLine={false}
              tickFormatter={(v: number) => `$${v / 1000}k`}
            />
            <Tooltip
              contentStyle={{
                backgroundColor: 'var(--color-card)',
                border: '1px solid var(--color-border)',
                borderRadius: '8px',
                color: 'var(--color-foreground)',
              }}
              formatter={(value: number) => [`$${value.toLocaleString()}`, 'Revenue']}
            />
            <Area
              type='monotone'
              dataKey='revenue'
              stroke='var(--color-chart-1)'
              fill='url(#fillRevenue)'
              strokeWidth={2}
            />
          </AreaChart>
        </ResponsiveContainer>
      </CardContent>
    </Card>
  )
}
