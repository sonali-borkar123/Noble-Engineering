import type { Metadata } from "next";
import "./globals.css";

const siteUrl = "https://www.nobleengineering.info";

export const metadata: Metadata = {
  metadataBase: new URL(siteUrl),
  title: {
    default: "Noble Engineering – Heavy Fabrication & Engineering Solutions | Pune, India",
    template: "%s | Noble Engineering",
  },
  description:
    "Noble Engineering is a leading heavy fabrication company in Pune, India. We manufacture heavy fabrication assemblies, material handling equipment, skid frames, solar structures, and more. ISO 9001:2015 certified.",
  keywords: [
    "heavy fabrication",
    "engineering solutions",
    "material handling equipment",
    "skid frames",
    "solar structures",
    "fabrication company Pune",
    "heavy fabrication India",
    "industrial fabrication",
    "crane beams",
    "pressure tanks",
    "Noble Engineering",
    "Pimpri Chinchwad fabrication",
    "ISO certified fabrication",
    "PCMC fabrication"
  ],
  authors: [{ name: "Noble Engineering" }],
  creator: "Noble Engineering",
  publisher: "Noble Engineering",
  icons: {
    icon: "/logo.jpeg",
    apple: "/logo.jpeg",
  },
  openGraph: {
    type: "website",
    locale: "en_IN",
    url: siteUrl,
    siteName: "Noble Engineering",
    title: "Noble Engineering – Heavy Fabrication & Engineering Solutions | Pune",
    description:
      "Complete Solution Provider for Heavy Fabrication Assemblies — World Class Quality, Competitive Cost, Reliable Products. ISO 9001:2015 certified manufacturer in Pune, India.",
    images: [
      {
        url: "/logo.jpeg",
        width: 800,
        height: 600,
        alt: "Noble Engineering Logo",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "Noble Engineering – Heavy Fabrication & Engineering Solutions",
    description:
      "ISO 9001:2015 certified heavy fabrication company in Pune. Manufacturing heavy assemblies, material handling equipment, skid frames & solar structures.",
    images: ["/logo.jpeg"],
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      "max-video-preview": -1,
      "max-image-preview": "large",
      "max-snippet": -1,
    },
  },
  alternates: {
    canonical: siteUrl,
  },
  verification: {
    // Add your Google Search Console verification code here once you have it
    google: "google-site-verification=ESWcnZjw-P_5smyFC6AqiSc40P8fvkUqy7d947RjAAI",
  },
};

// JSON-LD Structured Data for Local Business
const jsonLd = {
  "@context": "https://schema.org",
  "@type": "LocalBusiness",
  name: "Noble Engineering",
  description:
    "Complete Solution Provider for Heavy Fabrication Assemblies — World Class Quality, Competitive Cost, Reliable Products.",
  url: "https://www.nobleengineering.info",
  logo: "https://www.nobleengineering.info/logo.jpeg",
  image: "https://www.nobleengineering.info/logo.jpeg",
  telephone: "+919766314010",
  email: "noble.engineering0922@gmail.com",
  address: {
    "@type": "PostalAddress",
    streetAddress:
      "Gat No 1402, Sonawane Wasti Rd, near Trimurti kata, Jyotiba Nagar, Chikhali",
    addressLocality: "Pimpri-Chinchwad",
    addressRegion: "Maharashtra",
    postalCode: "411062",
    addressCountry: "IN",
  },
  geo: {
    "@type": "GeoCoordinates",
    latitude: 18.6725,
    longitude: 73.7988,
  },
  foundingDate: "2020",
  priceRange: "$$",
  openingHoursSpecification: {
    "@type": "OpeningHoursSpecification",
    dayOfWeek: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
    opens: "09:00",
    closes: "18:00",
  },
  sameAs: [],
  hasOfferCatalog: {
    "@type": "OfferCatalog",
    name: "Engineering Products",
    itemListElement: [
      {
        "@type": "Offer",
        itemOffered: {
          "@type": "Service",
          name: "Heavy Fabrication",
          description:
            "Concrete buckets, crane beams, construction cages, luminary carriages, and pressure tanks.",
        },
      },
      {
        "@type": "Offer",
        itemOffered: {
          "@type": "Service",
          name: "Material Handling Equipment",
          description:
            "Trolleys, pallets, and custom material handling solutions for industrial applications.",
        },
      },
      {
        "@type": "Offer",
        itemOffered: {
          "@type": "Service",
          name: "Skid Frames & Structures",
          description:
            "Skid frames, pipe supports, base frames, ladders, platforms, railings, and structural assemblies.",
        },
      },
      {
        "@type": "Offer",
        itemOffered: {
          "@type": "Service",
          name: "Solar Structures",
          description:
            "Solar panel mounting structures, frames, and support systems for renewable energy installations.",
        },
      },
    ],
  },
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <head>
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />
      </head>
      <body>{children}</body>
    </html>
  );
}
