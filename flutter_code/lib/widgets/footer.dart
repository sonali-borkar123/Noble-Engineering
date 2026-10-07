import 'package:flutter/material.dart';
import '../theme.dart';
import 'logo.dart';

/// Port of Footer.tsx — dark strip with logo + copyright line.
class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    return Container(
      color: AppColors.surfaceDark,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: SiteContainer(
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Logo(size: 36),
                const SizedBox(width: 8),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'NOBLE',
                      style: AppText.display(
                        size: 18,
                        color: AppColors.primary,
                        letterSpacing: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: ' ENGINEERING',
                      style: AppText.display(
                        size: 18,
                        color: AppColors.onDark,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            Text(
              '© $year Noble Engineering. All rights reserved. | UDYAM-MH-26-0295999',
              style: AppText.body(
                size: 14,
                color: AppColors.mutedOnDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
