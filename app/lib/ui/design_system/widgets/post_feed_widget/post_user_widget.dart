import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants/spaces.dart';
import '../../theme/theme.dart';

class PostUserWidget extends StatelessWidget {
  const PostUserWidget({super.key, this.username = 'F', required this.updatedAt, this.onShared});

  final String username;
  final DateTime updatedAt;
  final void Function()? onShared;

  String _getTimeElapsed() {
    final duration = DateTime.now().difference(updatedAt);
    final seconds = duration.inSeconds;

    return switch (seconds) {
      < 60 => '$seconds ${_pluralize("segundo", seconds)} atrás',
      < 3600 => '${seconds ~/ 60} ${_pluralize("minuto", seconds ~/ 60)} atrás',
      < 86400 => '${seconds ~/ 3600} ${_pluralize("hora", seconds ~/ 3600)} atrás',
      < 2592000 => '${seconds ~/ 86400} ${_pluralize("dia", seconds ~/ 86400)} atrás',
      < 31536000 => '${seconds ~/ 2592000} ${_pluralize("mês", seconds ~/ 2592000)} atrás',
      _ => '${seconds ~/ 31536000} ${_pluralize("ano", seconds ~/ 31536000)} atrás',
    };
  }

  String _pluralize(String word, int value) {
    if (value == 1) return word;
    return word == 'mês' ? 'meses' : '${word}s';
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.text;

    return Row(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: Spaces.xxl + 4, height: Spaces.xxl + 4),
          child: CircleAvatar(child: Text(username.isNotEmpty ? username[0].toUpperCase() : '?', style: textTheme.bodyL16Bold)),
        ),
        const SizedBox(width: Spaces.m - 2),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Spaces.xxxxl * 3.5),
          child: Text(username, overflow: TextOverflow.ellipsis, style: textTheme.bodyL16Bold.copyWith(color: theme.colors.whiteColor)),
        ),
        const Spacer(),
        Row(
          spacing: Spaces.s,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: Spaces.xxl * 4),
              child: Text(
                _getTimeElapsed(),
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyL16Bold.copyWith(fontWeight: FontWeight.w400, color: theme.colors.greyThree.withValues(alpha: 0.75)),
              ),
            ),
            InkWell(onTap: onShared, child: Icon(Iconsax.send_2, color: theme.colors.greyThree.withValues(alpha: 0.75))),
          ],
        ),
      ],
    );
  }
}
