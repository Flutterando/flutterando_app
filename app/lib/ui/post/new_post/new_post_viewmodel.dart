import 'package:result_command/result_command.dart';

import '../../../data/repositories/post_repository.dart';

class NewPostViewmodel {
  final PostRepository _postRepository;
  NewPostViewmodel(this._postRepository);

  late final createPostCommand = Command1(_postRepository.createPost);
}
