"use client";

import { motion, AnimatePresence, useInView } from "framer-motion";
import { useCallback, useEffect, useRef, useState } from "react";
import Image, { StaticImageData } from "next/image";
import { ChevronLeft, ChevronRight, Pause, Play } from "lucide-react";

import craneImg from "@/assets/machine/crane.jpeg";
import laserImg from "@/assets/fiber-laser-cutting.jpeg";
import bendsawImg from "@/assets/machine/bendsaw.jpeg";
import weldingImg from "@/assets/machine/welding.jpeg";
import airCompressorImg from "@/assets/machine/air_compressor.jpeg";
import arcWeldingImg from "@/assets/machine/arc_welding.jpeg";
import magneticDrillImg from "@/assets/machine/magnetic_drill.jpeg";
import pillerDrillImg from "@/assets/machine/piller_drill.jpeg";
import handPalletImg from "@/assets/machine/hand_pallet.jpeg";
import grinderImg from "@/assets/machine/grinder.jpeg";

type GroupItem = { name: string; image: StaticImageData };

type Slide =
  | { type: "single"; title: string; subtitle?: string; image: StaticImageData; alt: string }
  | { type: "group"; title: string; subtitle?: string; items: GroupItem[] };

const slides: Slide[] = [
  {
    type: "single",
    title: "EOT Crane",
    subtitle: "5 Ton capacity",
    image: craneImg,
    alt: "5 Ton EOT crane used for material lifting on the shop floor",
  },
  {
    type: "single",
    title: "Fiber Laser Cutting Machine",
    subtitle: "3 KW · Bed 1.5 × 6.5 Mtr · Make Synergy Machine",
    image: laserImg,
    alt: "3KW fiber laser cutting machine with 1.5 by 6.5 metre bed",
  },
  {
    type: "group",
    title: "Cutting & Welding Setup",
    subtitle: "Band saw, MIG & arc welding, air compressor",
    items: [
      { name: "Band Saw Machine – Range 250mm", image: bendsawImg },
      { name: "500A CO2 MIG Welding Machine – 6 Nos", image: weldingImg },
      { name: "Air Compressor 5HP", image: airCompressorImg },
      { name: "Arc Welding Machine 250A – 1 Nos", image: arcWeldingImg },
    ],
  },
  {
    type: "group",
    title: "Other Machines",
    subtitle: "Drilling, grinding & material handling",
    items: [
      { name: "Magnetic Drill Machine – Range 12 to 32mm", image: magneticDrillImg },
      { name: "Pillar Drill Machine – Range upto 22mm", image: pillerDrillImg },
      { name: "Heavy Duty Hand Pallet – Range 2T", image: handPalletImg },
      { name: "Hand Grinder 7\" / 4\"", image: grinderImg },
    ],
  },
];

const AUTOPLAY_MS = 5000;

