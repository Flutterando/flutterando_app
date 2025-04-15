import 'package:vaden/vaden.dart';

@DTO()
class UpdatePostsDTO {
  final int id;
  final String? description;
  final String? link;
  final String? image;
  final String? imageSubtitle;
  UpdatePostsDTO({
    required this.id,
    this.description,
    this.link,
    this.image,
    this.imageSubtitle,
  });

  Map<String, dynamic> toMapQuery() {
    return {
      'id': id,
      'description': description,
      'link': link,
      'image': image,
      'image_subtitle': imageSubtitle
    };
  }
}
