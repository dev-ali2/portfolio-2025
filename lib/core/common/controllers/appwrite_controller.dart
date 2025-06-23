import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/test_data.dart';

class AppwriteController extends GetxController {
  late Client client;
  bool isAppwriteInitialized = false;

  Future<void> initAppwrite() async {
    client = Client();
    try {
      await dotenv.load(fileName: "config.env");
      log('Env variables loaded: ${dotenv.env}');
      client
          .setEndpoint(dotenv.env['Endpoint'] ?? '')
          .setProject(dotenv.env['Project'] ?? '');
      // .setSelfSigned(status: true);
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

      // final Map<String, dynamic> mockData = {
      //   'data': sanitizeJson(dataAsString)
      // };
      // Get.find<DataController>().updateSiteData(mockData);
    } catch (e) {
      log('Error fetching site data: $e');
    }
  }
}

String dataAsString = testData;
String sanitizeJson(String jsonStr) {
  // This regex matches all ASCII control characters (0-31)
  RegExp controlChars = RegExp('[\u0000-\u001F]');

  return jsonStr.replaceAllMapped(controlChars, (match) {
    // Convert control character to its escape sequence
    String char = match.group(0)!;
    switch (char) {
      case '\b':
        return '\\b';
      case '\f':
        return '\\f';
      case '\n':
        return '\\n';
      case '\r':
        return '\\r';
      case '\t':
        return '\\t';
      default:
        // For other control characters, use Unicode escape sequence
        return '\\u${char.codeUnitAt(0).toRadixString(16).padLeft(4, '0')}';
    }
  });
}
