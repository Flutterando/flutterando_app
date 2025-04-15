import 'package:vaden/vaden.dart';

import '../entities/post.dart';

@DTO()
class PostsVO {
  final int page;
  final bool hasMore;
  final List<Posts> posts;
  PostsVO({
    required this.page,
    required this.hasMore,
    required this.posts,
  });
}
