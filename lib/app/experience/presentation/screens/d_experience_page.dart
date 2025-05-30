import 'package:flutter/material.dart';
import 'package:portfolio_2025/core/common/widgets/pages_header.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class DExperiencePage extends StatelessWidget {
  const DExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 60),
      child: Column(
        spacing: 60,
        mainAxisSize: MainAxisSize.min,
        children: [
          const PagesHeader(title: 'Work Experience'),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            margin: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: ColorsHelper.defaultPrimaryColor.withAlpha(200),
                    width: 2)),
            child: ListTile(
              horizontalTitleGap: 15,
              style: ListTileStyle.list,
              isThreeLine: true,
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '(2020-2025)',
                        style: FontsHelper.fontUbuntu
                            .copyWith(color: Colors.grey, fontSize: 12),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  SelectableText(
                      '''Developed and maintained high-performance cross-platform mobile applications using Flutter, collaborating closely with cross-functional teams including UI/UX designers, backend developers, and QA engineers.
            
Integrated RESTful APIs, Firebase FCM services, implemented state management solutions like Provider and used clean code architecture, contributing to robust, scalable, and user-friendly app architectures.
            ''',
                      style: FontsHelper.fontUbuntu
                          .copyWith(color: ColorsHelper.white, fontSize: 14)),
                ],
              ),
              leading: Image.asset(
                'assets/tech/flutter.png',
                fit: BoxFit.cover,
              ),
              title: SelectableText('Flutter Developer @ ABC',
                  style: FontsHelper.fontUbuntu.copyWith(
                      fontSize: 20,
                      color: ColorsHelper.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            margin: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: ColorsHelper.defaultPrimaryColor.withAlpha(200),
                    width: 2)),
            child: ListTile(
              horizontalTitleGap: 15,
              style: ListTileStyle.list,
              isThreeLine: true,
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '(2020-2025)',
                        style: FontsHelper.fontUbuntu
                            .copyWith(color: Colors.grey, fontSize: 12),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  SelectableText(
                      '''Developed and maintained high-performance cross-platform mobile applications using Flutter, collaborating closely with cross-functional teams including UI/UX designers, backend developers, and QA engineers.
            
Integrated RESTful APIs, Firebase FCM services, implemented state management solutions like Provider and used clean code architecture, contributing to robust, scalable, and user-friendly app architectures.
            ''',
                      style: FontsHelper.fontUbuntu
                          .copyWith(color: ColorsHelper.white, fontSize: 14)),
                ],
              ),
              leading: Image.asset(
                'assets/tech/flutter.png',
                fit: BoxFit.cover,
              ),
              title: SelectableText('Flutter Developer @ ABC',
                  style: FontsHelper.fontUbuntu.copyWith(
                      fontSize: 20,
                      color: ColorsHelper.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
