import 'package:flutter/material.dart';

class ColorsHelper {
  static const Color defaultPrimaryColor = Color.fromRGBO(240, 127, 7, 1);
  // static const Color canvasColor = Color.fromARGB(255, 0, 24, 28);
  static Color defaultCanvasColor =
      Color.lerp(Colors.black, defaultPrimaryColor, 0.05)!;
  //New modifications
  // static const Color accentColor = Color.fromRGBO(170, 92, 33, 1);
  static const Color accentColor = Color.fromRGBO(94, 43, 16, 1);

  static const Color canvasColor = Color.fromRGBO(7, 22, 39, 1);
  static const Color secondaryCanvasColor = Color.fromRGBO(6, 36, 65, 1);
  // static Color canvasColor = Color.fromRGBO(25, 27, 40, 1);
  static Color white = Colors.white.withAlpha(200);
}
