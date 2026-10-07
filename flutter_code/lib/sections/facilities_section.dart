import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/reveal.dart';

const _facilities = [
  (Icons.factory_outlined, 'Covered Area', '5,000 Sq Ft', false),
  (Icons.bolt, 'Power Supply', '50HP 3-Phase', false),
  (Icons.build_outlined, 'Monthly Capacity', '50 Tons', false),
  (Icons.straighten, 'Design Software', 'AutoCAD', false),
  (Icons.local_fire_department_outlined, 'Laser Cutting', '3 KW Fiber', true),
];

const _machines = [
  'MIG Welding Machine 400I – 5 Nos',
  'Arc Welding Machine 250I – 2 Nos',
  '50 Ton Press Machine',
  'Band Saw Cutting Machine',
  'Drilling Machines – 2 Nos',
  'Broach Cutter Machines – 2 Nos',
  '14" Chop Saw – 3 Nos',
  '5HP Compressor',
];

/// Port of FacilitiesSection.tsx — capability stat cards + equipment list
/// panel with a featured link to the laser-cutting section.
class FacilitiesSection extends StatelessWidget {
  const FacilitiesSection({super.key, required this.onLaserTap});

  final VoidCallback onLaserTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: SiteContainer(
        child: Column(
          children: [
            const RevealOnScroll(
              offset: Offset(0, 50),
              child: SectionHeader(
                eyebrow: 'Our Capabilities',
                title: 'Machines & Facilities',
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final cols =
                    Breakpoints.pick(context, 2, md: 3, lg: 5);
                const gap = 24.0;
                final w =
                    (constraints.maxWidth - gap * (cols - 1)) / cols;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 64),
                  child: Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    alignment: WrapAlignment.center,
                    children: [
                      for (var i = 0; i < _facilities.length; i++)
                        SizedBox(
                          width: w,
                          child: RevealOnScroll(
                            delay:
                                Duration(milliseconds: 200 + 100 * i),
                            offset: const Offset(0, 20),
                            duration:
                                const Duration(milliseconds: 500),
                            child: _FacilityCard(
                                facility: _facilities[i]),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            RevealOnScroll(
              delay: const Duration(milliseconds: 500),
              offset: const Offset(0, 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 672),
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: AppColors.steel,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Equipment List',
                        style: AppText.display(
                          size: 20,
                          weight: FontWeight.w600,
                          color: AppColors.onDark,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _FeaturedMachine(onTap: onLaserTap),
                      const SizedBox(height: 24),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final twoCol = Breakpoints.isSm(context);
                          final w = twoCol
                              ? (constraints.maxWidth - 12) / 2
                              : constraints.maxWidth;
                          return Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              for (final m in _machines)
                                SizedBox(
                                  width: w,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration:
                                            const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Flexible(
                                        child: Text(
                                          m,
                                          style: AppText.body(
                                            size: 14,
                                            color: AppColors
                                                .mutedOnDark,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FacilityCard extends StatelessWidget {
  const _FacilityCard({required this.facility});

  final (IconData, String, String, bool) facility;

  @override
  Widget build(BuildContext context) {
    final accent = facility.$4;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: accent
            ? AppColors.primary.withValues(alpha: 0.05)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: accent
              ? AppColors.primary.withValues(alpha: 0.5)
              : AppColors.border,
          width: accent ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Icon(facility.$1, size: 28, color: AppColors.primary),
          const SizedBox(height: 12),
          Text(
            facility.$3,
            textAlign: TextAlign.center,
            style: AppText.display(
              size: 20,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            facility.$2,
            textAlign: TextAlign.center,
            style: AppText.body(
              size: 14,
              color: AppColors.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedMachine extends StatefulWidget {
  const _FeaturedMachine({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_FeaturedMachine> createState() => _FeaturedMachineState();
}

class _FeaturedMachineState extends State<_FeaturedMachine> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.4)),
            color: AppColors.primary
                .withValues(alpha: _hover ? 0.15 : 0.1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(Icons.local_fire_department_outlined,
                    color: AppColors.primary, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      children: [
                        Text(
                          '3KW Fiber Laser Cutting Machine',
                          style: AppText.display(
                            size: 16,
                            weight: FontWeight.w600,
                            color: AppColors.onDark,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.auto_awesome,
                                  size: 9,
                                  color: AppColors.primaryForeground),
                              const SizedBox(width: 3),
                              Text(
                                'NEW',
                                style: AppText.display(
                                  size: 9,
                                  weight: FontWeight.w500,
                                  color: AppColors.primaryForeground,
                                  letterSpacing: 1.6,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Bed 1.5 × 6.5 Mtr · Make — Synergy Machine',
                      style: AppText.body(
                        size: 12,
                        color: AppColors.mutedOnDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
