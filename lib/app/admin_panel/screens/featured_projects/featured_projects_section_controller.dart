import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/admin_panel/screens/dashboard/dashboard_controller.dart';
import 'package:portfolio_2025/core/common/models/featured_work_model.dart';

class FeaturedProjectsSectionController extends GetxController {
  final DashboardController _dashboardController =
      Get.find<DashboardController>();

  late TextEditingController headerTitleController;
  RxBool isEnabled = true.obs;
  RxList<FeaturedProjectModel> featuredProjectItems =
      <FeaturedProjectModel>[].obs;

  RxList<AvailablePlatformModel> currentEditingPlatforms =
      <AvailablePlatformModel>[].obs;
  RxList<String> currentEditingTechnologies = <String>[].obs;
  RxList<AvailableOnModel> currentEditingAvailableOn = <AvailableOnModel>[].obs;

  final List<AvailablePlatformModel> _recommendedPlatforms = [
    AvailablePlatformModel(
        platformName: "Android", platformIcon: Icons.android),
    AvailablePlatformModel(
        platformName: "Apple iOS", platformIcon: Icons.apple),
    AvailablePlatformModel(platformName: "Web", platformIcon: Icons.web),
    AvailablePlatformModel(platformName: "Windows", platformIcon: Icons.window),
    AvailablePlatformModel(
        platformName: "MacOS", platformIcon: Icons.laptop_mac),
    AvailablePlatformModel(platformName: "Linux", platformIcon: Icons.shield),
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeFields();
  }

  void _initializeFields() {
    FeaturedWorkModel? currentFeaturedWork =
        _dashboardController.siteData.value?.featuredWork;

    if (currentFeaturedWork != null) {
      headerTitleController =
          TextEditingController(text: currentFeaturedWork.headerTitle);
      isEnabled.value = currentFeaturedWork.isEnabled;
      featuredProjectItems.assignAll(
        currentFeaturedWork.featuredProjects
                ?.map((item) => FeaturedProjectModel.fromJson(item.toJson()))
                .toList() ??
            [],
      );
    } else {
      headerTitleController = TextEditingController(text: "Featured Projects");
      isEnabled.value = true;
      featuredProjectItems.assignAll([]);
      Get.snackbar(
        "Notice",
        "No existing 'Featured Projects' data found. Initializing with defaults.",
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.black,
      );
    }
  }

