import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_2025/app/splash_screen/controllers/splash_screen_controller.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class DSplashScreen extends StatefulWidget {
  const DSplashScreen({super.key});

  @override
  State<DSplashScreen> createState() => _DSplashScreenState();
}

class _DSplashScreenState extends State<DSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
              child: FadeTransition(
                opacity: _fadeAnimation,
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
          ),
        );
      },
    );
  }
}
