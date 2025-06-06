import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/bottom_quick_info.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/landing_page_contact.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class DLandingPage extends StatefulWidget {
  const DLandingPage({super.key});

  @override
  State<DLandingPage> createState() => _DLandingPageState();
}

class _DLandingPageState extends State<DLandingPage>
    with SingleTickerProviderStateMixin {
  final dataController = Get.find<DataController>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
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
                spacing: 40,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SelectableText(
                    dataController.siteData?.landingPageModel.name ?? '',
                    style: GoogleFonts.poppins(
                        color: ColorsHelper.white,
                        wordSpacing: 15,
                        height: 0.8,
                        fontSize: 100,
                        fontWeight: FontWeight.bold),
                  ),
                  SelectableText(
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
                  if (dataController.siteData!.contactSection.isEnabled)
                    LandingPageContact(),
                ],
              ),
            ),
          ),
        ),
        //  const Positioned(top: 10, child: DTopbar()),
        // const Positioned(bottom: 10, child: BlinkingDownArrowCircle())
        const Positioned(
          bottom: 20,
          child: BottomQuickInfo(),
        ),
      ],
    );
  }
}
