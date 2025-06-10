import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/admin_panel/screens/landing_page_section/landing_page_section_controller.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class LandingPageSectionScreen extends StatelessWidget {
  LandingPageSectionScreen({super.key});

  final LandingPageSectionController controller =
      Get.put(LandingPageSectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsHelper.secondaryCanvasColor,
      appBar: AppBar(
        title: Text('Edit Landing Page Details',
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
              _buildTextField(controller.nameController, 'Your Name'),
              const SizedBox(height: 16),
              _buildTextField(controller.shortDescriptionController,
                  'Short Description / Tagline',
                  maxLines: 2),
              const SizedBox(height: 16),
              _buildTextField(
                  controller.bgImageUrlController, 'Background Image URL'),
              const SizedBox(height: 16),
              _buildTextField(
                  controller.yearsOfExperienceController, 'Years of Experience',
                  keyboardType: TextInputType.numberWithOptions(decimal: true)),
              const SizedBox(height: 16),
              _buildTextField(
                  controller.projectsCompletedController, 'Projects Completed',
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildTextField(controller.openSourceContributionsController,
                  'Open Source Contributions',
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              Obx(() => SwitchListTile(
                    title: Text('Show Description on Landing Page',
                        style: FontsHelper.poppinsFont
                            .copyWith(color: ColorsHelper.white)),
                    value: controller.showDescription.value,
                    onChanged: (bool value) =>
                        controller.showDescription.value = value,
                    activeColor: ColorsHelper.defaultPrimaryColor,
                    tileColor: ColorsHelper.canvasColor.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  )),
              const SizedBox(height: 10),
              Obx(() => SwitchListTile(
                    title: Text('Show Contact Options on Landing Page',
                        style: FontsHelper.poppinsFont
                            .copyWith(color: ColorsHelper.white)),
                    value: controller.showContactOptions.value,
                    onChanged: (bool value) =>
                        controller.showContactOptions.value = value,
                    activeColor: ColorsHelper.defaultPrimaryColor,
                    tileColor: ColorsHelper.canvasColor.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  )),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1, TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
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
}
