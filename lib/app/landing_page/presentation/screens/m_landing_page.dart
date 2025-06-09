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

class MLandingPage extends StatelessWidget {
  MLandingPage({super.key});

  final dataController = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MqHelper>(
      id: 'canvas options',
      builder: (controller) => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            key: landingPageKey,
            width: MqHelper.width,
            height: MqHelper.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(dataController.imageData ?? Uint8List(0)),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              child: Center(
                child: Column(
                  spacing: 15,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SelectableText(
                          dataController.siteData?.landingPageModel.name ?? '',
                          style: GoogleFonts.poppins(
                              color: ColorsHelper.white,
                              fontSize: 50,
                              wordSpacing: 10,
                              fontWeight: FontWeight.bold),
                        ),
                        SelectableText(
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
                      ],
                    ),
                    if (dataController.siteData!.contactSection.isEnabled)
                      // LandingPageContact(),
                      MLandingContact()
                  ],
                ),
              ),
            ),
          ),
          const Positioned(top: 10, child: MTopBar()),
          // const Positioned(bottom: 10, child: BlinkingDownArrowCircle())
          const Positioned(
            bottom: 20,
            child: MBottomQuickInfo(),
          ),
        ],
      ),
    );
  }
}
