import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/admin_panel/screens/dashboard/dashboard_controller.dart';
import 'package:portfolio_2025/core/common/models/tech_stack_model.dart';

class TechSectionController extends GetxController {
  final DashboardController _dashboardController =
      Get.find<DashboardController>();

  late TextEditingController headerTitleController;
  late TextEditingController prependTextOnClickController;
  RxBool isEnabled = true.obs;
  RxList<TechListItem> techListItems = <TechListItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeFields();
  }

  void _initializeFields() {
    TechStackModel? currentTechStack =
        _dashboardController.siteData.value?.tech;

    if (currentTechStack != null) {
      headerTitleController =
          TextEditingController(text: currentTechStack.headerTitle);
      prependTextOnClickController =
          TextEditingController(text: currentTechStack.prependTextOnClick);
      isEnabled.value = currentTechStack.isEnabled;
      techListItems.assignAll(currentTechStack.techList
          .map((item) => TechListItem.fromJson(item.toJson()))
          .toList());
    } else {
      headerTitleController = TextEditingController(text: "Tech Stack");
      prependTextOnClickController = TextEditingController(text: "What is ");
      isEnabled.value = true;
      techListItems.assignAll([]);
      Get.snackbar(
        "Notice",
        "No existing 'Tech Stack' data found. Initializing with defaults.",
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.black,
      );
    }
  }

  void addOrUpdateTechItem({TechListItem? existingItem, int? index}) {
    final TextEditingController titleCtrl =
        TextEditingController(text: existingItem?.title);
    final TextEditingController imageUrlCtrl =
        TextEditingController(text: existingItem?.imageUrl);

    Get.dialog(
      AlertDialog(
        backgroundColor: Get.theme.dialogBackgroundColor,
        title: Text(existingItem == null ? 'Add Tech Item' : 'Edit Tech Item',
            style: Get.textTheme.titleLarge),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: 'Title')),
              TextField(
                  controller: imageUrlCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Image URL (Optional)')),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel',
                  style: TextStyle(color: Get.theme.colorScheme.secondary))),
          TextButton(
            onPressed: () {
              if (titleCtrl.text.isNotEmpty) {
                final newItem = TechListItem(
                  title: titleCtrl.text,
                  imageUrl:
                      imageUrlCtrl.text.isNotEmpty ? imageUrlCtrl.text : null,
                );
                if (index != null && existingItem != null) {
                  techListItems[index] = newItem;
                } else {
                  techListItems.insert(0, newItem);
                }
                Get.back();
              } else {
                Get.snackbar("Error", "Title cannot be empty.",
                    backgroundColor: Colors.red, colorText: Colors.white);
              }
            },
            child: Text('Save',
                style: TextStyle(color: Get.theme.colorScheme.primary)),
          ),
        ],
      ),
    );
  }

  void removeTechItem(int index) {
    if (index >= 0 && index < techListItems.length) {
      techListItems.removeAt(index);
    }
  }

  void saveChangesToDashboard() {
    if (_dashboardController.siteData.value == null) {
      Get.snackbar("Error", "Cannot save: Main site data is not loaded.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final updatedTechStackModel = TechStackModel(
      headerTitle: headerTitleController.text,
      prependTextOnClick: prependTextOnClickController.text,
      isEnabled: isEnabled.value,
      techList: List<TechListItem>.from(
          techListItems.map((item) => TechListItem.fromJson(item.toJson()))),
    );

    _dashboardController.siteData.value!.tech = updatedTechStackModel;
    _dashboardController.siteData.refresh();

    Get.back();
    Get.snackbar("Success", "Tech Stack section updated successfully!",
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  @override
  void onClose() {
    headerTitleController.dispose();
    prependTextOnClickController.dispose();
    super.onClose();
  }
}
