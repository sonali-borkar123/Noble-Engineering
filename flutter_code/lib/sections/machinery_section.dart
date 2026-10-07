import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/reveal.dart';

const _autoplayMs = 5000;

class _GroupItem {
  const _GroupItem(this.name, this.image);
  final String name;
  final String image;
}

class _Slide {
  const _Slide.single({
    required this.title,
    this.subtitle,
    required this.image,
  })  : isGroup = false,
        items = const [];

  const _Slide.group({
    required this.title,
    this.subtitle,
    required this.items,
  })  : isGroup = true,
        image = '';

  final bool isGroup;
  final String title;
  final String? subtitle;
  final String image;
  final List<_GroupItem> items;
}

const _slides = [
  _Slide.single(
    title: 'EOT Crane',
    subtitle: '5 Ton capacity',
    image: 'assets/machine/crane.jpeg',
  ),
  _Slide.single(
    title: 'Fiber Laser Cutting Machine',
    subtitle: '3 KW · Bed 1.5 × 6.5 Mtr · Make Synergy Machine',
    image: 'assets/fiber_laser_cutting.jpeg',
  ),
  _Slide.group(
    title: 'Cutting & Welding Setup',
    subtitle: 'Band saw, MIG & arc welding, air compressor',
    items: [
      _GroupItem(
          'Band Saw Machine – Range 250mm', 'assets/machine/bendsaw.jpeg'),
      _GroupItem('500A CO2 MIG Welding Machine – 6 Nos',
          'assets/machine/welding.jpeg'),
      _GroupItem(
          'Air Compressor 5HP', 'assets/machine/air_compressor.jpeg'),
      _GroupItem('Arc Welding Machine 250A – 1 Nos',
          'assets/machine/arc_welding.jpeg'),
    ],
  ),
  _Slide.group(
    title: 'Other Machines',
    subtitle: 'Drilling, grinding & material handling',
    items: [
      _GroupItem('Magnetic Drill Machine – Range 12 to 32mm',
          'assets/machine/magnetic_drill.jpeg'),
      _GroupItem('Pillar Drill Machine – Range upto 22mm',
          'assets/machine/piller_drill.jpeg'),
      _GroupItem(
          'Heavy Duty Hand Pallet – Range 2T', 'assets/machine/hand_pallet.jpeg'),
      _GroupItem('Hand Grinder 7" / 4"', 'assets/machine/grinder.jpeg'),
    ],
  ),
];

/// Port of MachinerySection.tsx — an autoplaying carousel where each slide is
/// either a single machine photo or a 2×2 grid of equipment, with a gradient
/// title bar, progress indicator, arrows, dots and a pause control.
class MachinerySection extends StatefulWidget {
  const MachinerySection({super.key});

  @override
  State<MachinerySection> createState() => _MachinerySectionState();
}

