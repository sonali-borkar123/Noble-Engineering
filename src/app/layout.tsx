import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Noble Engineering - Heavy Fabrication & Engineering Solutions",
  description: "Complete Solution Provider for Heavy Fabrication Assemblies — World Class Quality, Competitive Cost, Reliable Products.",
  icons: {
    icon: "/logo.jpeg",
    apple: "/logo.jpeg",
  },
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
