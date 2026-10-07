import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/reveal.dart';

const _specs = [
  (Icons.bolt, 'Laser Power', '3 KW', 'Fiber source'),
  (Icons.open_in_full, 'Bed Size', '1.5 × 6.5', 'Metres'),
  (Icons.factory_outlined, 'Make', 'Synergy', 'Synergy Machine'),
  (Icons.gps_fixed, 'Process', 'CNC', 'Fiber laser cutting'),
];

const _benefits = [
  'Clean, burr-free edges straight off the bed',
  '6.5 metre long bed for full-length sheets and plates',
  'In-house cutting means shorter lead times',
  'Tight, repeatable accuracy on production batches',
  'Nesting-optimised cutting to reduce material waste',
  'Profiles, cut-outs and complex geometry in one setup',
];

/// Port of LaserCuttingSection.tsx — dark feature section for the new 3KW
/// fiber laser: image card with corner accents and "Now Operational" badge,
/// spec grid, benefits list and a CTA.
class LaserCuttingSection extends StatelessWidget {
  const LaserCuttingSection({super.key, required this.onContact});

  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final isLg = Breakpoints.isLg(context);
    return Container(
      color: AppColors.surfaceDark,
      child: Stack(
        children: [
          // Ambient amber glows.
          Positioned(
            top: -128,
            right: -96,
            child: _Glow(size: 448, alpha: 0.10),
          ),
          Positioned(
            bottom: -160,
            left: -128,
            child: _Glow(size: 416, alpha: 0.05),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 96),
            child: SiteContainer(
              child: Column(
                children: [
                  RevealOnScroll(
                    child: Column(
                      children: [
                        // "New Addition" pill badge.
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                                color: AppColors.primary
                                    .withValues(alpha: 0.4)),
                            color: AppColors.primary
                                .withValues(alpha: 0.1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.auto_awesome,
                                  size: 14, color: AppColors.primary),
                              const SizedBox(width: 8),
                              Text(
                                'NEW ADDITION',
                                style: AppText.display(
                                  size: 12,
                                  weight: FontWeight.w500,
                                  color: AppColors.primary,
                                  letterSpacing: 12 * 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: '3KW Fiber Laser ',
                              style: AppText.display(
                                size: Breakpoints.isMd(context) ? 48 : 36,
                                color: AppColors.onDark,
                                height: 1.15,
                              ),
                            ),
                            TextSpan(
                              text: 'Cutting Machine',
                              style: AppText.display(
                                size: Breakpoints.isMd(context) ? 48 : 36,
                                color: AppColors.primary,
                                height: 1.15,
                              ),
                            ),
                          ]),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'With Bed 1.5 × 6.5 Mtr  ·  Make — Synergy Machine',
                          textAlign: TextAlign.center,
                          style: AppText.body(
                            size: 18,
                            color: AppColors.mutedOnDark,
                          ),
                        ),
                        const SizedBox(height: 56),
                      ],
                    ),
                  ),
                  isLg
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: RevealOnScroll(
                                delay:
                                    const Duration(milliseconds: 150),
                                duration:
                                    const Duration(milliseconds: 700),
                                offset: const Offset(-40, 0),
                                child: const _MachinePhoto(),
                              ),
                            ),
                            const SizedBox(width: 48),
                            Expanded(
                              child: RevealOnScroll(
                                delay:
                                    const Duration(milliseconds: 250),
                                duration:
                                    const Duration(milliseconds: 700),
                                offset: const Offset(40, 0),
                                child: _Details(onContact: onContact),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const _MachinePhoto(),
                            const SizedBox(height: 48),
                            _Details(onContact: onContact),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.size, required this.alpha});

  final double size;
  final double alpha;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppColors.primary.withValues(alpha: alpha),
              AppColors.primary.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}

class _MachinePhoto extends StatelessWidget {
  const _MachinePhoto();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.steelLight),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black45, blurRadius: 32),
          ],
        ),
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/fiber_laser_cutting.jpeg',
                fit: BoxFit.cover,
                semanticLabel:
                    '3KW Fiber Laser Cutting Machine with 1.5 x 6.5 metre bed',
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xB30F131A),
                      Color(0x000F131A),
                    ],
                  ),
                ),
              ),
              // Corner accents.
              const Positioned(
                top: 16,
                left: 16,
                child: _Corner(top: true, left: true),
              ),
              const Positioned(
                bottom: 16,
                right: 16,
                child: _Corner(top: false, left: false),
              ),
              // Live badge.
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: const [
                      BoxShadow(color: Colors.black38, blurRadius: 12),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const _PingDot(),
                      const SizedBox(width: 8),
                      Text(
                        'NOW OPERATIONAL',
                        style: AppText.display(
                          size: 11,
                          weight: FontWeight.w500,
                          color: AppColors.primaryForeground,
                          letterSpacing: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 24,
                right: 96,
                bottom: 16,
                child: Text(
                  'INSTALLED IN-HOUSE',
                  style: AppText.display(
                    size: 14,
                    weight: FontWeight.w500,
                    color: AppColors.onDark,
                    letterSpacing: 14 * 0.1,
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

class _Corner extends StatelessWidget {
  const _Corner({required this.top, required this.left});

  final bool top;
  final bool left;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          top: top
              ? BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.7),
                  width: 2)
              : BorderSide.none,
          bottom: !top
              ? BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.7),
                  width: 2)
              : BorderSide.none,
          left: left
              ? BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.7),
                  width: 2)
              : BorderSide.none,
          right: !left
              ? BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.7),
                  width: 2)
              : BorderSide.none,
        ),
      ),
    );
  }
}

