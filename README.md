# GreenDrop — Flutter rebuild

A native Flutter rewrite of the GreenDrop prototype (donor ↔ NGO donation
matching app for Pune). This is a fresh implementation in Dart/Flutter —
same screens, flow, mock data and green/lime visual identity as the
original WebView prototype, not decompiled or copy-pasted code.

## What's included

- Splash → onboarding → role selection (Donor / NGO) → login/signup → dashboard
- **Donor side:** Home, Donate (category + NGO matching), My impact,
  Nearby NGOs, Pune leaderboard, Community, Profile (incl. dark mode toggle)
- **NGO side:** Dashboard, Donation requests, Post updates, Community, Profile
- Responsive layout: side navigation on wide screens (≥900px), bottom nav
  bar on mobile widths — no `Drawer` needed
- All data is local mock data (`lib/mock_data.dart`) — there's no backend;
  this mirrors the original prototype exactly

## Project structure

```
lib/
  main.dart              # App entry + stage routing (splash/onboarding/auth/dashboard)
  app_state.dart          # Single ChangeNotifier holding all app state
  models.dart              # Data models (NgoMatch, DonationRecord, etc.)
  mock_data.dart           # All mock content, ported from the original app.js
  theme.dart                # Color palette + light/dark ThemeData
  widgets/
    common.dart              # GdCard, GdTopBar, GdPrimaryButton, GdChip, toast helper
    nav.dart                  # Sidebar (desktop) + bottom nav (mobile)
  screens/
    splash_screen.dart
    onboarding_screen.dart
    role_screen.dart
    auth_screen.dart
    dashboard_shell.dart     # Switches between donor/NGO pages
    donor/                     # 7 donor screens
    ngo/                       # 5 NGO screens
```

## Running it

This project was generated without access to the Flutter SDK, so it
has **not** been built or run yet. To get it going:

```bash
flutter create --project-name greendrop .   # only if pubspec/lib get overwritten — skip if not needed
flutter pub get
flutter run
```

If `flutter create .` isn't needed (this repo already has `pubspec.yaml`
and `lib/`), just run:

```bash
flutter pub get
flutter run
```

## Notes / next steps

- No backend: donations, matches, XP, and leaderboard are all in-memory
  mock state (`AppState`), reset on app restart — same as the prototype.
- State is a plain `ChangeNotifier` + `setState` in `main.dart`, so no
  extra state-management package is required.
- Swap `mock_data.dart` for real API calls when you're ready to wire up
  a backend — the screens already read from typed models, so that's a
  contained change.
- Fonts: the original used Google Fonts (DM Sans / Manrope). This project
  references `Manrope` in `theme.dart`; add the `google_fonts` package or
  bundle the font files in `pubspec.yaml` if you want it to render exactly
  (falls back to the system font otherwise).
