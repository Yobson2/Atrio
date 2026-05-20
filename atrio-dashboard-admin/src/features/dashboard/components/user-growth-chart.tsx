import {
  Bar,
  BarChart,
  CartesianGrid,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from 'recharts'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'

const data = [
  { month: 'Jan', newUsers: 120, returning: 340 },
  { month: 'Feb', newUsers: 98, returning: 310 },
  { month: 'Mar', newUsers: 180, returning: 390 },
  { month: 'Apr', newUsers: 160, returning: 370 },
  { month: 'May', newUsers: 210, returning: 420 },
  { month: 'Jun', newUsers: 190, returning: 400 },
  { month: 'Jul', newUsers: 250, returning: 460 },
  { month: 'Aug', newUsers: 230, returning: 440 },
  { month: 'Sep', newUsers: 280, returning: 510 },
  { month: 'Oct', newUsers: 300, returning: 530 },
  { month: 'Nov', newUsers: 270, returning: 490 },
  { month: 'Dec', newUsers: 350, returning: 580 },
]

export function UserGrowthChart() {
  return (
    <Card>
      <CardHeader>
        <CardTitle>User Growth</CardTitle>
      </CardHeader>
      <CardContent>
        <ResponsiveContainer width='100%' height={350}>
          <BarChart data={data}>
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
            />
            <Tooltip
              contentStyle={{
                backgroundColor: 'var(--color-card)',
                border: '1px solid var(--color-border)',
                borderRadius: '8px',
                color: 'var(--color-foreground)',
              }}
            />
            <Bar
              dataKey='returning'
              stackId='users'
              fill='var(--color-chart-2)'
              radius={[0, 0, 0, 0]}
            />
            <Bar
              dataKey='newUsers'
              stackId='users'
              fill='var(--color-chart-1)'
              radius={[4, 4, 0, 0]}
            />
          </BarChart>
        </ResponsiveContainer>
      </CardContent>
    </Card>
  )
}
