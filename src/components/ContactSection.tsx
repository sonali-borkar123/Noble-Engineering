"use client";

import { motion, useInView } from "framer-motion";
import { useRef } from "react";
import { MapPin, Mail, Phone } from "lucide-react";

const ContactSection = () => {
  const ref = useRef(null);
  const inView = useInView(ref, { once: true, margin: "-100px" });

  return (
    <section id="contact" className="py-24 bg-background" ref={ref}>
      <div className="container mx-auto px-4">
        <motion.div initial={{ opacity: 0, y: 30 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.6 }} className="text-center mb-16">
          <p className="text-primary font-display text-sm tracking-[0.3em] uppercase mb-3">Get In Touch</p>
          <h2 className="font-display text-4xl md:text-5xl font-bold text-foreground">Contact Us</h2>
          <p className="text-muted-foreground mt-4 text-lg">
            Let&apos;s work <span className="text-primary font-semibold">together</span> and grow <span className="text-primary font-semibold">together</span>
          </p>
        </motion.div>

        <div className="grid md:grid-cols-3 gap-8 max-w-4xl mx-auto">
          <motion.a href="https://www.google.com/maps/place/NOBLE+ENGINEERING" target="_blank" rel="noopener noreferrer" initial={{ opacity: 0, y: 20 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.5, delay: 0.2 }} className="flex flex-col items-center text-center p-8 bg-steel rounded-lg hover:ring-2 hover:ring-primary/30 transition-all">
            <div className="w-14 h-14 bg-primary/20 rounded-full flex items-center justify-center mb-4"><MapPin className="text-primary" size={24} /></div>
            <h3 className="font-display text-lg font-semibold text-on-dark mb-2">Address</h3>
            <p className="text-muted-on-dark text-sm leading-relaxed">Gat No, 1402, Sonawane Wasti Rd, near Trimurti kata, Jyotiba Nagar, Chikhali, Pimpri-Chinchwad, Vitthal Nagar, Maharashtra 411062</p>
          </motion.a>

          <motion.a href="mailto:noble.engineering0922@gmail.com" initial={{ opacity: 0, y: 20 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.5, delay: 0.3 }} className="flex flex-col items-center text-center p-8 bg-steel rounded-lg hover:ring-2 hover:ring-primary/30 transition-all">
            <div className="w-14 h-14 bg-primary/20 rounded-full flex items-center justify-center mb-4"><Mail className="text-primary" size={24} /></div>
            <h3 className="font-display text-lg font-semibold text-on-dark mb-2">Email</h3>
            <p className="text-muted-on-dark text-sm">noble.engineering0922@gmail.com</p>
          </motion.a>

          <motion.a href="tel:+919766314010" initial={{ opacity: 0, y: 20 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.5, delay: 0.4 }} className="flex flex-col items-center text-center p-8 bg-steel rounded-lg hover:ring-2 hover:ring-primary/30 transition-all">
            <div className="w-14 h-14 bg-primary/20 rounded-full flex items-center justify-center mb-4"><Phone className="text-primary" size={24} /></div>
            <h3 className="font-display text-lg font-semibold text-on-dark mb-2">Call Us</h3>
            <p className="text-muted-on-dark text-sm">Mr. Rajendra Khaire</p>
            <p className="text-primary font-semibold mt-1">+91 9766314010</p>
          </motion.a>
        </div>
      </div>
    </section>
  );
};

export default ContactSection;
