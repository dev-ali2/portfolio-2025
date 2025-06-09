import 'dart:developer';

import 'package:get/get.dart';

class MqHelper extends GetxController {
  static double width = 0.0;
  static double height = 0.0;

  setSize(double w, double h) {
    width = w;
    height = h;
    update(['canvas', 'canvas options']);
    log('Width: $width, Height: $height');
  }
}
