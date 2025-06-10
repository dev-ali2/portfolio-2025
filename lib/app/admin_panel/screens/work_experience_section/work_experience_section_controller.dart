import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/admin_panel/screens/dashboard/dashboard_controller.dart';
import 'package:portfolio_2025/core/common/models/work_experience_model.dart';

class WorkExperienceSectionController extends GetxController {
  final DashboardController _dashboardController =
      Get.find<DashboardController>();

  late TextEditingController headerTitleController;
  RxBool isEnabled = true.obs;
  RxList<WorkModel> workExperienceItems = <WorkModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeFields();
  }

  void _initializeFields() {
    WorkExperienceModel? currentExperience =
        _dashboardController.siteData.value?.workExperience;

    if (currentExperience != null) {
      headerTitleController =
          TextEditingController(text: currentExperience.headerTitle);
      isEnabled.value = currentExperience.isEnabled;
      workExperienceItems.assignAll(
        currentExperience.workExperienceList
            .map((item) => WorkModel.fromJson(item.toJson()))
            .toList(),
      );
    } else {
      headerTitleController = TextEditingController(text: "Work Experience");
      isEnabled.value = true;
      workExperienceItems.assignAll([]);
      Get.snackbar(
        "Notice",
        "No existing 'Work Experience' data found. Initializing with defaults.",
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.black,
      );
    }
  }

  void addOrUpdateWorkExperienceItem({WorkModel? existingItem, int? index}) {
    final TextEditingController positionCtrl =
        TextEditingController(text: existingItem?.position);
    final TextEditingController companyNameCtrl =
        TextEditingController(text: existingItem?.companyName);
    final TextEditingController logoUrlCtrl =
        TextEditingController(text: existingItem?.companyLogoImageUrl);
    final TextEditingController startTimeCtrl =
        TextEditingController(text: existingItem?.startTime);
    final TextEditingController endTimeCtrl =
        TextEditingController(text: existingItem?.endTime);
    final TextEditingController responsibilitiesCtrl =
        TextEditingController(text: existingItem?.responsibilities.join('\n'));

    Get.dialog(
      AlertDialog(
        title: Text(existingItem == null
            ? 'Add Work Experience'
            : 'Edit Work Experience'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: positionCtrl,
                  decoration: const InputDecoration(labelText: 'Position')),
              TextField(
                  controller: companyNameCtrl,
                  decoration: const InputDecoration(labelText: 'Company Name')),
              TextField(
                  controller: logoUrlCtrl,
                  decoration: const InputDecoration(
                      labelText: 'Company Logo URL (Optional)')),
              TextField(
                  controller: startTimeCtrl,
                  decoration: const InputDecoration(
                      labelText: 'Start Time (e.g., Jan 2020)')),
              TextField(
                  controller: endTimeCtrl,
                  decoration: const InputDecoration(
                      labelText: 'End Time (e.g., Present or Dec 2021)')),
              TextField(
                controller: responsibilitiesCtrl,
                decoration: const InputDecoration(
                    labelText: 'Responsibilities (one per line)'),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              if (positionCtrl.text.isNotEmpty &&
                  companyNameCtrl.text.isNotEmpty &&
                  startTimeCtrl.text.isNotEmpty &&
                  endTimeCtrl.text.isNotEmpty) {
                final List<String> responsibilitiesList = responsibilitiesCtrl
                    .text
                    .split('\n')
                    .where((r) => r.trim().isNotEmpty)
                    .toList();

                final newItem = WorkModel(
                  createdAt: existingItem?.createdAt ?? DateTime.now(),
                  position: positionCtrl.text,
                  companyName: companyNameCtrl.text,
                  companyLogoImageUrl:
                      logoUrlCtrl.text.isNotEmpty ? logoUrlCtrl.text : null,
                  startTime: startTimeCtrl.text,
                  endTime: endTimeCtrl.text,
                  responsibilities: responsibilitiesList,
                );

                if (index != null && existingItem != null) {
                  workExperienceItems[index] = newItem;
                } else {
                  workExperienceItems.insert(0, newItem);
                }
                Get.back();
              } else {
                Get.snackbar("Error",
                    "Position, Company, Start, and End Time cannot be empty.",
                    backgroundColor: Colors.red, colorText: Colors.white);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void removeWorkExperienceItem(int index) {
    if (index >= 0 && index < workExperienceItems.length) {
      workExperienceItems.removeAt(index);
    }
  }

  void saveChangesToDashboard() {
    if (_dashboardController.siteData.value == null) {
      Get.snackbar("Error", "Cannot save: Main site data is not loaded.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final updatedWorkExperienceModel = WorkExperienceModel(
      headerTitle: headerTitleController.text,
      isEnabled: isEnabled.value,
      workExperienceList: List<WorkModel>.from(
          workExperienceItems.map((item) => WorkModel.fromJson(item.toJson()))),
    );

    _dashboardController.siteData.value!.workExperience =
        updatedWorkExperienceModel;
    _dashboardController.siteData.refresh();

    Get.back();
    Get.snackbar("Success", "Work Experience section updated successfully!",
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  @override
  void onClose() {
    headerTitleController.dispose();
    super.onClose();
  }
}
