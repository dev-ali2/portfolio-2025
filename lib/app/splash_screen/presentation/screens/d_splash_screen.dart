import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_2025/app/splash_screen/controllers/splash_screen_controller.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class DSplashScreen extends StatelessWidget {
  const DSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (controller) {
        return Material(
          color: Colors.black87,
          child: SizedBox(
            height: MqHelper.height,
            width: MqHelper.width,
            child: Center(
              child: Text(
                controller.currentGreeting,
                style: GoogleFonts.notoSans(
                    color: ColorsHelper.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
                // style: TextStyle(
                //     fontFamily: 'NotoSans',
                //     fontSize: 40,
                //     color: ColorsHelper.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
