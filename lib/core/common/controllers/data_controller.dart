import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:portfolio_2025/app/main_canvas/presentation/screen/main_canvas_screen.dart';
import 'package:portfolio_2025/core/common/models/data_model.dart';
import 'package:portfolio_2025/core/common/screens/site_error_screen.dart';
import 'package:portfolio_2025/core/common/screens/site_under_maintaince_screen.dart';
import 'package:scroll_animator/scroll_animator.dart';

class DataController extends GetxController {
  DataModel? siteData;
  bool isDataLoaded = false;
  Uint8List? imageData;

  void updateSiteData(Map<String, dynamic> appwriteResponse) async {
    try {
      log('Site data fetched: $appwriteResponse');
      siteData =
          DataModel.fromJson(jsonDecode(appwriteResponse['data'] as String));
      if (siteData == null) {
        Get.offAll(
            transition: Transition.circularReveal,
            routeName: '/',
            () => const SiteErrorScreen());
        return;
      }

      isDataLoaded = true;

      final response =
          await get(Uri.parse(siteData?.landingPageModel.bgImageUrl ?? ''));
      if (response.statusCode == 200) {
        imageData = response.bodyBytes;
      } else {
        log('Failed to load background image: ${response.statusCode}');
      }

      if (siteData!.isSiteEnabled == false && kReleaseMode) {
        Get.offAll(
            transition: Transition.circularReveal,
            routeName: '/',
            () => const SiteUnderMaintainceScreen());
        return;
      }

      Get.offAll(
          duration: const Duration(milliseconds: 1000),
          transition: Transition.fadeIn,
          routeName: '/',
          () => AnimatedPrimaryScrollController(
              animationFactory: const ChromiumImpulse(),
              child: Builder(builder: (context) => const MainCanvasScreen())));
    } catch (e) {
      log('Error parsing site data : $e');
      isDataLoaded = false;
      Get.offAll(
          transition: Transition.circularReveal,
          routeName: '/',
          () => const SiteErrorScreen());
      return;
    }
  }
}
