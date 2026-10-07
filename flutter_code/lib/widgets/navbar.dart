import 'package:flutter/material.dart';
import '../theme.dart';
import 'logo.dart';

class NavLink {
  const NavLink(this.label, this.sectionId, {this.badge});
  final String label;
  final String sectionId;
  final String? badge;
}

const navLinks = [
  NavLink('Home', 'home'),
  NavLink('About', 'about'),
  NavLink('Machinery', 'machinery'),
  NavLink('Products', 'products'),
  NavLink('Laser Cutting', 'laser-cutting', badge: 'New'),
  NavLink('Facilities', 'facilities'),
  NavLink('Clients', 'clients'),
  NavLink('Contact', 'contact'),
];

/// Fixed top navigation. Transparent over the hero, `bg-steel/95` with shadow
/// once scrolled past 50px — same behaviour as the React Navbar.
class Navbar extends StatefulWidget {
  const Navbar({
    super.key,
    required this.scrollController,
    required this.onNavigate,
  });

  final ScrollController scrollController;
  final void Function(String sectionId) onNavigate;

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool _scrolled = false;
  bool _menuOpen = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final s = widget.scrollController.offset > 50;
    if (s != _scrolled) setState(() => _scrolled = s);
  }

  void _go(String id) {
    setState(() => _menuOpen = false);
    widget.onNavigate(id);
  }

  @override
  Widget build(BuildContext context) {
    final isLg = Breakpoints.isLg(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: _scrolled || _menuOpen
            ? AppColors.steel.withValues(alpha: 0.95)
            : Colors.transparent,
        boxShadow: _scrolled
            ? const [BoxShadow(color: Colors.black26, blurRadius: 12)]
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Brand(onTap: () => _go('home')),
                if (isLg)
                  Row(
                    children: [
                      for (final link in navLinks)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                Breakpoints.isXl(context) ? 14 : 8,
                          ),
                          child: _NavItem(
                            link: link,
                            onTap: () => _go(link.sectionId),
                          ),
                        ),
                    ],
                  )
                else
                  IconButton(
                    onPressed: () => setState(() => _menuOpen = !_menuOpen),
                    icon: Icon(
                      _menuOpen ? Icons.close : Icons.menu,
                      color: AppColors.onDark,
                      size: 24,
                    ),
                  ),
              ],
            ),
          ),
          // Mobile menu (framer AnimatePresence height/opacity expand).
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: _menuOpen && !isLg
                ? Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.steel,
                      border: Border(
                        top: BorderSide(color: AppColors.steelLight),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final link in navLinks)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: _NavItem(
                              link: link,
                              onTap: () => _go(link.sectionId),
                            ),
                          ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Logo(size: 44),
            const SizedBox(width: 8),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: 'NOBLE',
                  style: AppText.display(
                    size: 20,
                    color: AppColors.primary,
                    letterSpacing: 1.5,
                  ),
                ),
                TextSpan(
                  text: ' ENGINEERING',
                  style: AppText.display(
                    size: 20,
                    color: AppColors.onDark,
                    letterSpacing: 1.5,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({required this.link, required this.onTap});
  final NavLink link;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: AppText.body(
                size: 14,
                weight: FontWeight.w500,
                color: _hover
                    ? AppColors.primary
                    : AppColors.onDark.withValues(alpha: 0.8),
                letterSpacing: 0.5,
              ),
              child: Text(widget.link.label.toUpperCase()),
            ),
            if (widget.link.badge != null) ...[
              const SizedBox(width: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  widget.link.badge!.toUpperCase(),
                  style: AppText.display(
                    size: 9,
                    weight: FontWeight.w500,
                    color: AppColors.primaryForeground,
                    letterSpacing: 1.6,
                    height: 1,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
