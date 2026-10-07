import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../widgets/reveal.dart';

const _mapsUrl =
    'https://www.google.com/maps/place/NOBLE+ENGINEERING';
const _email = 'noble.engineering0922@gmail.com';
const _phone = '+919766314010';

/// Port of ContactSection.tsx — three link cards (maps / mailto / tel).
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: SiteContainer(
        child: Column(
          children: [
            RevealOnScroll(
              child: SectionHeader(
                eyebrow: 'Get In Touch',
                title: 'Contact Us',
                subtitleWidget: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'Let\'s work ',
                      style: AppText.body(
                        size: 18,
                        color: AppColors.mutedForeground,
                      ),
                    ),
                    TextSpan(
                      text: 'together',
                      style: AppText.body(
                        size: 18,
                        weight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    TextSpan(
                      text: ' and grow ',
                      style: AppText.body(
                        size: 18,
                        color: AppColors.mutedForeground,
                      ),
                    ),
                    TextSpan(
                      text: 'together',
                      style: AppText.body(
                        size: 18,
                        weight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ]),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 896),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cols = Breakpoints.isMd(context) ? 3 : 1;
                  const gap = 32.0;
                  final w =
                      (constraints.maxWidth - gap * (cols - 1)) / cols;
                  final cards = <(IconData, String, List<String>, String)>[
                    (
                      Icons.location_on_outlined,
                      'Address',
                      const [
                        'Gat No, 1402, Sonawane Wasti Rd, near Trimurti kata, '
                            'Jyotiba Nagar, Chikhali, Pimpri-Chinchwad, '
                            'Vitthal Nagar, Maharashtra 411062'
                      ],
                      _mapsUrl,
                    ),
                    (
                      Icons.mail_outline,
                      'Email',
                      const [_email],
                      'mailto:$_email',
                    ),
                    (
                      Icons.phone_outlined,
                      'Call Us',
                      const ['Mr. Rajendra Khaire', '+91 9766314010'],
                      'tel:$_phone',
                    ),
                  ];
                  return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    alignment: WrapAlignment.center,
                    children: [
                      for (var i = 0; i < cards.length; i++)
                        SizedBox(
                          width: w,
                          child: RevealOnScroll(
                            delay:
                                Duration(milliseconds: 200 + 100 * i),
                            offset: const Offset(0, 20),
                            duration:
                                const Duration(milliseconds: 500),
                            child: _ContactCard(
                              icon: cards[i].$1,
                              title: cards[i].$2,
                              lines: cards[i].$3,
                              highlightLast: i == 2,
                              onTap: () => _open(cards[i].$4),
                            ),
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

class _ContactCard extends StatefulWidget {
  const _ContactCard({
    required this.icon,
    required this.title,
    required this.lines,
    required this.onTap,
    this.highlightLast = false,
  });

  final IconData icon;
  final String title;
  final List<String> lines;
  final VoidCallback onTap;
  final bool highlightLast;

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
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
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.steel,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hover
                  ? AppColors.primary.withValues(alpha: 0.3)
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
                child: Icon(widget.icon,
                    size: 24, color: AppColors.primary),
              ),
              Text(
                widget.title,
                style: AppText.display(
                  size: 18,
                  weight: FontWeight.w600,
                  color: AppColors.onDark,
                ),
              ),
              const SizedBox(height: 8),
              for (var i = 0; i < widget.lines.length; i++)
                Padding(
                  padding: EdgeInsets.only(
                      top: i == 0 ? 0 : 4),
                  child: Text(
                    widget.lines[i],
                    textAlign: TextAlign.center,
                    style: AppText.body(
                      size: 14,
                      color: widget.highlightLast && i == 1
                          ? AppColors.primary
                          : AppColors.mutedOnDark,
                      weight: widget.highlightLast && i == 1
                          ? FontWeight.w600
                          : FontWeight.w400,
                      height: 1.6,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
