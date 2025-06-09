import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/keys/widget_keys.dart';
import 'package:portfolio_2025/core/common/widgets/m_pages_header.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class MExperiencePage extends StatelessWidget {
  const MExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataController = Get.find<DataController>();
    return dataController.siteData!.workExperience.isEnabled
        ? Container(
            key: workExperiencePageKey,
            width: double.maxFinite,
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 60),
            child: Column(
              spacing: 30,
              mainAxisSize: MainAxisSize.min,
              children: [
                MPagesHeader(
                    title: dataController.siteData!.workExperience.headerTitle),
                ...List.generate(
                  dataController
                      .siteData!.workExperience.workExperienceList.length,
                  (i) => Container(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: ColorsHelper.secondaryCanvasColor),
                    child: ListTile(
                      horizontalTitleGap: 10,
                      style: ListTileStyle.list,
                      isThreeLine: true,
                      subtitle: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '(${dataController.siteData!.workExperience.workExperienceList[i].startTime} --> ${dataController.siteData!.workExperience.workExperienceList[i].endTime})',
                                style: FontsHelper.fontUbuntu
                                    .copyWith(color: Colors.grey, fontSize: 10),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          ...List.generate(
                            dataController.siteData!.workExperience
                                .workExperienceList[i].responsibilities.length,
                            (index) => SelectableText(
                                '${dataController.siteData!.workExperience.workExperienceList[i].responsibilities[index]}\n',
                                style: FontsHelper.fontUbuntu.copyWith(
                                    color: ColorsHelper.white, fontSize: 13)),
                          )
                        ],
                      ),
                      leading: SizedBox(
                        height: 40,
                        width: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            '${dataController.siteData!.workExperience.workExperienceList[i].companyLogoImageUrl}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: SelectableText(
                          '${dataController.siteData!.workExperience.workExperienceList[i].position} @ ${dataController.siteData!.workExperience.workExperienceList[i].companyName}',
                          style: FontsHelper.fontUbuntu.copyWith(
                              fontSize: 17,
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
