class WorkExperienceModel {
  bool isEnabled;
  String headerTitle;
  List<WorkModel> workExperienceList;

  WorkExperienceModel({
    required this.isEnabled,
    required this.headerTitle,
    required this.workExperienceList,
  });

  factory WorkExperienceModel.fromJson(Map<String, dynamic> json) {
    return WorkExperienceModel(
      isEnabled: json['isEnabled'] ?? true,
      headerTitle: json['headerTitle'],
      workExperienceList: (json['workExperienceList'] as List)
          .map((item) => WorkModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isEnabled': isEnabled,
      'headerTitle': headerTitle,
      'workExperienceList': workExperienceList
          .map((item) => item.toJson())
          .toList(),
    };
  }
}

class WorkModel {
  DateTime createdAt;
  String position;
  String companyName;
  String? companyLogoImageUrl;
  String startTime; //eg Jan 2020
  String endTime; //eg Present or Dec 2021
  List<String> responsibilities;

  WorkModel({
    required this.createdAt,
    required this.position,
    required this.companyName,
    this.companyLogoImageUrl,
    required this.startTime,
    required this.endTime,
    required this.responsibilities,
  });

  factory WorkModel.fromJson(Map<String, dynamic> json) {
    return WorkModel(
      createdAt: DateTime.parse(json['createdAt']),
      position: json['position'],
      companyName: json['companyName'],
      companyLogoImageUrl: json['companyLogoImageUrl'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      responsibilities: List<String>.from(json['responsibilities'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'position': position,
      'companyName': companyName,
      'companyLogoImageUrl': companyLogoImageUrl,
      'startTime': startTime,
      'endTime': endTime,
      'responsibilities': responsibilities,
    };
  }
}
