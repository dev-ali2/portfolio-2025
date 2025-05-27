import 'package:flutter/material.dart';
import 'package:portfolio_2025/core/common/widgets/pages_header.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class DAboutPage extends StatelessWidget {
  const DAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: const BoxDecoration(

          // border: Border.all(color: Colors.red)

          ),
      child: Column(
        spacing: 30,
        mainAxisSize: MainAxisSize.min,
        children: [
          const PagesHeader(title: 'About me'),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SelectableText(
                formatParagraphWithSpacing(
                    '''I turn ideas into reality through code. As a Full-Stack Cross-Platform Developer with 3+ years of hands-on experience, I've made it my mission to build applications that don't just work they work beautifully, everywhere.
Armed with a Software Engineering degree from COMSATS University Islamabad and a toolkit that includes Flutter, JavaScript, React, Node.js, and Express, I've crafted over 22 projects that prioritize seamless user experiences. My sweet spot? Flutter development, where I can create stunning applications that feel native on every platform while maintaining a single, efficient codebase.
I'm not just a developer who codes in isolation. I'm an open-source enthusiast with 8+ contributions, a collaborator who thrives in cross-platform focused teams, and someone who genuinely enjoys converting innovative ideas into open-source solutions. Having worked with 2 specialized companies and clients worldwide, I understand that great software is about solving real problems elegantly.
I'm on a journey to become a leading Cross-Platform and MVP Solution Architect because the future belongs to those who can build once and deploy everywhere.'''),
                style: FontsHelper.fontUbuntu
                    .copyWith(fontSize: 20, color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SelectableText(
                'Education',
                style: FontsHelper.fontUbuntu.copyWith(
                    decorationColor: ColorsHelper.defaultPrimaryColor,
                    fontSize: 30,
                    color: ColorsHelper.defaultPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            subtitle: SelectableText(
                'COMSATS University Islamabad, Lahore campus',
                style: FontsHelper.fontUbuntu
                    .copyWith(color: Colors.grey, fontSize: 14)),
            leading: Image.asset('assets/pngs/comsats.png'),
            title: SelectableText('BS Software Engineering',
                style: FontsHelper.fontUbuntu.copyWith(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            trailing: SelectableText(
              'Jan 2020- Feb 2024',
              style: FontsHelper.fontUbuntu
                  .copyWith(color: Colors.grey, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}

String formatParagraphWithSpacing(String paragraph) {
  return paragraph.replaceAll('\n', '\n\n');
}
