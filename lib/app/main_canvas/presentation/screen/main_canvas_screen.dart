import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:portfolio_2025/app/landing_page/presentation/screens/d_landing_page.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/d_topbar.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class MainCanvasScreen extends StatelessWidget {
  const MainCanvasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log('Size values: ${MqHelper.width}, ${MqHelper.height}');
    return GetBuilder<MqHelper>(
        init: MqHelper(),
        id: 'canvas',
        builder: (controller) {
          controller.setSize(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height);
          return Scaffold(
            backgroundColor: ColorsHelper.defaultCanvasColor,
            body: const SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DTopbar(),
                  DLandingPage(),
                  // DLandingPage(),
                  //  DLandingPage(),
                  // DLandingPage(),
                  //    DLandingPage(),
                  //  DLandingPage(),
                ],
              ),
            ),
          );
        });
  }
}
