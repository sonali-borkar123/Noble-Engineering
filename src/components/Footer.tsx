import Logo from "./Logo";

const Footer = () => (
  <footer className="bg-surface-dark py-8 border-t border-steel-light">
    <div className="container mx-auto px-4 flex flex-col md:flex-row items-center justify-between gap-4">
      <div className="flex items-center gap-2">
        <Logo size={36} />
        <p className="font-display text-lg font-bold tracking-wider">
          <span className="text-primary">NOBLE</span>{" "}
          <span className="text-on-dark">ENGINEERING</span>
        </p>
      </div>
      <p className="text-muted-on-dark text-sm">
        © {new Date().getFullYear()} Noble Engineering. All rights reserved. | UDYAM-MH-26-0295999
      </p>
    </div>
  </footer>
);

export default Footer;
