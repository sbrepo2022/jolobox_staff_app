import 'package:flutter/cupertino.dart';

class JoloboxTheme {
  static JoloboxSizes sizes = const JoloboxSizes();
  static JoloboxFonts fonts = const JoloboxFonts();
  static JoloboxColors colors = const JoloboxColors();
}

class JoloboxSizes {
  const JoloboxSizes();
  double get baseScale => 0.9;
  double get origTextSize => 16.0 * baseScale;
  double get bigTextSize => 20.0 * baseScale;
  double get smallPadding => 24 * baseScale;
  double get bigPadding => 32 * baseScale;
  double get borderRadius => 4 * baseScale;
  double get surfaceElevation => 4.0 * baseScale;
  double get bottomNavbarHeight => 80.0 * baseScale;
  double get bottomNavbarFontSize => 14.0 * baseScale;

  double themeScale(double size) {
    return size * baseScale;
  }
}

class JoloboxFonts {
  const JoloboxFonts();
  String get mainFontFamily => 'Montserrat';
}

class JoloboxColors {
  const JoloboxColors();
  Color get primary => const Color(0xFF0054E7);
  Color get secondary => const Color(0xFF5796F7);
  Color get onPrimaryInactive => const Color(0xFFA4C7ED);
  Color get buttonSurface => const Color(0xFFE3EFFB);
  Color get inactiveButtonSurface => const Color(0xFFF0F0F0);
  Color get text => const Color(0xFF262626);
  Color get danger => const Color(0xFFDC3545);
  Color get success => const Color(0xFF28A745);
  Color get inactiveButtonText => const Color(0xFF777777);
  Color get textInputBackground => const Color(0xFFF9F9F9);
  Color get background => const Color(0xFFFFFFFF);

  Color get shadowColor => const Color(0x30000000);
}
