import 'package:flutter/material.dart';

class ColorsHelper {
  static const Color defaultPrimaryColor = Colors.blue;
  // static const Color canvasColor = Color.fromARGB(255, 0, 24, 28);
  static Color defaultCanvasColor =
      Color.lerp(Colors.black, defaultPrimaryColor, 0.05)!;
}
