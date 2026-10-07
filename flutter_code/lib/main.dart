import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'pages/gallery_page.dart';
import 'pages/home_page.dart';
import 'theme.dart';
import 'widgets/site_button.dart';

void main() {
  usePathUrlStrategy(); // clean /gallery URLs like the Next.js site
  runApp(const NobleEngineeringApp());
}

/// Root app — equivalent of src/app/layout.tsx + routing for / and /gallery.
class NobleEngineeringApp extends StatelessWidget {
  const NobleEngineeringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:
          'Noble Engineering – Heavy Fabrication & Engineering Solutions | Pune, India',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return _noTransition(const _HomeRoute(), settings);
          case '/gallery':
            return _noTransition(const GalleryPage(), settings);
          default:
            return _noTransition(const NotFoundPage(), settings);
        }
      },
    );
  }
}

Route<void> _noTransition(Widget child, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings, // keep the route name so the browser URL/history updates
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  );
}

class _HomeRoute extends StatelessWidget {
  const _HomeRoute();

  @override
  Widget build(BuildContext context) {
    return HomePage(
      onOpenGallery: () => Navigator.of(context).pushNamed('/gallery'),
    );
  }
}

/// Port of not-found.tsx — simple 404 page.
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '404',
              style: AppText.display(
                size: 60,
                color: AppColors.foreground,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: AppText.body(
                size: 18,
                color: AppColors.mutedForeground,
              ),
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Back to Home',
              onPressed: () =>
                  Navigator.of(context).pushNamedAndRemoveUntil(
                '/',
                (route) => false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
