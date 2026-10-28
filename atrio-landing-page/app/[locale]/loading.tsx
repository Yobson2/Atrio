export default function Loading() {
  return (
    <div className="flex min-h-[60vh] items-center justify-center" role="status">
      <span className="size-10 animate-spin rounded-full bg-[conic-gradient(var(--color-teal),transparent_70%)] [mask:radial-gradient(farthest-side,transparent_calc(100%-4px),#000_calc(100%-4px))] motion-reduce:animate-none" />
    </div>
  );
}
