import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostCachedImage extends StatelessWidget {
  final String imageUrl;
  final String? name;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final String? cacheKey;
  final bool hasSubtitle;
  const PostCachedImage({
    super.key,
    required this.imageUrl,
    this.name,
    this.width,
    this.height,
    this.fit,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.cacheKey,
    this.hasSubtitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRadius ?? 0),
        topRight: Radius.circular(borderRadius ?? 0),
        bottomLeft: hasSubtitle ? Radius.circular(borderRadius ?? 0) : Radius.zero,
        bottomRight: hasSubtitle ? Radius.circular(borderRadius ?? 0) : Radius.zero,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width ?? 330,
        height: height ?? 330,
        fit: fit ?? BoxFit.cover,
        cacheKey: cacheKey,
        placeholder: (context, url) => const CircularProgressIndicator(),
        placeholderFadeInDuration: const Duration(milliseconds: 100),
        errorWidget:
            (context, url, error) =>
                Image.asset('assets/images/cached_error_image.png', width: width ?? 330, height: height ?? 330, fit: fit ?? BoxFit.cover),
      ),
    );
  }
}
