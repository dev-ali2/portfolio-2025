import 'package:portfolio_2025/core/common/models/top_bar_options_model.dart';

class LandingPageModel {
  List<TopBarOptionsModel> topBarOptions;
  String name;
  String shortDescription;
  bool showDiscription;
  String bgImageUrl;
  bool showContactOptions;
  double yearsOfExperience;
  int projectsCompleted;
  int openSourceContributions;

  LandingPageModel({
    required this.topBarOptions,
    required this.name,
    required this.shortDescription,
    required this.showDiscription,
    required this.bgImageUrl,
    required this.showContactOptions,
    required this.yearsOfExperience,
    required this.projectsCompleted,
    required this.openSourceContributions,
  });

  factory LandingPageModel.fromJson(Map<String, dynamic> json) {
    return LandingPageModel(
      topBarOptions: (json['topBarOptions'] as List)
          .map((item) => TopBarOptionsModel.fromJson(item))
          .toList(),
      name: json['name'],
      shortDescription: json['shortDescription'],
      showDiscription: json['showDiscription'],
      bgImageUrl: json['bgImageUrl'],
      showContactOptions: json['showContactOptions'],
      yearsOfExperience: json['yearsOfExperience'].toDouble(),
      projectsCompleted: json['projectsCompleted'],
      openSourceContributions: json['openSourceContributions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topBarOptions': topBarOptions.map((item) => item.toJson()).toList(),
      'name': name,
      'shortDescription': shortDescription,
      'showDiscription': showDiscription,
      'bgImageUrl': bgImageUrl,
      'showContactOptions': showContactOptions,
      'yearsOfExperience': yearsOfExperience,
      'projectsCompleted': projectsCompleted,
      'openSourceContributions': openSourceContributions,
    };
  }
}
