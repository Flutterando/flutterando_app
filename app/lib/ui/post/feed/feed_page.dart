import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../../app_widget.dart';
import '../../../config/dependencies.dart';
import '../../design_system/constants/spaces.dart';
import '../../design_system/theme/theme.dart';
import '../../design_system/widgets/appbar_widget.dart';
import '../../design_system/widgets/post_feed_widget/post_feed_skeleton_widget.dart';
import '../../design_system/widgets/post_feed_widget/post_feed_widget.dart';
import 'feed_viewmodel.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final viewmodel = injector.get<FeedViewmodel>();
  final isLoading = ValueNotifier(true);

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1)).then((_) {
      isLoading.value = false;
    });

    viewmodel.logoutCommand.addListener(listenerLogout);
  }

  listenerLogout() {
    if (viewmodel.logoutCommand.isSuccess ||
        viewmodel.logoutCommand.isFailure) {
      Routefly.navigate(routePaths.auth.login);
    }
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
  }

  @override
  void dispose() {
    viewmodel.logoutCommand.removeListener(listenerLogout);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        onCreatePost: () {
          Routefly.push(routePaths.post.newPost);
        },
        onNotification: () {},
        onLogout: viewmodel.logoutCommand.execute,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: Spaces.xxxxl),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          edgeOffset: 10,
          child: ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, isLoading, _) {
              if (isLoading) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Spaces.l,
                            ),
                            child: PostFeedSkeletonWidget(),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: Spaces.xxl,
                            ),
                            width: double.infinity,
                            height: 2,
                            color: context.colors.greyOne,
                          ),
                        ],
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Spaces.l,
                            ),
                            child: PostFeedSkeletonWidget(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Spaces.l,
                          ),
                          child: PostFeedWidget(
                            onShared: () {},
                            timeOfPost: 30000,
                            username: 'Jacob',
                            content:
                                'Tá pensando em criar conteúdo, mas não sabe por onde começar? Essa é a oportunidade perfeita! Vamos falar sobre produção de conteúdo do zero, equipamentos, plataformas e estratégias para crescer rápido.',
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: Spaces.xxl,
                          ),
                          width: double.infinity,
                          height: 2,
                          color: context.colors.greyOne,
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Spaces.l,
                          ),
                          child: PostFeedWidget(
                            onShared: () {},
                            timeOfPost: 30000,
                            username: 'Jão',
                            content:
                                'Tá pensando em criar conteúdo, mas não sabe por onde começar? Essa é a oportunidade perfeita! Vamos falar sobre produção de conteúdo do zero, equipamentos, plataformas e estratégias para crescer rápido.',
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: Spaces.xxl,
                          ),
                          width: double.infinity,
                          height: 2,
                          color: context.colors.greyOne,
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Spaces.l,
                          ),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
