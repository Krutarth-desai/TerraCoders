import 'package:flutter/material.dart';

/// GreenDrop brand palette — lifted from the original web prototype's
/// CSS custom properties so the Flutter app keeps the same identity.
class GdColors {
  static const forest = Color(0xFF075A43);
  static const forestDark = Color(0xFF063C2F);
  static const mint = Color(0xFFE5F5E8);
  static const lime = Color(0xFFD8F676);
  static const sand = Color(0xFFF7F8F4);
  static const ink = Color(0xFF15332A);
  static const copy = Color(0xFF61746C);
  static const card = Color(0xFFFFFFFF);
  static const line = Color(0x1A07452D);
  static const orange = Color(0xFFEF8D51);
  static const blue = Color(0xFF9DD5F3);

  // Dark-mode variants.
  static const darkBg = Color(0xFF0C1F19);
  static const darkCard = Color(0xFF14332A);
  static const darkLine = Color(0x33D8F676);
  static const darkInk = Color(0xFFEAF3EC);
  static const darkCopy = Color(0xFFA9BDB3);
}

class GdTheme {
  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: GdColors.sand,
      fontFamily: 'Manrope',
      colorScheme: ColorScheme.fromSeed(
        seedColor: GdColors.forest,
        brightness: Brightness.light,
        primary: GdColors.forest,
        secondary: GdColors.lime,
        surface: GdColors.card,
      ),
    );
    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: GdColors.ink,
        displayColor: GdColors.ink,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: GdColors.sand,
        foregroundColor: GdColors.ink,
        elevation: 0,
      ),
      cardTheme: const CardThemeData(
        color: GdColors.card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          side: BorderSide(color: GdColors.line),
        ),
      ),
    );
  }

  static ThemeData dark() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: GdColors.darkBg,
      fontFamily: 'Manrope',
      colorScheme: ColorScheme.fromSeed(
        seedColor: GdColors.lime,
        brightness: Brightness.dark,
        primary: GdColors.lime,
        secondary: GdColors.forest,
        surface: GdColors.darkCard,
      ),
    );
    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: GdColors.darkInk,
        displayColor: GdColors.darkInk,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: GdColors.darkBg,
        foregroundColor: GdColors.darkInk,
        elevation: 0,
      ),
      cardTheme: const CardThemeData(
        color: GdColors.darkCard,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          side: BorderSide(color: GdColors.darkLine),
        ),
      ),
    );
  }
}
