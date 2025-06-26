import 'dart:convert';
import 'dart:developer';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:portfolio_2025/core/common/models/device_info_model.dart';
import 'package:portfolio_2025/core/common/models/ip_get_model.dart';
import 'package:portfolio_2025/helpers/device_info_collector_helper.dart';

class SiteVisitLogHelper {
  static Future<void> logSiteData(Client client) async {
    try {
      final Map<String, dynamic> allDeviceData =
          await DeviceInfoCollector.collectAndPrintDeviceInfo();
      final DeviceInfoModel deviceInfo =
          DeviceInfoModel.fromJson(allDeviceData);
      log('Device data serialized');
      log('${deviceInfo.systemInfo?.memory?.totalJsHeapSize}');
      final ipResponse = await http.get(Uri.parse('https://ipapi.co/json/'));
      log('Got IP Response: ${ipResponse.body}');
      final ipSerializedData = IpGetModel.fromJson(jsonDecode(ipResponse.body));
      log('IP data serialized: ${ipSerializedData.city}');
      final Map<String, dynamic> siteLogDataToSend = {
        'deviceInfo': deviceInfo.toJson(),
        'ipInfo': ipSerializedData.toJson(),
        'dateTime': DateTime.now().toIso8601String(),
      };

      try {
        final databases = Databases(client);
        final document = await databases.createDocument(
          databaseId: dotenv.env['Database_id'] ?? '',
          collectionId: dotenv.env['Site_logs_collection'] ?? '',
          documentId: ID.unique(),
          data: {'visit': jsonEncode(siteLogDataToSend)},
        );
        log('Site visit logged successfully: ${document.$id}');
      } catch (e) {
        log('Error logging site visit: $e');
      }
    } catch (e) {
      Get.snackbar('Error', 'In Getting device info : $e',
          duration: const Duration(seconds: 60),
          backgroundColor: Colors.blue,
          colorText: Colors.white);
    }
  }
}
