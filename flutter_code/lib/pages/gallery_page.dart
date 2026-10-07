import 'package:flutter/material.dart';
import '../theme.dart';

class _GalleryItem {
  const _GalleryItem(this.title, this.alt, this.image);
  final String title;
  final String alt;
  final String image;
}

const _galleryItems = [
  _GalleryItem('Heavy Fabrication',
      'Heavy fabrication assembly - industrial crane beam component',
      'assets/heavy_2.jpeg'),
  _GalleryItem('Heavy Fabrication',
      'Heavy fabrication - pressure tank and structural welding',
      'assets/heavy_3.jpeg'),
  _GalleryItem('Heavy Fabrication',
      'Heavy fabrication - concrete bucket and construction cage',
      'assets/heavy_4.jpeg'),
  _GalleryItem('Skid Frame Assembly',
      'Skid frame assembly - industrial base frame fabrication',
      'assets/skid_2.jpeg'),
  _GalleryItem('Skid Frame Assembly',
      'Skid frame - pipe support and platform structure',
      'assets/skid_3.jpeg'),
  _GalleryItem('Skid Frame Assembly',
      'Skid frame assembly - structural railing and ladder',
      'assets/skid_4.jpeg'),
  _GalleryItem('Solar Structure',
      'Solar panel mounting structure fabrication',
      'assets/solar_1.jpeg'),
  _GalleryItem('Solar Structure',
      'Solar structure - ground mount frame system',
      'assets/solar_2.jpeg'),
  _GalleryItem('Solar Structure',
      'Solar structure - renewable energy support frame',
      'assets/solar_3.jpeg'),
  _GalleryItem('Material Handling Trolley',
      'Material handling trolley - industrial pallet system',
      'assets/material_1.jpeg'),
  _GalleryItem('Material Handling Trolley',
      'Material handling equipment - custom industrial trolley',
      'assets/material_2.jpeg'),
  _GalleryItem('Material Handling Trolley',
      'Material handling - heavy duty transport trolley',
      'assets/material_3.jpeg'),
  _GalleryItem('Material Handling Trolley',
      'Material handling solution - warehouse trolley system',
      'assets/material_4.jpeg'),
];

