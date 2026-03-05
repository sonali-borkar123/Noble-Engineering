"use client";

import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { ArrowLeft, X, ChevronLeft, ChevronRight } from "lucide-react";
import Link from "next/link";
import Image, { StaticImageData } from "next/image";
import fabricationImg from "@/assets/heavy_2.jpeg";
import fabricationImg1 from "@/assets/heavy_3.jpeg";
import fabricationImg2 from "@/assets/heavy_4.jpeg";
import materialImg from "@/assets/material_1.jpeg";
import materialImg1 from "@/assets/material_2.jpeg";
import materialImg2 from "@/assets/material_3.jpeg";
import materialImg3 from "@/assets/material_4.jpeg";
import skidImg from "@/assets/skid_2.jpeg";
import skidImg1 from "@/assets/skid_3.jpeg";
import skidImg2 from "@/assets/skid_4.jpeg";
import solar1 from "@/assets/solar_1.jpeg";
import solar2 from "@/assets/solar_2.jpeg";
import solar3 from "@/assets/solar_3.jpeg";

const galleryItems: { id: number; title: string; image: StaticImageData }[] = [
  { id: 1, title: "Heavy Fabrication", image: fabricationImg },
  { id: 2, title: "Heavy Fabrication", image: fabricationImg1 },
  { id: 3, title: "Heavy Fabrication", image: fabricationImg2 },
  { id: 4, title: "Skid Frame Assembly", image: skidImg },
  { id: 5, title: "Skid Frame Assembly", image: skidImg1 },
  { id: 6, title: "Skid Frame Assembly", image: skidImg2 },
  { id: 7, title: "Solar Structure", image: solar1 },
  { id: 8, title: "Solar Structure", image: solar2 },
  { id: 9, title: "Solar Structure", image: solar3 },
  { id: 10, title: "Material Handling Trolley", image: materialImg },
  { id: 11, title: "Material Handling Trolley", image: materialImg1 },
  { id: 12, title: "Material Handling Trolley", image: materialImg2 },
  { id: 13, title: "Material Handling Trolley", image: materialImg3 },
];

const GalleryContent = () => {
  const [lightboxIndex, setLightboxIndex] = useState<number | null>(null);

  const openLightbox = (index: number) => setLightboxIndex(index);
  const closeLightbox = () => setLightboxIndex(null);
  const goNext = () => { if (lightboxIndex !== null) setLightboxIndex((lightboxIndex + 1) % galleryItems.length); };
  const goPrev = () => { if (lightboxIndex !== null) setLightboxIndex((lightboxIndex - 1 + galleryItems.length) % galleryItems.length); };

  return (
    <div className="min-h-screen bg-background">
      <div className="bg-steel py-20 pt-28">
        <div className="container mx-auto px-4">
          <Link href="/" className="inline-flex items-center gap-2 text-muted-on-dark hover:text-primary transition-colors mb-6 text-sm">
            <ArrowLeft size={16} /> Back to Home
          </Link>
          <h1 className="font-display text-4xl md:text-5xl font-bold text-on-dark">
            Product <span className="text-primary">Gallery</span>
          </h1>
          <p className="text-muted-on-dark mt-3 text-lg max-w-2xl">Browse our range of heavy fabrication assemblies, material handling equipment, and structural solutions.</p>
        </div>
      </div>

      <div className="container mx-auto px-4 py-12 pb-20">
        <motion.div layout className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          <AnimatePresence mode="popLayout">
            {galleryItems.map((item, index) => (
              <motion.div key={item.id} layout initial={{ opacity: 0, scale: 0.9 }} animate={{ opacity: 1, scale: 1 }} exit={{ opacity: 0, scale: 0.9 }} transition={{ duration: 0.3 }} className="group cursor-pointer overflow-hidden rounded-lg bg-card border border-border" onClick={() => openLightbox(index)}>
                <div className="aspect-[4/3] overflow-hidden relative">
                  <Image src={item.image} alt={item.title} fill className="object-cover transition-transform duration-500 group-hover:scale-110" />
                </div>
                <div className="p-4">
                  <h3 className="font-display text-lg font-semibold text-foreground">{item.title}</h3>
                </div>
              </motion.div>
            ))}
          </AnimatePresence>
        </motion.div>
      </div>

      <AnimatePresence>
        {lightboxIndex !== null && (
          <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }} className="fixed inset-0 z-50 bg-black/90 flex items-center justify-center" onClick={closeLightbox}>
            <button onClick={closeLightbox} className="absolute top-6 right-6 text-white/70 hover:text-white transition-colors" aria-label="Close lightbox"><X size={28} /></button>
            <button onClick={(e) => { e.stopPropagation(); goPrev(); }} className="absolute left-4 text-white/70 hover:text-white transition-colors" aria-label="Previous image"><ChevronLeft size={36} /></button>
            <button onClick={(e) => { e.stopPropagation(); goNext(); }} className="absolute right-4 text-white/70 hover:text-white transition-colors" aria-label="Next image"><ChevronRight size={36} /></button>
            <motion.div key={lightboxIndex} initial={{ opacity: 0, scale: 0.9 }} animate={{ opacity: 1, scale: 1 }} exit={{ opacity: 0, scale: 0.9 }} className="max-w-4xl max-h-[80vh] mx-4 relative w-full h-[70vh]" onClick={(e) => e.stopPropagation()}>
              <Image src={galleryItems[lightboxIndex].image} alt={galleryItems[lightboxIndex].title} fill className="object-contain rounded-lg" />
              <p className="absolute bottom-[-2rem] left-0 right-0 text-center text-white font-display text-lg">{galleryItems[lightboxIndex].title}</p>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
};

export default GalleryContent;
