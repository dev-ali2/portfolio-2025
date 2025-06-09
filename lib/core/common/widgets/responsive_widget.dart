import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobileWidget;
  final Widget tabletWidget;
  final Widget desktopWidget;

  const ResponsiveWidget({
    super.key,
    required this.mobileWidget,
    required this.tabletWidget,
    required this.desktopWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MqHelper>(
      id: "canvas options",
      builder: (controller) {
        double width = MqHelper.width;
        if (width < 600) {
          log('returning mobile widget with width: $width');
          return mobileWidget;
        } else if (width < 1000) {
          log('returning tablet widget with width: $width');

          return tabletWidget;
        } else {
          log('returning desktop widget with width: $width');
          return desktopWidget;
        }
      },
    );
  }
}
