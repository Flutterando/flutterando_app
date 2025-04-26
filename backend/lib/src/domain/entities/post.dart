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

class DateTimeParse extends ParamParse<DateTime?, String> {
  const DateTimeParse();

  @override
  String toJson(DateTime? param) {
    return param?.toIso8601String() ?? '';
  }

  @override
  DateTime? fromJson(String? json) {
    return DateTime.tryParse(json ?? '');
  }
}
