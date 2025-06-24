import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/projects/presentation/widgets/d_project_detail_popup.dart';
import 'package:portfolio_2025/core/common/models/featured_work_model.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';
import 'package:portfolio_2025/helpers/get_icon_helper.dart';

class DProjectWidget extends StatelessWidget {
  final FeaturedProjectModel project;
  const DProjectWidget({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsGeometry.symmetric(vertical: 30),
      width: 350,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border:
              Border.all(color: ColorsHelper.secondaryCanvasColor, width: 2)),
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 200,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorsHelper.white,
            ),
            child: Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                        width: 350,
                        height: 200,
                        child: Image.network(
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              CupertinoIcons.photo,
                              size: 50,
                              color: ColorsHelper.secondaryCanvasColor,
                            );
                          },
                          project.projectImageUrl,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: ColorsHelper.secondaryCanvasColor),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 7),
                          child: Text(
                            project.type,
                            style: FontsHelper.fontUbuntu.copyWith(
                                fontWeight: FontWeight.w500,
                                color: ColorsHelper.white),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            spacing: 8,
            children: [
              const SizedBox(
                width: 5,
              ),
              ...List.generate(
                project.platforms.length,
                (i) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: ColorsHelper.secondaryCanvasColor),
                  child: Icon(
                    GetIconHelper.getIcon(project.platforms[i].platformName),
                    color: _getPlatformColor(project.platforms[i].platformName),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: SelectableText(project.projectName,
                  style: FontsHelper.fontUbuntu.copyWith(
                      color: ColorsHelper.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 3,

              // _truncateDescription(project.shortDescription, 15)
              project.shortDescription,
              style: FontsHelper.poppinsFont.copyWith(
                  overflow: TextOverflow.ellipsis,
                  color: ColorsHelper.white,
                  fontSize: 16),
            ),
          ),
          SizedBox(
            width: 200,
            child: TextButton(
                style: TextButton.styleFrom(
                    overlayColor:
                        ColorsHelper.defaultPrimaryColor.withAlpha(50)),
                onPressed: () {
                  Get.dialog(DProjectDetailPopup(project: project));
                },
                child: Text(
                  'View Info',
                  style: FontsHelper.poppinsFont.copyWith(
                      color: ColorsHelper.defaultPrimaryColor,
                      fontWeight: FontWeight.bold),
                )),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Color _getPlatformColor(String platformName) {
    final platform = platformName.toLowerCase();

    if (platform.contains('android')) return Colors.green;
    if (platform.contains('ios')) return ColorsHelper.white;
    if (platform.contains('web')) return Colors.blue;
    if (platform.contains('mac')) return Colors.orange;
    if (platform.contains('windows')) return Colors.lightBlue;

    return ColorsHelper.white;
  }
}
