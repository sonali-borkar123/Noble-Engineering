# Noble Engineering — Flutter clone

A Flutter (Dart) port of the Noble Engineering marketing website in this repo —
the same single-page site plus `/gallery` page, matching the Next.js version
section-for-section (hero carousel, stats counters, machinery carousel, laser
cutting feature, clients, certifications, contact, WhatsApp button, lightbox).

## Run

```bash
cd flutter_code
flutter pub get

# Web
flutter run -d chrome        # dev
flutter build web --release  # production build -> build/web/

# Android / iOS
flutter run                  # on a connected device/emulator
```

When hosting `build/web`, configure SPA fallback (rewrite all paths to
`index.html`) so `/gallery` loads directly — same as the Next.js site.

## Layout

- `lib/main.dart` — app + routes (`/`, `/gallery`)
- `lib/theme.dart` — colors (Tailwind palette), Oswald/Inter text styles,
  breakpoints, `SectionHeader`
- `lib/pages/` — `home_page.dart`, `gallery_page.dart` (grid + lightbox)
- `lib/sections/` — one widget per site section, same order as the React page
- `lib/widgets/` — navbar, footer, buttons, `RevealOnScroll`, logo, WhatsApp FAB
- `assets/`, `fonts/` — same images and fonts as the Next.js public folder
