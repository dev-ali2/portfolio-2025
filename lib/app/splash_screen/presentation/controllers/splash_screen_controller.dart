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
    'Konnichiwa',
    'Namaste',
    'Marhaba',
    'Privet',
    'Ni Hao',
    'Olá',
    'Hej',
    'Zdravstvuyte',
    'Shalom',
    'Yia sas',
    'Merhaba',
    'Annyeonghaseyo',
    'Jambo',
    'Sawubona',
    'Xin chào',
    'Sawasdee',
    'Kamusta',
    'Selamat',
    'Salam',
    'Habari',
    'Aloha',
    'Salaam',
    'Dzien dobry',
    'Dobrý den',
    'Jó napot',
    'Bună ziua',
    'Dobar dan',
    'Zdravo',
    'Sveiki',
    'Tere',
    'Labdien'
  ];

  int _currentIndex = 0;

  @override
  void onInit() async {
    super.onInit();

    _startGreetingLoop();
    await Get.find<AppwriteController>().initAppwrite();
    await Future.delayed(const Duration(seconds: 1));
    Get.find<AppwriteController>().getSiteData();
  }

  void _startGreetingLoop() {
    Timer.periodic(const Duration(milliseconds: 120), (timer) {
      currentGreeting = greetings[_currentIndex];
      update();
      _currentIndex = (_currentIndex + 1) % greetings.length;
    });
  }
}
