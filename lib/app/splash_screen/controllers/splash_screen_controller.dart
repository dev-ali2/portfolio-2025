import 'dart:async';

import 'package:get/get.dart';
import 'package:portfolio_2025/core/common/controllers/appwrite_controller.dart';

class SplashScreenController extends GetxController {
  String currentGreeting = 'Hello';
  final List<String> greetings = [
    'Hello',
    'Hola',
    'Bonjour',
    'Hallo',
    'Ciao',
    'こんにちは',
    'नमस्ते',
    'مرحبا',
    'Привет',
    '你好',
    'Olá',
    'Hej',
    'Здравствуйте',
    'שלום',
    'Γεια σας',
    'Merhaba'
  ];

  int _currentIndex = 0;

  @override
  void onInit() async {
    super.onInit();
    _startGreetingLoop();
    await Get.find<AppwriteController>().initAppwrite();
    Get.find<AppwriteController>().getSiteData();
  }

  void _startGreetingLoop() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      currentGreeting = greetings[_currentIndex];
      update();
      _currentIndex = (_currentIndex + 1) % greetings.length;
    });
  }
}
