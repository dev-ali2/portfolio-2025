import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/keys/widget_keys.dart';
import 'package:portfolio_2025/core/common/widgets/m_pages_header.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class MAboutPage extends StatelessWidget {
  const MAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataController = Get.find<DataController>();
    return dataController.siteData!.about.isEnabled
        ? GetBuilder<MqHelper>(
            id: 'canvas options',
            builder: (controller) => Container(
              key: aboutPageKey,
              width: MqHelper.width,
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 60),
              child: Column(
                spacing: 30,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MPagesHeader(
                      title: dataController.siteData!.about.headerTitle),
                  Column(
                    spacing: 30,
                    children: [
                      CircleAvatar(
                        radius:
                            80 + (MqHelper.width * MqHelper.height * 0.0001),
                        backgroundColor: ColorsHelper.white,
                        backgroundImage: NetworkImage(
                          dataController.siteData!.about.myImageUrl,
                        ),
                      ),
                      SizedBox(
                        width: MqHelper.width,
                        child: SelectableText(
                            dataController.siteData!.about.aboutDescription,
                            style: FontsHelper.fontUbuntu.copyWith(
                                fontSize: 15,
                                color: Colors.white.withAlpha(200))),
                      ),
                      ...List.generate(
                        dataController.siteData!.about.edudationList!.length,
                        (i) => SizedBox(
                          width: MqHelper.width,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            subtitle: SelectableText(
                                '${dataController.siteData!.about.edudationList?[i].UniversityName} ${dataController.siteData!.about.edudationList?[i].startAndEndDate}',
                                style: FontsHelper.fontUbuntu.copyWith(
                                    color: Colors.grey, fontSize: 12)),
                            leading: Image.network(
                              dataController.siteData!.about.edudationList?[i]
                                      .logoImageUrl ??
                                  '',
                              errorBuilder: (context, error, stackTrace) {
                                return const SizedBox.shrink();
                              },
                            ),
                            title: SelectableText(
                                '${dataController.siteData!.about.edudationList?[i].degreeTitle}',
                                style: FontsHelper.fontUbuntu.copyWith(
                                    fontSize: 17,
                                    color: ColorsHelper.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}

String formatParagraphWithSpacing(String paragraph) {
  return paragraph.replaceAll('\n', '\n\n');
}
