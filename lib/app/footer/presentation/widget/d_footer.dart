import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/admin_panel/screens/login/login_screen.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class DFooter extends StatelessWidget {
  const DFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
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
            IconButton(
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.transparent,
                )),
            const Spacer(),
            // SelectableText(
            //   '© 2025 - All rights reserved',
            //   style: FontsHelper.fontUbuntu.copyWith(color: Colors.grey),
            // ),
            SelectableText(
              'Made in ❤️ with Flutter',
              style: FontsHelper.fontUbuntu.copyWith(color: Colors.grey),
            ),
            const Spacer(),
          ],
        ));
  }
}