const MachinerySection = () => {
  const ref = useRef(null);
  const inView = useInView(ref, { once: true, margin: "-100px" });
  const [index, setIndex] = useState(0);
  const [direction, setDirection] = useState(1);
  const [paused, setPaused] = useState(false);

  const goTo = useCallback((next: number) => {
    setDirection(next > index || (index === slides.length - 1 && next === 0) ? 1 : -1);
    setIndex((next + slides.length) % slides.length);
  }, [index]);

  const goNext = useCallback(() => goTo(index + 1), [goTo, index]);
  const goPrev = useCallback(() => goTo(index - 1), [goTo, index]);

  const autoplayActive = !paused && inView;

  useEffect(() => {
    if (!autoplayActive) return;
    const timer = setInterval(() => {
      setDirection(1);
      setIndex((prev) => (prev + 1) % slides.length);
    }, AUTOPLAY_MS);
    return () => clearInterval(timer);
  }, [autoplayActive]);

  const slide = slides[index];

  return (
    <section id="machinery" className="py-24 bg-background" ref={ref}>
      <div className="container mx-auto px-4">
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          animate={inView ? { opacity: 1, y: 0 } : {}}
          transition={{ duration: 0.6 }}
          className="text-center mb-14"
        >
          <p className="text-primary font-display text-sm tracking-[0.3em] uppercase mb-3">Our Setup</p>
          <h2 className="font-display text-4xl md:text-5xl font-bold text-foreground">Machinery</h2>
          <p className="text-muted-foreground mt-3 max-w-2xl mx-auto">
            A look at the equipment that keeps our shop floor running — from cutting and welding to lifting and material handling.
          </p>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 30 }}
          animate={inView ? { opacity: 1, y: 0 } : {}}
          transition={{ duration: 0.6, delay: 0.15 }}
          className="relative max-w-3xl mx-auto"
          onMouseEnter={() => setPaused(true)}
          onMouseLeave={() => setPaused(false)}
        >
          <div className="relative rounded-2xl overflow-hidden border border-border bg-steel shadow-xl">
            <div className="relative aspect-[4/3] sm:aspect-[16/11] overflow-hidden">
              <AnimatePresence initial={false} custom={direction} mode="wait">
                <motion.div
                  key={index}
                  custom={direction}
                  initial={{ x: direction > 0 ? "100%" : "-100%", opacity: 0 }}
                  animate={{ x: "0%", opacity: 1 }}
                  exit={{ x: direction > 0 ? "-100%" : "100%", opacity: 0 }}
                  transition={{ duration: 0.5, ease: "easeInOut" }}
                  className="absolute inset-0"
                >
                  {slide.type === "single" ? (
                    <div className="relative w-full h-full bg-surface-dark">
                      <Image
                        src={slide.image}
                        alt={slide.alt}
                        fill
                        sizes="(max-width: 768px) 100vw, 768px"
                        className="object-contain"
                        priority={index === 0}
                      />
                    </div>
                  ) : (
                    <div className="grid grid-cols-2 grid-rows-2 gap-px w-full h-full bg-border">
                      {slide.items.map((item) => (
                        <div key={item.name} className="relative flex flex-col bg-white">
                          <div className="relative flex-1 min-h-0">
                            <Image
                              src={item.image}
                              alt={item.name}
                              fill
                              sizes="(max-width: 768px) 50vw, 380px"
                              className="object-contain p-3 sm:p-4"
                            />
                          </div>
                          <p className="bg-steel text-on-dark text-[9px] sm:text-[11px] font-medium px-2 py-1.5 leading-tight text-center line-clamp-2">
                            {item.name}
                          </p>
                        </div>
                      ))}
                    </div>
                  )}
                </motion.div>
              </AnimatePresence>

              {/* title bar */}
              <div className="absolute top-0 left-0 right-0 bg-gradient-to-b from-surface-dark/95 via-surface-dark/70 to-transparent px-14 sm:px-16 pt-4 sm:pt-5 pb-8 pointer-events-none z-20">
                <h3 className="font-display text-base sm:text-xl font-bold text-primary leading-snug drop-shadow-[0_1px_3px_rgba(0,0,0,0.8)]">{slide.title}</h3>
                {slide.subtitle && (
                  <p className="text-primary text-[11px] sm:text-sm mt-0.5 leading-snug drop-shadow-[0_1px_3px_rgba(0,0,0,0.8)]">{slide.subtitle}</p>
                )}
              </div>
            </div>

            {/* autoplay progress bar */}
            <div className="h-1 bg-steel-light">
              <motion.div
                key={`${index}-${autoplayActive}`}
                className="h-full bg-primary"
                initial={{ width: "0%" }}
                animate={{ width: autoplayActive ? "100%" : "0%" }}
                transition={{ duration: autoplayActive ? AUTOPLAY_MS / 1000 : 0, ease: "linear" }}
              />
            </div>

            {/* prev / next controls */}
            <button
              type="button"
              onClick={goPrev}
              aria-label="Previous machine"
              className="absolute left-3 top-1/2 -translate-y-1/2 z-30 flex items-center justify-center w-9 h-9 sm:w-10 sm:h-10 rounded-full bg-surface-dark/70 text-on-dark shadow-md hover:bg-primary transition-colors"
            >
              <ChevronLeft size={20} />
            </button>
            <button
              type="button"
              onClick={goNext}
              aria-label="Next machine"
              className="absolute right-3 top-1/2 -translate-y-1/2 z-30 flex items-center justify-center w-9 h-9 sm:w-10 sm:h-10 rounded-full bg-surface-dark/70 text-on-dark shadow-md hover:bg-primary transition-colors"
            >
              <ChevronRight size={20} />
            </button>
          </div>

          {/* dots + play/pause */}
          <div className="flex items-center justify-center gap-4 mt-6">
            <div className="flex items-center gap-2">
              {slides.map((s, i) => (
                <button
                  key={s.title}
                  type="button"
                  onClick={() => goTo(i)}
                  aria-label={`Go to slide ${i + 1}: ${s.title}`}
                  aria-current={i === index}
                  className={`h-2.5 rounded-full transition-all ${i === index ? "w-8 bg-primary" : "w-2.5 bg-border hover:bg-primary/50"
                    }`}
                />
              ))}
            </div>
            <button
              type="button"
              onClick={() => setPaused((p) => !p)}
              aria-label={paused ? "Resume auto slide" : "Pause auto slide"}
              className="flex items-center justify-center w-8 h-8 rounded-full border border-border text-muted-foreground hover:text-primary hover:border-primary/50 transition-colors"
            >
              {paused ? <Play size={14} /> : <Pause size={14} />}
            </button>
          </div>
        </motion.div>
      </div>
    </section>
  );
};

export default MachinerySection;
