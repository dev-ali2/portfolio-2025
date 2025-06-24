import 'package:flutter/material.dart';

class GetIconHelper {
  static IconData getIcon(String iconName) {
    if (iconName.toLowerCase().contains('android')) {
      return Icons.android;
    } else if (iconName.toLowerCase().contains('apple')) {
      return Icons.apple;
    } else if (iconName.toLowerCase().contains('web')) {
      return Icons.web;
    } else if (iconName.toLowerCase().contains('windows')) {
      return Icons.window;
    } else if (iconName.toLowerCase().contains('mac')) {
      return Icons.computer;
    } else if (iconName.toLowerCase().contains('linux')) {
      return Icons.shield;
    } else {
      return Icons.android;
    }
  }
}
