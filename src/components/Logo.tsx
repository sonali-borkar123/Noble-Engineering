import Image from "next/image";
import logoImg from "@/assets/logo.png";

const aspectRatio = logoImg.width / logoImg.height;

const Logo = ({ size = 40 }: { size?: number }) => (
  <Image
    src={logoImg}
    alt="Noble Engineering logo"
    height={size}
    width={Math.round(size * aspectRatio)}
    className="object-contain"
    style={{ height: size, width: "auto" }}
    priority
  />
);

export default Logo;
