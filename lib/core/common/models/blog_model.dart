class BlogModel {
  bool isEnabled;
  String headerTitle;
  List<BlogItem>? blogItems;

  BlogModel({
    required this.isEnabled,
    required this.headerTitle,
    this.blogItems,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      isEnabled: json['isEnabled'] ?? true,
      headerTitle: json['headerTitle'],
      blogItems: (json['blogItems'] as List)
          .map((item) => BlogItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isEnabled': isEnabled,
      'headerTitle': headerTitle,
      'blogItems': blogItems?.map((item) => item.toJson()).toList(),
    };
  }
}

class BlogItem {
  DateTime createdAt;
  String description;
  String imageUrl;
  String link;

  BlogItem({
    required this.createdAt,
    required this.description,
    required this.imageUrl,
    required this.link,
  });

  factory BlogItem.fromJson(Map<String, dynamic> json) {
    return BlogItem(
      createdAt: DateTime.parse(json['createdAt']),
      description: json['description'],
      imageUrl: json['imageUrl'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'description': description,
      'imageUrl': imageUrl,
      'link': link,
    };
  }
}
