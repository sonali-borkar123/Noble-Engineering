import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/reveal.dart';

/// Port of AboutSection.tsx — heading, intro paragraph, Mission/Vision cards.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final twoCol = Breakpoints.isMd(context);
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: SiteContainer(
        child: Column(
          children: [
            const RevealOnScroll(
              child: SectionHeader(eyebrow: 'Who We Are', title: 'About Us'),
            ),
            RevealOnScroll(
              delay: const Duration(milliseconds: 200),
              offset: const Offset(0, 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 768),
                child: Text(
                  'Noble Engineering is a properitor firm established in 2020. '
                  'Building on our group\'s experience, we manufacture heavy '
                  'fabrication assemblies, Material Handling Equipment, Tower '
                  'crane beams, skid frames, base frames, platforms, structure '
                  'fabrication, and other engineering applications.',
                  textAlign: TextAlign.center,
                  style: AppText.body(
                    size: 18,
                    color: AppColors.mutedForeground,
                    height: 1.7,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 64),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 896),
              child: twoCol
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: RevealOnScroll(
                            delay: const Duration(milliseconds: 300),
                            offset: const Offset(-30, 0),
                            child: _InfoCard(
                              icon: Icons.track_changes,
                              title: 'Our Mission',
                              body: 'To be the trusted manufacturing partner for '
                                  'heavy fabrication and engineering solutions — '
                                  'delivering consistent quality, on-time '
                                  'performance, and value-driven innovation that '
                                  'drives our customers\' success.',
                            ),
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: RevealOnScroll(
                            delay: const Duration(milliseconds: 400),
                            offset: const Offset(30, 0),
                            child: _InfoCard(
                              icon: Icons.visibility_outlined,
                              title: 'Our Vision',
                              body: 'To become a Complete Solution Provider for '
                                  'Heavy Fabrication assemblies by giving World '
                                  'Class Quality, Competitive Cost, Reliable '
                                  'Products and Excellent Services.',
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: const [
                        _InfoCard(
                          icon: Icons.track_changes,
                          title: 'Our Mission',
                          body: 'To be the trusted manufacturing partner for '
                              'heavy fabrication and engineering solutions — '
                              'delivering consistent quality, on-time '
                              'performance, and value-driven innovation that '
                              'drives our customers\' success.',
                        ),
                        SizedBox(height: 32),
                        _InfoCard(
                          icon: Icons.visibility_outlined,
                          title: 'Our Vision',
                          body: 'To become a Complete Solution Provider for '
                              'Heavy Fabrication assemblies by giving World '
                              'Class Quality, Competitive Cost, Reliable '
                              'Products and Excellent Services.',
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.steel,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: AppText.display(
              size: 24,
              weight: FontWeight.w600,
              color: AppColors.onDark,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            body,
            style: AppText.body(
              size: 16,
              color: AppColors.mutedOnDark,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
