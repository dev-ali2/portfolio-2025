import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/bottom_quick_info.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/d_topbar.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/landing_page_contact.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/keys/widget_keys.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class DLandingPage extends StatefulWidget {
  DLandingPage({super.key});

  @override
  State<DLandingPage> createState() => _DLandingPageState();
}

class _DLandingPageState extends State<DLandingPage>
    with TickerProviderStateMixin {
  late AnimationController fadeAnimController;
  late Animation<double> fadeAnim;
  late Animation<double> fadeAnim2;
  late AnimationController fadeAnim2Controller;
  bool showTopBar = false;

  @override
  void initState() {
    super.initState();

    fadeAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    fadeAnim2Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: fadeAnimController,
        curve: Curves.easeInOut,
      ),
    );

    fadeAnim2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: fadeAnim2Controller,
        curve: Curves.easeInOut,
      ),
    );
    startAnimation();
  }

  @override
  void dispose() {
    fadeAnimController.dispose();
    fadeAnim2Controller.dispose();
    super.dispose();
  }

  void startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1400));
    fadeAnimController.forward().then((_) async {
      await Future.delayed(const Duration(milliseconds: 800));

      fadeAnim2Controller.forward();
      showTopBar = true;
      setState(() {});
    });
  }

  final dataController = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MqHelper>(
      id: 'canvas options',
      builder: (controller) => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MqHelper.height,
            width: MqHelper.width,
            color: Colors.black87,
            child: FadeTransition(
              opacity: fadeAnim2,
              child: Image.memory(
                dataController.imageData ?? Uint8List(0),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            key: landingPageKey,
            width: MqHelper.width,
            height: MqHelper.height,
            // decoration: BoxDecoration(

            //     image: DecorationImage(
            //       image: MemoryImage(dataController.imageData ?? Uint8List(0)),
            //       fit: BoxFit.cover,
            //     ),
            //     ),
            child: Center(
              child: Column(
                spacing: 40,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: fadeAnim,
                    child: SelectableText(
                      dataController.siteData?.landingPageModel.name ?? '',
                      style: GoogleFonts.poppins(
                          color: ColorsHelper.white,
                          wordSpacing: 15,
                          height: 0.8,
                          fontSize: 100,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  FadeTransition(
                    opacity: fadeAnim2,
                    child: SelectableText(
                      dataController
                              .siteData?.landingPageModel.shortDescription ??
                          '',
                      style: GoogleFonts.poppins(
                        color: ColorsHelper.white,
                        fontSize: 30,
                        height: 0.8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (dataController.siteData!.contactSection.isEnabled)
                    FadeTransition(
                        opacity: fadeAnim2, child: LandingPageContact()),
                ],
              ),
            ),
          ),
          if (showTopBar)
            Positioned(
                top: 10,
                child: FadeTransition(opacity: fadeAnim2, child: DTopbar())),
          // const Positioned(bottom: 10, child: BlinkingDownArrowCircle())
          Positioned(
            bottom: 20,
            child: FadeTransition(opacity: fadeAnim2, child: BottomQuickInfo()),
          ),
        ],
      ),
    );
  }
}
