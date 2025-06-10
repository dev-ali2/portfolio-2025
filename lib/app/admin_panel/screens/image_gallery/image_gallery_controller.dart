import 'dart:developer';
import 'dart:io' if (dart.library.html) 'dart:html' show File;
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as appwrite_models;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

class DisplayableImageFile {
  final appwrite_models.File appwriteFile;
  final String viewUrl;

  DisplayableImageFile({required this.appwriteFile, required this.viewUrl});
}

class ImageGalleryController extends GetxController {
  late Client _appwriteClient;
  late Storage _appwriteStorage;
  final String? _bucketId =
      dotenv.env['IMAGE_BUCKET_ID'] ?? dotenv.env['Bucket_id'];

  RxList<DisplayableImageFile> displayableImageFiles =
      <DisplayableImageFile>[].obs;
  RxBool isLoading = true.obs;
  RxBool isUploading = false.obs;
  RxString errorMessage = ''.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    if (_bucketId == null) {
      final errorMsg =
          "IMAGE_BUCKET_ID (or Bucket_id) not found in .env file. Please ensure it's set.";
      errorMessage.value = errorMsg;
      isLoading.value = false;
      log(errorMsg, name: "ImageGalleryController");
      Get.snackbar("Configuration Error", errorMsg,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5));
      return;
    }
    log("Using Bucket ID: $_bucketId", name: "ImageGalleryController");

    _appwriteClient = Client()
        .setEndpoint(dotenv.env['Endpoint'] ?? '')
        .setProject(dotenv.env['Project'] ?? '')
        .setSelfSigned(status: true);
    _appwriteStorage = Storage(_appwriteClient);
    fetchImages();
  }

  Future<void> fetchImages() async {
    if (_bucketId == null) return;
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final appwrite_models.FileList result =
          await _appwriteStorage.listFiles(bucketId: _bucketId!);

      List<DisplayableImageFile> newDisplayableFiles = [];
      for (var file in result.files) {
        String viewUrl = _generateFileViewUrl(file.$id);
        if (viewUrl.isNotEmpty) {
          newDisplayableFiles
              .add(DisplayableImageFile(appwriteFile: file, viewUrl: viewUrl));
        } else {
          log("Could not generate view URL for file: ${file.name} (ID: ${file.$id})",
              name: "ImageGalleryController");
        }
      }
      displayableImageFiles.assignAll(newDisplayableFiles);

      if (displayableImageFiles.isEmpty) {
        log("No displayable images (or URL generation failed) in bucket: $_bucketId",
            name: "ImageGalleryController");
        if (result.files.isNotEmpty && newDisplayableFiles.isEmpty) {
          errorMessage.value =
              "Files found, but could not generate URLs. Check permissions or Appwrite setup.";
        }
      }
    } on AppwriteException catch (e) {
      final errorMsg = "Error fetching images from Appwrite: ${e.message}";
      errorMessage.value = errorMsg;
      log(errorMsg, name: "ImageGalleryController", error: e);
      Get.snackbar("Fetch Error", "Failed to fetch images: ${e.message}",
          backgroundColor: Colors.red, colorText: Colors.white);
    } catch (e) {
      final errorMsg = "Unexpected error fetching images: ${e.toString()}";
      errorMessage.value = errorMsg;
      log(errorMsg, name: "ImageGalleryController", error: e);
      Get.snackbar("Fetch Error", "An unexpected error occurred.",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  String _generateFileViewUrl(String fileId) {
    if (_bucketId == null) return '';
    try {
      final endpoint = dotenv.env['Endpoint'] ?? '';
      final projectId = dotenv.env['Project'] ?? '';

      if (endpoint.isEmpty || projectId.isEmpty) {
        log("Missing endpoint or project configuration",
            name: "ImageGalleryController");
        return '';
      }

      final url =
          '$endpoint/storage/buckets/$_bucketId/files/$fileId/view?project=$projectId';
      log("Generated view URL for $fileId: $url",
          name: "ImageGalleryController");
      return url;
    } catch (e) {
      log("Error generating file VIEW URL for $fileId: $e",
          name: "ImageGalleryController", error: e);
      return '';
    }
  }

  String getPublicFileViewUrl(String fileId) {
    return _generateFileViewUrl(fileId);
  }

  Future<void> pickAndUploadImage() async {
    if (_bucketId == null) {
      Get.snackbar("Error", "Storage bucket not configured.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    isUploading.value = true;
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        log("Picked file: ${pickedFile.name}, path: ${pickedFile.path}",
            name: "ImageGalleryController");

        InputFile fileToUpload;

        if (kIsWeb) {
          final Uint8List fileBytes = await pickedFile.readAsBytes();
          fileToUpload = InputFile.fromBytes(
            bytes: fileBytes,
            filename: pickedFile.name,
          );
          log("Uploading for web with bytes. Filename: ${pickedFile.name}, Byte length: ${fileBytes.length}",
              name: "ImageGalleryController");
        } else {
          fileToUpload = InputFile.fromPath(
            path: pickedFile.path,
            filename: pickedFile.name,
          );
          log("Uploading for mobile/desktop with path. Filename: ${pickedFile.name}",
              name: "ImageGalleryController");
        }

        await _appwriteStorage.createFile(
          bucketId: _bucketId!,
          fileId: ID.unique(),
          file: fileToUpload,
          permissions: [Permission.read(Role.any())],
        );
        Get.snackbar(
            "Success", "Image '${pickedFile.name}' uploaded successfully!",
            backgroundColor: Colors.green, colorText: Colors.white);
        fetchImages();
      } else {
        log("Image picking cancelled.", name: "ImageGalleryController");
      }
    } on AppwriteException catch (e) {
      final errorMsg = "Image upload failed (Appwrite): ${e.message}";
      errorMessage.value = errorMsg;
      log(errorMsg, name: "ImageGalleryController", error: e);
      Get.snackbar("Upload Error", "Appwrite error: ${e.message}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5));
    } catch (e) {
      final errorMsg = "Unexpected error during image upload: ${e.toString()}";
      errorMessage.value = errorMsg;
      log(errorMsg, name: "ImageGalleryController", error: e);
      Get.snackbar(
          "Upload Error", "An unexpected error occurred: ${e.toString()}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5));
    } finally {
      isUploading.value = false;
    }
  }

  void copyToClipboard(String textToCopy, String imageName) {
    if (textToCopy.isEmpty) {
      log("Attempted to copy empty URL for $imageName",
          name: "ImageGalleryController");
      Get.snackbar(
        "Error",
        "Could not generate URL for '$imageName'.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }
    Clipboard.setData(ClipboardData(text: textToCopy));
    log("Copied URL for $imageName: $textToCopy",
        name: "ImageGalleryController");
    Get.snackbar(
      "Copied to Clipboard",
      "URL for '$imageName' copied!",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black87,
      colorText: Colors.white,
    );
  }
}
