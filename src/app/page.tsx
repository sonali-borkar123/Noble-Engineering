import Navbar from "@/components/Navbar";
import HeroSection from "@/components/HeroSection";
import StatsSection from "@/components/StatsSection";
import AboutSection from "@/components/AboutSection";
import WhyChooseUs from "@/components/WhyChooseUs";
import ProductsSection from "@/components/ProductsSection";
import FacilitiesSection from "@/components/FacilitiesSection";
import ClientsSection from "@/components/ClientsSection";
import CertificationsSection from "@/components/CertificationsSection";
import ContactSection from "@/components/ContactSection";
import Footer from "@/components/Footer";
import WhatsAppButton from "@/components/WhatsAppButton";

export default function Home() {
  return (
    <div className="min-h-screen">
      <Navbar />
      <HeroSection />
      <StatsSection />
      <AboutSection />
      <WhyChooseUs />
      <ProductsSection />
      <FacilitiesSection />
      <ClientsSection />
      <CertificationsSection />
      <ContactSection />
      <Footer />
      <WhatsAppButton />
    </div>
  );
}
