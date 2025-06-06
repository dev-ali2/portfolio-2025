import 'package:flutter/material.dart';

class TopBarOptionsModel {
  String title;
  bool isEnabled;
  IconData? icon;

  TopBarOptionsModel({required this.title, required this.isEnabled, this.icon});

  factory TopBarOptionsModel.fromJson(Map<String, dynamic> json) {
    return TopBarOptionsModel(
      title: json['title'],
      isEnabled: json['isEnabled'] ?? true,
      icon: json['icon'] != null
          ? IconData(json['icon'], fontFamily: 'MaterialIcons')
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {'title': title, 'isEnabled': isEnabled, 'icon': icon?.codePoint};
  }
}
