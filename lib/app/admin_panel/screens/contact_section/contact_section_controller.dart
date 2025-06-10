import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/admin_panel/screens/dashboard/dashboard_controller.dart';
import 'package:portfolio_2025/core/common/models/contact_section_model.dart';

class ContactSectionController extends GetxController {
  final DashboardController _dashboardController =
      Get.find<DashboardController>();

  late TextEditingController callToActionController;
  late TextEditingController githubLinkController;
  late TextEditingController linkedinLinkController;
  late TextEditingController emailAddressController;
  late TextEditingController twitterLinkController;
  late TextEditingController instagramLinkController;
  late TextEditingController facebookLinkController;
  late TextEditingController whatsappNumberController;
  late TextEditingController resumeLinkController;
  late TextEditingController footerLineController;

  RxBool isEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeFields();
  }

  void _initializeFields() {
    ContactSectionModel? currentContact =
        _dashboardController.siteData.value?.contactSection;

    if (currentContact != null) {
      callToActionController =
          TextEditingController(text: currentContact.callToActionLine);
      githubLinkController =
          TextEditingController(text: currentContact.githubLink);
      linkedinLinkController =
          TextEditingController(text: currentContact.linkedinLink);
      emailAddressController =
          TextEditingController(text: _extractEmail(currentContact.emailLink));
      twitterLinkController =
          TextEditingController(text: currentContact.twitterLink);
      instagramLinkController =
          TextEditingController(text: currentContact.instagramLink);
      facebookLinkController =
          TextEditingController(text: currentContact.facebookLink);
      whatsappNumberController = TextEditingController(
          text: _extractWhatsAppNumber(currentContact.whatsappLink));
      resumeLinkController =
          TextEditingController(text: currentContact.downloadResumeLink);
      footerLineController =
          TextEditingController(text: currentContact.footerLine);
      isEnabled.value = currentContact.isEnabled;
    } else {
      callToActionController = TextEditingController();
      githubLinkController = TextEditingController();
      linkedinLinkController = TextEditingController();
      emailAddressController = TextEditingController();
      twitterLinkController = TextEditingController();
      instagramLinkController = TextEditingController();
      facebookLinkController = TextEditingController();
      whatsappNumberController = TextEditingController();
      resumeLinkController = TextEditingController();
      footerLineController = TextEditingController();
      isEnabled.value = true;
      Get.snackbar(
          "Error", "Contact section data not found. Initializing defaults.",
          backgroundColor: Colors.red);
    }
  }

  String _extractEmail(String? mailtoLink) {
    if (mailtoLink != null && mailtoLink.startsWith('mailto:')) {
      return mailtoLink.substring('mailto:'.length);
    }
    return mailtoLink ?? '';
  }

  String _extractWhatsAppNumber(String? waLink) {
    if (waLink != null && waLink.startsWith('https://wa.me/')) {
      return waLink.substring('https://wa.me/'.length);
    }
    return waLink ?? '';
  }

  void saveChangesToDashboard() {
    if (_dashboardController.siteData.value == null) {
      Get.snackbar("Error", "Cannot save: Main site data is not loaded.",
          backgroundColor: Colors.red);
      return;
    }

    String? finalEmailLink;
    if (emailAddressController.text.isNotEmpty) {
      finalEmailLink = emailAddressController.text.startsWith('mailto:')
          ? emailAddressController.text
          : 'mailto:${emailAddressController.text}';
    }

    String? finalWhatsAppLink;
    if (whatsappNumberController.text.isNotEmpty) {
      final cleanNumber =
          whatsappNumberController.text.replaceAll(RegExp(r'[^0-9]'), '');
      if (cleanNumber.isNotEmpty) {
        finalWhatsAppLink = 'https://wa.me/$cleanNumber';
      }
    }

    final updatedContactModel = ContactSectionModel(
      isEnabled: isEnabled.value,
      callToActionLine: callToActionController.text,
      githubLink: githubLinkController.text.isNotEmpty
          ? githubLinkController.text
          : null,
      linkedinLink: linkedinLinkController.text.isNotEmpty
          ? linkedinLinkController.text
          : null,
      emailLink: finalEmailLink,
      twitterLink: twitterLinkController.text.isNotEmpty
          ? twitterLinkController.text
          : null,
      instagramLink: instagramLinkController.text.isNotEmpty
          ? instagramLinkController.text
          : null,
      facebookLink: facebookLinkController.text.isNotEmpty
          ? facebookLinkController.text
          : null,
      whatsappLink: finalWhatsAppLink,
      downloadResumeLink: resumeLinkController.text.isNotEmpty
          ? resumeLinkController.text
          : null,
      footerLine: footerLineController.text,
    );

    _dashboardController.siteData.value!.contactSection = updatedContactModel;
    _dashboardController.siteData.refresh();

    Get.back();
    Get.snackbar("Success", "Contact section updated successfully!",
        backgroundColor: Colors.green);
  }

  @override
  void onClose() {
    callToActionController.dispose();
    githubLinkController.dispose();
    linkedinLinkController.dispose();
    emailAddressController.dispose();
    twitterLinkController.dispose();
    instagramLinkController.dispose();
    facebookLinkController.dispose();
    whatsappNumberController.dispose();
    resumeLinkController.dispose();
    footerLineController.dispose();
    super.onClose();
  }
}
