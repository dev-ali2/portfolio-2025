import 'package:flutter/material.dart';
import 'package:portfolio_2025/app/main_canvas/presentation/controllers/main_canvas_controller.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';

class ScrollToUpBtn extends StatelessWidget {
  MainCanvasController controller;
  ScrollToUpBtn({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      right: 15,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: ColorsHelper.secondaryCanvasColor.withAlpha(20),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: ColorsHelper.defaultPrimaryColor.withAlpha(200),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        duration: const Duration(milliseconds: 600),
        width: controller.showScrollUpButton ? 50 : 0,
        height: controller.showScrollUpButton ? 50 : 0,
        curve: Curves.easeInOut,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 600),
          opacity: controller.showScrollUpButton ? 1.0 : 0.0,
          curve: Curves.easeInOut,
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: ColorsHelper.secondaryCanvasColor,
              foregroundColor: ColorsHelper.defaultPrimaryColor,
              overlayColor: ColorsHelper.defaultPrimaryColor.withAlpha(100),
            ),
            onPressed: controller.scrollToTop,
            icon: const Icon(
              Icons.arrow_upward_rounded,
              color: ColorsHelper.defaultPrimaryColor,
              size: 27,
            ),
          ),
        ),
      ),
    );
  }
}
