"use client";

import { motion, useInView } from "framer-motion";
import { useRef, useState, useEffect } from "react";
import { Users, Package, Factory, Award } from "lucide-react";

const stats = [
  { icon: Package, value: 50, suffix: "+", label: "Projects Delivered" },
  { icon: Users, value: 18, suffix: "+", label: "Trusted Clients" },
  { icon: Factory, value: 50, suffix: " Tons", label: "Monthly Capacity" },
  { icon: Award, value: 5, suffix: "+ Yrs", label: "Experience" },
];

const Counter = ({ target, suffix }: { target: number; suffix: string }) => {
  const [count, setCount] = useState(0);
  const ref = useRef(null);
  const inView = useInView(ref, { once: true });

  useEffect(() => {
    if (!inView) return;
    let start = 0;
    const step = Math.ceil(target / (2000 / 30));
    const timer = setInterval(() => {
      start += step;
      if (start >= target) { setCount(target); clearInterval(timer); } else { setCount(start); }
    }, 30);
    return () => clearInterval(timer);
  }, [inView, target]);

  return <span ref={ref} className="font-display text-4xl md:text-5xl font-bold text-primary">{count}{suffix}</span>;
};

const StatsSection = () => {
  const ref = useRef(null);
  const inView = useInView(ref, { once: true, margin: "-50px" });

  return (
    <section className="py-16 bg-steel" ref={ref}>
      <div className="container mx-auto px-4">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
          {stats.map((stat, i) => (
            <motion.div key={stat.label} initial={{ opacity: 0, y: 20 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.5, delay: i * 0.1 }} className="text-center">
              <stat.icon className="mx-auto text-primary/60 mb-3" size={28} />
              <Counter target={stat.value} suffix={stat.suffix} />
              <p className="text-muted-on-dark text-sm mt-2">{stat.label}</p>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default StatsSection;
