import 'package:flutter/material.dart';
import '../constants/spaces.dart';
import 'link_post_widget.dart';
import 'post_user_widget.dart';
import 'expandable_text.dart';

class PostFeedWidget extends StatefulWidget {
  // Use o parâmetro content para passar o texto desejado
  const PostFeedWidget({
    super.key,
    this.content =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget consectetur sagittis, nisl nunc egestas nunc, eget lacinia nunc nisl eget nunc. Este texto é um exemplo um pouco mais longo para garantir que a funcionalidade de expandir seja testada corretamente.',
    this.username = 'F',
    this.timeOfPost = 0,
    this.onShared,
    this.imageUrl =
        'https://media.licdn.com/dms/image/v2/D4E22AQG23nwGm5GN9A/feedshare-shrink_2048_1536/B4EZWzWwX4HgAs-/0/1742470843949?e=1747267200&v=beta&t=FnsBSTJQ6zTZn9aSksEC8zFBpH-GBO8yV_NjI0LXhe8',
    this.postDescription = 'Descrição do post',
  });

  final String content;
  final String username;
  final int timeOfPost;
  final void Function()? onShared;
  final String imageUrl;
  final String postDescription;

  @override
  State<PostFeedWidget> createState() => _PostFeedWidgetState();
}

class _PostFeedWidgetState extends State<PostFeedWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostUserWidget(
          onShared: widget.onShared,
          timeOfPost: widget.timeOfPost,
          username: widget.username,
        ),
        const SizedBox(height: Spaces.s - 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spaces.xxxl),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: Spaces.m + 2),
              const Text('>_'),
              const SizedBox(width: Spaces.l + 1),
              Expanded(
                child: Column(
                  spacing: Spaces.s + 3,
                  children: [
                    ExpandableTextFixed3Lines(widget.content),
                    LinkPostWidget(
                      imageUrl: widget.imageUrl,
                      postDescription: widget.postDescription,
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
