class PostDto {
  String description;
  String? image;
  String? imageSubtitle;
  String? link;

  PostDto({
    required this.description,
    this.image,
    this.imageSubtitle,
    this.link,
  });

  factory PostDto.fromEmpty() =>
      PostDto(description: '', image: '', imageSubtitle: '', link: '');

  setDescription(String value) => description = value;

  setImage(String value) => image = value;

  setImageSubtitle(String value) => imageSubtitle = value;

  setLink(String value) => link = value;

  Map<String, dynamic> toJson() => {
    'description': description,
    'image': image,
    'imageSubtitle': imageSubtitle,
    'link': link,
  };
}
