import 'package:flutter/material.dart';
import 'package:portfolio_2025/app/main_canvas/presentation/controllers/main_canvas_controller.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';

class FollowerDot extends StatelessWidget {
  final MainCanvasController controller;
  const FollowerDot({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Offset>(
      valueListenable: controller.currentPositionNotifier,
      builder: (context, currentPosition, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: controller.isNearTargetNotifier,
          builder: (context, isNearTarget, child) {
            return AnimatedBuilder(
              animation: controller.scaleAnimation,
              builder: (context, child) {
                return Positioned(
                  left: currentPosition.dx + MainCanvasController.offsetX,
                  top: currentPosition.dy + MainCanvasController.offsetY,
                  child: IgnorePointer(
                    child: Transform.scale(
                      scale: controller.scaleAnimation.value,
                      child: Container(
                        width: MainCanvasController.circleSize,
                        height: MainCanvasController.circleSize,
                        decoration: BoxDecoration(
                          color: isNearTarget
                              ? ColorsHelper.defaultPrimaryColor.withAlpha(230)
                              : Colors.transparent,
                          shape: BoxShape.circle,
                          boxShadow: isNearTarget
                              ? [
                                  BoxShadow(
                                    color: ColorsHelper.defaultPrimaryColor
                                        .withAlpha(255),
                                    blurRadius: 12,
                                    spreadRadius: 3,
                                  )
                                ]
                              : [
                                  BoxShadow(
                                    color: ColorsHelper.defaultPrimaryColor
                                        .withAlpha(170),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                  )
                                ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
