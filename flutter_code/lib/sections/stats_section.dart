import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/reveal.dart';

const _stats = [
  (Icons.inventory_2_outlined, 50, '+', 'Projects Delivered'),
  (Icons.people_outline, 18, '+', 'Trusted Clients'),
  (Icons.factory_outlined, 50, ' Tons', 'Monthly Capacity'),
  (Icons.emoji_events_outlined, 5, '+ Yrs', 'Experience'),
];

/// `bg-steel` strip with 4 animated counters — port of StatsSection.tsx.
class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.steel,
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: SiteContainer(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final cols = Breakpoints.isMd(context) ? 4 : 2;
            return Wrap(
              spacing: 32,
              runSpacing: 32,
              children: [
                for (var i = 0; i < _stats.length; i++)
                  SizedBox(
                    width: (constraints.maxWidth - 32 * (cols - 1)) / cols,
                    child: RevealOnScroll(
                      delay: Duration(milliseconds: 100 * i),
                      offset: const Offset(0, 20),
                      duration: const Duration(milliseconds: 500),
                      child: _Stat(stat: _stats[i]),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.stat});

  final (IconData, int, String, String) stat;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(stat.$1, size: 28, color: AppColors.primary.withValues(alpha: 0.6)),
        const SizedBox(height: 12),
        // Counter animates 0 → target over ~2s once the section reveals.
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: stat.$2),
          duration: const Duration(milliseconds: 2000),
          builder: (context, value, _) => Text(
            '$value${stat.$3}',
            style: AppText.display(
              size: Breakpoints.isMd(context) ? 48 : 36,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          stat.$4,
          textAlign: TextAlign.center,
          style: AppText.body(size: 14, color: AppColors.mutedOnDark),
        ),
      ],
    );
  }
}
