import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';

class AppwriteController extends GetxController {
  late Client client;
  bool isAppwriteInitialized = false;

  Future<void> initAppwrite() async {
    client = Client();
    try {
      await dotenv.load(fileName: ".env");
      log('Env variables loaded: ${dotenv.env}');
      client
          .setEndpoint(dotenv.env['Endpoint'] ?? '')
          .setProject(dotenv.env['Project'] ?? '')
          .setSelfSigned(status: true);
      isAppwriteInitialized = true;
      log('Appwrite initialized successfully.');
      // getSiteData();
    } catch (e) {
      log('Error in initializing app write : $e');
    }
  }

  Future<void> getSiteData() async {
    if (!isAppwriteInitialized) {
      log('Error while getting data, AppWrite not initialized yet.');
      return;
    }
    try {
      final database = Databases(client);
      final response = await database.getDocument(
          databaseId: dotenv.env['Database_id'] ?? '',
          collectionId: dotenv.env['Collection_id'] ?? '',
          documentId: dotenv.env['Document_id'] ?? '');

      Get.find<DataController>().updateSiteData(response.data);

      // final Map<String, dynamic> mockData = {'data': dataAsString};
      // Get.find<DataController>().updateSiteData(mockData);
    } catch (e) {
      log('Error fetching site data: $e');
    }
  }
}

String dataAsString = '''''';
