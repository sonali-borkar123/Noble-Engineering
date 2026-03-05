import type { Metadata } from "next";
import GalleryContent from "@/components/GalleryContent";

export const metadata: Metadata = {
  title: "Product Gallery – Heavy Fabrication, Material Handling & Solar Structures",
  description:
    "Browse Noble Engineering's product gallery featuring heavy fabrication assemblies, material handling equipment, skid frames, and solar structures manufactured in Pune, India.",
  alternates: {
    canonical: "https://www.nobleengineering.info/gallery",
  },
  openGraph: {
    title: "Product Gallery | Noble Engineering",
    description:
      "View our range of heavy fabrication assemblies, material handling equipment, skid frames, and solar structures.",
    url: "https://www.nobleengineering.info/gallery",
    images: [{ url: "/logo.jpeg", alt: "Noble Engineering Product Gallery" }],
  },
};

export default function GalleryPage() {
  return <GalleryContent />;
}
