import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/spaces.dart';
import '../theme/theme.dart';

class PostUserWidget extends StatelessWidget {
  const PostUserWidget({
    super.key,
    this.username = 'F',
    this.timeOfPost = 0,
    this.onShared,
  });
  final String username;
  final int timeOfPost;
  final void Function()? onShared;

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
      padding: const EdgeInsets.symmetric(horizontal: Spaces.xxxl),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(
              width: Spaces.xxl + 4,
              height: Spaces.xxl + 4,
            ),
            child: CircleAvatar(
              child: Text(
                username.substring(0, 1).toUpperCase(),
                style: context.text.bodyL16Bold,
              ),
            ),
          ),
          const SizedBox(width: Spaces.m - 2),
          Text(
            username,
            style: context.text.bodyL16Bold.copyWith(
              color: context.theme.colors.whiteColor,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                getTimeElapsed(),
                style: context.text.bodyL16Bold.copyWith(
                  fontWeight: FontWeight.w400,
                  color: context.theme.colors.greyThree,
                ),
              ),
              InkWell(
                onTap: onShared,
                child: Icon(
                  Iconsax.send_2,
                  color: context.theme.colors.greyTwo,
                ),
              ),
            ],
            spacing: Spaces.m - 2,
          ),
        ],
      ),
    );
  }
}
