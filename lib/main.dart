import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/main_canvas/presentation/screen/main_canvas_screen.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';

import 'package:portfolio_2025/helpers/theme_helper.dart';
import 'package:scroll_animator/scroll_animator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Client client = Client();
  try {
    await dotenv.load(fileName: ".env");
    log('Env variables loaded: ${dotenv.env}');
    client
        .setEndpoint(dotenv.env['Endpoint'] ?? '')
        .setProject(dotenv.env['Project'] ?? '')
        .setSelfSigned(status: true);
    log('Appwrite client initialized with endpoint: ${dotenv.env['Endpoint']} and project: ${dotenv.env['Project']}');
  } catch (e) {
    log('Error in main function : $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: ColorsHelper.defaultCanvasColor,
        child: GetMaterialApp(
          actions: {
            ...WidgetsApp.defaultActions,
            ScrollIntent: AnimatedScrollAction(),
          },
          debugShowCheckedModeBanner: false,
          color: ColorsHelper.defaultCanvasColor,
          theme: ThemeHelper.darkTheme,
          title: 'Flutter Demo',
          home: AnimatedPrimaryScrollController(
              animationFactory: const ChromiumImpulse(),
              // animationFactory: const ChromiumEaseInOut(),
              child: Builder(builder: (context) => const MainCanvasScreen())

              // child: const MainCanvasScreen())),
              ),
        ));
  }
}
