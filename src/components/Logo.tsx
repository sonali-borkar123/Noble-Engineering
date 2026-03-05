import Image from "next/image";
import logoImg from "@/assets/logo.jpeg";

const Logo = ({ size = 40 }: { size?: number }) => (
  <div
    className="rounded-full overflow-hidden border-2 border-primary/30 flex-shrink-0"
    style={{ width: size, height: size }}
  >
    <Image
      src={logoImg}
      alt="Noble Engineering logo"
      height={size}
      width={size}
      className="object-cover w-full h-full"
    />
  </div>
);

export default Logo;
