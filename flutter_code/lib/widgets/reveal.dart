import 'package:flutter/material.dart';

/// Replicates framer-motion's `useInView({ once: true })` + motion.div
/// pattern: fades/slides the child in once when it scrolls into view.
///
/// Listens to the nearest Scrollable's position (a ChangeNotifier) and checks
/// the widget's global position against the viewport height.
class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.offset = const Offset(0, 30),
    this.viewportMargin = 100,
    this.onRevealed,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;

  /// Starting translation, like framer's `y: 30` / `x: -40`.
  final Offset offset;

  /// How far inside the viewport edge the widget must be before revealing
  /// (approximates framer's `margin: "-100px"`).
  final double viewportMargin;

  /// Called once when the widget first scrolls into view.
  final VoidCallback? onRevealed;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  ScrollPosition? _position;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: widget.offset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pos = Scrollable.maybeOf(context)?.position;
    if (pos != _position) {
      _position?.removeListener(_check);
      _position = pos;
      _position?.addListener(_check);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (_revealed || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize || !box.attached) return;
    final dy = box.localToGlobal(Offset.zero).dy;
    final viewport = MediaQuery.sizeOf(context).height;
    if (dy < viewport - widget.viewportMargin && dy > -box.size.height) {
      _revealed = true;
      widget.onRevealed?.call();
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_check);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(offset: _slide.value, child: child),
        );
      },
    );
  }
}
