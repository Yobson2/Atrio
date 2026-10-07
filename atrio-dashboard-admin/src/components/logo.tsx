import { type SVGProps } from 'react'

export function Logo({ ...props }: SVGProps<SVGSVGElement>) {
  return (
    <svg
      xmlns='http://www.w3.org/2000/svg'
      viewBox='0 0 120 120'
      fill='none'
      {...props}
    >
      <defs>
        <linearGradient id='atrio-logo-bg' x1='0' y1='0' x2='1' y2='1'>
          <stop offset='0' stopColor='#00685F' />
          <stop offset='1' stopColor='#008378' />
        </linearGradient>
      </defs>
      <rect width='120' height='120' rx='27' fill='url(#atrio-logo-bg)' />
      {/* Portal A — archway + crossbar, gold oculus */}
      <g transform='translate(16.8 13.2) scale(0.72)'>
        <path
          d='M32 100V58a28 28 0 0 1 56 0v42M32 80h56'
          stroke='white'
          strokeWidth='16'
          strokeLinecap='round'
        />
        <circle cx='60' cy='54' r='7' fill='#F0C060' />
      </g>
    </svg>
  )
}
