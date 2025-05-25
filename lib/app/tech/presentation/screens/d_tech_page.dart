import 'package:flutter/material.dart';
import 'package:portfolio_2025/app/tech/presentation/widgets/tech_image_widget.dart';
import 'package:portfolio_2025/core/common/widgets/pages_header.dart';

class DTechPage extends StatelessWidget {
  const DTechPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: const Column(
        spacing: 30,
        mainAxisSize: MainAxisSize.min,
        children: [
          PagesHeader(title: 'Tech stack'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70),
            child: Wrap(
              alignment: WrapAlignment.center,
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
            ),
          )
        ],
      ),
    );
  }
}
