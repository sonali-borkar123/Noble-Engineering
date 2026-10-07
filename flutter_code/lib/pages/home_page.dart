import 'package:flutter/material.dart';
import '../theme.dart';
import '../sections/about_section.dart';
import '../sections/certifications_section.dart';
import '../sections/clients_section.dart';
import '../sections/contact_section.dart';
import '../sections/facilities_section.dart';
import '../sections/hero_section.dart';
import '../sections/laser_cutting_section.dart';
import '../sections/machinery_section.dart';
import '../sections/products_section.dart';
import '../sections/stats_section.dart';
import '../sections/why_choose_us.dart';
import '../widgets/footer.dart';
import '../widgets/navbar.dart';
import '../widgets/whatsapp_button.dart';

/// The single-page home layout — equivalent of src/app/page.tsx. Sections are
/// keyed by id so navbar anchors scroll to them (like #about hrefs).
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.onOpenGallery});

  final VoidCallback onOpenGallery;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _sectionKeys = <String, GlobalKey>{};

  GlobalKey _keyFor(String id) =>
      _sectionKeys.putIfAbsent(id, () => GlobalKey());

  void _scrollTo(String id) {
    if (id == 'home') {
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut);
      return;
    }
    final ctx = _sectionKeys[id]?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _section(String id, Widget child) =>
      KeyedSubtree(key: _keyFor(id), child: child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _section('home', HeroSection(onNavigate: _scrollTo)),
                const StatsSection(),
                _section('about', const AboutSection()),
                const WhyChooseUs(),
                _section('machinery', const MachinerySection()),
                _section(
                  'products',
                  ProductsSection(onOpenGallery: widget.onOpenGallery),
                ),
                _section(
                  'laser-cutting',
                  LaserCuttingSection(
                      onContact: () => _scrollTo('contact')),
                ),
                _section(
                  'facilities',
                  FacilitiesSection(
                      onLaserTap: () => _scrollTo('laser-cutting')),
                ),
                _section('clients', const ClientsSection()),
                const CertificationsSection(),
                _section('contact', const ContactSection()),
                const SiteFooter(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(
              scrollController: _scrollController,
              onNavigate: _scrollTo,
            ),
          ),
          const Positioned(
            bottom: 24,
            right: 24,
            child: WhatsAppButton(),
          ),
        ],
      ),
    );
  }
}

