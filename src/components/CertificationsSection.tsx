"use client";

import { motion, useInView } from "framer-motion";
import { useRef } from "react";
import { BadgeCheck, FileCheck, Shield, Award } from "lucide-react";

const certifications = [
  { icon: Award, title: "ISO 9001:2015 Certified", code: "ISO 9001:2015", desc: "Certified Quality Management System ensuring consistent quality standards across all manufacturing processes." },
  { icon: BadgeCheck, title: "UDYAM Registered", code: "UDYAM-MH-26-0295999", desc: "Registered Micro/Small Enterprise under Ministry of MSME, Government of India." },
  { icon: FileCheck, title: "GST Registered", code: "GST Compliant", desc: "Fully compliant with Goods and Services Tax regulations for transparent business." },
  { icon: Shield, title: "Quality Assured", code: "In-house QC", desc: "Rigorous in-house quality checks at every stage — from raw material to final dispatch." },
];

const CertificationsSection = () => {
  const ref = useRef(null);
  const inView = useInView(ref, { once: true, margin: "-100px" });

  return (
    <section className="py-24 bg-background" ref={ref}>
      <div className="container mx-auto px-4">
        <motion.div initial={{ opacity: 0, y: 30 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.6 }} className="text-center mb-16">
          <p className="text-primary font-display text-sm tracking-[0.3em] uppercase mb-3">Trust & Compliance</p>
          <h2 className="font-display text-4xl md:text-5xl font-bold text-foreground">Certifications</h2>
        </motion.div>

        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-8 max-w-5xl mx-auto">
          {certifications.map((cert, i) => (
            <motion.div key={cert.title} initial={{ opacity: 0, y: 25 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.5, delay: 0.2 + i * 0.15 }} className="text-center p-8 border border-border rounded-lg hover:border-primary/30 transition-colors">
              <div className="w-16 h-16 bg-primary/10 rounded-full flex items-center justify-center mx-auto mb-5">
                <cert.icon className="text-primary" size={28} />
              </div>
              <h3 className="font-display text-xl font-semibold text-foreground mb-1">{cert.title}</h3>
              <p className="text-primary text-xs font-mono mb-3">{cert.code}</p>
              <p className="text-muted-foreground text-sm leading-relaxed">{cert.desc}</p>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default CertificationsSection;
