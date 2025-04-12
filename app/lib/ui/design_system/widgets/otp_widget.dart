import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../constants/spaces.dart';
import '../theme/theme.dart';

class OtpFieldController {
  void Function()? _clear;

  void clear() {
    _clear?.call();
  }

  Future<void> _bind(void Function() clearCallback) async {
    _clear = clearCallback;
  }
}

class OtpWidget extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String> onCompleted;
  final bool hasError;
  final String? errorMessage;
  final OtpFieldController? controller;

  const OtpWidget({
    super.key,
    required this.length,
    required this.onCompleted,
    this.onChanged,
    this.hasError = false,
    this.errorMessage,
    this.controller,
  });

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
    _controllers = List.generate(widget.length, (_) => TextEditingController());

    widget.controller?._bind(_clearAll);
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onInputChanged(int index, String value) {
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    final code = _controllers.map((e) => e.text).join();
    widget.onChanged?.call(code);

    if (code.length == widget.length && !_controllers.any((c) => c.text.isEmpty)) {
      widget.onCompleted(code);
    }
  }

  void _clearAll() {
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes.first.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.hasError ? Colors.redAccent : Colors.grey.shade800;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.length, (i) {
            final isFocused = _focusNodes[i].hasFocus;
            final isFilled = _controllers[i].text.isNotEmpty;

            Color color;
            if (widget.hasError) {
              color = Colors.redAccent;
            } else if (isFocused) {
              color = Colors.blueAccent;
            } else {
              color = borderColor;
            }

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: Spaces.xxs + Spaces.xs),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: color, width: Spaces.xxs),
                borderRadius: BorderRadius.circular( Spaces.m),
              ),
              alignment: Alignment.center,
              child: TextField(
                controller: _controllers[i],
                focusNode: _focusNodes[i],
                onChanged: (value) => _onInputChanged(i, value),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: Spaces.xl -  Spaces.xs,
                  fontWeight: FontWeight.bold,
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                cursorColor: Colors.blueAccent,
                decoration: const InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: Spaces.m),
        if (widget.hasError && widget.errorMessage != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(Iconsax.info_circle, color: context.colors.errorLightColor, size: Spaces.xl),
              const SizedBox(width: Spaces.m),
              Text(
                widget.errorMessage!,
                style: context.text.bodyM14Bold.copyWith(
                  color: context.colors.errorLightColor,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
