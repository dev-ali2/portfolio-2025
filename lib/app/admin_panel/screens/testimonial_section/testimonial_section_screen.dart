import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/admin_panel/screens/testimonial_section/testimonial_section_controller.dart';
import 'package:portfolio_2025/core/common/models/testimonial_model.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class TestimonialsSectionScreen extends StatelessWidget {
  TestimonialsSectionScreen({super.key});

  final TestimonialsSectionController controller =
      Get.put(TestimonialsSectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsHelper.secondaryCanvasColor,
      appBar: AppBar(
        title: Text('Edit Testimonials Section',
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
              Text('Testimonials',
                  style: FontsHelper.titleNameFont.copyWith(
                      color: ColorsHelper.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.testimonialListItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.testimonialListItems[index];
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
                                  radius: 25,
                                  backgroundImage: NetworkImage(item.imageUrl!),
                                  onBackgroundImageError: (_, __) {},
                                  backgroundColor:
                                      ColorsHelper.secondaryCanvasColor,
                                )
                              : CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      ColorsHelper.defaultPrimaryColor,
                                  child: Icon(Icons.person_pin_rounded,
                                      color: Colors.white),
                                ),
                          title: Text(item.name,
                              style: FontsHelper.poppinsFont.copyWith(
                                  color: ColorsHelper.white,
                                  fontWeight: FontWeight.w600)),
                          subtitle: Text(
                            '${item.position ?? ""}\n"${item.testimonial}"',
                            style: FontsHelper.poppinsFont.copyWith(
                                color: ColorsHelper.white.withOpacity(0.7)),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          isThreeLine: true,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit,
                                    color: ColorsHelper.defaultPrimaryColor),
                                onPressed: () =>
                                    controller.addOrUpdateTestimonial(
                                        existingItem: item, index: index),
                              ),
                              IconButton(
                                icon:
                                    Icon(Icons.delete, color: Colors.redAccent),
                                onPressed: () =>
                                    _confirmDeleteTestimonial(context, index),
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
                  label: Text('Add Testimonial',
                      style: FontsHelper.poppinsFont
                          .copyWith(color: ColorsHelper.white)),
                  onPressed: () => controller.addOrUpdateTestimonial(),
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

  void _confirmDeleteTestimonial(BuildContext context, int index) {
    Get.dialog(
      AlertDialog(
        backgroundColor: ColorsHelper.canvasColor,
        title: Text('Confirm Delete',
            style: FontsHelper.poppinsFont.copyWith(color: ColorsHelper.white)),
        content: Text('Are you sure you want to delete this testimonial?',
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
              controller.removeTestimonial(index);
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
