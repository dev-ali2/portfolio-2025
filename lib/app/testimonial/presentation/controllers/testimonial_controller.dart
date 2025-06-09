import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestimonialController extends GetxController {
  final RxInt currentCarouselIndex = 0.obs;

  final PageController pageController = PageController();

  void nextCarouselPage(int maxPages) {
    if (currentCarouselIndex.value < maxPages - 1) {
      currentCarouselIndex.value++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousCarouselPage() {
    if (currentCarouselIndex.value > 0) {
      currentCarouselIndex.value--;
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void onPageChanged(int index) {
    currentCarouselIndex.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
