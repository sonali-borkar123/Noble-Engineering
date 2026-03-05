import Image from "next/image";
import logoImg from "@/assets/logo.jpeg";

const Logo = ({ size = 40 }: { size?: number }) => (
  <div
    className="relative flex-shrink-0 rounded-md overflow-hidden"
    style={{ height: size, width: size }}
  >
    <Image
      src={logoImg}
      alt="Noble Engineering logo"
      fill
      sizes={`${size}px`}
      className="object-contain"
      priority
    />
  </div>
);

export default Logo;
