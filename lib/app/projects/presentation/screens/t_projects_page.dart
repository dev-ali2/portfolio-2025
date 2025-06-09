import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:portfolio_2025/app/projects/presentation/widgets/t_project_widget.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/keys/widget_keys.dart';
import 'package:portfolio_2025/core/common/widgets/pages_header.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class TProjectsPage extends StatelessWidget {
  const TProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataController = Get.find<DataController>();
    return dataController.siteData!.featuredWork.isEnabled
        ? Container(
            key: projectsPageKey,
            width: double.maxFinite,
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 60),
            child: Column(
              spacing: 40,
              mainAxisSize: MainAxisSize.min,
              children: [
                PagesHeader(
                    title: dataController.siteData!.featuredWork.headerTitle),
                Wrap(
                  spacing: 30,
                  alignment: WrapAlignment.center,
                  children: [
                    ...List.generate(
                        dataController.siteData!.featuredWork.featuredProjects
                                ?.length ??
                            0,
                        (i) => TProjectWidget(
                            project: dataController
                                .siteData!.featuredWork.featuredProjects![i]))
                  ],
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: ColorsHelper.defaultPrimaryColor,
                  ),
                  onPressed: () async {
                    if (await canLaunchUrl(Uri.parse(
                        dataController.siteData!.contactSection.githubLink ??
                            ''))) {
                      await launchUrl(Uri.parse(
                          dataController.siteData!.contactSection.githubLink!));
                    } else {
                      return;
                    }
                  },
                  label: Text(
                    'Explore More',
                    style: FontsHelper.fontUbuntu
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  icon: const Icon(
                    BoxIcons.bxl_github,
                    size: 30,
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
