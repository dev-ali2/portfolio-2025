import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/admin_panel/screens/dashboard/dashboard_controller.dart';

import 'package:portfolio_2025/core/common/models/about_model.dart';

class AboutSectionController extends GetxController {
  final DashboardController _dashboardController =
      Get.find<DashboardController>();

  late TextEditingController myImageUrlController;
  late TextEditingController aboutDescriptionController;
  late TextEditingController headerTitleController;
  RxBool isEnabled = true.obs;

  RxList<EducationModel> educationItems = <EducationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeFields();
  }

  void _initializeFields() {
    AboutModel? currentAbout = _dashboardController.siteData.value?.about;

    if (currentAbout != null) {
      myImageUrlController =
          TextEditingController(text: currentAbout.myImageUrl);
      aboutDescriptionController =
          TextEditingController(text: currentAbout.aboutDescription);
      headerTitleController =
          TextEditingController(text: currentAbout.headerTitle);
      isEnabled.value = currentAbout.isEnabled;
      educationItems.assignAll(currentAbout.edudationList
              ?.map((e) => EducationModel.fromJson(e.toJson())) ??
          []);
    } else {
      myImageUrlController = TextEditingController();
      aboutDescriptionController = TextEditingController();
      headerTitleController = TextEditingController(text: "About Me");
      isEnabled.value = true;
      educationItems.assignAll([]);
      Get.snackbar(
        "Notice",
        "No existing 'About' data found. Initializing with defaults.",
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.black,
      );
    }
  }

  void addOrUpdateEducationItem({EducationModel? existingItem, int? index}) {
    final TextEditingController degreeTitleCtrl =
        TextEditingController(text: existingItem?.degreeTitle);
    final TextEditingController universityNameCtrl =
        TextEditingController(text: existingItem?.UniversityName);
    final TextEditingController startEndDateCtrl =
        TextEditingController(text: existingItem?.startAndEndDate);
    final TextEditingController logoImageUrlCtrl =
        TextEditingController(text: existingItem?.logoImageUrl);

    Get.dialog(
      AlertDialog(
        title: Text(existingItem == null ? 'Add Education' : 'Edit Education'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: degreeTitleCtrl,
                  decoration: const InputDecoration(labelText: 'Degree Title')),
              TextField(
                  controller: universityNameCtrl,
                  decoration:
                      const InputDecoration(labelText: 'University Name')),
              TextField(
                  controller: startEndDateCtrl,
                  decoration: const InputDecoration(
                      labelText: 'Start & End Date (e.g., 2020-2024)')),
              TextField(
                  controller: logoImageUrlCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Logo Image URL')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              if (degreeTitleCtrl.text.isNotEmpty &&
                  universityNameCtrl.text.isNotEmpty) {
                final newItem = EducationModel(
                  createdAt: existingItem?.createdAt ?? DateTime.now(),
                  degreeTitle: degreeTitleCtrl.text,
                  UniversityName: universityNameCtrl.text,
                  startAndEndDate: startEndDateCtrl.text,
                  logoImageUrl: logoImageUrlCtrl.text,
                );
                if (index != null && existingItem != null) {
                  educationItems[index] = newItem;
                } else {
                  educationItems.add(newItem);
                }
                Get.back();
              } else {
                Get.snackbar("Error",
                    "Degree Title and University Name cannot be empty.",
                    backgroundColor: Colors.red, colorText: Colors.white);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void removeEducationItem(int index) {
    if (index >= 0 && index < educationItems.length) {
      educationItems.removeAt(index);
    }
  }

  void saveChangesToDashboard() {
    if (_dashboardController.siteData.value == null) {
      Get.snackbar("Error", "Cannot save: Main site data is not loaded.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final updatedAboutModel = AboutModel(
      myImageUrl: myImageUrlController.text,
      aboutDescription: aboutDescriptionController.text,
      edudationList: List<EducationModel>.from(
          educationItems.map((e) => EducationModel.fromJson(e.toJson()))),
      headerTitle: headerTitleController.text,
      isEnabled: isEnabled.value,
    );

    _dashboardController.siteData.value!.about = updatedAboutModel;
    _dashboardController.siteData.refresh();

    Get.back();
    Get.snackbar("Success", "About section updated successfully!",
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  @override
  void onClose() {
    myImageUrlController.dispose();
    aboutDescriptionController.dispose();
    headerTitleController.dispose();
    super.onClose();
  }
}
