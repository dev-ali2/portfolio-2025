import 'package:flutter/material.dart';
import 'package:portfolio_2025/core/common/widgets/pages_header.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class DExperiencePage extends StatelessWidget {
  const DExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        spacing: 40,
        mainAxisSize: MainAxisSize.min,
        children: [
          const PagesHeader(title: 'Work Experience'),
          ListTile(
            isThreeLine: true,
            subtitle: SelectableText(
                '''Developed and maintained high-performance cross-platform mobile applications using Flutter, collaborating closely with cross-functional teams including UI/UX designers, backend developers, and QA engineers.

Integrated RESTful APIs, Firebase FCM services, implemented state management solutions like Provider and used clean code architecture, contributing to robust, scalable, and user-friendly app architectures.
''',
                style: FontsHelper.fontUbuntu
                    .copyWith(color: Colors.grey, fontSize: 14)),
            leading: Image.asset('assets/tech/flutter.png'),
            title: SelectableText('Flutter Developer @ ABC',
                style: FontsHelper.fontUbuntu.copyWith(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            trailing: SelectableText(
              'Date not specified',
              style: FontsHelper.fontUbuntu
                  .copyWith(color: Colors.grey, fontSize: 14),
            ),
          ),
          ListTile(
              isThreeLine: true,
              subtitle: SelectableText(
                  '''Collaborated with global clients to deliver tailored Flutter applications, maintaining clear and consistent communication across time zones to ensure alignment with project goals and expectations.

Implemented real-time features using Agora SDK for voice/video communication and integrated Azure AD B2C for secure user authentication, enhancing app functionality and enterprise-grade security.
''',
                  style: FontsHelper.fontUbuntu
                      .copyWith(color: Colors.grey, fontSize: 14)),
              leading: Image.asset('assets/tech/flutter.png'),
              title: SelectableText('Flutter Developer @ ABC',
                  style: FontsHelper.fontUbuntu.copyWith(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              trailing: SelectableText(
                'Date not specified',
                style: FontsHelper.fontUbuntu
                    .copyWith(color: Colors.grey, fontSize: 14),
              ))
        ],
      ),
    );
  }
}
