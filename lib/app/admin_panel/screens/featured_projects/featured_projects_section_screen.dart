import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/admin_panel/screens/featured_projects/featured_projects_section_controller.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class FeaturedProjectsScreen extends StatelessWidget {
  FeaturedProjectsScreen({super.key});

  final FeaturedProjectsSectionController controller =
      Get.put(FeaturedProjectsSectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsHelper.secondaryCanvasColor,
      appBar: AppBar(
        title: Text('Edit Featured Projects',
            style: FontsHelper.poppinsFont.copyWith(color: ColorsHelper.white)),
        backgroundColor: ColorsHelper.canvasColor,
        iconTheme: IconThemeData(color: ColorsHelper.white),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.saveChangesToDashboard,
        label: Text('Done',
            style: FontsHelper.poppinsFont.copyWith(color: Colors.white)),
        icon: const Icon(Icons.save, color: Colors.white),
        backgroundColor: ColorsHelper.defaultPrimaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(controller.headerTitleController, 'Header Title'),
              const SizedBox(height: 16),
              Obx(() => SwitchListTile(
                    title: Text('Section Enabled',
                        style: FontsHelper.poppinsFont
                            .copyWith(color: ColorsHelper.white)),
                    value: controller.isEnabled.value,
                    onChanged: (bool value) =>
                        controller.isEnabled.value = value,
                    activeColor: ColorsHelper.defaultPrimaryColor,
                    tileColor: ColorsHelper.canvasColor.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  )),
              const SizedBox(height: 24),
              Text('Projects',
                  style: FontsHelper.titleNameFont.copyWith(
                      color: ColorsHelper.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.featuredProjectItems.length,
                    itemBuilder: (context, index) {
                      final project = controller.featuredProjectItems[index];
                      return Card(
                        color: ColorsHelper.canvasColor,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: (project.projectImageUrl.isNotEmpty &&
                                  Uri.tryParse(project.projectImageUrl)
                                          ?.hasAbsolutePath ==
                                      true)
                              ? SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image.network(project.projectImageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (c, e, s) => Icon(
                                          Icons.broken_image,
                                          color: ColorsHelper
                                              .defaultPrimaryColor)),
                                )
                              : CircleAvatar(
                                  backgroundColor:
                                      ColorsHelper.defaultPrimaryColor,
                                  child:
                                      Icon(Icons.article, color: Colors.white)),
                          title: Text(project.projectName,
                              style: FontsHelper.poppinsFont.copyWith(
                                  color: ColorsHelper.white,
                                  fontWeight: FontWeight.w600)),
                          subtitle: Text(
                            '${project.type} - ${project.shortDescription}',
                            style: FontsHelper.poppinsFont.copyWith(
                                color: ColorsHelper.white.withOpacity(0.7)),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit,
                                    color: ColorsHelper.defaultPrimaryColor),
                                onPressed: () =>
                                    controller.addOrUpdateFeaturedProject(
                                        existingItem: project, index: index),
                              ),
                              IconButton(
                                icon:
                                    Icon(Icons.delete, color: Colors.redAccent),
                                onPressed: () =>
                                    _confirmDeleteProject(context, index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsHelper.defaultPrimaryColor),
                  icon: Icon(Icons.add, color: ColorsHelper.white),
                  label: Text('Add Project',
                      style: FontsHelper.poppinsFont
                          .copyWith(color: ColorsHelper.white)),
                  onPressed: () => controller.addOrUpdateFeaturedProject(),
                ),
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: FontsHelper.poppinsFont.copyWith(color: ColorsHelper.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: FontsHelper.poppinsFont
            .copyWith(color: ColorsHelper.white.withOpacity(0.7)),
        filled: true,
        fillColor: ColorsHelper.canvasColor.withOpacity(0.5),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: ColorsHelper.defaultPrimaryColor)),
      ),
    );
  }

  void _confirmDeleteProject(BuildContext context, int index) {
    Get.dialog(
      AlertDialog(
        backgroundColor: ColorsHelper.canvasColor,
        title: Text('Confirm Delete',
            style: FontsHelper.poppinsFont.copyWith(color: ColorsHelper.white)),
        content: Text('Are you sure you want to delete this project?',
            style: FontsHelper.poppinsFont
                .copyWith(color: ColorsHelper.white.withOpacity(0.8))),
        actions: [
          TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel',
                  style: FontsHelper.poppinsFont
                      .copyWith(color: ColorsHelper.defaultPrimaryColor))),
          TextButton(
            onPressed: () {
              controller.removeFeaturedProjectItem(index);
              Get.back();
            },
            child: Text('Delete',
                style:
                    FontsHelper.poppinsFont.copyWith(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}
