import 'package:flutter/material.dart';
import 'package:portfolio_2025/app/contact/presentation/widgets/d_contact_page_options.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class DContactPage extends StatelessWidget {
  const DContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 60,
        children: [
          const SizedBox(
            height: 50,
          ),
          SelectableText.rich(
            textAlign: TextAlign.center,
            TextSpan(
              style: FontsHelper.fontUbuntu.copyWith(
                fontSize: 30,
                wordSpacing: 3,
                color: ColorsHelper.white,
                // fontWeight: FontWeight.bold
              ),
              children: [
                const TextSpan(text: 'Let\'s make your users say '),
                TextSpan(
                  text: 'Wow',
                  style: FontsHelper.fontUbuntu.copyWith(
                    fontSize: 30,
                    wordSpacing: 5,
                    color: ColorsHelper.defaultPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: ', not '),
                TextSpan(
                  text: 'Why?',
                  style: FontsHelper.fontUbuntu.copyWith(
                    fontSize: 30,
                    wordSpacing: 5,
                    color: ColorsHelper.defaultPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const TextSpan(text: '.'),
              ],
            ),
          ),
          const DContactPageOptions(),
        ],
      ),
    );
  }
}
