import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/admin_panel/screens/image_gallery/image_gallery_controller.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class ImageGalleryDialog extends StatelessWidget {
  ImageGalleryDialog({super.key});

  final ImageGalleryController controller = Get.put(ImageGalleryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsHelper.secondaryCanvasColor.withOpacity(0.98),
      appBar: AppBar(
        title: Text('Appwrite Image Gallery',
            style: FontsHelper.poppinsFont.copyWith(color: ColorsHelper.white)),
        backgroundColor: ColorsHelper.canvasColor,
        iconTheme: IconThemeData(color: ColorsHelper.white),
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: "Refresh Images",
            onPressed: () => controller.fetchImages(),
          )
        ],
      ),
      floatingActionButton: Obx(() => FloatingActionButton.extended(
            onPressed: controller.isUploading.value
                ? null
                : controller.pickAndUploadImage,
            label: controller.isUploading.value
                ? Text('Uploading...',
                    style:
                        FontsHelper.poppinsFont.copyWith(color: Colors.white))
                : Text('Upload Image',
                    style:
                        FontsHelper.poppinsFont.copyWith(color: Colors.white)),
            icon: controller.isUploading.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white))
                : const Icon(Icons.add_photo_alternate, color: Colors.white),
            backgroundColor: controller.isUploading.value
                ? Colors.grey
                : ColorsHelper.defaultPrimaryColor,
          )),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
                  color: ColorsHelper.defaultPrimaryColor));
        }
        if (controller.errorMessage.value.isNotEmpty &&
            controller.displayableImageFiles.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.redAccent, size: 50),
                  const SizedBox(height: 10),
                  Text(
                    controller.errorMessage.value,
                    style: FontsHelper.poppinsFont
                        .copyWith(color: Colors.redAccent, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
        if (controller.displayableImageFiles.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image_search,
                    color: ColorsHelper.white.withOpacity(0.7), size: 60),
                const SizedBox(height: 10),
                Text(
                  'No images found or URLs could not be generated.',
                  style: FontsHelper.poppinsFont
                      .copyWith(color: ColorsHelper.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: Icon(Icons.refresh, color: ColorsHelper.white),
                  label: Text("Try Refresh",
                      style: FontsHelper.poppinsFont
                          .copyWith(color: ColorsHelper.white)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsHelper.defaultPrimaryColor),
                  onPressed: () => controller.fetchImages(),
                )
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 1200
                ? 5
                : (MediaQuery.of(context).size.width > 800
                    ? 4
                    : (MediaQuery.of(context).size.width > 600 ? 3 : 2)),
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 0.75,
          ),
          itemCount: controller.displayableImageFiles.length,
          itemBuilder: (context, index) {
            final displayableImage = controller.displayableImageFiles[index];
            final appwriteFile = displayableImage.appwriteFile;
            final imageUrlForDisplay = displayableImage.viewUrl;

            if (index == 0) {
              log("First image URL for display from DisplayableImageFile: $imageUrlForDisplay",
                  name: "ImageGalleryDialog");
            }

            return Card(
              color: ColorsHelper.canvasColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: ColorsHelper.secondaryCanvasColor.withOpacity(0.3),
                      child: imageUrlForDisplay.isNotEmpty
                          ? Image.network(
                              imageUrlForDisplay,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                log("Error loading image $imageUrlForDisplay: $error",
                                    name: "ImageGalleryDialog",
                                    error: error,
                                    stackTrace: stackTrace);
                                return Center(
                                    child: Icon(Icons.broken_image_outlined,
                                        color:
                                            ColorsHelper.white.withOpacity(0.6),
                                        size: 40));
                              },
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                    color: ColorsHelper.defaultPrimaryColor,
                                    strokeWidth: 2.0,
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Icon(Icons.image_not_supported_outlined,
                                  color: ColorsHelper.white.withOpacity(0.6),
                                  size: 40)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 6.0),
                    child: Text(
                      appwriteFile.name,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: FontsHelper.poppinsFont.copyWith(
                          color: ColorsHelper.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.copy_all_outlined,
                          size: 15, color: ColorsHelper.white),
                      label: Text('Copy URL',
                          style: FontsHelper.poppinsFont.copyWith(
                              fontSize: 11.5, color: ColorsHelper.white)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              ColorsHelper.defaultPrimaryColor.withOpacity(0.6),
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6))),
                      onPressed: () {
                        controller.copyToClipboard(
                            imageUrlForDisplay, appwriteFile.name);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
