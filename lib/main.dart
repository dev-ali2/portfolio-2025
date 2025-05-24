import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/main_canvas/presentation/screen/main_canvas_screen.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';

import 'package:portfolio_2025/helpers/theme_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: ColorsHelper.defaultCanvasColor,
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          color: ColorsHelper.defaultCanvasColor,
          theme: ThemeHelper.darkTheme,
          title: 'Flutter Demo',
          home: const MainCanvasScreen()),
    );
  }
}
