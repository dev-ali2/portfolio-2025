import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/admin_panel/screens/contact_section/contact_section_controller.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class ContactSectionScreen extends StatelessWidget {
  ContactSectionScreen({super.key});

  final ContactSectionController controller =
      Get.put(ContactSectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsHelper.secondaryCanvasColor,
      appBar: AppBar(
        title: Text('Edit Contact Section',
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
              _buildTextField(
                  controller.callToActionController, 'Call to Action Line',
                  maxLines: 2),
              const SizedBox(height: 16),
              _buildTextField(controller.emailAddressController,
                  'Email Address (e.g., abc@example.com)'),
              const SizedBox(height: 16),
              _buildTextField(controller.whatsappNumberController,
                  'WhatsApp Number (e.g., 923001234567)',
                  keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
              _buildTextField(controller.githubLinkController,
                  'GitHub Profile URL (Optional)'),
              const SizedBox(height: 16),
              _buildTextField(controller.linkedinLinkController,
                  'LinkedIn Profile URL (Optional)'),
              const SizedBox(height: 16),
              _buildTextField(controller.twitterLinkController,
                  'Twitter Profile URL (Optional)'),
              const SizedBox(height: 16),
              _buildTextField(controller.instagramLinkController,
                  'Instagram Profile URL (Optional)'),
              const SizedBox(height: 16),
              _buildTextField(controller.facebookLinkController,
                  'Facebook Profile URL (Optional)'),
              const SizedBox(height: 16),
              _buildTextField(controller.resumeLinkController,
                  'Download Resume URL (Optional)'),
              const SizedBox(height: 16),
              _buildTextField(controller.footerLineController, 'Footer Line',
                  maxLines: 2),
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
