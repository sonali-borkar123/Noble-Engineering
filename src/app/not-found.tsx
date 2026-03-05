import Link from "next/link";

export default function NotFound() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-background">
      <div className="text-center">
        <h1 className="font-display text-6xl font-bold text-foreground mb-4">404</h1>
        <p className="text-muted-foreground text-lg mb-8">Page not found</p>
        <Link href="/" className="inline-flex items-center justify-center px-8 py-4 bg-primary text-primary-foreground font-display text-sm uppercase tracking-widest hover:bg-amber-warm transition-colors rounded">
          Back to Home
        </Link>
      </div>
    </div>
  );
}
