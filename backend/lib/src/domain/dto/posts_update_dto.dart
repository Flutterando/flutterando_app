import 'package:vaden/vaden.dart';

@DTO()
class UpdatePostsDTO {
  final int id;
  final String? title;
  final String? subtitle;
  final String? description;
  final String? link;
  final String? image;
  UpdatePostsDTO({
    required this.id,
    this.title,
    this.subtitle,
    this.description,
    this.link,
    this.image,
  });

  Map<String, dynamic> toMapQuery() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'link': link,
      'image': image,
    };
  }
}
