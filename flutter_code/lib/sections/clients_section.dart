import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/reveal.dart';

const _clients = [
  ('Dynamic Industries', 'assets/dynamic.jpeg'),
  ('THERMAX LIMITED, Bhosari', 'assets/thermax.png'),
  ('Privilege Biksons Boilers Pvt Ltd', 'assets/privilege_biksons_boilers.jpg'),
  ('LOHR India Automotive, Chakan', 'assets/lohr.jpg'),
  ('Toyota Material Handling, Chakan', 'assets/toyota_material_handling.webp'),
  ('Ecofrost Technologies Pvt Ltd', 'assets/Ecofrost.png'),
  ('Preciforge And Gears, Chakan', 'assets/Preciforge.jpg'),
  ('Techno Dry System, Chakan', 'assets/techno_dry.jpg'),
  ('Lumax Industrial Ltd, Chakan', 'assets/lumax.jpg'),
  ('Ecozen Solutions Pvt Ltd', 'assets/Ecozen.png'),
  ('Hylite Galvanisers Pvt Ltd', 'assets/HyliteGalvanisers.png'),
  ('Swaraj India Group, Pune', 'assets/swaraj_logo.jpeg'),
  ('High Temp Furnaces, Chakan', 'assets/HighTempFurnaces.jpg'),
];

/// Port of ClientsSection.tsx — dark "Our Customers" grid of client logo
/// cards.
class ClientsSection extends StatelessWidget {
  const ClientsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.steel, // .section-dark
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: SiteContainer(
        child: Column(
          children: [
            const RevealOnScroll(
              child: SectionHeader(
                eyebrow: 'Trusted By',
                title: 'Our Customers',
                dark: true,
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1152),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cols = Breakpoints.pick(context, 2,
                      sm: 3, lg: 4, xl: 5);
                  const gap = 20.0;
                  final w =
                      (constraints.maxWidth - gap * (cols - 1)) / cols;
                  return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: [
                      for (var i = 0; i < _clients.length; i++)
                        SizedBox(
                          width: w,
                          child: RevealOnScroll(
                            delay:
                                Duration(milliseconds: 100 + 50 * i),
                            offset: const Offset(0, 20),
                            duration:
                                const Duration(milliseconds: 400),
                            child: _ClientCard(client: _clients[i]),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClientCard extends StatefulWidget {
  const _ClientCard({required this.client});

  final (String, String) client;

  @override
  State<_ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<_ClientCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _hover
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hover
                ? AppColors.primary.withValues(alpha: 0.5)
                : AppColors.steelLight,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  const BoxShadow(color: Colors.black26, blurRadius: 8),
                  if (_hover)
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 16,
                    ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: ClipOval(
                child: Image.asset(
                  widget.client.$2,
                  fit: BoxFit.contain,
                  semanticLabel: widget.client.$1,
                  errorBuilder: (context, error, stack) => const Icon(
                      Icons.business,
                      color: AppColors.mutedForeground),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.client.$1,
              textAlign: TextAlign.center,
              style: AppText.body(
                size: 12,
                weight: FontWeight.w500,
                color: AppColors.onDark.withValues(alpha: 0.9),
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
