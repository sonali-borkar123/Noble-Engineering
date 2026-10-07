import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/reveal.dart';

const _certs = [
  (
    Icons.emoji_events_outlined,
    'ISO 9001:2015 Certified',
    'ISO 9001:2015',
    'Certified Quality Management System ensuring consistent quality standards across all manufacturing processes.',
  ),
  (
    Icons.verified_outlined,
    'UDYAM Registered',
    'UDYAM-MH-26-0295999',
    'Registered Micro/Small Enterprise under Ministry of MSME, Government of India.',
  ),
  (
    Icons.fact_check_outlined,
    'GST Registered',
    'GST Compliant',
    'Fully compliant with Goods and Services Tax regulations for transparent business.',
  ),
  (
    Icons.shield_outlined,
    'Quality Assured',
    'In-house QC',
    'Rigorous in-house quality checks at every stage — from raw material to final dispatch.',
  ),
];

/// Port of CertificationsSection.tsx — four certification cards.
class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

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
                eyebrow: 'Trust & Compliance',
                title: 'Certifications',
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1024),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cols =
                      Breakpoints.pick(context, 1, md: 2, lg: 4);
                  const gap = 32.0;
                  final w =
                      (constraints.maxWidth - gap * (cols - 1)) / cols;
                  return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: [
                      for (var i = 0; i < _certs.length; i++)
                        SizedBox(
                          width: w,
                          child: RevealOnScroll(
                            delay:
                                Duration(milliseconds: 200 + 150 * i),
                            offset: const Offset(0, 25),
                            duration:
                                const Duration(milliseconds: 500),
                            child: _CertCard(cert: _certs[i]),
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

class _CertCard extends StatefulWidget {
  const _CertCard({required this.cert});

  final (IconData, String, String, String) cert;

  @override
  State<_CertCard> createState() => _CertCardState();
}

class _CertCardState extends State<_CertCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hover
                ? AppColors.primary.withValues(alpha: 0.3)
                : AppColors.border,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
              child:
                  Icon(widget.cert.$1, size: 28, color: AppColors.primary),
            ),
            Text(
              widget.cert.$2,
              textAlign: TextAlign.center,
              style: AppText.display(
                size: 20,
                weight: FontWeight.w600,
                color: AppColors.foreground,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.cert.$3,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.cert.$4,
              textAlign: TextAlign.center,
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
