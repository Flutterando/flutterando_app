import 'package:backend/src/domain/parses/date_time_parse.dart';
import 'package:vaden/vaden.dart';

import 'user.dart';

@DTO()
class Posts {
  final int id;
  final String description;
  final String? link;
  final String? image;
  final String? imageSubtitle;
  final User author;
  @UseParse(DateTimeParse)
  final DateTime createdAt;
  @UseParse(DateTimeParse)
  final DateTime updatedAt;
  Posts({
    required this.id,
    required this.description,
    this.link,
    this.image,
    this.imageSubtitle,
    required this.author,
    required this.createdAt,
    required this.updatedAt,
  });
}
