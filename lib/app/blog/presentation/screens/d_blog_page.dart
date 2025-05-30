import 'package:flutter/material.dart';
import 'package:portfolio_2025/app/blog/presentation/widgets/blog_tile_widget.dart';
import 'package:portfolio_2025/core/common/widgets/pages_header.dart';

class DBlogPage extends StatelessWidget {
  const DBlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 60),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 60,
        children: [
          PagesHeader(title: 'Recent blogs'),
          Wrap(
            spacing: 40,
            alignment: WrapAlignment.start,
            children: [
              BlogTileWidget(),
              BlogTileWidget(),
              BlogTileWidget(),
              BlogTileWidget(),
              BlogTileWidget(),
              BlogTileWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
