import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:portfolio_2025/app/about/presentation/screens/d_about_page.dart';
import 'package:portfolio_2025/app/blog/presentation/screens/d_blog_page.dart';
import 'package:portfolio_2025/app/contact/presentation/screens/d_contact_page.dart';
import 'package:portfolio_2025/app/experience/presentation/screens/d_experience_page.dart';
import 'package:portfolio_2025/app/landing_page/presentation/screens/d_landing_page.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/d_topbar.dart';
import 'package:portfolio_2025/app/tech/presentation/screens/d_tech_page.dart';
import 'package:portfolio_2025/app/projects/presentation/screens/d_projects_page.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class MainCanvasScreen extends StatelessWidget {
  const MainCanvasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MqHelper>(
        init: MqHelper(),
        id: 'canvas',
        builder: (controller) {
          controller.setSize(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height);
          return Scaffold(
            backgroundColor: ColorsHelper.defaultCanvasColor,
            body: const SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DTopbar(),
                  DLandingPage(),
                  DAboutPage(),
                  DTechPage(),
                  DProjectsPage(),
                  DExperiencePage(),
                  DBlogPage(),
                  DContactPage()
                ],
              ),
            ),
          );
        });
  }
}