/// The "ping" dot inside the Now Operational badge — a dot with a repeating
/// expanding ring, like Tailwind's animate-ping.
class _PingDot extends StatefulWidget {
  const _PingDot();

  @override
  State<_PingDot> createState() => _PingDotState();
}

class _PingDotState extends State<_PingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 8,
      height: 8,
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Transform.scale(
                scale: 1 + _c.value * 1.5,
                child: Opacity(
                  opacity: 0.7 * (1 - _c.value),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryForeground,
                    ),
                  ),
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryForeground,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({required this.onContact});

  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final isSm = Breakpoints.isSm(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Noble Engineering has added a 3KW fiber laser cutting machine to its '
          'existing setup. With a 1.5 × 6.5 metre bed, we now cut sheet and '
          'plate profiles in-house — giving our customers tighter tolerances, '
          'faster turnaround, and complete control over quality from cutting '
          'through to final fabrication and assembly.',
          style: AppText.body(
            size: 16,
            color: AppColors.mutedOnDark,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 32),
        LayoutBuilder(
          builder: (context, constraints) {
            const gap = 16.0;
            final w = (constraints.maxWidth - gap) / 2;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (var i = 0; i < _specs.length; i++)
                  SizedBox(
                    width: w,
                    child: RevealOnScroll(
                      delay: Duration(milliseconds: 400 + 100 * i),
                      offset: const Offset(0, 20),
                      duration: const Duration(milliseconds: 500),
                      child: _SpecCard(spec: _specs[i]),
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (var i = 0; i < _benefits.length; i++)
              SizedBox(
                width: isSm ? 260 : double.infinity,
                child: RevealOnScroll(
                  delay: Duration(milliseconds: 800 + 70 * i),
                  offset: const Offset(15, 0),
                  duration: const Duration(milliseconds: 400),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Icon(Icons.check,
                            size: 16, color: AppColors.primary),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          _benefits[i],
                          style: AppText.body(
                            size: 14,
                            color: AppColors.mutedOnDark,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 32),
        RevealOnScroll(
          delay: const Duration(milliseconds: 1250),
          offset: const Offset(0, 15),
          duration: const Duration(milliseconds: 500),
          child: _EnquireButton(onTap: onContact),
        ),
      ],
    );
  }
}

class _SpecCard extends StatefulWidget {
  const _SpecCard({required this.spec});

  final (IconData, String, String, String) spec;

  @override
  State<_SpecCard> createState() => _SpecCardState();
}

class _SpecCardState extends State<_SpecCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.steel,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hover
                ? AppColors.primary.withValues(alpha: 0.4)
                : AppColors.steelLight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(widget.spec.$1, size: 20, color: AppColors.primary),
            const SizedBox(height: 12),
            Text(
              widget.spec.$2.toUpperCase(),
              style: AppText.body(
                size: 11,
                color: AppColors.mutedOnDark,
                letterSpacing: 1.6,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              widget.spec.$3,
              style: AppText.display(
                size: 24,
                color: AppColors.onDark,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              widget.spec.$4,
              style: AppText.body(
                size: 12,
                color: AppColors.mutedOnDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EnquireButton extends StatefulWidget {
  const _EnquireButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_EnquireButton> createState() => _EnquireButtonState();
}

class _EnquireButtonState extends State<_EnquireButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            color: _hover ? AppColors.amberWarm : AppColors.primary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ENQUIRE ABOUT LASER CUTTING',
                style: AppText.display(
                  size: 14,
                  weight: FontWeight.w500,
                  color: AppColors.primaryForeground,
                  letterSpacing: 14 * 0.1,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedSlide(
                offset: Offset(_hover ? 0.15 : 0, 0),
                duration: const Duration(milliseconds: 200),
                child: const Icon(Icons.arrow_forward,
                    size: 16, color: AppColors.primaryForeground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
