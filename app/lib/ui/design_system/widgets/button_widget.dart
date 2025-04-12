import 'package:flutter/material.dart';

import '../constants/spaces.dart';
import '../theme/theme.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget._({
    required this.onPressed,
    required this.text,
    this.loading = false,
    this.disabled = false,
    this.isOutline = false,
    this.isSecondary = false,
    this.isSimpleText = false,
    this.padding,
  });

  factory ButtonWidget.filledPrimary({
    required VoidCallback onPressed,
    required String text,
    bool loading = false,
    bool disabled = false,
    EdgeInsetsGeometry? padding,
  }) => ButtonWidget._(
    onPressed: onPressed,
    text: text,
    loading: loading,
    disabled: disabled,
    padding: padding,
  );

  factory ButtonWidget.filledSecondary({
    required VoidCallback onPressed,
    required String text,
    bool loading = false,
    bool disabled = false,
    EdgeInsetsGeometry? padding,
  }) => ButtonWidget._(
    onPressed: onPressed,
    text: text,
    loading: loading,
    disabled: disabled,
    isSecondary: true,
    padding: padding,
  );

  factory ButtonWidget.outlinePrimary({
    required VoidCallback onPressed,
    required String text,
    bool loading = false,
    bool disabled = false,
    EdgeInsetsGeometry? padding,
  }) => ButtonWidget._(
    onPressed: onPressed,
    text: text,
    loading: loading,
    disabled: disabled,
    isOutline: true,
    padding: padding,
  );

  factory ButtonWidget.outlineSecondary({
    required VoidCallback onPressed,
    required String text,
    bool loading = false,
    bool disabled = false,
    EdgeInsetsGeometry? padding,
  }) => ButtonWidget._(
    onPressed: onPressed,
    text: text,
    loading: loading,
    disabled: disabled,
    isOutline: true,
    isSecondary: true,
    padding: padding,
  );

  factory ButtonWidget.textPrimary({
    required VoidCallback onPressed,
    required String text,
    bool loading = false,
    bool disabled = false,
    EdgeInsetsGeometry? padding,
  }) => ButtonWidget._(
    onPressed: onPressed,
    text: text,
    loading: loading,
    disabled: disabled,
    isSimpleText: true,
    padding: padding,
  );

  factory ButtonWidget.textSecondary({
    required VoidCallback onPressed,
    required String text,
    bool loading = false,
    bool disabled = false,
    EdgeInsetsGeometry? padding,
  }) => ButtonWidget._(
    onPressed: onPressed,
    text: text,
    loading: loading,
    disabled: disabled,
    isSecondary: true,
    isSimpleText: true,
    padding: padding,
  );

  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final bool loading;
  final bool disabled;
  final String text;

  final bool isOutline;
  final bool isSecondary;
  final bool isSimpleText;

  @override
  Widget build(BuildContext context) {
    var bgColor = context.colors.primaryColor;
    var borderColor = context.colors.primaryColor;
    var circleProgressColor = context.colors.whiteColor;
    var fontColor = context.colors.whiteColor;

    if (isSecondary) {
      bgColor = context.colors.greyTwo;
      borderColor = context.colors.greyTwo;
    }

    if (isOutline) {
      bgColor = Colors.transparent;
      circleProgressColor = context.colors.primaryColor;
      fontColor = context.colors.primaryColor;

      if (isSecondary) {
        borderColor = context.colors.greyThree;
        circleProgressColor = context.colors.greyThree;
        fontColor = context.colors.greyThree;
      }
    }

    if (isSimpleText) {
      bgColor = Colors.transparent;
      borderColor = Colors.transparent;
      fontColor = context.colors.primaryColor;

      if (isSecondary) {
        fontColor = context.colors.greyThree;
      }
    }

    if (disabled) {
      borderColor = context.colors.greyTwo;
      bgColor = context.colors.greyTwo;
      fontColor = context.colors.greyThree;

      if (isOutline) {
        bgColor = Colors.transparent;
      }

      if (isSimpleText) {
        borderColor = Colors.transparent;
        bgColor = Colors.transparent;

        if (isSimpleText) {
          fontColor = context.colors.greyThree.withValues(alpha: 0.6);
        }
      }
    }

    return Material(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Spaces.m),
        side: BorderSide(width: Spaces.xxs, color: borderColor),
      ),
      child: InkWell(
        onTap: (disabled || loading) ? null : onPressed,
        splashColor: context.colors.whiteColor.withValues(alpha: 0.1),
        highlightColor: Colors.transparent,
        child: Container(
          padding: padding != null ? padding : const EdgeInsets.all(Spaces.m),
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: Spaces.xxxl),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Spaces.m),
            border: Border.all(width: Spaces.xxs, color: borderColor),
          ),
          child: Center(
            child:
                loading //
                    ? _circleProgress(context, circleProgressColor)
                    : Text(text, style: TextStyle(color: fontColor)),
          ),
        ),
      ),
    );
  }

  Widget _circleProgress(BuildContext context, Color color) => //
      SizedBox(
    width: Spaces.xl,
    height: Spaces.xl,
    child: CircularProgressIndicator(
      color: color,
      strokeWidth: Spaces.xxs,
      backgroundColor: Colors.transparent,
    ),
  );
}
