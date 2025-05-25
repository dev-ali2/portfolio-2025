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
              color: ColorsHelper.defaultPrimaryColor.withAlpha(200))),
      child: Column(
        spacing: 15,
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
                    ColorsHelper.defaultPrimaryColor.withAlpha(100),
                    ColorsHelper.defaultPrimaryColor.withAlpha(50)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
            child: Center(
                child: Text(
              'Pizza 47',
              style: FontsHelper.fontUbuntu.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                  color: Colors.white),
            )),
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
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ColorsHelper.defaultPrimaryColor.withAlpha(50)),
                child: Row(
                  spacing: 8,
                  children: [
                    const Icon(Icons.android),
                    Text(
                      'Android',
                      style: FontsHelper.animatedTextsFont
                          .copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ColorsHelper.defaultPrimaryColor.withAlpha(50)),
                child: Row(
                  spacing: 8,
                  children: [
                    const Icon(Icons.apple),
                    Text(
                      'IOS',
                      style: FontsHelper.animatedTextsFont
                          .copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ColorsHelper.defaultPrimaryColor.withAlpha(50)),
                child: Row(
                  spacing: 8,
                  children: [
                    const Icon(CupertinoIcons.globe),
                    Text(
                      'Web',
                      style: FontsHelper.animatedTextsFont
                          .copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Text(
              'This is a pizza app very good and ui friendly made purely on flutter and for backend I donut know which thing i used.',
              style: FontsHelper.fontUbuntu
                  .copyWith(color: Colors.white, fontSize: 18),
            ),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    foregroundColor: Colors.white,
                    backgroundColor:
                        ColorsHelper.defaultPrimaryColor.withAlpha(70)),
                onPressed: () {},
                child: const Text('View more')),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
