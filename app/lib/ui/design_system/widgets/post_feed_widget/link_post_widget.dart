import 'package:flutter/material.dart';

import '../../constants/spaces.dart';
import '../../theme/theme.dart';
import 'post_cached_image_widget.dart';

class LinkPostWidget extends StatelessWidget {
  final String imageUrl;
  final String postDescription;
  const LinkPostWidget({super.key, required this.imageUrl, required this.postDescription});

  @override
  Widget build(BuildContext context) {
    final hasSubtitle = postDescription.isEmpty;
    return Column(
      children: [
        Container(
          height: 330,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colors.greyTwo),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(Spaces.m),
              topRight: const Radius.circular(Spaces.m),
              bottomLeft: Radius.circular(hasSubtitle ? Spaces.m : 0),
              bottomRight: Radius.circular(hasSubtitle ? Spaces.m : 0),
            ),
            // image: DecorationImage(image: CachedNetworkImageProvider(imageUrl), fit: BoxFit.cover),
          ),
          child: PostCachedImage(imageUrl: imageUrl, borderRadius: Spaces.m, hasSubtitle: hasSubtitle),
        ),
        if (!hasSubtitle)
          Container(
            padding: const EdgeInsets.all(Spaces.s),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colors.greyTwo),
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(Spaces.m), bottomRight: Radius.circular(Spaces.m)),
            ),
            child: Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              postDescription,
              style: Theme.of(context).textStyles.bodyM14Bold.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
      ],
    );
  }
}
