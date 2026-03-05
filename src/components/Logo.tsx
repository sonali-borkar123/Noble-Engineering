import Image from "next/image";
import logoImg from "@/assets/logo.jpeg";

const Logo = ({ size = 40 }: { size?: number }) => (
  <Image src={logoImg} alt="Noble Engineering logo" height={size} width={size} className="h-auto" style={{ height: size, width: "auto" }} />
);

export default Logo;