/// Port of GalleryContent.tsx — header band, image grid, and a lightbox
/// dialog with prev/next navigation.
class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  int? _lightboxIndex;

  void _goNext() => setState(() =>
      _lightboxIndex = (_lightboxIndex! + 1) % _galleryItems.length);

  void _goPrev() => setState(() => _lightboxIndex =
      (_lightboxIndex! - 1 + _galleryItems.length) % _galleryItems.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Header band.
                Container(
                  width: double.infinity,
                  color: AppColors.steel,
                  padding: const EdgeInsets.only(
                      top: 112, bottom: 80),
                  child: SiteContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _BackLink(
                            onTap: () => Navigator.of(context).pop()),
                        const SizedBox(height: 24),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: 'Product ',
                              style: AppText.display(
                                size: Breakpoints.isMd(context)
                                    ? 48
                                    : 36,
                                color: AppColors.onDark,
                              ),
                            ),
                            TextSpan(
                              text: 'Gallery',
                              style: AppText.display(
                                size: Breakpoints.isMd(context)
                                    ? 48
                                    : 36,
                                color: AppColors.primary,
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(height: 12),
                        ConstrainedBox(
                          constraints:
                              const BoxConstraints(maxWidth: 672),
                          child: Text(
                            'Browse our range of heavy fabrication assemblies, '
                            'material handling equipment, and structural solutions.',
                            style: AppText.body(
                              size: 18,
                              color: AppColors.mutedOnDark,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Grid.
                Padding(
                  padding:
                      const EdgeInsets.only(top: 48, bottom: 80),
                  child: SiteContainer(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final cols = Breakpoints.pick(context, 1,
                            sm: 2, lg: 3);
                        const gap = 24.0;
                        final w = (constraints.maxWidth -
                                gap * (cols - 1)) /
                            cols;
                        return Wrap(
                          spacing: gap,
                          runSpacing: gap,
                          children: [
                            for (var i = 0;
                                i < _galleryItems.length;
                                i++)
                              SizedBox(
                                width: w,
                                child: _GalleryCard(
                                  item: _galleryItems[i],
                                  onTap: () => setState(
                                      () => _lightboxIndex = i),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_lightboxIndex != null)
            _Lightbox(
              item: _galleryItems[_lightboxIndex!],
              onClose: () =>
                  setState(() => _lightboxIndex = null),
              onNext: _goNext,
              onPrev: _goPrev,
            ),
        ],
      ),
    );
  }
}

class _BackLink extends StatefulWidget {
  const _BackLink({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_BackLink> createState() => _BackLinkState();
}

class _BackLinkState extends State<_BackLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_back,
                size: 16,
                color: _hover
                    ? AppColors.primary
                    : AppColors.mutedOnDark),
            const SizedBox(width: 8),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: AppText.body(
                size: 14,
                color: _hover
                    ? AppColors.primary
                    : AppColors.mutedOnDark,
              ),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class _GalleryCard extends StatefulWidget {
  const _GalleryCard({required this.item, required this.onTap});

  final _GalleryItem item;
  final VoidCallback onTap;

  @override
  State<_GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<_GalleryCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 4 / 3,
                child: ClipRect(
                  child: AnimatedScale(
                    scale: _hover ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: Image.asset(
                      widget.item.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      semanticLabel: widget.item.alt,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.item.title,
                  style: AppText.display(
                    size: 18,
                    weight: FontWeight.w600,
                    color: AppColors.foreground,
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

class _Lightbox extends StatelessWidget {
  const _Lightbox({
    required this.item,
    required this.onClose,
    required this.onNext,
    required this.onPrev,
  });

  final _GalleryItem item;
  final VoidCallback onClose;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        color: Colors.black.withValues(alpha: 0.9),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {}, // swallow taps on the image
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 64),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight:
                              MediaQuery.sizeOf(context).height *
                                  0.7,
                        ),
                        child: AnimatedSwitcher(
                          duration:
                              const Duration(milliseconds: 300),
                          transitionBuilder:
                              (child, animation) =>
                                  FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: Tween(begin: 0.9, end: 1.0)
                                  .animate(animation),
                              child: child,
                            ),
                          ),
                          child: ClipRRect(
                            key: ValueKey(item.image),
                            borderRadius:
                                BorderRadius.circular(8),
                            child: Image.asset(
                              item.image,
                              fit: BoxFit.contain,
                              semanticLabel: item.alt,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      AnimatedSwitcher(
                        duration:
                            const Duration(milliseconds: 300),
                        child: Text(
                          item.title,
                          key: ValueKey(item.title),
                          textAlign: TextAlign.center,
                          style: AppText.display(
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 24,
              right: 24,
              child: _LightboxButton(
                icon: Icons.close,
                size: 28,
                onTap: onClose,
              ),
            ),
            Positioned(
              left: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: _LightboxButton(
                  icon: Icons.chevron_left,
                  size: 36,
                  onTap: onPrev,
                ),
              ),
            ),
            Positioned(
              right: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: _LightboxButton(
                  icon: Icons.chevron_right,
                  size: 36,
                  onTap: onNext,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LightboxButton extends StatefulWidget {
  const _LightboxButton({
    required this.icon,
    required this.size,
    required this.onTap,
  });

  final IconData icon;
  final double size;
  final VoidCallback onTap;

  @override
  State<_LightboxButton> createState() => _LightboxButtonState();
}

class _LightboxButtonState extends State<_LightboxButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Icon(
          widget.icon,
          size: widget.size,
          color: _hover
              ? Colors.white
              : Colors.white.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}
