import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData dark() {
    final colorScheme = const ColorScheme.dark().copyWith(
      primary: AppColors.purple,
      secondary: AppColors.blue,
      surface: AppColors.surfaceDark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: AppTypography.textThemeDark(),
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(color: AppColors.textDarkPrimary),
      inputDecorationTheme: _inputTheme(
        isDark: true,
        textColor: AppColors.textDarkPrimary,
        hintColor: AppColors.textDarkSecondary,
      ),
    );
  }

  static ThemeData light() {
    final colorScheme = const ColorScheme.light().copyWith(
      primary: AppColors.purple,
      secondary: AppColors.blue,
      surface: AppColors.surfaceLight,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: AppTypography.textThemeLight(),
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(color: AppColors.textLightPrimary),
      inputDecorationTheme: _inputTheme(
        isDark: false,
        textColor: AppColors.textLightPrimary,
        hintColor: AppColors.textLightSecondary,
      ),
    );
  }

  static InputDecorationTheme _inputTheme({
    required bool isDark,
    required Color textColor,
    required Color hintColor,
  }) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide(
        color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.10),
        width: 1.0,
      ),
    );

    return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      border: baseBorder,
      enabledBorder: baseBorder,
      focusedBorder: baseBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.neonCyan, width: 1.4),
      ),
      labelStyle: TextStyle(color: hintColor.withValues(alpha: 0.9)),
      floatingLabelStyle: const TextStyle(color: AppColors.neonCyan),
      hintStyle: TextStyle(color: hintColor.withValues(alpha: 0.85)),
    );
  }
}

