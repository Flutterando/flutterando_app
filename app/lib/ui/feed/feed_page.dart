import 'package:flutter/material.dart';

import '../design_system/constants/spaces.dart';
import '../design_system/widgets/link_post_widget.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          spacing: Spaces.m,
          children: [
            Text('Tela do feed'),
            LinkPostWidget(
              postDescription:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget consectetur sagittis, nisl nunc egestas nunc, eget lacinia nunc nisl eget nunc.',
              imageUrl:
                  'https://media.licdn.com/dms/image/v2/D4E22AQG23nwGm5GN9A/feedshare-shrink_2048_1536/B4EZWzWwX4HgAs-/0/1742470843949?e=1747267200&v=beta&t=FnsBSTJQ6zTZn9aSksEC8zFBpH-GBO8yV_NjI0LXhe8',
            ),
          ],
        ),
      ),
    );
  }
}
