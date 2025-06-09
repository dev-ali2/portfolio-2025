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
    'Merhaba',
    '안녕하세요',
    'Jambo',
    'Sawubona',
    'Xin chào',
    'สวัสดี',
    'Kamusta',
    'Selamat',
    'Salam',
    'Habari',
    'Aloha'
  ];

  int _currentIndex = 0;

  @override
  void onInit() async {
    super.onInit();
    // await Future.delayed(const Duration(milliseconds: 500));
    _startGreetingLoop();
    await Get.find<AppwriteController>().initAppwrite();
    // await Future.delayed(Duration(seconds: 2));
    Get.find<AppwriteController>().getSiteData();
  }

  void _startGreetingLoop() {
    Timer.periodic(const Duration(milliseconds: 150), (timer) {
      currentGreeting = greetings[_currentIndex];
      update();
      _currentIndex = (_currentIndex + 1) % greetings.length;
    });
  }
}
