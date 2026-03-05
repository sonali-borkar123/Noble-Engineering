"use client";

import { MessageCircle } from "lucide-react";

const WhatsAppButton = () => {
  const handleClick = () => {
    window.location.href = "https://api.whatsapp.com/send?phone=91970578516&text=Hello%20Noble%20Engineering%2C%20I%20would%20like%20to%20inquire%20about%20your%20services.";
  };

  return (
    <button onClick={handleClick} className="fixed bottom-6 right-6 z-40 bg-[#25D366] hover:bg-[#1ebe57] text-white p-4 rounded-full shadow-lg hover:shadow-xl transition-all hover:scale-110" aria-label="Chat on WhatsApp">
      <MessageCircle size={28} />
    </button>
  );
};

export default WhatsAppButton;
