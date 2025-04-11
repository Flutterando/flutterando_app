import 'package:flutter/material.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle displayL64Bold;
  final TextStyle displayM48Bold;
  final TextStyle displayS32Bold;

  final TextStyle headlineL40Bold;
  final TextStyle headlineM36Bold;
  final TextStyle headlineS32Bold;

  final TextStyle titleL32Bold;
  final TextStyle titleM24Bold;
  final TextStyle titleS20Bold;

  final TextStyle bodyXL18Bold;
  final TextStyle bodyL16Bold;
  final TextStyle bodyM14Bold;
  final TextStyle bodyS12Bold;

  final TextStyle labelL16Bold;
  final TextStyle labelM12Bold;
  final TextStyle labelS8Bold;

  const AppTextStyles({
    this.displayL64Bold = const TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.displayM48Bold = const TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.displayS32Bold = const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.headlineL40Bold = const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: _defaultColor,
    ),
    this.headlineM36Bold = const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.headlineS32Bold = const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.titleL32Bold = const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.titleM24Bold = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.titleS20Bold = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.bodyXL18Bold = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.bodyL16Bold = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.bodyM14Bold = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.bodyS12Bold = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.labelL16Bold = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.labelM12Bold = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
    this.labelS8Bold = const TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.w700,
      color: _defaultColor,
    ),
  });

  static const _defaultColor = Color(0xffABABAB);

  @override
  AppTextStyles copyWith({
    TextStyle? displayL64Bold,
    TextStyle? displayM48Bold,
    TextStyle? displayS32Bold,
    TextStyle? headlineL40Bold,
    TextStyle? headlineM36Bold,
    TextStyle? headlineS32Bold,
    TextStyle? titleL32Bold,
    TextStyle? titleM24Bold,
    TextStyle? titleS20Bold,
    TextStyle? bodyXL18Bold,
    TextStyle? bodyL16Bold,
    TextStyle? bodyM14Bold,
    TextStyle? bodyS12Bold,
    TextStyle? labelL16Bold,
    TextStyle? labelM12Bold,
    TextStyle? labelS8Bold,
  }) {
    return AppTextStyles(
      displayL64Bold: displayL64Bold ?? this.displayL64Bold,
      displayM48Bold: displayM48Bold ?? this.displayM48Bold,
      displayS32Bold: displayS32Bold ?? this.displayS32Bold,
      headlineL40Bold: headlineL40Bold ?? this.headlineL40Bold,
      headlineM36Bold: headlineM36Bold ?? this.headlineM36Bold,
      headlineS32Bold: headlineS32Bold ?? this.headlineS32Bold,
      titleL32Bold: titleL32Bold ?? this.titleL32Bold,
      titleM24Bold: titleM24Bold ?? this.titleM24Bold,
      titleS20Bold: titleS20Bold ?? this.titleS20Bold,
      bodyXL18Bold: bodyXL18Bold ?? this.bodyXL18Bold,
      bodyL16Bold: bodyL16Bold ?? this.bodyL16Bold,
      bodyM14Bold: bodyM14Bold ?? this.bodyM14Bold,
      bodyS12Bold: bodyS12Bold ?? this.bodyS12Bold,
      labelL16Bold: labelL16Bold ?? this.labelL16Bold,
      labelM12Bold: labelM12Bold ?? this.labelM12Bold,
      labelS8Bold: labelS8Bold ?? this.labelS8Bold,
    );
  }

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) {
      return this;
    }

    return AppTextStyles(
      displayL64Bold: TextStyle.lerp(displayL64Bold, other.displayL64Bold, t)!,
      displayM48Bold: TextStyle.lerp(displayM48Bold, other.displayM48Bold, t)!,
      displayS32Bold: TextStyle.lerp(displayS32Bold, other.displayS32Bold, t)!,
      headlineL40Bold:
          TextStyle.lerp(headlineL40Bold, other.headlineL40Bold, t)!,
      headlineM36Bold:
          TextStyle.lerp(headlineM36Bold, other.headlineM36Bold, t)!,
      headlineS32Bold:
          TextStyle.lerp(headlineS32Bold, other.headlineS32Bold, t)!,
      titleL32Bold: TextStyle.lerp(titleL32Bold, other.titleL32Bold, t)!,
      titleM24Bold: TextStyle.lerp(titleM24Bold, other.titleM24Bold, t)!,
      titleS20Bold: TextStyle.lerp(titleS20Bold, other.titleS20Bold, t)!,
      bodyXL18Bold: TextStyle.lerp(bodyXL18Bold, other.bodyXL18Bold, t)!,
      bodyL16Bold: TextStyle.lerp(bodyL16Bold, other.bodyL16Bold, t)!,
      bodyM14Bold: TextStyle.lerp(bodyM14Bold, other.bodyM14Bold, t)!,
      bodyS12Bold: TextStyle.lerp(bodyS12Bold, other.bodyS12Bold, t)!,
      labelL16Bold: TextStyle.lerp(labelL16Bold, other.labelL16Bold, t)!,
      labelM12Bold: TextStyle.lerp(labelM12Bold, other.labelM12Bold, t)!,
      labelS8Bold: TextStyle.lerp(labelS8Bold, other.labelS8Bold, t)!,
    );
  }
}
