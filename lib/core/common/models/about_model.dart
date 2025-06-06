class AboutModel {
  String myImageUrl;
  String aboutDescription;
  List<EducationModel>? edudationList;
  String headerTitle;
  bool isEnabled;

  AboutModel({
    required this.myImageUrl,
    required this.aboutDescription,
    required this.edudationList,
    required this.headerTitle,
    this.isEnabled = true,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) {
    return AboutModel(
      myImageUrl: json['myImageUrl'],
      aboutDescription: json['aboutDescription'],
      edudationList: (json['edudationList'] as List)
          .map((item) => EducationModel.fromJson(item))
          .toList(),
      headerTitle: json['headerTitle'],
      isEnabled: json['isEnabled'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'myImageUrl': myImageUrl,
      'aboutDescription': aboutDescription,
      'edudationList': edudationList?.map((item) => item.toJson()).toList(),
      'headerTitle': headerTitle,
      'isEnabled': isEnabled,
    };
  }
}

class EducationModel {
  DateTime createdAt;
  String degreeTitle;
  String UniversityName;
  String startAndEndDate;
  String logoImageUrl;

  EducationModel({
    required this.degreeTitle,
    required this.createdAt,
    required this.UniversityName,
    required this.startAndEndDate,
    required this.logoImageUrl,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      createdAt: DateTime.parse(json['createdAt']),
      degreeTitle: json['degreeTitle'],
      UniversityName: json['UniversityName'],
      startAndEndDate: json['startAndEndDate'],
      logoImageUrl: json['logoImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'degreeTitle': degreeTitle,
      'UniversityName': UniversityName,
      'startAndEndDate': startAndEndDate,
      'logoImageUrl': logoImageUrl,
    };
  }
}
