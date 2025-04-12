import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';
import '../theme/theme.dart';

class InputWidget extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? helperText;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final bool enabled;
  final IconData? helperIcon;
  final IconData? prefixIcon;
  final String? initialValue;

  const InputWidget({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.enabled = true,
    this.helperIcon,
    this.prefixIcon,
    this.initialValue,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool _obscureText = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 12),
            child: Text(
              widget.label!,
              style: appTextStyles.labelL16Bold.copyWith(
                color: appColors.greyThree,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        TextFormField(
          initialValue: widget.initialValue,
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: _obscureText,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          cursorColor: appColors.focusColor,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
            if (widget.validator != null) {
              setState(() {
                _errorText = widget.validator!(value);
              });
            }
          },
          validator: widget.validator,
          style: context.text.bodyM14Bold.copyWith(
            fontWeight: FontWeight.w400,
            color: context.colors.textPrimaryColor,
          ),
          decoration: _InputDecoration.build(
            appColors: appColors,
            appTextStyles: appTextStyles,
            prefixIcon: widget.prefixIcon,
            errorText: _errorText,
            helperText: widget.helperText,
            helperIcon: widget.helperIcon,
            hintText: widget.hintText,
            obscureText: widget.obscureText,
            onToggleObscureText: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            isObscureTextEnabled: _obscureText,
          ),
        ),
      ],
    );
  }
}

class _InputDecoration {
  static InputDecoration build({
    required AppColors appColors,
    required AppTextStyles appTextStyles,
    IconData? prefixIcon,
    String? errorText,
    String? helperText,
    IconData? helperIcon,
    String? hintText,
    required bool obscureText,
    required VoidCallback onToggleObscureText,
    required bool isObscureTextEnabled,
  }) {
    return InputDecoration(
      prefixIcon:
          prefixIcon != null
              ? Icon(
                prefixIcon,
                size: 20,
                color:
                    errorText == null
                        ? appColors.textSupportColor
                        : appColors.errorColor,
              )
              : null,
      error:
          errorText != null
              ? _AuxiliarText(
                text: errorText,
                icon: Iconsax.info_circle,
                color: appColors.errorColor,
              )
              : null,
      helper:
          helperText != null
              ? _AuxiliarText(
                text: helperText,
                icon: helperIcon,
                color: appColors.greyThree,
              )
              : null,
      hintText: hintText,
      hintStyle: TextStyle(color: appColors.textSupportColor, fontSize: 16),
      filled: true,
      fillColor: appColors.blackColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: appColors.textSupportColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: appColors.focusColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: appColors.errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: appColors.errorColor),
      ),
      errorStyle: appTextStyles.labelM12Bold.copyWith(
        color: appColors.errorColor,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: appTextStyles.labelL16Bold.copyWith(
        color: appColors.greyOne,
        fontWeight: FontWeight.w400,
      ),
      suffixIcon:
          obscureText
              ? IconButton(
                icon: Icon(
                  isObscureTextEnabled ? Iconsax.eye_slash : Iconsax.eye,
                  color: appColors.textSupportColor,
                ),
                onPressed: onToggleObscureText,
              )
              : null,
    );
  }
}

class _AuxiliarText extends StatelessWidget {
  const _AuxiliarText({required this.text, this.icon, required this.color});

  final String? text;
  final IconData? icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        spacing: 4,
        children: [
          if (icon != null) Icon(icon, size: 16, color: color),
          Flexible(
            child: Text(
              text!,
              style: appTextStyles.labelM12Bold.copyWith(
                color: color,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
