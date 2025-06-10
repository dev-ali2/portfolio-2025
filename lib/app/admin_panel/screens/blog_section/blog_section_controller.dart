import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/admin_panel/screens/dashboard/dashboard_controller.dart';
import 'package:portfolio_2025/core/common/models/blog_model.dart';

class BlogSectionController extends GetxController {
  final DashboardController _dashboardController =
      Get.find<DashboardController>();

  late TextEditingController headerTitleController;
  RxBool isEnabled = true.obs;
  RxList<BlogItem> blogListItems = <BlogItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeFields();
  }

  void _initializeFields() {
    BlogModel? currentBlog = _dashboardController.siteData.value?.blog;

    if (currentBlog != null) {
      headerTitleController =
          TextEditingController(text: currentBlog.headerTitle);
      isEnabled.value = currentBlog.isEnabled;
      blogListItems.assignAll(
        currentBlog.blogItems
                ?.map((item) => BlogItem.fromJson(item.toJson()))
                .toList() ??
            [],
      );
    } else {
      headerTitleController = TextEditingController(text: "My Blog");
      isEnabled.value = true;
      blogListItems.assignAll([]);
      Get.snackbar(
        "Notice",
        "No existing 'Blog' data found. Initializing with defaults.",
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.black,
      );
    }
  }

  void addOrUpdateBlogItem({BlogItem? existingItem, int? index}) {
    final descriptionCtrl =
        TextEditingController(text: existingItem?.description);
    final imageUrlCtrl = TextEditingController(text: existingItem?.imageUrl);
    final linkCtrl = TextEditingController(text: existingItem?.link);

    Get.dialog(
      AlertDialog(
        title: Text(existingItem == null ? 'Add Blog Item' : 'Edit Blog Item'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: descriptionCtrl,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3),
              TextField(
                  controller: imageUrlCtrl,
                  decoration: const InputDecoration(labelText: 'Image URL')),
              TextField(
                  controller: linkCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Blog Post Link')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              if (descriptionCtrl.text.isNotEmpty &&
                  imageUrlCtrl.text.isNotEmpty &&
                  linkCtrl.text.isNotEmpty) {
                final newItem = BlogItem(
                  createdAt: existingItem?.createdAt ?? DateTime.now(),
                  description: descriptionCtrl.text,
                  imageUrl: imageUrlCtrl.text,
                  link: linkCtrl.text,
                );

                if (index != null && existingItem != null) {
                  blogListItems[index] = newItem;
                } else {
                  blogListItems.insert(0, newItem);
                }
                Get.back();
              } else {
                Get.snackbar("Error",
                    "All fields (Description, Image URL, Link) are required.",
                    backgroundColor: Colors.red, colorText: Colors.white);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void removeBlogItem(int index) {
    if (index >= 0 && index < blogListItems.length) {
      blogListItems.removeAt(index);
    }
  }

  void saveChangesToDashboard() {
    if (_dashboardController.siteData.value == null) {
      Get.snackbar("Error", "Cannot save: Main site data is not loaded.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final updatedBlogModel = BlogModel(
      headerTitle: headerTitleController.text,
      isEnabled: isEnabled.value,
      blogItems: List<BlogItem>.from(
          blogListItems.map((item) => BlogItem.fromJson(item.toJson()))),
    );

    _dashboardController.siteData.value!.blog = updatedBlogModel;
    _dashboardController.siteData.refresh();

    Get.back();
    Get.snackbar("Success", "Blog section updated successfully!",
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  @override
  void onClose() {
    headerTitleController.dispose();
    super.onClose();
  }
}
