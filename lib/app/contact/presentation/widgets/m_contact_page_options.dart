import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/widgets/contact_icon_btn.dart';
import 'package:url_launcher/url_launcher.dart';

class MContactPageOptions extends StatelessWidget {
  const MContactPageOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final dataController = Get.find<DataController>();
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
          iconSize: 25,
          size: 50,
        ),
        ContactIconBtn(
          onPressed: () async {
            if (await canLaunchUrl(Uri.parse(
                dataController.siteData?.contactSection.githubLink ?? ''))) {
              await launchUrl(Uri.parse(
                  dataController.siteData?.contactSection.githubLink ?? ''));
            }
          },
          icon: BoxIcons.bxl_github,
          iconSize: 25,
          size: 50,
        ),
        ContactIconBtn(
          onPressed: () async {
            if (await canLaunchUrl(Uri.parse(
                dataController.siteData?.contactSection.linkedinLink ?? ''))) {
              await launchUrl(Uri.parse(
                  dataController.siteData?.contactSection.linkedinLink ?? ''));
            }
          },
          icon: BoxIcons.bxl_linkedin,
          iconSize: 25,
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
          iconSize: 25,
          size: 50,
        ),
      ],
    );
  }
}
