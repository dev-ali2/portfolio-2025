import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/m_bottom_quick_info.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/m_landing_contact.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/m_topbar.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/keys/widget_keys.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class MLandingPage extends StatefulWidget {
  const MLandingPage({super.key});

  @override
  State<MLandingPage> createState() => _MLandingPageState();
}

class _MLandingPageState extends State<MLandingPage>
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
            //   image: DecorationImage(
            //     image: MemoryImage(dataController.imageData ?? Uint8List(0)),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: Center(
              child: Column(
                spacing: 15,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FadeTransition(
                        opacity: fadeAnim,
                        child: SelectableText(
                          dataController.siteData?.landingPageModel.name ?? '',
                          style: GoogleFonts.poppins(
                              color: ColorsHelper.white,
                              fontSize: 50,
                              wordSpacing: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      FadeTransition(
                        opacity: fadeAnim2,
                        child: SelectableText(
                          textAlign: TextAlign.center,
                          dataController.siteData?.landingPageModel
                                  .shortDescription ??
                              '',
                          style: GoogleFonts.poppins(
                            color: ColorsHelper.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (dataController.siteData!.contactSection.isEnabled)
                    // LandingPageContact(),
                    FadeTransition(opacity: fadeAnim2, child: MLandingContact())
                ],
              ),
            ),
          ),
          if (showTopBar)
            Positioned(
                top: 10,
                child: FadeTransition(opacity: fadeAnim2, child: const MTopBar())),
          // const Positioned(bottom: 10, child: BlinkingDownArrowCircle())
          Positioned(
            bottom: 20,
            child:
                FadeTransition(opacity: fadeAnim2, child: const MBottomQuickInfo()),
          ),
        ],
      ),
    );
  }
}
