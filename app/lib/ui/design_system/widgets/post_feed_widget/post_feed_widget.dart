import 'package:flutter/material.dart';
import '../../../../core/extensions/validator_extension.dart';
import '../../../../domain/entities/post_entity.dart';
import '../../../../domain/validators/post_validator.dart';
import '../../constants/spaces.dart';
import '../../theme/theme.dart';
import 'link_post_widget.dart';
import 'post_user_widget.dart';
import 'expandable_text.dart';

class PostFeedWidget extends StatefulWidget {
  const PostFeedWidget({
    super.key,
    required this.post,
    this.onShared,
  });

  final void Function()? onShared;
  final Post post;

  @override
  State<PostFeedWidget> createState() => _PostFeedWidgetState();
}

class _PostFeedWidgetState extends State<PostFeedWidget> {
  final validator = PostValidator();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostUserWidget(
          onShared: widget.onShared,
          updatedAt: widget.post.updateAt,
          username: widget.post.author.email,
        ),
        const SizedBox(height: Spaces.s - 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spaces.s),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '>_',
                style: context.text.bodyM14Bold.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: Spaces.l),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: Spaces.l,
                  children: [
                    ExpandableTextFixed3Lines(widget.post.description),
                    if (isValidUrl(widget.post.image))
                      LinkPostWidget(
                        imageUrl: widget.post.image,
                        postDescription: widget.post.imageSubtitle,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
