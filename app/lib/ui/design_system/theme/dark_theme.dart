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
      surface: colors.backgroundColor,
      onSurface: colors.backgroundColor,
    ),
    textTheme: TextTheme(
      headlineLarge: textStyles.headlineL40Bold.copyWith(
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
  );
}
