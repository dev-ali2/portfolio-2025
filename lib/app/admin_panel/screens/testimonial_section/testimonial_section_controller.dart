import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/admin_panel/screens/dashboard/dashboard_controller.dart';
import 'package:portfolio_2025/core/common/models/testimonial_model.dart';

class TestimonialsSectionController extends GetxController {
  final DashboardController _dashboardController =
      Get.find<DashboardController>();

  late TextEditingController headerTitleController;
  RxBool isEnabled = true.obs;
  RxList<TestimonialData> testimonialListItems = <TestimonialData>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeFields();
  }

  void _initializeFields() {
    TestimonialModel? currentTestimonials =
        _dashboardController.siteData.value?.testimonial;

    if (currentTestimonials != null) {
      headerTitleController =
          TextEditingController(text: currentTestimonials.headerTitle);
      isEnabled.value = currentTestimonials.isEnabled;
      testimonialListItems.assignAll(
        currentTestimonials.testimonials
            .map((item) => TestimonialData.fromJson(item.toJson()))
            .toList(),
      );
    } else {
      headerTitleController = TextEditingController(text: "Testimonials");
      isEnabled.value = true;
      testimonialListItems.assignAll([]);
      Get.snackbar(
        "Notice",
        "No existing 'Testimonials' data found. Initializing with defaults.",
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.black,
      );
    }
  }

  void addOrUpdateTestimonial({TestimonialData? existingItem, int? index}) {
    final nameCtrl = TextEditingController(text: existingItem?.name);
    final positionCtrl = TextEditingController(text: existingItem?.position);
    final imageUrlCtrl = TextEditingController(text: existingItem?.imageUrl);
    final testimonialCtrl =
        TextEditingController(text: existingItem?.testimonial);

    Get.dialog(
      AlertDialog(
        title:
            Text(existingItem == null ? 'Add Testimonial' : 'Edit Testimonial'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Name')),
              TextField(
                  controller: positionCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Position (Optional)')),
              TextField(
                  controller: imageUrlCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Image URL (Optional)')),
              TextField(
                  controller: testimonialCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Testimonial Text'),
                  maxLines: 4),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              if (nameCtrl.text.isNotEmpty && testimonialCtrl.text.isNotEmpty) {
                final newItem = TestimonialData(
                  name: nameCtrl.text,
                  position:
                      positionCtrl.text.isNotEmpty ? positionCtrl.text : null,
                  imageUrl:
                      imageUrlCtrl.text.isNotEmpty ? imageUrlCtrl.text : null,
                  testimonial: testimonialCtrl.text,
                );

                if (index != null && existingItem != null) {
                  testimonialListItems[index] = newItem;
                } else {
                  testimonialListItems.insert(0, newItem);
                }
                Get.back();
              } else {
                Get.snackbar("Error", "Name and Testimonial text are required.",
                    backgroundColor: Colors.red, colorText: Colors.white);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void removeTestimonial(int index) {
    if (index >= 0 && index < testimonialListItems.length) {
      testimonialListItems.removeAt(index);
    }
  }

  void saveChangesToDashboard() {
    if (_dashboardController.siteData.value == null) {
      Get.snackbar("Error", "Cannot save: Main site data is not loaded.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final updatedTestimonialModel = TestimonialModel(
      headerTitle: headerTitleController.text,
      isEnabled: isEnabled.value,
      testimonials: List<TestimonialData>.from(testimonialListItems
          .map((item) => TestimonialData.fromJson(item.toJson()))),
    );

    _dashboardController.siteData.value!.testimonial = updatedTestimonialModel;
    _dashboardController.siteData.refresh();

    Get.back();
    Get.snackbar("Success", "Testimonials section updated successfully!",
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  @override
  void onClose() {
    headerTitleController.dispose();
    super.onClose();
  }
}
