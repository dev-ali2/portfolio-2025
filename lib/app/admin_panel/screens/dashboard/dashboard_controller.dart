import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as appwrite_models;
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'dart:convert';

import 'package:portfolio_2025/core/common/models/data_model.dart';
import 'package:portfolio_2025/app/splash_screen/presentation/screens/d_splash_screen.dart';

class DashboardController extends GetxController {
  late Client _client;
  late Account _account;
  late Databases _databases;

  RxString userName = 'User'.obs;
  RxBool isLoading = true.obs;
  RxBool isLoggingOut = false.obs;
  RxString errorMessage = ''.obs;

  Rx<DataModel?> siteData = Rx<DataModel?>(null);

  @override
  void onInit() {
    super.onInit();
    _client = Client()
        .setEndpoint(dotenv.env['Endpoint'] ?? 'YOUR_FALLBACK_ENDPOINT')
        .setProject(dotenv.env['Project'] ?? 'YOUR_FALLBACK_PROJECT_ID')
        .setSelfSigned(status: true);
    _account = Account(_client);
    _databases = Databases(_client);

    _fetchUserDataAndInitialData();
  }

  Future<void> _fetchUserDataAndInitialData() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final appwrite_models.User user = await _account.get();
      userName.value = user.name.isEmpty ? user.email : user.name;

      siteData.value = Get.find<DataController>().siteData!;
    } on AppwriteException catch (e) {
      errorMessage.value = "Error fetching data: ${e.message}";
      if (e.code == 401) {
        Get.offAll(() => const DSplashScreen());
        return;
      }
      if (siteData.value == null) {
        errorMessage.value += "\nUsing sample data for UI as fallback.";
        log('Error fetching user data: ${e.message}, using sample data as fallback.');
      }
    } catch (e) {
      errorMessage.value = "An unexpected error occurred: ${e.toString()}";
      if (siteData.value == null) {
        errorMessage.value += "\nUsing sample data for UI as fallback.";
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateSiteData() async {
    try {
      log('Env variables = ${dotenv.env}');

      log('DatabaseID : ${dotenv.env['Database_id']}');
      log('CollectionID : ${dotenv.env['Collection_id']}');
      log('DocumentID : ${dotenv.env['Document_id']}');
      final response = await _databases.updateDocument(
        databaseId: '${dotenv.env['Database_id']}',
        collectionId: '${dotenv.env['Collection_id']}',
        documentId: '${dotenv.env['Document_id']}',
        data: {'data': jsonEncode(siteData.value)},
      );
      log('Collection updated: ${response.toMap()}');
      Get.snackbar('Success', 'New Data uploaded successfully',
          backgroundColor: Colors.green, colorText: Colors.white);
      return true;
    } catch (e) {
      log('Error updating collection: $e');
      Get.snackbar('Error', 'Failed to upload new data',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
  }

  void toggleSiteEnabled(bool value) {
    if (siteData.value != null) {
      siteData.value!.isSiteEnabled = value;
      siteData.refresh();
      print("Site Enabled: ${siteData.value!.isSiteEnabled}");
    }
  }

  void toggleMouseFollow(bool value) {
    if (siteData.value != null) {
      siteData.value!.followMousePosition = value;
      siteData.refresh();
      print("Mouse Follow: ${siteData.value!.followMousePosition}");
    }
  }

  void toggleTopBarOptionEnabled(int index, bool value) {
    if (siteData.value != null &&
        index < siteData.value!.landingPageModel.topBarOptions.length) {
      siteData.value!.landingPageModel.topBarOptions[index].isEnabled = value;
      siteData.refresh();
      print(
          "Top Bar Option '${siteData.value!.landingPageModel.topBarOptions[index].title}' Enabled: $value");
    }
  }

  Future<void> logoutUser() async {
    isLoggingOut.value = true;
    try {
      await _account.deleteSession(sessionId: 'current');
      Get.offAll(routeName: '/', () => const DSplashScreen());
    } on AppwriteException catch (e) {
      Get.snackbar(
        "Logout Error",
        e.message ?? "Could not log out. Please try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Logout Error",
        "An unexpected error occurred: ${e.toString()}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoggingOut.value = false;
    }
  }
}
