import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/spaces.dart';
import '../theme/theme.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final void Function()? onNotification;
  final String username;

  AppBarWidget({super.key, this.onNotification, this.username = 'F'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Spaces.xl + 2,
        horizontal: Spaces.l,
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/images/logo.svg', width: 158, height: 32),
          const Spacer(),
          Row(
            spacing: Spaces.l,
            children: [
              if (onNotification != null)
                InkWell(
                  child: Icon(
                    Iconsax.add_square,
                    color: context.theme.colors.greyThree,
                  ),
                  onTap: onNotification,
                ),
              Icon(Iconsax.notification, color: context.theme.colors.greyThree),
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
