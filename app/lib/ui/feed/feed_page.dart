import 'package:flutter/material.dart';

import '../design_system/constants/spaces.dart';
import '../design_system/theme/theme.dart';
import '../design_system/widgets/appbar_widget.dart';
import '../design_system/widgets/post_feed_widget/post_feed_widget.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        onCreatePost: () {},
        onNotification: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: Spaces.xxxxl),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          edgeOffset: 10,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Spaces.l),
                      child: PostFeedWidget(
                        onShared: () {},
                        timeOfPost: 30000,
                        username: 'Jacob',
                        content:
                            'Tá pensando em criar conteúdo, mas não sabe por onde começar? Essa é a oportunidade perfeita! Vamos falar sobre produção de conteúdo do zero, equipamentos, plataformas e estratégias para crescer rápido.',
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: Spaces.xxl),
                      width: double.infinity,
                      height: 2,
                      color: context.colors.greyOne,
                    )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Spaces.l),
                      child: PostFeedWidget(
                        onShared: () {},
                        timeOfPost: 30000,
                        username: 'Jão',
                        content:
                        'Tá pensando em criar conteúdo, mas não sabe por onde começar? Essa é a oportunidade perfeita! Vamos falar sobre produção de conteúdo do zero, equipamentos, plataformas e estratégias para crescer rápido.',
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: Spaces.xxl),
                      width: double.infinity,
                      height: 2,
                      color: context.colors.greyOne,
                    )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Spaces.l),
                      child: PostFeedWidget(
                        onShared: () {},
                        timeOfPost: 30000,
                        username: 'wellgenio',
                        content:
                        'Tá pensando em criar conteúdo, mas não sabe por onde começar? Essa é a oportunidade perfeita! Vamos falar sobre produção de conteúdo do zero, equipamentos, plataformas e estratégias para crescer rápido.',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
