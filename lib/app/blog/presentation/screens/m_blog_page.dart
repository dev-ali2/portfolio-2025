import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/blog/presentation/widgets/m_blog_item_widget.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/keys/widget_keys.dart';
import 'package:portfolio_2025/core/common/widgets/m_pages_header.dart';

class MBlogPage extends StatelessWidget {
  const MBlogPage({super.key});

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
              spacing: 30,
              children: [
                MPagesHeader(title: dataController.siteData!.blog.headerTitle),
                Wrap(
                  spacing: 30,
                  alignment: WrapAlignment.center,
                  children: [
                    ...List.generate(
                        dataController.siteData!.blog.blogItems?.length ?? 0,
                        (i) => MBlogItemWidget(
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
