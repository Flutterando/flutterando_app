import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_style.dart';

ThemeData get darkTheme {
  const colors = AppColors();
  const textStyles = AppTextStyles();

  return ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: colors.grayStrong,
      onPrimary: colors.grayMedium,
      secondary: colors.red,
      onSecondary: colors.red,
      error: colors.red,
      onError: colors.red,
      surface: const Color(0xff111111),
      onSurface: colors.blackBackground,
    ),
    textTheme: TextTheme(
      headlineLarge: textStyles.headlineM36Bold.copyWith(
        color: const Color(0xffFFFFFF),
      ),
      headlineSmall: textStyles.headlineS32Bold.copyWith(
        color: const Color(0xffFFFFFF),
      ),
      bodyMedium: textStyles.bodyM14Bold.copyWith(
        color: const Color(0xffFFFFFF),
      ),
      bodySmall: textStyles.bodyS12Bold.copyWith(
        color: const Color(0xffFFFFFF),
      ),
      labelLarge: textStyles.labelL16Bold.copyWith(
        color: const Color(0xffFFFFFF),
      ),
      labelMedium: textStyles.labelM12Bold.copyWith(
        color: const Color(0xffFFFFFF),
      ),
      labelSmall: textStyles.labelS8Bold.copyWith(
        color: const Color(0xffFFFFFF),
      ),
      displayLarge: textStyles.displayL64Bold.copyWith(
        color: const Color(0xffFFFFFF),
      ),
    ),
    extensions: const [AppColors(), AppTextStyles()],
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: Colors.blue),
      hintStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xffC7C7C7),
      ),
      suffixIconColor: const Color(0xff939AA5),
      filled: true,
      fillColor: const Color(0xff222222),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xffC7C7C7), width: 2.0),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.blue, size: 16),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(const EdgeInsets.all(18.0)),
        backgroundColor: WidgetStateProperty.all(const Color(0xffC22445)),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        overlayColor: WidgetStateProperty.all(
          Colors.white.withValues(alpha: 0.2),
        ),
      ),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: Color(0xff333333)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(double.infinity, 48)),
        backgroundColor: WidgetStateProperty.all(colors.red),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 16),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
    ),
  );
}
