import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/spaces.dart';
import '../theme/theme.dart';

class LinkPostWidget extends StatelessWidget {
  final String imageUrl;
  final String postDescription;
  const LinkPostWidget({
    super.key,
    required this.imageUrl,
    required this.postDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Spaces.xxl),
      child: Column(
        children: [
          Container(
            height: 330,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colors.greyTwo),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Spaces.m),
                topRight: Radius.circular(Spaces.m),
              ),
              image: DecorationImage(
                image: CachedNetworkImageProvider(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(Spaces.s),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colors.greyTwo),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(Spaces.m),
                bottomRight: Radius.circular(Spaces.m),
              ),
            ),
            child: Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              postDescription,
              style: Theme.of(
                context,
              ).textStyles.bodyM14Bold.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
