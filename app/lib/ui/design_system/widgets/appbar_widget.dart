import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/spaces.dart';
import '../theme/theme.dart';
import 'svg_image_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final void Function()? onCreatePost;
  final void Function()? onNotification;
  final String username;

  AppBarWidget({
    super.key,
    this.onCreatePost,
    this.onNotification,
    this.username = 'F',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
            vertical: Spaces.xl + 2,
            horizontal: Spaces.l,
          ) +
          const EdgeInsets.only(top: Spaces.xl),
      child: Row(
        children: [
          SvgImage.logoDefault.image(width: 158, height: 32),
          const Spacer(),
          Row(
            spacing: Spaces.l,
            children: [
              if (onCreatePost != null)
                InkWell(
                  child: Icon(
                    Iconsax.add_square,
                    color: context.theme.colors.greyThree,
                  ),
                  onTap: onCreatePost,
                ),
              if (onNotification != null)
                InkWell(
                  child: Icon(
                    Iconsax.notification,
                    color: context.theme.colors.greyThree,
                  ),
                  onTap: onNotification,
                ),
              CircleAvatar(
                radius: Spaces.l + 2,
                child: Text(
                  username,
                  style: context.theme.textStyles.bodyL16Bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(84);
}
