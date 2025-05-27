import 'package:flutter/material.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/landing_page_contact.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class DContactPage extends StatelessWidget {
  const DContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 30,
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SelectableText(
                  textAlign: TextAlign.center,
                  'Have a project in mind?\nLet\'s collaborate and bring it to life.',
                  style: FontsHelper.landingPageQuoteFont.copyWith(
                      fontSize: 30,
                      color: ColorsHelper.defaultPrimaryColor.withAlpha(255),
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                const LandingPageContact(),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.only(top: 40),
                    decoration: const BoxDecoration(),
                    width: double.maxFinite,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SelectableText(
                          'Made in ❤️ with Flutter',
                          style: FontsHelper.fontUbuntu
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
