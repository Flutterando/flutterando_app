import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../theme/theme.dart';

class PostUserWidget extends StatelessWidget {
  const PostUserWidget({super.key, this.username, this.timeOfPost = 0});
  final String? username;
  final int timeOfPost;

  String getTimeElapsed() {
    if (timeOfPost < 60) {
      return '$timeOfPost segundos atrás';
    } else if (timeOfPost < 3600) {
      final minutes = timeOfPost ~/ 60;
      return '$minutes minutos atrás';
    } else if (timeOfPost < 86400) {
      final hours = timeOfPost ~/ 3600;
      return '$hours horas atrás';
    } else if (timeOfPost < 2592000) {
      final days = timeOfPost ~/ 86400;
      return '$days dias atrás';
    } else if (timeOfPost < 31536000) {
      final months = timeOfPost ~/ 2592000;
      return '$months meses atrás';
    } else {
      final years = timeOfPost ~/ 31536000;
      return '$years anos atrás';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 36, height: 36),
            child: CircleAvatar(
              child: Text(username ?? 'F', style: context.text.bodyL16Bold),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            username ?? 'Profile name',
            style: TextStyle(
              color: context.theme.colors.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                getTimeElapsed(),
                style: TextStyle(
                  color: context.theme.colors.greyTwo,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Icon(Iconsax.send_2, color: context.theme.colors.greyTwo),
            ],
            spacing: 10,
          ),
        ],
      ),
    );
  }
}
