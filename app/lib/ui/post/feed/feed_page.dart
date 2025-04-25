import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../../app_widget.dart';
import '../../../config/dependencies.dart';
import '../../design_system/constants/spaces.dart';
import '../../design_system/theme/theme.dart';
import '../../design_system/widgets/alert_widget.dart';
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

    viewmodel.logoutCommand.addListener(listenerLogout);
    viewmodel.getPostsCommand.addListener(listenerGetPost);

    viewmodel.getPostsCommand.execute();
  }

  void listenerGetPost() {
    if (viewmodel.getPostsCommand.isSuccess) {
      isLoading.value = false;
      return;
    }

    if (viewmodel.getPostsCommand.isFailure) {
      AlertWidget.error(context, message: 'Não foi possível carregar o feed');
    }
  }

  void listenerLogout() {
    if (viewmodel.logoutCommand.isSuccess ||
        viewmodel.logoutCommand.isFailure) {
      Routefly.navigate(routePaths.auth.login);
    }
  }

  Future<void> _onRefresh() async => //
      await viewmodel.getPostsCommand.execute();

  @override
  void dispose() {
    viewmodel.logoutCommand.removeListener(listenerLogout);
    viewmodel.getPostsCommand.removeListener(listenerGetPost);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewmodel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBarWidget(
            onCreatePost:
                viewmodel.isCreator
                    ? () => Routefly.push(routePaths.post.newPost)
                    : null,
            // onNotification: () {},
            onLogout: viewmodel.logoutCommand.execute,
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: Spaces.xxxxl),
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              edgeOffset: 10,
              child: ListenableBuilder(
                listenable: Listenable.merge([
                  isLoading,
                  viewmodel,
                  viewmodel.getPostsCommand,
                ]),
                builder: (context, _) {
                  if (isLoading.value) {
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
                    slivers:
                        viewmodel.posts.map((post) {
                          return SliverToBoxAdapter(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Spaces.l,
                                  ),
                                  child: PostFeedWidget(
                                    onShared: () => viewmodel.onShared(post),
                                    post: post,
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
                          );
                        }).toList(),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
