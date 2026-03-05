"use client";

import { useState, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { ArrowDown } from "lucide-react";
import Image from "next/image";
import heroBg from "@/assets/solar_1.jpeg";
import fabricationImg from "@/assets/heavy_3.jpeg";
import materialImg from "@/assets/material_1.jpeg";
import skidImg from "@/assets/skid_2.jpeg";

const slides = [heroBg, fabricationImg, materialImg, skidImg];

const HeroSection = () => {
  const [current, setCurrent] = useState(0);

  useEffect(() => {
    const timer = setInterval(() => setCurrent((prev) => (prev + 1) % slides.length), 5000);
    return () => clearInterval(timer);
  }, []);

  return (
    <section id="home" className="relative min-h-screen flex items-center justify-center overflow-hidden">
      <AnimatePresence mode="popLayout">
        <motion.div key={current} initial={{ opacity: 0, scale: 1.1 }} animate={{ opacity: 1, scale: 1 }} exit={{ opacity: 0 }} transition={{ duration: 1.2 }} className="absolute inset-0">
          <Image src={slides[current]} alt="Noble Engineering" fill className="object-cover" priority />
        </motion.div>
      </AnimatePresence>
      <div className="absolute inset-0 bg-gradient-to-b from-surface-dark/80 via-surface-dark/60 to-surface-dark/90" />

      <div className="relative z-10 container mx-auto px-4 text-center">
        <motion.div initial={{ opacity: 0, y: 40 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.8, delay: 0.2 }}>
          <p className="text-primary font-display text-lg tracking-[0.3em] uppercase mb-4">Made in India</p>
          <h1 className="font-display text-5xl md:text-7xl lg:text-8xl font-bold text-on-dark leading-tight mb-6">
            NOBLE<br /><span className="text-primary">ENGINEERING</span>
          </h1>
          <p className="max-w-2xl mx-auto text-muted-on-dark text-lg md:text-xl leading-relaxed mb-10">
            Complete Solution Provider for Heavy Fabrication Assemblies — World Class Quality, Competitive Cost, Reliable Products.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <a href="#products" className="inline-flex items-center justify-center px-8 py-4 bg-primary text-primary-foreground font-display text-sm uppercase tracking-widest hover:bg-amber-warm transition-colors">Our Products</a>
            <a href="#contact" className="inline-flex items-center justify-center px-8 py-4 border border-on-dark/30 text-on-dark font-display text-sm uppercase tracking-widest hover:border-primary hover:text-primary transition-colors">Contact Us</a>
          </div>
        </motion.div>
      </div>

      <div className="absolute bottom-20 left-1/2 -translate-x-1/2 flex gap-2 z-10">
        {slides.map((_, i) => (
          <button key={i} onClick={() => setCurrent(i)} className={`w-2 h-2 rounded-full transition-all ${i === current ? "bg-primary w-6" : "bg-on-dark/40"}`} aria-label={`Go to slide ${i + 1}`} />
        ))}
      </div>

      <motion.div className="absolute bottom-8 left-1/2 -translate-x-1/2 text-on-dark/50" animate={{ y: [0, 10, 0] }} transition={{ repeat: Infinity, duration: 2 }}>
        <ArrowDown size={24} />
      </motion.div>
    </section>
  );
};

export default HeroSection;
