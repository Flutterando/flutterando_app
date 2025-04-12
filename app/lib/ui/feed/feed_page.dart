import 'package:flutter/material.dart';

import '../design_system/constants/spaces.dart';
import '../design_system/widgets/post_feed_widget.dart';


class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: Spaces.m,
          children: [
            const Text('Tela do feed'),
            PostFeedWidget(
              onShared: () {},
              timeOfPost: 30000,
              username: 'Profile name',
              content:
                  'Tá pensando em criar conteúdo, mas não sabe por onde começar? Essa é a oportunidade perfeita! Vamos falar sobre produção de conteúdo do zero, equipamentos, plataformas e estratégias para crescer rápido.',
            ),
          ],
        ),
      ),
    );
  }
}
