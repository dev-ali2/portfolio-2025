import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_2025/core/common/models/blog_model.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogTileWidget extends StatelessWidget {
  final BlogItem blogItem;
  const BlogTileWidget({super.key, required this.blogItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsGeometry.symmetric(vertical: 30),
      width: 350,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: ColorsHelper.secondaryCanvasColor, width: 2)),
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
              color: ColorsHelper.white,
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      CupertinoIcons.photo,
                      size: 50,
                      color: ColorsHelper.secondaryCanvasColor,
                    );
                  },
                  blogItem.imageUrl,
                  fit: BoxFit.cover,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: SelectableText(
              maxLines: 3,
              blogItem.description,
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
                onPressed: () async {
                  if (await canLaunchUrl(Uri.parse(blogItem.link))) {
                    await launchUrl(Uri.parse(blogItem.link));
                  } else {
                    return;
                  }
                },
                label: Text(
                  'Visit blog',
                  style: FontsHelper.fontUbuntu
                      .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                )),
          ),
          const SizedBox(
            height: 0,
          )
        ],
      ),
    );
  }
}
