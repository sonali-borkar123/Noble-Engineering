"use client";

import { motion, useInView } from "framer-motion";
import { useRef } from "react";
import { Ruler, Zap, Wrench, Factory, Flame, Sparkles, type LucideIcon } from "lucide-react";

const facilities: { icon: LucideIcon; label: string; value: string; accent?: boolean }[] = [
  { icon: Factory, label: "Covered Area", value: "5,000 Sq Ft" },
  { icon: Zap, label: "Power Supply", value: "50HP 3-Phase" },
  { icon: Wrench, label: "Monthly Capacity", value: "50 Tons" },
  { icon: Ruler, label: "Design Software", value: "AutoCAD" },
  { icon: Flame, label: "Laser Cutting", value: "3 KW Fiber", accent: true },
];

const machines = [
  "MIG Welding Machine 400I – 5 Nos",
  "Arc Welding Machine 250I – 2 Nos",
  "50 Ton Press Machine",
  "Band Saw Cutting Machine",
  "Drilling Machines – 2 Nos",
  "Broach Cutter Machines – 2 Nos",
  "14\" Chop Saw – 3 Nos",
  "5HP Compressor",
];

const featuredMachine = {
  title: "3KW Fiber Laser Cutting Machine",
  detail: "Bed 1.5 × 6.5 Mtr · Make — Synergy Machine",
};

const FacilitiesSection = () => {
  const ref = useRef(null);
  const inView = useInView(ref, { once: true, margin: "-100px" });

  return (
    <section id="facilities" className="py-24 bg-background" ref={ref}>
      <div className="container mx-auto px-4">
        <motion.div initial={{ opacity: 0, y: 50 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.6 }} className="text-center mb-16">
          <p className="text-primary font-display text-sm tracking-[0.3em] uppercase mb-3">Our Capabilities</p>
          <h2 className="font-display text-4xl md:text-5xl font-bold text-foreground">Machines & Facilities</h2>
        </motion.div>

        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-6 mb-16">
          {facilities.map((item, i) => (
            <motion.div
              key={item.label}
              initial={{ opacity: 0, y: 20 }}
              animate={inView ? { opacity: 1, y: 0 } : {}}
              transition={{ duration: 0.5, delay: 0.2 + i * 0.1 }}
              className={`text-center p-6 rounded-lg transition-colors ${item.accent
                ? "border-2 border-primary/50 bg-primary/5"
                : "border border-border"
                }`}
            >
              <item.icon className="mx-auto text-primary mb-3" size={28} />
              <p className="font-display text-xl font-bold text-foreground">{item.value}</p>
              <p className="text-muted-foreground text-sm mt-1">{item.label}</p>
            </motion.div>
          ))}
        </div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.6, delay: 0.5 }} className="max-w-2xl mx-auto bg-steel rounded-lg p-8">
          <h3 className="font-display text-xl font-semibold text-on-dark mb-6 text-center">Equipment List</h3>

          <a href="#laser-cutting" className="group flex items-start gap-4 mb-6 p-4 rounded-lg border border-primary/40 bg-primary/10 hover:bg-primary/15 transition-colors">
            <Flame className="text-primary shrink-0 mt-0.5" size={22} />
            <div className="min-w-0">
              <div className="flex flex-wrap items-center gap-2">
                <p className="font-display text-base font-semibold text-on-dark">{featuredMachine.title}</p>
                <span className="inline-flex items-center gap-1 px-1.5 py-0.5 rounded bg-primary text-primary-foreground text-[9px] font-display uppercase tracking-widest leading-none">
                  <Sparkles size={9} /> New
                </span>
              </div>
              <p className="text-muted-on-dark text-xs mt-1">{featuredMachine.detail}</p>
            </div>
          </a>

          <div className="grid sm:grid-cols-2 gap-3">
            {machines.map((machine) => (
              <div key={machine} className="flex items-center gap-3 text-muted-on-dark text-sm">
                <div className="w-1.5 h-1.5 rounded-full bg-primary shrink-0" />
                {machine}
              </div>
            ))}
          </div>
        </motion.div>
      </div>
    </section>
  );
};

export default FacilitiesSection;
