import 'package:flutter/material.dart';

/// Logo component — the site logo image at a given height.
class Logo extends StatelessWidget {
  const Logo({super.key, this.size = 40});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo.png',
      height: size,
      fit: BoxFit.contain,
      semanticLabel: 'Noble Engineering logo',
    );
  }
}
