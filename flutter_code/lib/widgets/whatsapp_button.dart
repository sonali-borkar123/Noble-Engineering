import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';

const _whatsappUrl =
    'https://api.whatsapp.com/send?phone=919766314010'
    '&text=Hello%20Noble%20Engineering%2C%20I%20would%20like%20to%20inquire%20about%20your%20services.';

/// Fixed bottom-right WhatsApp chat button — port of WhatsAppButton.tsx.
class WhatsAppButton extends StatefulWidget {
  const WhatsAppButton({super.key});

  @override
  State<WhatsAppButton> createState() => _WhatsAppButtonState();
}

class _WhatsAppButtonState extends State<WhatsAppButton> {
  bool _hover = false;

  Future<void> _open() async {
    await launchUrl(Uri.parse(_whatsappUrl),
        mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: _open,
        child: AnimatedScale(
          scale: _hover ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hover ? AppColors.whatsappHover : AppColors.whatsapp,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.chat_bubble_outline,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
