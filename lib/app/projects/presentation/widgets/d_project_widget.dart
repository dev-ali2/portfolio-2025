import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class DProjectWidget extends StatelessWidget {
  const DProjectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsGeometry.symmetric(vertical: 30),
      // height: 500,
      width: 350,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: ColorsHelper.defaultPrimaryColor.withAlpha(120))),
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 200,
            width: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    ColorsHelper.defaultPrimaryColor.withAlpha(30),
                    ColorsHelper.defaultPrimaryColor.withAlpha(30)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
            child: Stack(
              children: [
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: ColorsHelper.secondaryCanvasColor
                                  .withAlpha(200)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          child: Text(
                            'Open Source',
                            style: FontsHelper.fontUbuntu.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ColorsHelper.white),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            spacing: 8,
            children: [
              const SizedBox(
                width: 5,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ColorsHelper.secondaryCanvasColor.withAlpha(200)),
                child: Row(
                  spacing: 8,
                  children: [
                    const Icon(
                      Icons.android,
                      color: Colors.green,
                    ),
                    // Text(
                    //   'Android',
                    //   style: FontsHelper.animatedTextsFont
                    //       .copyWith(color: Colors.white),
                    // )
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ColorsHelper.secondaryCanvasColor.withAlpha(200)),
                child: Row(
                  spacing: 8,
                  children: [
                    const Icon(
                      Icons.apple,
                      color: Colors.white,
                    ),
                    // Text(
                    //   'IOS',
                    //   style: FontsHelper.animatedTextsFont
                    //       .copyWith(color: Colors.white),
                    // )
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ColorsHelper.secondaryCanvasColor.withAlpha(200)),
                child: Row(
                  spacing: 8,
                  children: [
                    const Icon(
                      CupertinoIcons.globe,
                      color: Colors.blue,
                    ),
                    // Text(
                    //   'Web',
                    //   style: FontsHelper.animatedTextsFont
                    //       .copyWith(color: Colors.white),
                    // )
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: SelectableText('App Name',
                  style: FontsHelper.fontUbuntu.copyWith(
                      color: ColorsHelper.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: SelectableText(
              'This is a pizza app very good and ui friendly made purely on flutter and for backend I donut know which thing i used.',
              style: FontsHelper.poppinsFont
                  .copyWith(color: ColorsHelper.white, fontSize: 16),
            ),
          ),
          // SizedBox(
          //   width: 200,
          //   child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(10)),
          //           foregroundColor: ColorsHelper.white,
          //           backgroundColor:
          //               ColorsHelper.secondaryCanvasColor.withAlpha(200)),
          //       onPressed: () {},
          //       child: Text(
          //         'View info',
          //         style: FontsHelper.poppinsFont.copyWith(
          //             fontSize: 14,
          //             fontWeight: FontWeight.w600,
          //             color: ColorsHelper.defaultPrimaryColor),
          //       )),
          // ),
          SizedBox(
            width: 200,
            child: TextButton(
                onPressed: () {},
                child: Text(
                  'View Info',
                  style: FontsHelper.poppinsFont.copyWith(
                      color: ColorsHelper.defaultPrimaryColor,
                      fontWeight: FontWeight.bold),
                )),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
