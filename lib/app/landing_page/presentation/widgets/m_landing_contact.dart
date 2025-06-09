import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/widgets/contact_icon_btn.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class MLandingContact extends StatelessWidget {
  final dataController = Get.find<DataController>();
  MLandingContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
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
          size: 35,
          iconSize: 19,
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
          size: 35,
          iconSize: 19,
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
          size: 35,
          iconSize: 19,
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
          size: 35,
          iconSize: 19,
        ),
        SizedBox(
          height: 35,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
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
                  'CV',
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      color: const Color.fromRGBO(191, 200, 202, 1)),
                ),
                icon: const Icon(
                  Icons.download,
                  size: 15,
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
