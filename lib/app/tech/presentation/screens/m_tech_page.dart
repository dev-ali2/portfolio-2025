import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/tech/presentation/widgets/m_tech_image_widget.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/keys/widget_keys.dart';
import 'package:portfolio_2025/core/common/widgets/m_pages_header.dart';

class MTechPage extends StatelessWidget {
  const MTechPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataController = Get.find<DataController>();
    return dataController.siteData!.tech.isEnabled
        ? Container(
            key: techPageKey,
            width: double.maxFinite,
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 60),
            child: Column(
              spacing: 30,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MPagesHeader(title: dataController.siteData!.tech.headerTitle),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    ...List.generate(
                      dataController.siteData!.tech.techList.length,
                      (index) => MTechImageWidget(
                          image: dataController
                                  .siteData!.tech.techList[index].imageUrl ??
                              '',
                          title: dataController
                              .siteData!.tech.techList[index].title),
                    ),
                  ],
                )
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
