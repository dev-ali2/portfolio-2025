import 'package:flutter/material.dart';
import 'package:portfolio_2025/app/contact/presentation/widgets/d_contact_page_options.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/landing_page_contact.dart';
import 'package:portfolio_2025/core/common/widgets/pages_header.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class DContactPage extends StatelessWidget {
  const DContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 60,
        children: [
          SizedBox(
            height: 50,
          ),
          SelectableText(
            textAlign: TextAlign.center,
            'Let\'s make your users say "Wow", not "Why?".',
            style: FontsHelper.fontUbuntu.copyWith(
                fontSize: 30,
                wordSpacing: 5,
                color: ColorsHelper.defaultPrimaryColor.withAlpha(255),
                fontWeight: FontWeight.bold),
          ),
          DContactPageOptions(),
        ],
      ),
    );
  }
}
