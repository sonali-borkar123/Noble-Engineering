import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/reveal.dart';
import '../widgets/site_button.dart';

const _products = [
  (
    'Heavy Fabrication',
    'Concrete buckets, crane beams, construction cages, luminary carriages, and pressure tanks.',
    'assets/heavy_2.jpeg',
  ),
  (
    'Material Handling Equipment',
    'Trolleys, pallets, and custom material handling solutions for industrial applications.',
    'assets/material_1.jpeg',
  ),
  (
    'Skid Frames & Structures',
    'Skid frames, pipe supports, base frames, ladders, platforms, railings, and structural assemblies.',
    'assets/skid_3.jpeg',
  ),
  (
    'Solar Structures',
    'Solar panel mounting structures, frames, and support systems for renewable energy installations.',
    'assets/solar_1.jpeg',
  ),
];

/// Port of ProductsSection.tsx — dark "Product Range" grid of 4 image cards
/// linking to the gallery page plus a "View Full Gallery" button.
class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key, required this.onOpenGallery});

  final VoidCallback onOpenGallery;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.steel, // .section-dark
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: SiteContainer(
        child: Column(
          children: [
            const RevealOnScroll(
              child: SectionHeader(
                eyebrow: 'What We Build',
                title: 'Product Range',
                dark: true,
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final cols =
                    Breakpoints.pick(context, 1, md: 2, lg: 4);
                const gap = 32.0;
                final w = (constraints.maxWidth - gap * (cols - 1)) / cols;
                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (var i = 0; i < _products.length; i++)
                      SizedBox(
                        width: w,
                        child: RevealOnScroll(
                          delay:
                              Duration(milliseconds: 200 + 150 * i),
                          offset: const Offset(0, 40),
                          child: _ProductCard(
                            product: _products[i],
                            onTap: onOpenGallery,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 40),
            RevealOnScroll(
              delay: const Duration(milliseconds: 900),
              offset: const Offset(0, 20),
              child: PrimaryButton(
                label: 'View Full Gallery',
                onPressed: onOpenGallery,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatefulWidget {
  const _ProductCard({required this.product, required this.onTap});

  final (String, String, String) product;
  final VoidCallback onTap;

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AspectRatio(
            aspectRatio: 4 / 5,
            child: Stack(
              fit: StackFit.expand,
              children: [
                AnimatedScale(
                  scale: _hover ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOut,
                  child: Image.asset(widget.product.$3,
                      fit: BoxFit.cover,
                      semanticLabel: widget.product.$1),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.surfaceDark,
                        Color(0x660F131A),
                        Color(0x000F131A),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 24,
                  right: 24,
                  bottom: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.$1,
                        style: AppText.display(
                          size: 24,
                          weight: FontWeight.w600,
                          color: AppColors.onDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.product.$2,
                        style: AppText.body(
                          size: 14,
                          color: AppColors.mutedOnDark,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
