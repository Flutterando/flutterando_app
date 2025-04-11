import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  //
  final Color primaryColor;
  final Color backgroundColor;
  final Color greyOne;
  final Color greyTwo;
  final Color greyThree;
  final Color successColor;
  final Color successLightColor;
  final Color errorColor;
  final Color errorLightColor;
  final Color alert;
  final Color errorSupportColor;
  final Color focusColor;
  final Color disabledColor;
  final Color inputColor;
  final Color whiteColor;
  final Color blackColor;

  final Color textPrimary;
  final Color textSupport;

  const AppColors({
    this.primaryColor = const Color(0xFFC22546),
    this.backgroundColor = const Color(0xFF121212),
    this.greyOne = const Color(0xFF232323),
    this.greyTwo = const Color(0xFF424242),
    this.greyThree = const Color(0xFFABABAB),
    this.successColor = const Color(0xFF00C933),
    this.successLightColor = const Color(0xFF34C759),
    this.errorColor = const Color(0xFFFF0004),
    this.errorLightColor = const Color(0xFFF44549),
    this.alert = const Color(0xFFFFBB00),
    this.errorSupportColor = const Color(0xFFFFE0E1),
    this.focusColor = const Color(0xFF00A0FF),
    this.disabledColor = const Color(0xFFDBDBDB),
    this.inputColor = const Color(0xFFF1F1F1),
    this.whiteColor = const Color(0xFFFFFFFF),
    this.blackColor = const Color(0xFF000000),
    this.textPrimary = const Color(0xFFABABAB),
    this.textSupport = const Color(0xFF424242),
  });

  @override
  AppColors copyWith({
    Color? primaryColor,
    Color? backgroundColor,
    Color? greyOne,
    Color? greyTwo,
    Color? greyThree,
    Color? successColor,
    Color? errorColor,
    Color? alert,
    Color? errorSupportColor,
    Color? focusColor,
    Color? disabledColor,
    Color? inputColor,
    Color? whiteColor,
    Color? blackColor,
    Color? textPrimary,
    Color? textSupport,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      greyOne: greyOne ?? this.greyOne,
      greyTwo: greyTwo ?? this.greyTwo,
      greyThree: greyThree ?? this.greyThree,
      successColor: successColor ?? this.successColor,
      errorColor: errorColor ?? this.errorColor,
      alert: alert ?? this.alert,
      errorSupportColor: errorSupportColor ?? this.errorSupportColor,
      focusColor: focusColor ?? this.focusColor,
      disabledColor: disabledColor ?? this.disabledColor,
      inputColor: inputColor ?? this.inputColor,
      whiteColor: whiteColor ?? this.whiteColor,
      blackColor: blackColor ?? this.blackColor,
      textPrimary: textPrimary ?? this.textPrimary,
      textSupport: textSupport ?? this.textSupport,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      greyOne: Color.lerp(greyOne, other.greyOne, t)!,
      greyTwo: Color.lerp(greyTwo, other.greyTwo, t)!,
      greyThree: Color.lerp(greyThree, other.greyThree, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      alert: Color.lerp(alert, other.alert, t)!,
      errorSupportColor:
          Color.lerp(errorSupportColor, other.errorSupportColor, t)!,
      focusColor: Color.lerp(focusColor, other.focusColor, t)!,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t)!,
      inputColor: Color.lerp(inputColor, other.inputColor, t)!,
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t)!,
      blackColor: Color.lerp(blackColor, other.blackColor, t)!,
      textPrimary:  Color.lerp(primaryColor, other.primaryColor, t)!,
      textSupport:  Color.lerp(textSupport, other.textSupport, t)!,
    );
  }
}
