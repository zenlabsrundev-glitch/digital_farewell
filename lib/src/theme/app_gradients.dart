import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppGradients {
  static const primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.purple,
      AppColors.pink,
      AppColors.blue,
    ],
    stops: [0.0, 0.45, 1.0],
  );

  static const darkBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF070819),
      Color(0xFF15123A),
      Color(0xFF0A1D2A),
    ],
    stops: [0.0, 0.55, 1.0],
  );

  static const lightBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF5E9FF),
      Color(0xFFEAF6FF),
      Color(0xFFFFECF8),
    ],
    stops: [0.0, 0.55, 1.0],
  );

  static const glow = RadialGradient(
    center: Alignment(-0.2, -0.5),
    radius: 1.2,
    colors: [
      Color(0x55B79CFF),
      Color(0x22FF4FD8),
      Color(0x00000000),
    ],
    stops: [0.0, 0.35, 1.0],
  );
}

