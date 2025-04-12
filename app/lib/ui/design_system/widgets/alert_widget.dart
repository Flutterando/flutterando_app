import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/spaces.dart';
import '../theme/theme.dart';

enum AlertType { success, warning, error }

class AlertWidget {
  static void success(BuildContext context, {required String message}) =>
      _show(context, message: message, type: AlertType.success);

  static void warning(BuildContext context, {required String message}) =>
      _show(context, message: message, type: AlertType.warning);

  static void error(BuildContext context, {required String message}) =>
      _show(context, message: message, type: AlertType.error);

  static void _show(
    BuildContext context, {
    required String message,
    required AlertType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.clearSnackBars();

    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      content: _AlertContent(message: message, type: type, duration: duration),
    );

    scaffoldMessenger.showSnackBar(snackBar);
  }
}

class _AlertContent extends StatefulWidget {
  final String message;
  final AlertType type;
  final Duration duration;

  const _AlertContent({
    required this.message,
    required this.type,
    required this.duration,
  });

  @override
  State<_AlertContent> createState() => _AlertContentState();
}

class _AlertContentState extends State<_AlertContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  Color get _color {
    switch (widget.type) {
      case AlertType.success:
        return context.colors.successLightColor;
      case AlertType.warning:
        return context.colors.alert;
      case AlertType.error:
        return context.colors.errorLightColor;
    }
  }

  IconData get _icon {
    switch (widget.type) {
      case AlertType.success:
        return Iconsax.tick_square;
      case AlertType.warning:
        return Iconsax.warning_2;
      case AlertType.error:
        return Icons.error_outline;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration + const Duration(milliseconds: 300),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Spaces.l),
          topRight: Radius.circular(Spaces.l),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.all(Spaces.l),
            child: Row(
              children: [
                Icon(_icon, color: _color),
                const SizedBox(width: Spaces.m),
                Expanded(
                  child: Text(
                    widget.message,
                    style: context.text.bodyM14Bold.copyWith(
                      color: context.colors.textPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
              child: AnimatedBuilder(
                animation: _controller,
                builder:
                    (context, child) => LinearProgressIndicator(
                      value: _controller.value,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(_color),
                      minHeight: 4,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
