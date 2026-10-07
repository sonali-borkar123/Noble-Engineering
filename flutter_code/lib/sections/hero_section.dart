import 'dart:async';

import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/site_button.dart';

const _slides = [
  ('assets/solar_1.jpeg', 'Noble Engineering solar structure fabrication in Pune'),
  ('assets/fiber_laser_cutting.jpeg', '3KW Fiber Laser Cutting Machine'),
  ('assets/heavy_3.jpeg', 'Heavy fabrication assembly - crane beams'),
  ('assets/material_1.jpeg', 'Material handling equipment'),
  ('assets/skid_2.jpeg', 'Skid frame and structural fabrication work'),
];

/// Full-viewport hero with a 5s crossfade carousel, gradient overlay, title,
/// CTAs, dot indicators and a bouncing arrow — a port of HeroSection.tsx.
class HeroSection extends StatefulWidget {
  const HeroSection({super.key, required this.onNavigate});

  final void Function(String sectionId) onNavigate;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  int _current = 0;
  Timer? _timer;
  late final AnimationController _bounce;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => setState(() => _current = (_current + 1) % _slides.length),
    );
    _bounce = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _bounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final isMd = Breakpoints.isMd(context);
    final titleSize = Breakpoints.pick<double>(context, 48,
        md: 72, lg: 96);

    return SizedBox(
      height: h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Crossfading background slides.
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 1200),
            child: _ZoomInImage(
              key: ValueKey(_current),
              asset: _slides[_current].$1,
              alt: _slides[_current].$2,
            ),
          ),
          // Gradient overlay: surface-dark 80% / 60% / 90% top→bottom.
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xCC0F131A),
                  Color(0x990F131A),
                  Color(0xE60F131A),
                ],
              ),
            ),
          ),
          // Centred content.
          Center(
            child: SiteContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'MADE IN INDIA',
                    style: AppText.display(
                      size: 18,
                      weight: FontWeight.w500,
                      color: AppColors.primary,
                      letterSpacing: 18 * 0.3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: 'NOBLE\n',
                        style: AppText.display(
                          size: titleSize,
                          color: AppColors.onDark,
                          height: 1.1,
                        ),
                      ),
                      TextSpan(
                        text: 'ENGINEERING',
                        style: AppText.display(
                          size: titleSize,
                          color: AppColors.primary,
                          height: 1.1,
                        ),
                      ),
                    ]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 672),
                    child: Text(
                      'Complete Solution Provider for Heavy Fabrication Assemblies — '
                      'World Class Quality, Competitive Cost, Reliable Products.',
                      textAlign: TextAlign.center,
                      style: AppText.body(
                        size: isMd ? 20 : 18,
                        color: AppColors.mutedOnDark,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      PrimaryButton(
                        label: 'Our Products',
                        onPressed: () => widget.onNavigate('products'),
                      ),
                      OutlineButton(
                        label: 'Contact Us',
                        onPressed: () => widget.onNavigate('contact'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Slide dots.
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < _slides.length; i++)
                  GestureDetector(
                    onTap: () => setState(() => _current = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: i == _current ? 24 : 8,
                      decoration: BoxDecoration(
                        color: i == _current
                            ? AppColors.primary
                            : AppColors.onDark.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Bouncing scroll arrow.
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _bounce,
              builder: (context, child) => Transform.translate(
                offset: Offset(0, _bounce.value * 10),
                child: child,
              ),
              child: Icon(
                Icons.arrow_downward,
                size: 24,
                color: AppColors.onDark.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Incoming slide: scales 1.1 → 1.0 while the switcher crossfades it in,
/// matching `initial={{ opacity: 0, scale: 1.1 }}`.
class _ZoomInImage extends StatelessWidget {
  const _ZoomInImage({super.key, required this.asset, required this.alt});

  final String asset;
  final String alt;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.1, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOut,
      builder: (context, scale, child) =>
          Transform.scale(scale: scale, child: child),
      child: Image.asset(
        asset,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        semanticLabel: alt,
      ),
    );
  }
}
