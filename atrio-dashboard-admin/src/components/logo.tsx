import { type SVGProps } from 'react'

export function Logo({ ...props }: SVGProps<SVGSVGElement>) {
  return (
    <svg
      xmlns='http://www.w3.org/2000/svg'
      viewBox='0 0 32 32'
      fill='none'
      {...props}
    >
      <rect width='32' height='32' rx='7' fill='#00685F' />
      {/* Archway */}
      <path
        d='M16 6C11.03 6 7 10.03 7 15v12h4V15c0-2.76 2.24-5 5-5s5 2.24 5 5v12h4V15c0-4.97-4.03-9-9-9z'
        fill='white'
      />
      {/* Chair seat */}
      <ellipse cx='16' cy='21' rx='3.5' ry='2' fill='white' />
      {/* Chair base */}
      <rect x='15' y='23' width='2' height='3' rx='1' fill='white' />
      <rect x='12.5' y='25.5' width='7' height='1.5' rx='0.75' fill='white' />
    </svg>
  )
}
