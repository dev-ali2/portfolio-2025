import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/contact/presentation/widgets/d_contact_page_options.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/keys/widget_keys.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class DContactPage extends StatelessWidget {
  const DContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataController = Get.find<DataController>();
    return dataController.siteData!.contactSection.isEnabled
        ? Container(
            key: contactPageKey,
            width: double.maxFinite,
            padding: const EdgeInsets.only(left: 50, right: 50, bottom: 60),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 60,
              children: [
                const SizedBox(
                  height: 10,
                ),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 27, 113, 194),
                      ColorsHelper.defaultPrimaryColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: SelectableText(
                      style: FontsHelper.fontUbuntu.copyWith(
                          fontSize: 30,
                          fontStyle: FontStyle.italic,
                          wordSpacing: 3,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      dataController.siteData!.contactSection.callToActionLine),
                ),
                const DContactPageOptions(),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
