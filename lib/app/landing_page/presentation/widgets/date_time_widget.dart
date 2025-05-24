import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/date_time_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisSize: MainAxisSize.min,
      children: [
        GetBuilder<DateTimeHelper>(
          id: 'timer',
          init: DateTimeHelper(),
          builder: (controller) => SelectableText(
            controller.combinedDate.value,
            style: FontsHelper.landingPageQuoteFont.copyWith(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: ColorsHelper.defaultPrimaryColor.withAlpha(255)),
          ),
        ),
        GetBuilder<DateTimeHelper>(
          id: 'timer',
          init: DateTimeHelper(),
          builder: (controller) => SelectableText(
            controller.timeAmPm.value,
            style: FontsHelper.landingPageQuoteFont.copyWith(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: ColorsHelper.defaultPrimaryColor.withAlpha(255)),
          ),
        ),
      ],
    );
  }
}
