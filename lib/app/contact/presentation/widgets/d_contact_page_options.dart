import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/widgets/contact_icon_btn.dart';
import 'package:url_launcher/url_launcher.dart';

class DContactPageOptions extends StatelessWidget {
  const DContactPageOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final dataController = Get.find<DataController>();
    return Row(
      spacing: 20,
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
          iconSize: 40,
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
          iconSize: 40,
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
          iconSize: 40,
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
          iconSize: 40,
        ),
        // SizedBox(
        //   height: 70,
        //   width: 70,
        //   child: ClipRRect(
        //     child: BackdropFilter(
        //       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        //       child: IconButton(
        //         style: ButtonStyle(
        //             overlayColor: WidgetStateProperty.all(
        //                 ColorsHelper.defaultPrimaryColor.withAlpha(70)),
        //             elevation: WidgetStateProperty.all(5),
        //             backgroundColor: WidgetStateProperty.all(
        //               Colors.white.withAlpha(20),
        //             )),
        //         onPressed: () {},
        //         icon: const Icon(
        //           BoxIcons.bxl_whatsapp,
        //           size: 40,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
