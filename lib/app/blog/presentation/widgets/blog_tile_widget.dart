import 'package:flutter/material.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class BlogTileWidget extends StatelessWidget {
  const BlogTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsGeometry.symmetric(vertical: 30),
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
                    ColorsHelper.defaultPrimaryColor.withAlpha(30),
                    ColorsHelper.defaultPrimaryColor.withAlpha(30)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: SelectableText(
              'This is a pizza app very good and ui friendly made purely on flutter and for backend I donut know which thing i used.',
              style: FontsHelper.fontUbuntu
                  .copyWith(color: Colors.white, fontSize: 18),
            ),
          ),
          SizedBox(
            width: 200,
            child: TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: ColorsHelper.defaultPrimaryColor,
                ),
                icon: const Icon(Icons.arrow_outward_rounded),
                onPressed: () {},
                label: Text(
                  'Visit blog',
                  style: FontsHelper.fontUbuntu
                      .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
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
