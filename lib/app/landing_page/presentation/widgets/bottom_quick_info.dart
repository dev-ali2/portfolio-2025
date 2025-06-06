import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class BottomQuickInfo extends StatelessWidget {
  const BottomQuickInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final dataController = Get.find<DataController>();
    return SizedBox(
      width: MqHelper.width * 0.9,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 5,
            children: [
              SelectableText(
                '~${dataController.siteData?.landingPageModel.yearsOfExperience ?? '2'}',
                style: FontsHelper.fontUbuntu.copyWith(
                    decorationThickness: 0,
                    height: 0.8,
                    textBaseline: TextBaseline.alphabetic,
                    color: ColorsHelper.defaultPrimaryColor,
                    fontSize: 40,
                    fontWeight: FontWeight.w500),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                spacing: 5,
                children: [
                  SelectableText(
                    textAlign: TextAlign.left,
                    'Years',
                    style: FontsHelper.fontUbuntu
                        .copyWith(fontSize: 12, color: Colors.grey),
                  ),
                  SelectableText('Experience',
                      style: FontsHelper.fontUbuntu
                          .copyWith(fontSize: 12, color: Colors.grey))
                ],
              ),
            ],
          ),
          Row(
            spacing: 5,
            children: [
              SelectableText(
                '${dataController.siteData?.landingPageModel.projectsCompleted ?? '10'}+',
                style: FontsHelper.fontUbuntu.copyWith(
                    decorationThickness: 0,
                    height: 0.8,
                    textBaseline: TextBaseline.alphabetic,
                    color: ColorsHelper.defaultPrimaryColor,
                    fontSize: 40,
                    fontWeight: FontWeight.w500),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                spacing: 5,
                children: [
                  SelectableText(
                    textAlign: TextAlign.left,
                    'Projects',
                    style: FontsHelper.fontUbuntu
                        .copyWith(fontSize: 12, color: Colors.grey),
                  ),
                  SelectableText('Completed',
                      style: FontsHelper.fontUbuntu
                          .copyWith(fontSize: 12, color: Colors.grey))
                ],
              ),
            ],
          ),
          Row(
            spacing: 5,
            children: [
              SelectableText(
                '${dataController.siteData?.landingPageModel.openSourceContributions ?? '5'}+',
                style: FontsHelper.fontUbuntu.copyWith(
                    decorationThickness: 0,
                    height: 0.8,
                    textBaseline: TextBaseline.alphabetic,
                    color: ColorsHelper.defaultPrimaryColor,
                    fontSize: 40,
                    fontWeight: FontWeight.w500),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                spacing: 5,
                children: [
                  SelectableText(
                    textAlign: TextAlign.left,
                    'Open Source',
                    style: FontsHelper.fontUbuntu
                        .copyWith(fontSize: 12, color: Colors.grey),
                  ),
                  SelectableText('Contributions',
                      style: FontsHelper.fontUbuntu
                          .copyWith(fontSize: 12, color: Colors.grey))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
