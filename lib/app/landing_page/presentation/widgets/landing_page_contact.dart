import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';

class LandingPageContact extends StatelessWidget {
  const LandingPageContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(
                  ColorsHelper.defaultPrimaryColor.withAlpha(50)),
              elevation: WidgetStateProperty.all(5),
              backgroundColor: WidgetStateProperty.all(
                  ColorsHelper.defaultPrimaryColor.withAlpha(50))),
          iconSize: 35,
          onPressed: () {},
          icon: const Icon(BoxIcons.bxl_gmail),
        ),
        IconButton(
          style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(
                  ColorsHelper.defaultPrimaryColor.withAlpha(50)),
              elevation: WidgetStateProperty.all(5),
              backgroundColor: WidgetStateProperty.all(
                  ColorsHelper.defaultPrimaryColor.withAlpha(50))),
          iconSize: 35,
          onPressed: () {},
          icon: const Icon(BoxIcons.bxl_github),
        ),
        IconButton(
          style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(
                  ColorsHelper.defaultPrimaryColor.withAlpha(50)),
              elevation: WidgetStateProperty.all(5),
              backgroundColor: WidgetStateProperty.all(
                  ColorsHelper.defaultPrimaryColor.withAlpha(50))),
          iconSize: 35,
          onPressed: () {},
          icon: const Icon(BoxIcons.bxl_linkedin),
        )
      ],
    );
  }
}
