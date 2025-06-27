import 'dart:convert';
import 'dart:developer';
import 'package:appwrite/appwrite.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:portfolio_2025/core/common/models/device_info_model.dart';

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

      // final http.Response? ipResponse =
      //     await http.get(Uri.parse('http://ip-api.com/json/'));
      // IpGetModel? ipSerializedData;
      // if (ipResponse != null) {
      //   log('Got IP Response: ${ipResponse.body}');
      //   ipSerializedData = IpGetModel.fromJson(jsonDecode(ipResponse.body));
      //   log('IP data serialized: ${ipSerializedData.city}');
      // }

      final Map<String, dynamic> siteLogDataToSend = {
        'deviceInfo': deviceInfo.toJson(),
        // 'ipInfo': ipSerializedData?.toJson() ?? {'ip': 'Unknown'},
        'dateTime': DateTime.now().toIso8601String(),
      };
      final databases = Databases(client);
      final document = await databases.createDocument(
        databaseId: dotenv.env['Database_id'] ?? '',
        collectionId: dotenv.env['Site_logs_collection'] ?? '',
        documentId: ID.unique(),
        data: {'visit': jsonEncode(siteLogDataToSend)},
      );
      log('Site visit logged successfully: ${document.$id}');
    } catch (e) {
      print('Warning: $e');
    }
  }
}
