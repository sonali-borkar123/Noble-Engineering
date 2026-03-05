"use client";

import { motion, useInView } from "framer-motion";
import { useRef } from "react";
import { Target, Eye } from "lucide-react";

const AboutSection = () => {
  const ref = useRef(null);
  const inView = useInView(ref, { once: true, margin: "-100px" });

  return (
    <section id="about" className="py-24 bg-background" ref={ref}>
      <div className="container mx-auto px-4">
        <motion.div initial={{ opacity: 0, y: 30 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.6 }} className="text-center mb-16">
          <p className="text-primary font-display text-sm tracking-[0.3em] uppercase mb-3">Who We Are</p>
          <h2 className="font-display text-4xl md:text-5xl font-bold text-foreground">About Us</h2>
        </motion.div>

        <motion.p initial={{ opacity: 0, y: 20 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.6, delay: 0.2 }} className="max-w-3xl mx-auto text-center text-muted-foreground text-lg leading-relaxed mb-16">
          Noble Engineering is a properitor firm established in 2020. Building on our group&apos;s experience, we manufacture heavy fabrication assemblies, Material Handling Equipment, Tower crane beams, skid frames, base frames, platforms, structure fabrication, and other engineering applications.
        </motion.p>

        <div className="grid md:grid-cols-2 gap-8 max-w-4xl mx-auto">
          <motion.div initial={{ opacity: 0, x: -30 }} animate={inView ? { opacity: 1, x: 0 } : {}} transition={{ duration: 0.6, delay: 0.3 }} className="bg-steel p-8 rounded-lg">
            <div className="w-12 h-12 bg-primary/20 rounded flex items-center justify-center mb-5">
              <Target className="text-primary" size={24} />
            </div>
            <h3 className="font-display text-2xl font-semibold text-on-dark mb-4">Our Mission</h3>
            <p className="text-muted-on-dark leading-relaxed">To be the trusted manufacturing partner for heavy fabrication and engineering solutions — delivering consistent quality, on-time performance, and value-driven innovation that drives our customers&apos; success.</p>
          </motion.div>

          <motion.div initial={{ opacity: 0, x: 30 }} animate={inView ? { opacity: 1, x: 0 } : {}} transition={{ duration: 0.6, delay: 0.4 }} className="bg-steel p-8 rounded-lg">
            <div className="w-12 h-12 bg-primary/20 rounded flex items-center justify-center mb-5">
              <Eye className="text-primary" size={24} />
            </div>
            <h3 className="font-display text-2xl font-semibold text-on-dark mb-4">Our Vision</h3>
            <p className="text-muted-on-dark leading-relaxed">To become a Complete Solution Provider for Heavy Fabrication assemblies by giving World Class Quality, Competitive Cost, Reliable Products and Excellent Services.</p>
          </motion.div>
        </div>
      </div>
    </section>
  );
};

export default AboutSection;
