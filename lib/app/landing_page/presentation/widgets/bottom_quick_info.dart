import 'package:flutter/material.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class BottomQuickInfo extends StatelessWidget {
  const BottomQuickInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 10,
          children: [
            SelectableText(
              '~3',
              style: FontsHelper.fontUbuntu.copyWith(
                  color: ColorsHelper.defaultPrimaryColor,
                  fontSize: 27,
                  fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  textAlign: TextAlign.left,
                  'Years',
                  style: FontsHelper.fontUbuntu.copyWith(
                    fontSize: 19,
                  ),
                ),
                SelectableText('Experience',
                    style: FontsHelper.fontUbuntu.copyWith(
                      fontSize: 19,
                    ))
              ],
            )
          ],
        ),
        Row(
          spacing: 10,
          children: [
            SelectableText(
              '20+',
              style: FontsHelper.fontUbuntu.copyWith(
                  color: ColorsHelper.defaultPrimaryColor,
                  fontSize: 27,
                  fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  textAlign: TextAlign.left,
                  'Projects',
                  style: FontsHelper.fontUbuntu.copyWith(
                    fontSize: 19,
                  ),
                ),
                SelectableText('Completed',
                    style: FontsHelper.fontUbuntu.copyWith(
                      fontSize: 19,
                    ))
              ],
            )
          ],
        ),
        Row(
          spacing: 10,
          children: [
            SelectableText(
              '8+',
              style: FontsHelper.fontUbuntu.copyWith(
                  color: ColorsHelper.defaultPrimaryColor,
                  fontSize: 27,
                  fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  textAlign: TextAlign.left,
                  'Open-Souce',
                  style: FontsHelper.fontUbuntu.copyWith(
                    fontSize: 19,
                  ),
                ),
                SelectableText('Contributions',
                    style: FontsHelper.fontUbuntu.copyWith(
                      fontSize: 19,
                    ))
              ],
            )
          ],
        ),
      ],
    );
  }
}
