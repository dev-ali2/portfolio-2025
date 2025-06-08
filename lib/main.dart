import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/splash_screen/presentation/screens/d_splash_screen.dart';
import 'package:portfolio_2025/core/init_bindings.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';

import 'package:portfolio_2025/helpers/theme_helper.dart';
import 'package:scroll_animator/scroll_animator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitBindings().initDependencies();

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
          // home: AnimatedPrimaryScrollController(
          //     animationFactory: const ChromiumImpulse(),
          //     // animationFactory: const ChromiumEaseInOut(),
          //     child: Builder(builder: (context) => const DSplashScreen())

          //     // child: const MainCanvasScreen())),
          //     ),
          home: const DSplashScreen(),
        ));
  }
}
