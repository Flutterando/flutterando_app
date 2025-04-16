import '../../domain/entities/post_entity.dart';
import 'user_adapter.dart';

class PostAdapter {
  static Post fromJson(Map<String, dynamic> body) {
    return Post(
      id: body['id'],
      description: body['description'],
      image: body['image'],
      imageSubtitle: body['imageSubtitle'],
      link: body['link'],
      updateAt: DateTime.tryParse(body['updatedAt']) ?? DateTime.now(),
      author: LoggedUserAdapter.fromJson(body['author']),
    );
  }
}
