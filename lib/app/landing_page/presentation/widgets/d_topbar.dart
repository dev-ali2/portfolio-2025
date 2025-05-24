import 'package:flutter/material.dart';
import 'package:portfolio_2025/app/landing_page/data/d_topbar_options.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class DTopbar extends StatelessWidget {
  const DTopbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MqHelper.width,
      height: 90,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: MqHelper.width * 0.01),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  '<Ali/>',
                  style: FontsHelper.headerLogoFont.copyWith(
                      color: ColorsHelper.defaultPrimaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Flexible(
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Center(
                      child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onHover: (event) {},
                          child: TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor:
                                    ColorsHelper.defaultPrimaryColor),
                            onPressed: () {},
                            child: Text(DTopbarOptions.topbarItems[index].title,
                                style: FontsHelper.fontUbuntu.copyWith(
                                    fontSize: 17, color: Colors.white)),
                          )),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: MqHelper.width * 0.01);
                  },
                  itemCount: DTopbarOptions.topbarItems.length),
            ),
          ],
        ),
      ),
    );
  }
}
