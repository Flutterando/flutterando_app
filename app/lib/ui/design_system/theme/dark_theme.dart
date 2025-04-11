import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_style.dart';

ThemeData get darkTheme {
  const colors = AppColors();
  const textStyles = AppTextStyles();

  return ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: colors.primaryColor,
      onPrimary: colors.primaryColor,
      secondary: colors.greyTwo,
      onSecondary: colors.greyTwo,
      error: colors.errorColor,
      onError: colors.errorColor,
      surface: const Color(0xff111111),
      onSurface: colors.backgroundColor,
    ),
    textTheme: TextTheme(
      headlineLarge: textStyles.headlineLarge.copyWith(
        color: const Color(0xffFFFFFF),
      ),
      headlineSmall: textStyles.headlineSmall.copyWith(
        color: const Color(0xffFFFFFF),
      ),
      bodyMedium: textStyles.bodyMedium.copyWith(
        color: const Color(0xffFFFFFF),
      ),
      bodySmall: textStyles.bodySmall.copyWith(color: const Color(0xffFFFFFF)),
      labelLarge: textStyles.labelLarge.copyWith(
        color: const Color(0xffFFFFFF),
      ),
      labelMedium: textStyles.labelMedium.copyWith(
        color: const Color(0xffFFFFFF),
      ),
      labelSmall: textStyles.labelSmall.copyWith(
        color: const Color(0xffFFFFFF),
      ),
      displayLarge: textStyles.displayLarge.copyWith(
        color: const Color(0xffFFFFFF),
      ),
    ),
    extensions: const [AppColors(), AppTextStyles()],
  );
}
