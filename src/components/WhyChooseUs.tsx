"use client";

import { motion, useInView } from "framer-motion";
import { useRef } from "react";
import { ShieldCheck, Clock, IndianRupee, Wrench, HeartHandshake, TrendingUp } from "lucide-react";

const reasons = [
  { icon: ShieldCheck, title: "World Class Quality", desc: "Strict quality control at every stage of fabrication and assembly." },
  { icon: IndianRupee, title: "Competitive Pricing", desc: "Cost-effective solutions without compromising on quality standards." },
  { icon: Clock, title: "On-Time Delivery", desc: "Reliable timelines backed by 50 tons monthly production capacity." },
  { icon: Wrench, title: "Custom Solutions", desc: "Tailored engineering for your specific industrial requirements." },
  { icon: HeartHandshake, title: "Trusted Partnerships", desc: "Long-term relationships with 18+ leading industrial clients." },
  { icon: TrendingUp, title: "Continuous Improvement", desc: "Constantly upgrading processes, tools, and team capabilities." },
];

const WhyChooseUs = () => {
  const ref = useRef(null);
  const inView = useInView(ref, { once: true, margin: "-100px" });

  return (
    <section className="py-24 bg-background" ref={ref}>
      <div className="container mx-auto px-4">
        <motion.div initial={{ opacity: 0, y: 30 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.6 }} className="text-center mb-16">
          <p className="text-primary font-display text-sm tracking-[0.3em] uppercase mb-3">Our Strengths</p>
          <h2 className="font-display text-4xl md:text-5xl font-bold text-foreground">Why Choose Us</h2>
        </motion.div>
        <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-6 max-w-5xl mx-auto">
          {reasons.map((item, i) => (
            <motion.div key={item.title} initial={{ opacity: 0, y: 25 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.5, delay: 0.15 + i * 0.1 }} className="p-6 rounded-lg border border-border hover:border-primary/30 hover:shadow-lg transition-all group">
              <div className="w-12 h-12 bg-primary/10 rounded-lg flex items-center justify-center mb-4 group-hover:bg-primary/20 transition-colors">
                <item.icon className="text-primary" size={22} />
              </div>
              <h3 className="font-display text-lg font-semibold text-foreground mb-2">{item.title}</h3>
              <p className="text-muted-foreground text-sm leading-relaxed">{item.desc}</p>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default WhyChooseUs;
