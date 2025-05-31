import 'package:flutter/material.dart';
import 'package:portfolio_2025/core/common/widgets/pages_header.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class DAboutPage extends StatelessWidget {
  const DAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 60),
      child: Column(
        spacing: 60,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PagesHeader(title: 'About Me'),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // spacing: 40,
            children: [
              CircleAvatar(
                radius: 100 + (MqHelper.width * MqHelper.height * 0.0001),
                backgroundColor: ColorsHelper.white,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 30,
                children: [
                  SizedBox(
                    width: MqHelper.width * 0.5,
                    child: SelectableText(
                        formatParagraphWithSpacing(
                            '''A Full-Stack Cross-Platform Developer with 3+ years of hands-on experience, I've made it my mission to build applications that don't just work they work beautifully, everywhere.
I've crafted over 22 projects that prioritize seamless user experiences. My sweet spot? Flutter development, where I can create stunning applications that feel native on every platform while maintaining a single, efficient codebase.
I'm not just a developer who codes in isolation. I'm an open-source enthusiast with 8+ contributions, a collaborator who thrives in cross-platform focused teams, and someone who genuinely enjoys converting innovative ideas into open-source solutions. Having worked with 2 specialized companies and clients worldwide, I understand that great software is about solving real problems elegantly.
I'm on a journey to become a leading Cross-Platform and MVP Solution Architect because the future belongs to those who can build once and deploy everywhere.'''),
                        style: FontsHelper.fontUbuntu.copyWith(
                            fontSize: 18, color: Colors.white.withAlpha(200))),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: MqHelper.width * 0.5,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        subtitle: SelectableText(
                            'COMSATS University Islamabad, Lahore campus (2020-2024)',
                            style: FontsHelper.fontUbuntu
                                .copyWith(color: Colors.grey, fontSize: 14)),
                        leading: Image.asset('assets/pngs/comsats.png'),
                        title: SelectableText('BS Software Engineering',
                            style: FontsHelper.fontUbuntu.copyWith(
                                fontSize: 20,
                                color: ColorsHelper.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String formatParagraphWithSpacing(String paragraph) {
  return paragraph.replaceAll('\n', '\n\n');
}
