import { useRef, useState } from 'react'
import { IconCamera } from '@tabler/icons-react'
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar'

interface AvatarUploadProps {
  currentSrc?: string
  fallback: string
  onFileSelect: (file: File) => void
}

export default function AvatarUpload({
  currentSrc,
  fallback,
  onFileSelect,
}: AvatarUploadProps) {
  const inputRef = useRef<HTMLInputElement>(null)
  const [preview, setPreview] = useState<string | undefined>(currentSrc)

  function handleChange(e: React.ChangeEvent<HTMLInputElement>) {
    const file = e.target.files?.[0]
    if (!file) return
    setPreview(URL.createObjectURL(file))
    onFileSelect(file)
  }

  return (
    <div
      className='group relative cursor-pointer'
      onClick={() => inputRef.current?.click()}
      role='button'
      tabIndex={0}
      onKeyDown={(e) => {
        if (e.key === 'Enter' || e.key === ' ') inputRef.current?.click()
      }}
    >
      <Avatar className='size-20'>
        <AvatarImage src={preview} alt='Profile photo' />
        <AvatarFallback className='text-lg'>{fallback}</AvatarFallback>
      </Avatar>
      <div className='bg-foreground/40 absolute inset-0 flex items-center justify-center rounded-full opacity-0 transition-opacity group-hover:opacity-100'>
        <IconCamera className='text-white' size={20} />
      </div>
      <input
        ref={inputRef}
        type='file'
        accept='image/*'
        className='sr-only'
        onChange={handleChange}
      />
    </div>
  )
}
