import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:portfolio_2025/app/projects/presentation/widgets/d_project_widget.dart';
import 'package:portfolio_2025/core/common/widgets/pages_header.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class DProjectsPage extends StatelessWidget {
  const DProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 60),
      child: Column(
        spacing: 60,
        mainAxisSize: MainAxisSize.min,
        children: [
          const PagesHeader(title: 'Featured work'),
          const Wrap(
            spacing: 40,
            alignment: WrapAlignment.center,
            children: [
              DProjectWidget(),
              DProjectWidget(),
              DProjectWidget(),
              DProjectWidget(),
            ],
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: ColorsHelper.defaultPrimaryColor,
            ),
            onPressed: () {},
            label: Text(
              'Explore More',
              style: FontsHelper.fontUbuntu
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            icon: const Icon(
              BoxIcons.bxl_github,
              size: 30,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 45),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: SelectableText(
          //       'Open source contributions',
          //       style: FontsHelper.fontUbuntu.copyWith(
          //           decorationColor: ColorsHelper.defaultPrimaryColor,
          //           fontSize: 30,
          //           color: ColorsHelper.defaultPrimaryColor,
          //           fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),
          // const Wrap(
          //   spacing: 40,
          //   alignment: WrapAlignment.start,
          //   children: [
          //     DProjectWidget(),
          //     DProjectWidget(),
          //     DProjectWidget(),
          //     DProjectWidget(),
          //     DProjectWidget(),
          //     DProjectWidget(),
          //   ],
          // ),
        ],
      ),
    );
  }
}
