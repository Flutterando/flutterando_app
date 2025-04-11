import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/spaces.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({
    Key? key,
    void Function()? onNotification,
    Color? backgroundColor,
    String name = 'F',
  }) : super(
         ///This is the number that sets AppBar's height equals to 84px
         toolbarHeight: 55.38,
         key: key,
         title: SvgPicture.asset('assets/images/logo.svg'),
         actions: [
           if (onNotification != null)
             IconButton(
               icon: const Icon(Iconsax.add_square, size: 20),
               onPressed: onNotification,
             ),
           const Icon(Iconsax.notification, size: 20),
           const SizedBox(width: 16),
           CircleAvatar(
             child: Text(name, style: const AppTextStyles().labelL16Bold),
             radius: Spaces.l,
           ),
         ],
         backgroundColor: backgroundColor ?? const AppColors().blackColor,
         centerTitle: false,
         actionsPadding: const EdgeInsets.symmetric(horizontal: 16.0),
         titleSpacing: 16,
       );
}
