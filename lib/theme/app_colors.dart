import 'package:flutter/material.dart';

class AppColors {
  static const white = Colors.white;
  static MaterialColor brandColor = MaterialColor(0xFF8154F2, _brandSwatch);

  static const List<int> _brandRgb = [129, 84, 242];

  static final Map<int, Color> _brandSwatch = {
    50: Color.fromRGBO(_brandRgb[0], _brandRgb[1], _brandRgb[2], 0.1),
    100: Color.fromRGBO(_brandRgb[0], _brandRgb[1], _brandRgb[2], 0.2),
    200: Color.fromRGBO(_brandRgb[0], _brandRgb[1], _brandRgb[2], 0.3),
    300: Color.fromRGBO(_brandRgb[0], _brandRgb[1], _brandRgb[2], 0.4),
    400: Color.fromRGBO(_brandRgb[0], _brandRgb[1], _brandRgb[2], 0.5),
    500: Color.fromRGBO(_brandRgb[0], _brandRgb[1], _brandRgb[2], 0.6),
    600: Color.fromRGBO(_brandRgb[0], _brandRgb[1], _brandRgb[2], 0.7),
    700: Color.fromRGBO(_brandRgb[0], _brandRgb[1], _brandRgb[2], 0.8),
    800: Color.fromRGBO(_brandRgb[0], _brandRgb[1], _brandRgb[2], 0.9),
    900: Color.fromRGBO(_brandRgb[0], _brandRgb[1], _brandRgb[2], 1),
  };
}
