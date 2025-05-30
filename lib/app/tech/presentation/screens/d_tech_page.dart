import 'package:flutter/material.dart';
import 'package:portfolio_2025/app/tech/presentation/widgets/tech_image_widget.dart';
import 'package:portfolio_2025/core/common/widgets/pages_header.dart';

class DTechPage extends StatelessWidget {
  const DTechPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 60),
      child: const Column(
        spacing: 60,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PagesHeader(title: 'Tech stack'),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 40,
            runSpacing: 40,
            children: [
              TechImageWidget(
                image: 'assets/tech/flutter.png',
                title: 'Flutter',
              ),
              TechImageWidget(
                image: 'assets/tech/kotlin.png',
                title: 'Kotlin',
              ),
              TechImageWidget(
                image: 'assets/tech/js.webp',
                title: 'JavaScript',
              ),
              TechImageWidget(
                image: 'assets/tech/node.webp',
                title: 'Node.js',
              ),
              TechImageWidget(
                image: 'assets/tech/api.png',
                title: 'REST APIs',
              ),
              TechImageWidget(
                image: 'assets/tech/firebase.png',
                title: 'Firebase',
              ),
              TechImageWidget(
                image: 'assets/tech/supabase.png',
                title: 'Supabase',
              ),
              TechImageWidget(
                image: 'assets/tech/appwrite.webp',
                title: 'App-Write',
              ),
              TechImageWidget(
                image: 'assets/tech/github.png',
                title: 'GitHub',
              ),
            ],
          )
        ],
      ),
    );
  }
}
