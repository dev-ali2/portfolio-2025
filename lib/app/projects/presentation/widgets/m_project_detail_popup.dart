import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/core/common/models/featured_work_model.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class MProjectDetailPopup extends StatelessWidget {
  final FeaturedProjectModel project;
  const MProjectDetailPopup({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: ColorsHelper.white.withAlpha(30),
        child: Container(
          margin: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: ColorsHelper.canvasColor.withAlpha(230),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: ColorsHelper.white.withAlpha(100),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Spacer(),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              project.projectName,
                              textAlign: TextAlign.center,
                              style: FontsHelper.poppinsFont.copyWith(
                                color: ColorsHelper.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () => Get.back(),
                              icon: Icon(
                                Icons.close,
                                color: ColorsHelper.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // Description
                      Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Description',
                          style: FontsHelper.poppinsFont.copyWith(
                            color: ColorsHelper.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        project.longDescription,
                        style: FontsHelper.fontUbuntu.copyWith(
                          color: ColorsHelper.white,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Tech Used Section
                      Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Tech Used',
                          style: FontsHelper.poppinsFont.copyWith(
                            color: ColorsHelper.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: project.technologies
                            .map((tech) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: ColorsHelper.secondaryCanvasColor
                                      // border: Border.all(
                                      //   width: 1.2,
                                      //   color: ColorsHelper.defaultPrimaryColor
                                      //       .withAlpha(200),
                                      // ),
                                      ),
                                  child: Text(
                                    tech,
                                    style: FontsHelper.fontUbuntu.copyWith(
                                      color: ColorsHelper.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 20),

                      // Platforms Section
                      Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Supported Platforms',
                          style: FontsHelper.poppinsFont.copyWith(
                            color: ColorsHelper.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        runSpacing: 30,
                        spacing: 30,
                        children: [
                          ...project.platforms.map((platform) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    platform.platformIcon,
                                    color: _getPlatformColor(
                                        platform.platformName),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    platform.platformName,
                                    style: FontsHelper.poppinsFont.copyWith(
                                      color: ColorsHelper.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Links Section
                      Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Available on',
                          style: FontsHelper.poppinsFont.copyWith(
                            color: ColorsHelper.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: [
                          ...project.availableOn!.map((availableOn) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton.icon(
                                      style: TextButton.styleFrom(
                                        overlayColor: ColorsHelper
                                            .defaultPrimaryColor
                                            .withAlpha(100),
                                      ),
                                      onPressed: () async {
                                        if (await canLaunchUrl(Uri.parse(
                                            availableOn.link ?? ''))) {
                                          await launchUrl(
                                              Uri.parse(availableOn.link!));
                                        } else {
                                          return;
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.arrow_outward_rounded,
                                        color: ColorsHelper.defaultPrimaryColor,
                                        size: 18,
                                      ),
                                      label: Text(
                                        availableOn.name,
                                        style: FontsHelper.fontUbuntu.copyWith(
                                          wordSpacing: 3,
                                          fontSize: 16,
                                          color: ColorsHelper.white,
                                        ),
                                      )),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
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
