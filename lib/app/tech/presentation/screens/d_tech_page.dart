import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/tech/presentation/widgets/tech_image_widget.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/widgets/pages_header.dart';

class DTechPage extends StatelessWidget {
  const DTechPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataController = Get.find<DataController>();
    return dataController.siteData!.tech.isEnabled
        ? Container(
            width: double.maxFinite,
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 60),
            child: Column(
              spacing: 60,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PagesHeader(
                    title: dataController.siteData!.tech.headerTitle),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 40,
                  runSpacing: 40,
                  children: [
                    ...List.generate(
                      dataController.siteData!.tech.techList.length,
                      (index) => TechImageWidget(
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
