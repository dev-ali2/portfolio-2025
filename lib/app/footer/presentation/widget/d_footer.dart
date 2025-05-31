import 'package:flutter/material.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class DFooter extends StatelessWidget {
  const DFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.only(top: 40),
        decoration: const BoxDecoration(
          color: Colors.black45,
        ),
        width: double.maxFinite,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableText(
              'Made in ❤️ with Flutter',
              style: FontsHelper.fontUbuntu.copyWith(color: Colors.grey),
            ),
          ],
        ));
  }
}
