import 'package:flutter/widgets.dart';

class FeaturedWorkModel {
  bool isEnabled;
  String headerTitle;
  List<FeaturedProjectModel>? featuredProjects;

  FeaturedWorkModel({
    required this.isEnabled,
    required this.headerTitle,
    required this.featuredProjects,
  });

  factory FeaturedWorkModel.fromJson(Map<String, dynamic> json) {
    return FeaturedWorkModel(
      isEnabled: json['isEnabled'] ?? true,
      headerTitle: json['headerTitle'],
      featuredProjects: (json['featuredProjects'] as List)
          .map((item) => FeaturedProjectModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isEnabled': isEnabled,
      'headerTitle': headerTitle,
      'featuredProjects': featuredProjects
          ?.map((item) => item.toJson())
          .toList(),
    };
  }
}

class FeaturedProjectModel {
  DateTime createdAt;
  String projectName;
  String projectImageUrl;
  String shortDescription;
  String longDescription;
  String type; //Open source etc
  List<AvailablePlatformModel> platforms;
  List<String> technologies;
  List<AvailableOnModel>? availableOn;

  FeaturedProjectModel({
    required this.createdAt,
    required this.projectName,
    required this.projectImageUrl,
    required this.shortDescription,
    required this.longDescription,
    required this.type,
    required this.platforms,
    required this.technologies,
    this.availableOn,
  });

  factory FeaturedProjectModel.fromJson(Map<String, dynamic> json) {
    return FeaturedProjectModel(
      createdAt: DateTime.parse(json['createdAt']),
      projectName: json['projectName'],
      projectImageUrl: json['projectImageUrl'],
      shortDescription: json['shortDescription'],
      longDescription: json['longDescription'],
      type: json['type'],
      platforms: (json['platforms'] as List)
          .map((item) => AvailablePlatformModel.fromJson(item))
          .toList(),
      technologies: List<String>.from(json['technologies']),
      availableOn: (json['availableOn'] as List?)
          ?.map((item) => AvailableOnModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'projectName': projectName,
      'projectImageUrl': projectImageUrl,
      'shortDescription': shortDescription,
      'longDescription': longDescription,
      'type': type,
      'platforms': platforms.map((item) => item.toJson()).toList(),
      'technologies': technologies,
      'availableOn': availableOn?.map((item) => item.toJson()).toList(),
    };
  }
}

class AvailablePlatformModel {
  String platformName;
  IconData platformIcon;

  AvailablePlatformModel({
    required this.platformName,
    required this.platformIcon,
  });

  factory AvailablePlatformModel.fromJson(Map<String, dynamic> json) {
    return AvailablePlatformModel(
      platformName: json['platformName'],
      platformIcon: IconData(json['platformIcon'], fontFamily: 'MaterialIcons'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'platformName': platformName,
      'platformIcon': platformIcon.codePoint,
    };
  }
}

class AvailableOnModel {
  String name;
  String imageURl;
  String? link;

  AvailableOnModel({required this.name, required this.imageURl, this.link});

  factory AvailableOnModel.fromJson(Map<String, dynamic> json) {
    return AvailableOnModel(
      name: json['name'],
      imageURl: json['imageURl'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'imageURl': imageURl, 'link': link};
  }
}
