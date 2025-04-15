import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/spaces.dart';
import '../../theme/theme.dart';

class PostFeedSkeletonWidget extends StatelessWidget {
  const PostFeedSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Shimmer.fromColors(
                  baseColor: context.colors.greyOne,
                  highlightColor: context.colors.greyTwo,
                  child: Container(
                    width: Spaces.xxl + 4,
                    height: Spaces.xxl + 4,
                    decoration: BoxDecoration(
                      color: context.colors.greyTwo,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
                const SizedBox(width: Spaces.m - 2),
                Shimmer.fromColors(
                  baseColor: context.colors.greyOne,
                  highlightColor: context.colors.greyTwo,
                  child: Container(
                    width: Spaces.xxl * 2,
                    height: Spaces.xl,
                    decoration: BoxDecoration(
                      color: context.colors.greyTwo,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            Shimmer.fromColors(
              baseColor: context.colors.greyOne,
              highlightColor: context.colors.greyTwo,
              child: Container(
                width: Spaces.xxl * 4,
                height: Spaces.xl,
                decoration: BoxDecoration(
                  color: context.colors.greyTwo,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: Spaces.l, left: Spaces.xxxxl),
          child: Shimmer.fromColors(
            baseColor: context.colors.greyOne,
            highlightColor: context.colors.greyTwo,
            child: Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.4,
              decoration: BoxDecoration(
                color: context.colors.greyOne,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