  void addOrUpdateFeaturedProject(
      {FeaturedProjectModel? existingItem, int? index}) {
    final projectNameCtrl =
        TextEditingController(text: existingItem?.projectName);
    final projectImageUrlCtrl =
        TextEditingController(text: existingItem?.projectImageUrl);
    final shortDescriptionCtrl =
        TextEditingController(text: existingItem?.shortDescription);
    final longDescriptionCtrl =
        TextEditingController(text: existingItem?.longDescription);
    final typeCtrl = TextEditingController(text: existingItem?.type);

    currentEditingPlatforms.assignAll(existingItem?.platforms
            .map((e) => AvailablePlatformModel.fromJson(e.toJson()))
            .toList() ??
        []);
    currentEditingTechnologies
        .assignAll(List<String>.from(existingItem?.technologies ?? []));
    currentEditingAvailableOn.assignAll(existingItem?.availableOn
            ?.map((e) => AvailableOnModel.fromJson(e.toJson()))
            .toList() ??
        []);

    Get.dialog(
      AlertDialog(
        title: Text(existingItem == null
            ? 'Add Featured Project'
            : 'Edit Featured Project'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                  controller: projectNameCtrl,
                  decoration: const InputDecoration(labelText: 'Project Name')),
              TextField(
                  controller: projectImageUrlCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Project Image URL')),
              TextField(
                  controller: shortDescriptionCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Short Description'),
                  maxLines: 2),
              TextField(
                  controller: longDescriptionCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Long Description'),
                  maxLines: 4),
              TextField(
                  controller: typeCtrl,
                  decoration: const InputDecoration(
                      labelText: 'Type (e.g., Open Source)')),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: _manageTechnologiesDialog,
                  child: const Text("Manage Technologies")),
              const SizedBox(height: 5),
              ElevatedButton(
                  onPressed: _managePlatformsDialog,
                  child: const Text("Manage Platforms")),
              const SizedBox(height: 5),
              ElevatedButton(
                  onPressed: _manageAvailableOnDialog,
                  child: const Text("Manage Availability")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              if (projectNameCtrl.text.isNotEmpty &&
                  projectImageUrlCtrl.text.isNotEmpty &&
                  shortDescriptionCtrl.text.isNotEmpty) {
                final newItem = FeaturedProjectModel(
                  createdAt: existingItem?.createdAt ?? DateTime.now(),
                  projectName: projectNameCtrl.text,
                  projectImageUrl: projectImageUrlCtrl.text,
                  shortDescription: shortDescriptionCtrl.text,
                  longDescription: longDescriptionCtrl.text,
                  type: typeCtrl.text,
                  platforms: List<AvailablePlatformModel>.from(
                      currentEditingPlatforms.map(
                          (e) => AvailablePlatformModel.fromJson(e.toJson()))),
                  technologies: List<String>.from(currentEditingTechnologies),
                  availableOn: List<AvailableOnModel>.from(
                      currentEditingAvailableOn
                          .map((e) => AvailableOnModel.fromJson(e.toJson()))),
                );

                if (index != null && existingItem != null) {
                  featuredProjectItems[index] = newItem;
                } else {
                  featuredProjectItems.insert(0, newItem);
                }
                Get.back();
              } else {
                Get.snackbar("Error",
                    "Project Name, Image URL, and Short Description are required.",
                    backgroundColor: Colors.red, colorText: Colors.white);
              }
            },
            child: const Text('Save Project'),
          ),
        ],
      ),
    );
  }

  void _manageTechnologiesDialog() {
    final techInputController =
        TextEditingController(text: currentEditingTechnologies.join(', '));
    Get.dialog(
      AlertDialog(
        title: const Text('Manage Technologies'),
        content: TextField(
          controller: techInputController,
          decoration: const InputDecoration(
              labelText: 'Technologies (comma-separated)'),
          maxLines: 2,
        ),
        actions: [
          TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              currentEditingTechnologies.assignAll(techInputController.text
                  .split(',')
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList());
              Get.back(result: true);
            },
            child: const Text('Save Technologies'),
          ),
        ],
      ),
    );
  }

  void _managePlatformsDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Select Platforms'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _recommendedPlatforms.length,
            itemBuilder: (context, idx) {
              final recommendedPlatform = _recommendedPlatforms[idx];
              return Obx(() {
                final bool isSelected = currentEditingPlatforms.any(
                    (p) => p.platformName == recommendedPlatform.platformName);
                return CheckboxListTile(
                  title: Text(recommendedPlatform.platformName),
                  secondary: Icon(recommendedPlatform.platformIcon,
                      color: isSelected ? Get.theme.primaryColor : Colors.grey),
                  value: isSelected,
                  onChanged: (bool? selected) {
                    if (selected == true) {
                      if (!currentEditingPlatforms.any((p) =>
                          p.platformName == recommendedPlatform.platformName)) {
                        currentEditingPlatforms.add(AvailablePlatformModel(
                          platformName: recommendedPlatform.platformName,
                          platformIcon: recommendedPlatform.platformIcon,
                        ));
                      }
                    } else {
                      currentEditingPlatforms.removeWhere((p) =>
                          p.platformName == recommendedPlatform.platformName);
                    }
                  },
                );
              });
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Done')),
        ],
      ),
    );
  }

  void _manageAvailableOnDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Manage Availability'),
        content: SizedBox(
          width: double.maxFinite,
          child: Obx(() => ListView.builder(
                shrinkWrap: true,
                itemCount: currentEditingAvailableOn.length + 1,
                itemBuilder: (context, idx) {
                  if (idx == currentEditingAvailableOn.length) {
                    return ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text("Add Availability"),
                      onPressed: () => _addOrEditAvailableOnDialog(),
                    );
                  }
                  final item = currentEditingAvailableOn[idx];
                  return ListTile(
                    title: Text(item.name),
                    subtitle:
                        Text(item.imageURl, overflow: TextOverflow.ellipsis),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => currentEditingAvailableOn.removeAt(idx),
                    ),
                    onTap: () => _addOrEditAvailableOnDialog(
                        existingAvailableOn: item, index: idx),
                  );
                },
              )),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Done')),
        ],
      ),
    );
  }

  void _addOrEditAvailableOnDialog(
      {AvailableOnModel? existingAvailableOn, int? index}) {
    final nameCtrl = TextEditingController(text: existingAvailableOn?.name);
    final imageUrlCtrl =
        TextEditingController(text: existingAvailableOn?.imageURl);
    final linkCtrl = TextEditingController(text: existingAvailableOn?.link);

    Get.dialog(
      AlertDialog(
        title: Text(existingAvailableOn == null
            ? 'Add Availability'
            : 'Edit Availability'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                    labelText: 'Name (e.g., GitHub, Play Store)')),
            TextField(
                controller: imageUrlCtrl,
                decoration: const InputDecoration(labelText: 'Image URL')),
            TextField(
                controller: linkCtrl,
                decoration:
                    const InputDecoration(labelText: 'Link (Optional)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              if (nameCtrl.text.isNotEmpty && imageUrlCtrl.text.isNotEmpty) {
                final newItem = AvailableOnModel(
                  name: nameCtrl.text,
                  imageURl: imageUrlCtrl.text,
                  link: linkCtrl.text.isNotEmpty ? linkCtrl.text : null,
                );
                if (index != null) {
                  currentEditingAvailableOn[index] = newItem;
                } else {
                  currentEditingAvailableOn.add(newItem);
                }
                Get.back();
              } else {
                Get.snackbar("Error", "Name and Image URL are required.",
                    backgroundColor: Colors.red);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void removeFeaturedProjectItem(int index) {
    if (index >= 0 && index < featuredProjectItems.length) {
      featuredProjectItems.removeAt(index);
    }
  }

  void saveChangesToDashboard() {
    if (_dashboardController.siteData.value == null) {
      Get.snackbar("Error", "Cannot save: Main site data is not loaded.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final updatedModel = FeaturedWorkModel(
      headerTitle: headerTitleController.text,
      isEnabled: isEnabled.value,
      featuredProjects: List<FeaturedProjectModel>.from(featuredProjectItems
          .map((item) => FeaturedProjectModel.fromJson(item.toJson()))),
    );

    _dashboardController.siteData.value!.featuredWork = updatedModel;
    _dashboardController.siteData.refresh();
    log('New data model : ${_dashboardController.siteData.value?.toJson()}');

    Get.back();
    Get.snackbar("Success", "Featured Projects section updated successfully!",
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  @override
  void onClose() {
    headerTitleController.dispose();
    super.onClose();
  }
}
