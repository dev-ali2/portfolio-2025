import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/admin_panel/screens/about_section/about_section_screen.dart';
import 'package:portfolio_2025/app/admin_panel/screens/blog_section/blog_section_screen.dart';
import 'package:portfolio_2025/app/admin_panel/screens/contact_section/contact_section_screen.dart';
import 'package:portfolio_2025/app/admin_panel/screens/dashboard/dashboard_controller.dart';
import 'package:portfolio_2025/app/admin_panel/screens/featured_projects/featured_projects_section_screen.dart';
import 'package:portfolio_2025/app/admin_panel/screens/image_gallery/image_gallery_dialog.dart';
import 'package:portfolio_2025/app/admin_panel/screens/landing_page_section/landing_page_section_screen.dart';
import 'package:portfolio_2025/app/admin_panel/screens/tech_section/tech_section_screen.dart';
import 'package:portfolio_2025/app/admin_panel/screens/testimonial_section/testimonial_section_screen.dart';
import 'package:portfolio_2025/app/admin_panel/screens/work_experience_section/work_experience_screen.dart';
import 'package:portfolio_2025/app/splash_screen/presentation/screens/d_splash_screen.dart';
import 'package:portfolio_2025/core/common/models/top_bar_options_model.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final DashboardController controller = Get.put(DashboardController());

  void _showImageGalleryDialog(BuildContext context) {
    Get.dialog(
      ImageGalleryDialog(),
      barrierDismissible: true,
      useSafeArea: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.updateSiteData();
        },
        label: Text('Upload Changes',
            style: FontsHelper.poppinsFont.copyWith(color: Colors.white)),
        icon: const Icon(Icons.save, color: Colors.white),
        backgroundColor: ColorsHelper.defaultPrimaryColor,
      ),
      backgroundColor: ColorsHelper.secondaryCanvasColor,
      appBar: AppBar(
        backgroundColor: ColorsHelper.canvasColor,
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorsHelper.white),
          onPressed: () => Get.offAll(routeName: '/', () => const DSplashScreen()),
        ),
        title: Obx(() => Text(
              'Welcome, ${controller.userName.value}',
              style: FontsHelper.poppinsFont
                  .copyWith(color: ColorsHelper.white, fontSize: 18),
            )),
        actions: [
          Obx(() {
            if (controller.siteData.value == null &&
                !controller.isLoading.value) {
              return _buildLogoutButton();
            }
            if (controller.siteData.value != null) {
              return Row(
                children: [
                  Text("Site:",
                      style: FontsHelper.poppinsFont
                          .copyWith(color: ColorsHelper.white)),
                  Switch(
                    value: controller.siteData.value!.isSiteEnabled,
                    onChanged: controller.toggleSiteEnabled,
                    activeColor: ColorsHelper.defaultPrimaryColor,
                    inactiveThumbColor: Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text("Mouse:",
                      style: FontsHelper.poppinsFont
                          .copyWith(color: ColorsHelper.white)),
                  Switch(
                    value: controller.siteData.value!.followMousePosition,
                    onChanged: controller.toggleMouseFollow,
                    activeColor: ColorsHelper.defaultPrimaryColor,
                    inactiveThumbColor: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  _buildLogoutButton(),
                  const SizedBox(width: 8),
                ],
              );
            }
            return _buildLogoutButton();
          }),
        ],
        iconTheme: IconThemeData(color: ColorsHelper.white),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
                  color: ColorsHelper.defaultPrimaryColor));
        }
        if (controller.errorMessage.value.isNotEmpty &&
            controller.siteData.value == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Error loading dashboard data: ${controller.errorMessage.value}',
                style: FontsHelper.poppinsFont
                    .copyWith(color: Colors.redAccent, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        if (controller.siteData.value == null) {
          return Center(
            child: Text(
              'No site data available. ${controller.errorMessage.value}',
              style: FontsHelper.poppinsFont
                  .copyWith(color: ColorsHelper.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        }

        final landingPageModel = controller.siteData.value!.landingPageModel;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.errorMessage.value.isNotEmpty &&
                  controller.siteData.value != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    controller.errorMessage.value,
                    style: FontsHelper.poppinsFont
                        .copyWith(color: Colors.orangeAccent),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: _buildDashboardButton(
                      icon: Icons.web_asset,
                      label: 'Landing Page',
                      onPressed: () => Get.to(() => LandingPageSectionScreen()),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildDashboardButton(
                      icon: Icons.contact_mail,
                      label: 'Contact Section',
                      onPressed: () => Get.to(() => ContactSectionScreen()),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildDashboardButton(
                      icon: Icons.photo_library,
                      label: 'Image Gallery',
                      onPressed: () => _showImageGalleryDialog(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Manage Top Bar Navigation Options:',
                style: FontsHelper.titleNameFont.copyWith(
                    color: ColorsHelper.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: List.generate(landingPageModel.topBarOptions.length,
                    (index) {
                  TopBarOptionsModel option =
                      landingPageModel.topBarOptions[index];
                  return _buildOptionCard(context, option, index);
                }),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDashboardButton(
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: ColorsHelper.white, size: 20),
      label: Text(label,
          style: FontsHelper.poppinsFont
              .copyWith(color: ColorsHelper.white, fontSize: 13),
          textAlign: TextAlign.center),
      style: ElevatedButton.styleFrom(
          backgroundColor: ColorsHelper.defaultPrimaryColor.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: onPressed,
    );
  }

  Widget _buildLogoutButton() {
    return Obx(() {
      if (controller.isLoggingOut.value) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
                strokeWidth: 2, color: ColorsHelper.white),
          ),
        );
      }
      return IconButton(
        icon: Icon(Icons.logout, color: ColorsHelper.white),
        tooltip: 'Logout',
        onPressed: () {
          Get.defaultDialog(
            title: "Confirm Logout",
            middleText: "Are you sure you want to log out?",
            textConfirm: "Logout",
            textCancel: "Cancel",
            confirmTextColor: Colors.white,
            buttonColor: ColorsHelper.defaultPrimaryColor,
            cancelTextColor: ColorsHelper.defaultPrimaryColor,
            onConfirm: () {
              Get.back();
              controller.logoutUser();
            },
            backgroundColor: ColorsHelper.canvasColor,
            titleStyle:
                FontsHelper.poppinsFont.copyWith(color: ColorsHelper.white),
            middleTextStyle: FontsHelper.poppinsFont
                .copyWith(color: ColorsHelper.white.withOpacity(0.8)),
          );
        },
      );
    });
  }

  Widget _buildOptionCard(
      BuildContext context, TopBarOptionsModel option, int index) {
    const cardWidth = 280.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          String titleLower = option.title.toLowerCase();
          if (titleLower == "about") {
            Get.to(() => AboutSectionScreen());
          } else if (titleLower == "tech") {
            Get.to(() => TechSectionScreen());
          } else if (titleLower == "experience") {
            Get.to(() => WorkExperienceScreen());
          } else if (titleLower == "projects" ||
              titleLower == "featured work") {
            Get.to(() => FeaturedProjectsScreen());
          } else if (titleLower == "blog") {
            Get.to(() => BlogSectionScreen());
          } else if (titleLower == "testimonials" ||
              titleLower == "endorsements" ||
              titleLower == "reviews" ||
              titleLower == "feedbacks" ||
              titleLower == "client testimonials" ||
              titleLower == "client reviews") {
            Get.to(() => TestimonialsSectionScreen());
          } else {
            Get.snackbar("Navigation",
                "Management for '${option.title}' is not yet implemented.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: ColorsHelper.defaultPrimaryColor,
                colorText: ColorsHelper.white);
          }
        },
        child: Container(
          width: cardWidth,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: ColorsHelper.canvasColor,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                      IconData(option.icon?.codePoint ?? Icons.error.codePoint,
                          fontFamily: 'MaterialIcons'),
                      color: ColorsHelper.defaultPrimaryColor,
                      size: 24),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      option.title,
                      style: FontsHelper.poppinsFont.copyWith(
                          color: ColorsHelper.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enabled:',
                    style: FontsHelper.poppinsFont.copyWith(
                        color: ColorsHelper.white.withOpacity(0.8),
                        fontSize: 14),
                  ),
                  Switch(
                    value: option.isEnabled,
                    onChanged: (bool value) {
                      controller.toggleTopBarOptionEnabled(index, value);
                    },
                    activeColor: ColorsHelper.defaultPrimaryColor,
                    inactiveThumbColor: Colors.grey[600],
                    activeTrackColor:
                        ColorsHelper.defaultPrimaryColor.withOpacity(0.5),
                    inactiveTrackColor: Colors.grey.withOpacity(0.5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
