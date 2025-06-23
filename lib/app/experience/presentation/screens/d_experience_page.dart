import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/keys/widget_keys.dart';
import 'package:portfolio_2025/core/common/widgets/pages_header.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class DExperiencePage extends StatelessWidget {
  const DExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataController = Get.find<DataController>();
    return dataController.siteData!.workExperience.isEnabled
        ? Container(
            key: workExperiencePageKey,
            width: double.maxFinite,
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 60),
            child: Column(
              spacing: 40,
              mainAxisSize: MainAxisSize.min,
              children: [
                PagesHeader(
                    title: dataController.siteData!.workExperience.headerTitle),
                ...List.generate(
                  dataController
                      .siteData!.workExperience.workExperienceList.length,
                  (i) => Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 0),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white.withAlpha(40), width: 1),
                        borderRadius: BorderRadius.circular(35),
                        color: ColorsHelper.secondaryCanvasColor),
                    child: ListTile(
                      horizontalTitleGap: 15,
                      style: ListTileStyle.list,
                      isThreeLine: true,
                      subtitle: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${dataController.siteData!.workExperience.workExperienceList[i].startTime} - ${dataController.siteData!.workExperience.workExperienceList[i].endTime}',
                              style: FontsHelper.fontUbuntu
                                  .copyWith(color: Colors.grey, fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ...List.generate(
                            dataController.siteData!.workExperience
                                .workExperienceList[i].responsibilities.length,
                            (index) => Align(
                              alignment: Alignment.centerLeft,
                              child: SelectableText(
                                  textAlign: TextAlign.start,
                                  '${dataController.siteData!.workExperience.workExperienceList[i].responsibilities[index]}\n',
                                  style: FontsHelper.fontUbuntu.copyWith(
                                      color: ColorsHelper.white, fontSize: 14)),
                            ),
                          )
                        ],
                      ),
                      leading: Container(
                        margin: const EdgeInsets.only(right: 7),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            '${dataController.siteData!.workExperience.workExperienceList[i].companyLogoImageUrl}',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                      title: SelectableText(
                          '${dataController.siteData!.workExperience.workExperienceList[i].position} @ ${dataController.siteData!.workExperience.workExperienceList[i].companyName}',
                          style: FontsHelper.fontUbuntu.copyWith(
                              height: 0.7,
                              fontSize: 20,
                              color: ColorsHelper.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
