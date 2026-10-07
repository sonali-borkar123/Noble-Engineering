import 'package:flutter/material.dart';

/// Design tokens ported from globals.css / tailwind.config.ts.
class AppColors {
  AppColors._();

  static const background = Color(0xFFF6F7F9); // 220 20% 97%
  static const foreground = Color(0xFF131720); // 220 25% 10%
  static const card = Color(0xFFFFFFFF);
  static const primary = Color(0xFFF98806); // 32 95% 50%
  static const primaryForeground = Color(0xFFFFFFFF);
  static const muted = Color(0xFFE8EAEE); // 220 15% 92%
  static const mutedForeground = Color(0xFF676F7E); // 220 10% 45%
  static const border = Color(0xFFDCDFE5); // 220 15% 88%
  static const steel = Color(0xFF1D212B); // 220 20% 14%
  static const steelLight = Color(0xFF363D49); // 220 15% 25%
  static const amberWarm = Color(0xFFDA6C0B); // 28 90% 45%
  static const surfaceDark = Color(0xFF0F131A); // 220 25% 8%
  static const surfaceSteel = Color(0xFF262B36); // 220 18% 18%
  static const onDark = Color(0xFFF2F2F2); // 0 0% 95%
  static const mutedOnDark = Color(0xFF9DA3AF); // 220 10% 65%
  static const whatsapp = Color(0xFF25D366);
  static const whatsappHover = Color(0xFF1EBE57);
}

/// Oswald is the display (heading) font, Inter the body font — same as the
/// site's `font-display` / `font-body` utilities.
class AppText {
  AppText._();

  static TextStyle display({
    double size = 16,
    FontWeight weight = FontWeight.w700,
    Color color = AppColors.onDark,
    double? letterSpacing,
    double? height,
    List<Shadow>? shadows,
  }) {
    return TextStyle(
      fontFamily: 'Oswald',
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      shadows: shadows,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle body({
    double size = 16,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.foreground,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: TextDecoration.none,
    );
  }
}

/// Tailwind breakpoints: sm 640, md 768, lg 1024, xl 1280.
class Breakpoints {
  Breakpoints._();

  static double width(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  static bool isSm(BuildContext c) => width(c) >= 640;
  static bool isMd(BuildContext c) => width(c) >= 768;
  static bool isLg(BuildContext c) => width(c) >= 1024;
  static bool isXl(BuildContext c) => width(c) >= 1280;

  /// Picks the largest matching variant, like Tailwind responsive prefixes.
  static T pick<T>(BuildContext c, T base,
      {T? sm, T? md, T? lg, T? xl, T? xxl}) {
    final w = width(c);
    if (w >= 1400 && xxl != null) return xxl;
    if (w >= 1280 && xl != null) return xl;
    if (w >= 1024 && lg != null) return lg;
    if (w >= 768 && md != null) return md;
    if (w >= 640 && sm != null) return sm;
    return base;
  }
}

/// Mirrors the Tailwind `container` class: fluid below 640px, then snapped to
/// each breakpoint width, centred, with 16px horizontal padding (the px-4 the
/// sections add on top of `container`).
class SiteContainer extends StatelessWidget {
  const SiteContainer({super.key, required this.child});

  final Widget child;

  static double maxWidthFor(double viewport) {
    if (viewport >= 1400) return 1400;
    if (viewport >= 1280) return 1280;
    if (viewport >= 1024) return 1024;
    if (viewport >= 768) return 768;
    if (viewport >= 640) return 640;
    return viewport;
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidthFor(w)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: child,
        ),
      ),
    );
  }
}

/// Section eyebrow label, e.g. "WHO WE ARE" — primary colour, Oswald, wide
/// tracking. Wraps the `p` + `h2` pattern used by every section header.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.titleSpans,
    this.subtitle,
    this.subtitleWidget,
    this.dark = false,
    this.marginBottom = 64,
  });

  final String eyebrow;
  final String title;
  final InlineSpan? titleSpans;
  final String? subtitle;
  final Widget? subtitleWidget;
  final bool dark;
  final double marginBottom;

  @override
  Widget build(BuildContext context) {
    final titleColor = dark ? AppColors.onDark : AppColors.foreground;
    return Padding(
      padding: EdgeInsets.only(bottom: marginBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            eyebrow.toUpperCase(),
            textAlign: TextAlign.center,
            style: AppText.display(
              size: 14,
              weight: FontWeight.w500,
              color: AppColors.primary,
              letterSpacing: 14 * 0.3,
            ),
          ),
          const SizedBox(height: 12),
          Text.rich(
            titleSpans ?? TextSpan(text: title),
            textAlign: TextAlign.center,
            style: AppText.display(
              size: Breakpoints.isMd(context) ? 48 : 36,
              weight: FontWeight.w700,
              color: titleColor,
              height: 1.15,
            ),
          ),
          if (subtitle != null || subtitleWidget != null) ...[
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 672),
              child: subtitleWidget ??
                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: AppText.body(
                      size: 16,
                      color: dark
                          ? AppColors.mutedOnDark
                          : AppColors.mutedForeground,
                      height: 1.6,
                    ),
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
