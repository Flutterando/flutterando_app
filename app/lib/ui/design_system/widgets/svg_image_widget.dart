import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum SvgImage {
  logoDefault('assets/images/logo.svg'),
  logoWhite('assets/images/logo_white.svg'),
  logoLarge('assets/images/logo_large.svg'),
  logoIconOnly('assets/images/logo_icon.svg'),;

  final String path;
  const SvgImage(this.path);

  SvgPicture image({
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
    );
  }
}