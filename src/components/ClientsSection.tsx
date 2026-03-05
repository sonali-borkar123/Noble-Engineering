"use client";

import { motion, useInView } from "framer-motion";
import { useRef } from "react";
import Image, { StaticImageData } from "next/image";

import dynamicLogo from "@/assets/dynamic.jpeg";
import thermaxLogo from "@/assets/thermax.png";
import privilegeLogo from "@/assets/privilege_Biksons_Boilers.jpg";
import lohrLogo from "@/assets/lohr.jpg";
import toyotaLogo from "@/assets/Toyota Material Handling, Chakan.webp";
import ecofrostLogo from "@/assets/Ecofrost.png";
import preciforgeLogo from "@/assets/Preciforge.jpg";
import technoDryLogo from "@/assets/techno_dry.jpg";
import lumaxLogo from "@/assets/lumax.jpg";
import ecozenLogo from "@/assets/Ecozen.png";
import hyliteLogo from "@/assets/HyliteGalvanisers.png";
import swarajLogo from "@/assets/swaraj_logo.jpeg";
import highTempLogo from "@/assets/HighTempFurnaces.jpg";

const clients: { name: string; logo: StaticImageData }[] = [
  { name: "Dynamic Industries", logo: dynamicLogo },
  { name: "THERMAX LIMITED, Bhosari", logo: thermaxLogo },
  { name: "Privilege Biksons Boilers Pvt Ltd", logo: privilegeLogo },
  { name: "LOHR India Automotive, Chakan", logo: lohrLogo },
  { name: "Toyota Material Handling, Chakan", logo: toyotaLogo },
  { name: "Ecofrost Technologies Pvt Ltd", logo: ecofrostLogo },
  { name: "Preciforge And Gears, Chakan", logo: preciforgeLogo },
  { name: "Techno Dry System, Chakan", logo: technoDryLogo },
  { name: "Lumax Industrial Ltd, Chakan", logo: lumaxLogo },
  { name: "Ecozen Solutions Pvt Ltd", logo: ecozenLogo },
  { name: "Hylite Galvanisers Pvt Ltd", logo: hyliteLogo },
  { name: "Swaraj India Group, Pune", logo: swarajLogo },
  { name: "High Temp Furnaces, Chakan", logo: highTempLogo },
];

const ClientsSection = () => {
  const ref = useRef(null);
  const inView = useInView(ref, { once: true, margin: "-100px" });

  return (
    <section id="clients" className="py-24 section-dark" ref={ref}>
      <div className="container mx-auto px-4">
        <motion.div initial={{ opacity: 0, y: 30 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.6 }} className="text-center mb-16">
          <p className="text-primary font-display text-sm tracking-[0.3em] uppercase mb-3">Trusted By</p>
          <h2 className="font-display text-4xl md:text-5xl font-bold text-on-dark">Our Customers</h2>
        </motion.div>

        <motion.div initial={{ opacity: 0 }} animate={inView ? { opacity: 1 } : {}} transition={{ duration: 0.8, delay: 0.3 }} className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-5 max-w-6xl mx-auto">
          {clients.map((client, i) => (
            <motion.div key={client.name} initial={{ opacity: 0, y: 20 }} animate={inView ? { opacity: 1, y: 0 } : {}} transition={{ duration: 0.4, delay: 0.1 + i * 0.05 }} className="group bg-white/5 backdrop-blur-sm border border-steel-light rounded-xl p-5 flex flex-col items-center justify-center gap-3 hover:border-primary/50 hover:bg-white/10 transition-all duration-300">
              <div className="w-20 h-20 rounded-full overflow-hidden bg-white flex items-center justify-center shadow-md group-hover:shadow-primary/20 transition-shadow duration-300 p-2 relative">
                <Image src={client.logo} alt={client.name} fill className="object-contain p-2" />
              </div>
              <p className="text-on-dark/90 text-xs font-medium text-center leading-tight">{client.name}</p>
            </motion.div>
          ))}
        </motion.div>
      </div>
    </section>
  );
};

export default ClientsSection;
