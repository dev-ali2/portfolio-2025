import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/core/common/models/featured_work_model.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class DProjectDetailPopup extends StatelessWidget {
  final FeaturedProjectModel project;
  const DProjectDetailPopup({super.key, required this.project});

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 40),
                          Expanded(
                            child: Text(
                              project.projectName,
                              textAlign: TextAlign.center,
                              style: FontsHelper.poppinsFont.copyWith(
                                color: ColorsHelper.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(
                              Icons.close,
                              color: ColorsHelper.white,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Description
                      Text(
                        'Description',
                        style: FontsHelper.poppinsFont.copyWith(
                          color: ColorsHelper.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        project.longDescription,
                        style: FontsHelper.fontUbuntu.copyWith(
                          color: ColorsHelper.white,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Tech Used Section
                      Text(
                        'Tech Used',
                        style: FontsHelper.poppinsFont.copyWith(
                          color: ColorsHelper.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 15),
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
                                      color: ColorsHelper.secondaryCanvasColor),
                                  child: Text(
                                    tech,
                                    style: FontsHelper.fontUbuntu.copyWith(
                                      color: ColorsHelper.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 24),

                      // Platforms Section
                      if (project.platforms.isNotEmpty)
                        Text(
                          'Supported Platform',
                          style: FontsHelper.poppinsFont.copyWith(
                            color: ColorsHelper.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                      const SizedBox(height: 15),
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
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Links Section
                      if (project.availableOn != null &&
                          project.availableOn!.isNotEmpty)
                        Text(
                          'Availability',
                          style: FontsHelper.poppinsFont.copyWith(
                            color: ColorsHelper.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                      const SizedBox(height: 15),
                      Wrap(
                        runSpacing: 30,
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
