"use client";

import { motion, useInView } from "framer-motion";
import { useRef } from "react";
import Link from "next/link";
import Image from "next/image";
import fabricationImg from "@/assets/heavy_2.jpeg";
import materialImg from "@/assets/material_1.jpeg";
import skidImg from "@/assets/skid_3.jpeg";
import solarImg from "@/assets/solar_1.jpeg";

const products = [
  { title: "Heavy Fabrication", description: "Concrete buckets, crane beams, construction cages, luminary carriages, and pressure tanks.", image: fabricationImg },
  { title: "Material Handling Equipment", description: "Trolleys, pallets, and custom material handling solutions for industrial applications.", image: materialImg },
  { title: "Skid Frames & Structures", description: "Skid frames, pipe supports, base frames, ladders, platforms, railings, and structural assemblies.", image: skidImg },
  { title: "Solar Structures", description: "Solar panel mounting structures, frames, and support systems for renewable energy installations.", image: solarImg },
];

const ProductsSection = () => {
  const ref = useRef(null);
  const inView = useInView(ref, { once: true, margin: "-100px" });

  return (
    <section id="products" className="py-24 section-dark" ref={ref}>
      <div className="container mx-auto px-4">
        <motion.div initial={{ opacity: 0, y: 30 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.6 }} className="text-center mb-16">
          <p className="text-primary font-display text-sm tracking-[0.3em] uppercase mb-3">What We Build</p>
          <h2 className="font-display text-4xl md:text-5xl font-bold text-on-dark">Product Range</h2>
        </motion.div>

        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
          {products.map((product, i) => (
            <motion.div key={product.title} initial={{ opacity: 0, y: 40 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.6, delay: 0.2 + i * 0.15 }}>
              <Link href="/gallery" className="group relative overflow-hidden rounded-lg block cursor-pointer">
                <div className="aspect-[4/5] overflow-hidden relative">
                  <Image src={product.image} alt={product.title} fill className="object-cover transition-transform duration-700 group-hover:scale-110" />
                  <div className="absolute inset-0 bg-gradient-to-t from-surface-dark via-surface-dark/40 to-transparent" />
                </div>
                <div className="absolute bottom-0 left-0 right-0 p-6">
                  <h3 className="font-display text-2xl font-semibold text-on-dark mb-2">{product.title}</h3>
                  <p className="text-muted-on-dark text-sm leading-relaxed">{product.description}</p>
                </div>
              </Link>
            </motion.div>
          ))}
        </div>

        {/* <motion.div initial={{ opacity: 0, y: 20 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.6, delay: 0.7 }} className="mt-12 flex flex-wrap justify-center gap-3">
          {["Galvanized Grating", "Water & Pressure Tanks", "Car Carrier Pivots", "Mass Production Parts"].map((item) => (
            <span key={item} className="px-4 py-2 border border-steel-light text-muted-on-dark text-sm rounded font-medium">{item}</span>
          ))}
        </motion.div> */}

        <motion.div initial={{ opacity: 0, y: 20 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.6, delay: 0.9 }} className="mt-10 text-center">
          <Link href="/gallery" className="inline-flex items-center justify-center px-8 py-4 bg-primary text-primary-foreground font-display text-sm uppercase tracking-widest hover:bg-amber-warm transition-colors rounded">
            View Full Gallery
          </Link>
        </motion.div>
      </div>
    </section>
  );
};

export default ProductsSection;
