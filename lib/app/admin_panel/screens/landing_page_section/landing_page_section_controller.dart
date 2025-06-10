import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/admin_panel/screens/dashboard/dashboard_controller.dart';
import 'package:portfolio_2025/core/common/models/landing_page_model.dart';

class LandingPageSectionController extends GetxController {
  final DashboardController _dashboardController =
      Get.find<DashboardController>();

  late TextEditingController nameController;
  late TextEditingController shortDescriptionController;
  late TextEditingController bgImageUrlController;
  late TextEditingController yearsOfExperienceController;
  late TextEditingController projectsCompletedController;
  late TextEditingController openSourceContributionsController;

  RxBool showDescription = true.obs;
  RxBool showContactOptions = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeFields();
  }

  void _initializeFields() {
    LandingPageModel? currentLandingPage =
        _dashboardController.siteData.value?.landingPageModel;

    if (currentLandingPage != null) {
      nameController = TextEditingController(text: currentLandingPage.name);
      shortDescriptionController =
          TextEditingController(text: currentLandingPage.shortDescription);
      bgImageUrlController =
          TextEditingController(text: currentLandingPage.bgImageUrl);
      yearsOfExperienceController = TextEditingController(
          text: currentLandingPage.yearsOfExperience.toString());
      projectsCompletedController = TextEditingController(
          text: currentLandingPage.projectsCompleted.toString());
      openSourceContributionsController = TextEditingController(
          text: currentLandingPage.openSourceContributions.toString());
      showDescription.value = currentLandingPage.showDiscription;
      showContactOptions.value = currentLandingPage.showContactOptions;
    } else {
      nameController = TextEditingController();
      shortDescriptionController = TextEditingController();
      bgImageUrlController = TextEditingController();
      yearsOfExperienceController = TextEditingController(text: "0.0");
      projectsCompletedController = TextEditingController(text: "0");
      openSourceContributionsController = TextEditingController(text: "0");
      showDescription.value = true;
      showContactOptions.value = true;
      Get.snackbar(
          "Error", "Landing page data not found. Initializing with defaults.",
          backgroundColor: Colors.red);
    }
  }

  void saveChangesToDashboard() {
    if (_dashboardController.siteData.value == null) {
      Get.snackbar("Error", "Cannot save: Main site data is not loaded.",
          backgroundColor: Colors.red);
      return;
    }
    LandingPageModel? originalLandingPage =
        _dashboardController.siteData.value!.landingPageModel;
    if (originalLandingPage == null) {
      Get.snackbar("Error", "Original landing page data is missing.",
          backgroundColor: Colors.red);
      return;
    }

    double years = double.tryParse(yearsOfExperienceController.text) ??
        originalLandingPage.yearsOfExperience;
    int projects = int.tryParse(projectsCompletedController.text) ??
        originalLandingPage.projectsCompleted;
    int contributions = int.tryParse(openSourceContributionsController.text) ??
        originalLandingPage.openSourceContributions;

    final updatedLandingPageModel = LandingPageModel(
      topBarOptions: originalLandingPage.topBarOptions,
      name: nameController.text,
      shortDescription: shortDescriptionController.text,
      showDiscription: showDescription.value,
      bgImageUrl: bgImageUrlController.text,
      showContactOptions: showContactOptions.value,
      yearsOfExperience: years,
      projectsCompleted: projects,
      openSourceContributions: contributions,
    );

    _dashboardController.siteData.value!.landingPageModel =
        updatedLandingPageModel;
    _dashboardController.siteData.refresh();

    Get.back();
    Get.snackbar("Success", "Landing Page details updated successfully!",
        backgroundColor: Colors.green);
  }

  @override
  void onClose() {
    nameController.dispose();
    shortDescriptionController.dispose();
    bgImageUrlController.dispose();
    yearsOfExperienceController.dispose();
    projectsCompletedController.dispose();
    openSourceContributionsController.dispose();
    super.onClose();
  }
}
