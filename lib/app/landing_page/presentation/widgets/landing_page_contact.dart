import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/widgets/contact_icon_btn.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPageContact extends StatelessWidget {
  final dataController = Get.find<DataController>();
  LandingPageContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      mainAxisSize: MainAxisSize.min,
      children: [
        ContactIconBtn(
          onPressed: () async {
            if (await canLaunchUrl(Uri.parse(
                dataController.siteData?.contactSection.emailLink ?? ''))) {
              await launchUrl(Uri.parse(
                  dataController.siteData?.contactSection.emailLink ?? ''));
            }
          },
          icon: BoxIcons.bxl_gmail,
          size: 50,
        ),
        ContactIconBtn(
          icon: BoxIcons.bxl_github,
          onPressed: () async {
            if (await canLaunchUrl(Uri.parse(
                dataController.siteData?.contactSection.githubLink ?? ''))) {
              await launchUrl(Uri.parse(
                  dataController.siteData?.contactSection.githubLink ?? ''));
            }
          },
          size: 50,
        ),
        ContactIconBtn(
          icon: BoxIcons.bxl_linkedin,
          onPressed: () async {
            if (await canLaunchUrl(Uri.parse(
                dataController.siteData?.contactSection.linkedinLink ?? ''))) {
              await launchUrl(Uri.parse(
                  dataController.siteData?.contactSection.linkedinLink ?? ''));
            }
          },
          size: 50,
        ),
        ContactIconBtn(
          onPressed: () async {
            if (await canLaunchUrl(Uri.parse(
                dataController.siteData?.contactSection.whatsappLink ?? ''))) {
              await launchUrl(Uri.parse(
                  dataController.siteData?.contactSection.whatsappLink ?? ''));
            }
          },
          icon: BoxIcons.bxl_whatsapp,
          size: 50,
        ),
        SizedBox(
          height: 50,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(
                        ColorsHelper.defaultPrimaryColor.withAlpha(50)),
                    elevation: WidgetStateProperty.all(5),
                    backgroundColor: WidgetStateProperty.all(
                      Colors.white.withAlpha(20),
                    )),
                onPressed: () async {
                  if (await canLaunchUrl(Uri.parse(dataController
                          .siteData?.contactSection.downloadResumeLink ??
                      ''))) {
                    await launchUrl(Uri.parse(dataController
                            .siteData?.contactSection.downloadResumeLink ??
                        ''));
                  }
                },
                label: Text(
                  'Download CV',
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: const Color.fromRGBO(191, 200, 202, 1)),
                ),
                icon: const Icon(
                  Icons.download,
                  color: Color.fromRGBO(191, 200, 202, 1),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
