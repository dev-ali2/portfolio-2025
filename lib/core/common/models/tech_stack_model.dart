class TechStackModel {
  bool isEnabled;
  List<TechListItem> techList;
  String prependTextOnClick;
  String headerTitle;

  TechStackModel({
    required this.isEnabled,
    required this.headerTitle,
    required this.techList,
    required this.prependTextOnClick,
  });

  factory TechStackModel.fromJson(Map<String, dynamic> json) {
    return TechStackModel(
      headerTitle: json['headerTitle'] ?? 'Tech Stack',
      prependTextOnClick: json['prependTextOnClick'] ?? '',
      isEnabled: json['isEnabled'] ?? true,
      techList: (json['techList'] as List)
          .map((item) => TechListItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'headerTitle': headerTitle,
      'prependTextOnClick': prependTextOnClick,
      'isEnabled': isEnabled,
      'techList': techList.map((item) => item.toJson()).toList(),
    };
  }
}

class TechListItem {
  String title;
  String? imageUrl;

  TechListItem({required this.title, this.imageUrl});

  factory TechListItem.fromJson(Map<String, dynamic> json) {
    return TechListItem(title: json['title'], imageUrl: json['imageUrl']);
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'imageUrl': imageUrl};
  }
}
