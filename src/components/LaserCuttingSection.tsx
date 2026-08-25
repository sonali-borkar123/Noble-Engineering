"use client";

import { motion, useInView } from "framer-motion";
import { useRef } from "react";
import Image from "next/image";
import { Zap, Maximize, Factory, Crosshair, Sparkles, ArrowRight, Check } from "lucide-react";
import laserImg from "@/assets/fiber-laser-cutting.jpeg";

const specs = [
  { icon: Zap, label: "Laser Power", value: "3 KW", note: "Fiber source" },
  { icon: Maximize, label: "Bed Size", value: "1.5 × 6.5", note: "Metres" },
  { icon: Factory, label: "Make", value: "Synergy", note: "Synergy Machine" },
  { icon: Crosshair, label: "Process", value: "CNC", note: "Fiber laser cutting" },
];

const benefits = [
  "Clean, burr-free edges straight off the bed",
  "6.5 metre long bed for full-length sheets and plates",
  "In-house cutting means shorter lead times",
  "Tight, repeatable accuracy on production batches",
  "Nesting-optimised cutting to reduce material waste",
  "Profiles, cut-outs and complex geometry in one setup",
];

const LaserCuttingSection = () => {
  const ref = useRef(null);
  const inView = useInView(ref, { once: true, margin: "-100px" });

  return (
    <section id="laser-cutting" className="relative py-24 bg-surface-dark overflow-hidden" ref={ref}>
      {/* ambient amber glow */}
      <div className="pointer-events-none absolute -top-32 -right-24 w-[28rem] h-[28rem] rounded-full bg-primary/10 blur-3xl" />
      <div className="pointer-events-none absolute -bottom-40 -left-32 w-[26rem] h-[26rem] rounded-full bg-primary/5 blur-3xl" />

      <div className="container mx-auto px-4 relative">
        {/* heading */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          animate={inView ? { opacity: 1, y: 0 } : {}}
          transition={{ duration: 0.6 }}
          className="text-center mb-14"
        >
          <span className="inline-flex items-center gap-2 px-4 py-1.5 mb-5 rounded-full border border-primary/40 bg-primary/10 text-primary text-xs font-display uppercase tracking-[0.2em]">
            <Sparkles size={14} /> New Addition
          </span>
          <h2 className="font-display text-4xl md:text-5xl font-bold text-on-dark leading-tight">
            3KW Fiber Laser <span className="text-primary">Cutting Machine</span>
          </h2>
          <p className="mt-4 text-muted-on-dark text-lg">
            With Bed 1.5 × 6.5 Mtr &nbsp;·&nbsp; Make — Synergy Machine
          </p>
        </motion.div>

        <div className="grid lg:grid-cols-2 gap-12 items-center">
          {/* machine photo */}
          <motion.div
            initial={{ opacity: 0, x: -40 }}
            animate={inView ? { opacity: 1, x: 0 } : {}}
            transition={{ duration: 0.7, delay: 0.15 }}
            className="relative"
          >
            <div className="relative rounded-xl overflow-hidden border border-steel-light shadow-2xl group">
              <div className="relative aspect-[4/3]">
                <Image
                  src={laserImg}
                  alt="3KW Fiber Laser Cutting Machine with 1.5 x 6.5 metre bed, make Synergy Machine, installed at Noble Engineering"
                  fill
                  sizes="(max-width: 1024px) 100vw, 50vw"
                  className="object-cover object-center transition-transform duration-700 group-hover:scale-105"
                />
              </div>
              <div className="absolute inset-0 bg-gradient-to-t from-surface-dark/70 via-transparent to-transparent" />

              {/* corner accents */}
              <span className="absolute top-4 left-4 w-10 h-10 border-t-2 border-l-2 border-primary/70 rounded-tl" />
              <span className="absolute bottom-4 right-4 w-10 h-10 border-b-2 border-r-2 border-primary/70 rounded-br" />

              {/* live badge */}
              <div className="absolute top-4 right-4 flex items-center gap-2 px-3 py-1.5 rounded-full bg-primary text-primary-foreground text-[11px] font-display uppercase tracking-widest shadow-lg">
                <span className="relative flex w-2 h-2">
                  <span className="absolute inline-flex w-full h-full rounded-full bg-primary-foreground/70 animate-ping" />
                  <span className="relative inline-flex w-2 h-2 rounded-full bg-primary-foreground" />
                </span>
                Now Operational
              </div>

              <p className="absolute bottom-4 left-6 right-24 text-on-dark font-display text-sm uppercase tracking-widest">
                Installed In-House
              </p>
            </div>
          </motion.div>

          {/* specs + benefits */}
          <motion.div
            initial={{ opacity: 0, x: 40 }}
            animate={inView ? { opacity: 1, x: 0 } : {}}
            transition={{ duration: 0.7, delay: 0.25 }}
          >
            <p className="text-muted-on-dark leading-relaxed mb-8">
              Noble Engineering has added a 3KW fiber laser cutting machine to its existing
              setup. With a 1.5 × 6.5 metre bed, we now cut sheet and plate profiles in-house —
              giving our customers tighter tolerances, faster turnaround, and complete control
              over quality from cutting through to final fabrication and assembly.
            </p>

            <div className="grid grid-cols-2 gap-4 mb-8">
              {specs.map((spec, i) => (
                <motion.div
                  key={spec.label}
                  initial={{ opacity: 0, y: 20 }}
                  animate={inView ? { opacity: 1, y: 0 } : {}}
                  transition={{ duration: 0.5, delay: 0.4 + i * 0.1 }}
                  className="p-5 rounded-lg bg-steel border border-steel-light hover:border-primary/40 transition-colors"
                >
                  <spec.icon className="text-primary mb-3" size={20} />
                  <p className="text-muted-on-dark text-[11px] uppercase tracking-widest">{spec.label}</p>
                  <p className="font-display text-2xl font-bold text-on-dark leading-snug">{spec.value}</p>
                  <p className="text-muted-on-dark text-xs mt-0.5">{spec.note}</p>
                </motion.div>
              ))}
            </div>

            <ul className="grid sm:grid-cols-2 gap-3 mb-8">
              {benefits.map((benefit, i) => (
                <motion.li
                  key={benefit}
                  initial={{ opacity: 0, x: 15 }}
                  animate={inView ? { opacity: 1, x: 0 } : {}}
                  transition={{ duration: 0.4, delay: 0.8 + i * 0.07 }}
                  className="flex items-start gap-2.5 text-muted-on-dark text-sm leading-relaxed"
                >
                  <Check className="text-primary shrink-0 mt-0.5" size={16} />
                  {benefit}
                </motion.li>
              ))}
            </ul>

            <motion.a
              href="#contact"
              initial={{ opacity: 0, y: 15 }}
              animate={inView ? { opacity: 1, y: 0 } : {}}
              transition={{ duration: 0.5, delay: 1.25 }}
              className="inline-flex items-center gap-2 px-8 py-4 bg-primary text-primary-foreground font-display text-sm uppercase tracking-widest hover:bg-amber-warm transition-colors rounded group"
            >
              Enquire About Laser Cutting
              <ArrowRight size={16} className="transition-transform group-hover:translate-x-1" />
            </motion.a>
          </motion.div>
        </div>
      </div>
    </section>
  );
};

export default LaserCuttingSection;
