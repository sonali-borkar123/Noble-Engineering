import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/reveal.dart';

const _reasons = [
  (Icons.verified_user_outlined, 'World Class Quality',
      'Strict quality control at every stage of fabrication and assembly.'),
  (Icons.currency_rupee, 'Competitive Pricing',
      'Cost-effective solutions without compromising on quality standards.'),
  (Icons.schedule, 'On-Time Delivery',
      'Reliable timelines backed by 50 tons monthly production capacity.'),
  (Icons.build_outlined, 'Custom Solutions',
      'Tailored engineering for your specific industrial requirements.'),
  (Icons.handshake_outlined, 'Trusted Partnerships',
      'Long-term relationships with 18+ leading industrial clients.'),
  (Icons.trending_up, 'Continuous Improvement',
      'Constantly upgrading our setup — including a new 3KW fiber laser cutting machine.'),
];

/// Port of WhyChooseUs.tsx — 6 reason cards in a responsive grid.
class WhyChooseUs extends StatelessWidget {
  const WhyChooseUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: SiteContainer(
        child: Column(
          children: [
            const RevealOnScroll(
              child: SectionHeader(
                eyebrow: 'Our Strengths',
                title: 'Why Choose Us',
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1024),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cols = Breakpoints.pick(context, 1, sm: 2, lg: 3);
                  const gap = 24.0;
                  final w =
                      (constraints.maxWidth - gap * (cols - 1)) / cols;
                  return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: [
                      for (var i = 0; i < _reasons.length; i++)
                        SizedBox(
                          width: w,
                          child: RevealOnScroll(
                            delay: Duration(milliseconds: 150 + 100 * i),
                            offset: const Offset(0, 25),
                            duration: const Duration(milliseconds: 500),
                            child: _ReasonCard(reason: _reasons[i]),
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

class _ReasonCard extends StatefulWidget {
  const _ReasonCard({required this.reason});

  final (IconData, String, String) reason;

  @override
  State<_ReasonCard> createState() => _ReasonCardState();
}

class _ReasonCardState extends State<_ReasonCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hover
                ? AppColors.primary.withValues(alpha: 0.3)
                : AppColors.border,
          ),
          boxShadow: _hover
              ? const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary
                    .withValues(alpha: _hover ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(widget.reason.$1,
                  color: AppColors.primary, size: 22),
            ),
            const SizedBox(height: 16),
            Text(
              widget.reason.$2,
              style: AppText.display(
                size: 18,
                weight: FontWeight.w600,
                color: AppColors.foreground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.reason.$3,
              style: AppText.body(
                size: 14,
                color: AppColors.mutedForeground,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
