import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/blog/presentation/widgets/blog_tile_widget.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/keys/widget_keys.dart';
import 'package:portfolio_2025/core/common/widgets/pages_header.dart';

class DBlogPage extends StatelessWidget {
  const DBlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataController = Get.find<DataController>();
    return dataController.siteData!.blog.isEnabled
        ? Container(
            key: blogPageKey,
            width: double.maxFinite,
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 60),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 60,
              children: [
                PagesHeader(title: dataController.siteData!.blog.headerTitle),
                Wrap(
                  spacing: 40,
                  alignment: WrapAlignment.center,
                  children: [
                    ...List.generate(
                        dataController.siteData!.blog.blogItems?.length ?? 0,
                        (i) => BlogTileWidget(
                              blogItem:
                                  dataController.siteData!.blog.blogItems![i],
                            )),
                  ],
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
