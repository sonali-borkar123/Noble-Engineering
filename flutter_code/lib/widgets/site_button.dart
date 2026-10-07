import 'package:flutter/material.dart';
import '../theme.dart';

/// Filled primary button used across the site ("Our Products", "View Full
/// Gallery", CTAs). `px-8 py-4 bg-primary` with amber-warm hover.
class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.trailing,
  });

  final String label;
  final VoidCallback onPressed;
  final Widget? trailing;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onPressed,
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
                widget.label.toUpperCase(),
                style: AppText.display(
                  size: 14,
                  weight: FontWeight.w500,
                  color: AppColors.primaryForeground,
                  letterSpacing: 14 * 0.1,
                ),
              ),
              if (widget.trailing != null) ...[
                const SizedBox(width: 8),
                widget.trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Outlined variant used for the hero "Contact Us" button:
/// `border border-on-dark/30 text-on-dark`, border/text turn primary on hover.
class OutlineButton extends StatefulWidget {
  const OutlineButton({super.key, required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  State<OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<OutlineButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final color = _hover ? AppColors.primary : AppColors.onDark;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: _hover
                  ? AppColors.primary
                  : AppColors.onDark.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            widget.label.toUpperCase(),
            style: AppText.display(
              size: 14,
              weight: FontWeight.w500,
              color: color,
              letterSpacing: 14 * 0.1,
            ),
          ),
        ),
      ),
    );
  }
}
