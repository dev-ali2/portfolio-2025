import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/admin_panel/screens/tech_section/tech_section_controller.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class TechSectionScreen extends StatelessWidget {
  TechSectionScreen({super.key});

  final TechSectionController controller = Get.put(TechSectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsHelper.secondaryCanvasColor,
      appBar: AppBar(
        title: Text('Edit Tech Stack Section',
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
              _buildTextField(controller.prependTextOnClickController,
                  'Prepend Text on Click'),
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
              Text('Tech Items',
                  style: FontsHelper.titleNameFont.copyWith(
                      color: ColorsHelper.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.techListItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.techListItems[index];
                      return Card(
                        color: ColorsHelper.canvasColor,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: (item.imageUrl != null &&
                                  item.imageUrl!.isNotEmpty &&
                                  Uri.tryParse(item.imageUrl!)
                                          ?.hasAbsolutePath ==
                                      true)
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(item.imageUrl!),
                                  backgroundColor:
                                      ColorsHelper.secondaryCanvasColor,
                                  onBackgroundImageError:
                                      (_, __) {}, // Handle broken image links
                                )
                              : CircleAvatar(
                                  backgroundColor:
                                      ColorsHelper.defaultPrimaryColor,
                                  child: Text(
                                      item.title.isNotEmpty
                                          ? item.title[0].toUpperCase()
                                          : 'T',
                                      style: FontsHelper.poppinsFont
                                          .copyWith(color: ColorsHelper.white)),
                                ),
                          title: Text(item.title,
                              style: FontsHelper.poppinsFont.copyWith(
                                  color: ColorsHelper.white,
                                  fontWeight: FontWeight.w600)),
                          subtitle: item.imageUrl != null &&
                                  item.imageUrl!.isNotEmpty
                              ? Text(item.imageUrl!,
                                  style: FontsHelper.poppinsFont.copyWith(
                                      color:
                                          ColorsHelper.white.withOpacity(0.7)),
                                  overflow: TextOverflow.ellipsis)
                              : null,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    color: ColorsHelper.defaultPrimaryColor),
                                onPressed: () => controller.addOrUpdateTechItem(
                                    existingItem: item, index: index),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.redAccent),
                                onPressed: () =>
                                    _confirmDeleteTechItem(context, index),
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
                  label: Text('Add Tech Item',
                      style: FontsHelper.poppinsFont
                          .copyWith(color: ColorsHelper.white)),
                  onPressed: () => controller.addOrUpdateTechItem(),
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
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: ColorsHelper.defaultPrimaryColor),
        ),
      ),
    );
  }

  void _confirmDeleteTechItem(BuildContext context, int index) {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this tech item?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              controller.removeTechItem(index);
              Get.back();
            },
            child:
                const Text('Delete', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}
