import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/spaces.dart';
import '../theme/theme.dart';

class SnackBarWidget {
  static void success(BuildContext context, String message) {
    _show(
      context,
      message: message,
      backgroundColor: context.colors.successLightColor,
      icon: Iconsax.tick_square,
      iconColor: context.colors.textSupport,
      textColor: context.colors.textSupport,
    );
  }

  static void warning(BuildContext context, String message) {
    _show(
      context,
      message: message,
      backgroundColor: context.colors.alert,
      icon: Iconsax.danger,
      iconColor: context.colors.textSupport,
      textColor: context.colors.textSupport,
    );
  }

  static void error(BuildContext context, String message) {
    _show(
      context,
      message: message,
      backgroundColor: context.colors.errorLightColor,
      icon: Iconsax.danger,
      iconColor: context.colors.textSupport,
      textColor: context.colors.textSupport,
    );
  }

  static void _show(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required IconData icon,
    required Color iconColor,
    required Color textColor,
  }) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: const EdgeInsets.all(Spaces.l),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(Spaces.l),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: Spaces.m,
          children: [
            Icon(icon, color: iconColor, size: Spaces.xl - Spaces.xs),
            Expanded(
              child: Text(
                message,
                style: context.text.bodyM14Bold.copyWith(
                  color: context.colors.textSupport,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