class _MachinerySectionState extends State<MachinerySection>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  int _direction = 1;
  bool _paused = false;
  bool _seen = false; // becomes true when section scrolls into view

  /// Doubles as the autoplay timer and the progress bar: when it completes,
  /// the slide advances.
  late final AnimationController _progress;

  @override
  void initState() {
    super.initState();
    _progress = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _autoplayMs),
    );
    _progress.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        _goTo(_index + 1);
      }
    });
  }

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  bool get _autoplayActive => _seen && !_paused;

  void _syncAutoplay() {
    if (_autoplayActive) {
      _progress.forward(from: 0);
    } else {
      _progress.stop();
      _progress.reset();
    }
  }

  void _goTo(int next) {
    setState(() {
      _direction = (next > _index ||
              (_index == _slides.length - 1 && next == 0))
          ? 1
          : -1;
      _index = (next + _slides.length) % _slides.length;
    });
    _syncAutoplay();
  }

  void _setPaused(bool paused) {
    if (paused == _paused) return;
    setState(() => _paused = paused);
    _syncAutoplay();
  }

  @override
  Widget build(BuildContext context) {
    final isSm = Breakpoints.isSm(context);
    final slide = _slides[_index];

    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: SiteContainer(
        child: Column(
          children: [
            RevealOnScroll(
              onRevealed: () {
                _seen = true;
                _syncAutoplay();
              },
              child: const SectionHeader(
                eyebrow: 'Our Setup',
                title: 'Machinery',
                subtitle:
                    'A look at the equipment that keeps our shop floor running — '
                    'from cutting and welding to lifting and material handling.',
                marginBottom: 56,
              ),
            ),
            RevealOnScroll(
              delay: const Duration(milliseconds: 150),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 768),
                child: MouseRegion(
                  onEnter: (_) => _setPaused(true),
                  onExit: (_) => _setPaused(false),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.steel,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.border),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 24,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AspectRatio(
                                  aspectRatio: isSm ? 16 / 11 : 4 / 3,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      AnimatedSwitcher(
                                        duration: const Duration(
                                            milliseconds: 500),
                                        switchInCurve: Curves.easeInOut,
                                        switchOutCurve: Curves.easeInOut,
                                        transitionBuilder:
                                            _slideTransition,
                                        layoutBuilder:
                                            (current, previous) => Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            ...previous,
                                            ?current,
                                          ],
                                        ),
                                        child: KeyedSubtree(
                                          key: ValueKey(_index),
                                          child: slide.isGroup
                                              ? _GroupSlide(slide: slide)
                                              : _SingleSlide(slide: slide),
                                        ),
                                      ),
                                      // Title bar gradient.
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        child: IgnorePointer(
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                              isSm ? 64 : 56,
                                              isSm ? 20 : 16,
                                              isSm ? 64 : 56,
                                              32,
                                            ),
                                            decoration:
                                                const BoxDecoration(
                                              gradient: LinearGradient(
                                                begin:
                                                    Alignment.topCenter,
                                                end: Alignment
                                                    .bottomCenter,
                                                colors: [
                                                  Color(0xF20F131A),
                                                  Color(0xB30F131A),
                                                  Color(0x000F131A),
                                                ],
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: [
                                                Text(
                                                  slide.title,
                                                  style:
                                                      AppText.display(
                                                    size:
                                                        isSm ? 20 : 16,
                                                    color: AppColors
                                                        .primary,
                                                    height: 1.25,
                                                    shadows: const [
                                                      Shadow(
                                                        color: Colors
                                                            .black87,
                                                        blurRadius: 3,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (slide.subtitle !=
                                                    null)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets
                                                            .only(
                                                            top: 2),
                                                    child: Text(
                                                      slide.subtitle!,
                                                      style: AppText
                                                          .display(
                                                        size: isSm
                                                            ? 14
                                                            : 11,
                                                        weight:
                                                            FontWeight
                                                                .w400,
                                                        color: AppColors
                                                            .primary,
                                                        height: 1.25,
                                                        shadows: const [
                                                          Shadow(
                                                            color: Colors
                                                                .black87,
                                                            blurRadius:
                                                                3,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Autoplay progress bar.
                                Container(
                                  height: 4,
                                  color: AppColors.steelLight,
                                  child: AnimatedBuilder(
                                    animation: _progress,
                                    builder: (context, _) =>
                                        FractionallySizedBox(
                                      alignment:
                                          Alignment.centerLeft,
                                      widthFactor: _progress.value,
                                      child: Container(
                                          color: AppColors.primary),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Prev / next arrows.
                          Positioned(
                            left: 12,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: _ArrowButton(
                                icon: Icons.chevron_left,
                                onTap: () => _goTo(_index - 1),
                                size: isSm ? 40 : 36,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 12,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: _ArrowButton(
                                icon: Icons.chevron_right,
                                onTap: () => _goTo(_index + 1),
                                size: isSm ? 40 : 36,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var i = 0; i < _slides.length; i++)
                            GestureDetector(
                              onTap: () => _goTo(i),
                              child: AnimatedContainer(
                                duration:
                                    const Duration(milliseconds: 300),
                                margin:
                                    const EdgeInsets.symmetric(
                                        horizontal: 4),
                                height: 10,
                                width: i == _index ? 32 : 10,
                                decoration: BoxDecoration(
                                  color: i == _index
                                      ? AppColors.primary
                                      : AppColors.border,
                                  borderRadius:
                                      BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          const SizedBox(width: 16),
                          _PauseButton(
                            paused: _paused,
                            onTap: () => _setPaused(!_paused),
                          ),
                        ],
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

  Widget _slideTransition(Widget child, Animation<double> animation) {
    // Incoming slides enter from the direction side; outgoing exit opposite —
    // mirrors framer's x: ±100% variants.
    final isIncoming = child.key == ValueKey(_index);
    final begin = isIncoming ? Offset(_direction.toDouble(), 0) : Offset.zero;
    final end =
        isIncoming ? Offset.zero : Offset(-_direction.toDouble(), 0);
    return SlideTransition(
      position: Tween(begin: begin, end: end).animate(animation),
      child: FadeTransition(opacity: animation, child: child),
    );
  }
}

class _SingleSlide extends StatelessWidget {
  const _SingleSlide({required this.slide});
  final _Slide slide;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceDark,
      child: Image.asset(slide.image, fit: BoxFit.contain),
    );
  }
}

class _GroupSlide extends StatelessWidget {
  const _GroupSlide({required this.slide});
  final _Slide slide;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.border,
      child: Column(
        children: [
          for (var row = 0; row < 2; row++)
            Expanded(
              child: Row(
                children: [
                  for (var col = 0; col < 2; col++)
                    Expanded(
                      child: _GridCell(item: slide.items[row * 2 + col]),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _GridCell extends StatelessWidget {
  const _GridCell({required this.item});
  final _GroupItem item;

  @override
  Widget build(BuildContext context) {
    final isSm = Breakpoints.isSm(context);
    return Container(
      margin: const EdgeInsets.all(0.5),
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(isSm ? 16 : 12),
              child: Image.asset(item.image, fit: BoxFit.contain),
            ),
          ),
          Container(
            width: double.infinity,
            color: AppColors.steel,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(
              item.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppText.body(
                size: isSm ? 11 : 9,
                weight: FontWeight.w500,
                color: AppColors.onDark,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowButton extends StatefulWidget {
  const _ArrowButton({
    required this.icon,
    required this.onTap,
    required this.size,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;

  @override
  State<_ArrowButton> createState() => _ArrowButtonState();
}

class _ArrowButtonState extends State<_ArrowButton> {
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
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hover
                ? AppColors.primary
                : AppColors.surfaceDark.withValues(alpha: 0.7),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
          ),
          child: Icon(widget.icon, color: AppColors.onDark, size: 20),
        ),
      ),
    );
  }
}

class _PauseButton extends StatefulWidget {
  const _PauseButton({required this.paused, required this.onTap});

  final bool paused;
  final VoidCallback onTap;

  @override
  State<_PauseButton> createState() => _PauseButtonState();
}

class _PauseButtonState extends State<_PauseButton> {
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
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: _hover
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : AppColors.border,
            ),
          ),
          child: Icon(
            widget.paused ? Icons.play_arrow : Icons.pause,
            size: 14,
            color: _hover ? AppColors.primary : AppColors.mutedForeground,
          ),
        ),
      ),
    );
  }
}
