import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/about/presentation/screens/d_about_page.dart';
import 'package:portfolio_2025/app/about/presentation/screens/m_about_page.dart';
import 'package:portfolio_2025/app/about/presentation/screens/t_about_page.dart';
import 'package:portfolio_2025/app/blog/presentation/screens/d_blog_page.dart';
import 'package:portfolio_2025/app/blog/presentation/screens/m_blog_page.dart';
import 'package:portfolio_2025/app/blog/presentation/screens/t_blog_page.dart';
import 'package:portfolio_2025/app/contact/presentation/screens/d_contact_page.dart';
import 'package:portfolio_2025/app/contact/presentation/screens/m_contact_page.dart';
import 'package:portfolio_2025/app/contact/presentation/screens/t_contact_page.dart';
import 'package:portfolio_2025/app/experience/presentation/screens/d_experience_page.dart';
import 'package:portfolio_2025/app/experience/presentation/screens/m_experience_page.dart';
import 'package:portfolio_2025/app/experience/presentation/screens/t_experience_page.dart';
import 'package:portfolio_2025/app/footer/presentation/widget/d_footer.dart';
import 'package:portfolio_2025/app/landing_page/presentation/screens/d_landing_page.dart';
import 'package:portfolio_2025/app/landing_page/presentation/screens/m_landing_page.dart';
import 'package:portfolio_2025/app/landing_page/presentation/screens/t_landing_page.dart';
import 'package:portfolio_2025/app/main_canvas/presentation/controllers/main_canvas_controller.dart';
import 'package:portfolio_2025/app/main_canvas/presentation/widgets/follower_dot.dart';
import 'package:portfolio_2025/app/main_canvas/presentation/widgets/scroll_to_up_btn.dart';
import 'package:portfolio_2025/app/projects/presentation/screens/m_projects_page.dart';
import 'package:portfolio_2025/app/projects/presentation/screens/t_projects_page.dart';
import 'package:portfolio_2025/app/tech/presentation/screens/d_tech_page.dart';
import 'package:portfolio_2025/app/projects/presentation/screens/d_projects_page.dart';
import 'package:portfolio_2025/app/tech/presentation/screens/m_tech_page.dart';
import 'package:portfolio_2025/app/tech/presentation/screens/t_tech_page.dart';
import 'package:portfolio_2025/app/testimonial/presentation/screens/d_testimonial_page.dart';
import 'package:portfolio_2025/app/testimonial/presentation/screens/m_testimonial_page.dart';
import 'package:portfolio_2025/app/testimonial/presentation/screens/t_testimonial_page.dart';
import 'package:portfolio_2025/core/common/widgets/responsive_widget.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class MainCanvasScreen extends StatelessWidget {
  const MainCanvasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainCanvasController>(
      init: MainCanvasController(),
      builder: (controller) {
        return GetBuilder<MqHelper>(
          init: MqHelper(),
          id: 'canvas',
          builder: (mqController) {
            controller.updateScreenSize(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            );

            return Scaffold(
              backgroundColor: ColorsHelper.canvasColor,
              body: Stack(
                alignment: Alignment.center,
                children: [
                  _buildScrollableContent(controller),

                  // Mouse pointer overlay
                  if (controller.shouldShowMousePointer && MqHelper.width > 999)
                    FollowerDot(controller: controller),

                  GetBuilder<MainCanvasController>(
                    id: 'scroll-button',
                    builder: (controller) => ScrollToUpBtn(
                      controller: controller,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildScrollableContent(MainCanvasController controller) {
    return MouseRegion(
      onHover: (event) => controller.updateMousePosition(event.position),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          controller.handleScrollNotification(notification);
          return true;
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: GetBuilder<MqHelper>(
            id: 'canvas options',
            builder: (mqController) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ResponsiveWidget(
                    mobileWidget: MLandingPage(),
                    tabletWidget: TLandingPage(),
                    desktopWidget: DLandingPage()),
                const ResponsiveWidget(
                    mobileWidget: MAboutPage(),
                    tabletWidget: TAboutPage(),
                    desktopWidget: DAboutPage()),
                const ResponsiveWidget(
                    mobileWidget: MTechPage(),
                    tabletWidget: TTechPage(),
                    desktopWidget: DTechPage()),
                const ResponsiveWidget(
                    mobileWidget: MExperiencePage(),
                    tabletWidget: TExperiencePage(),
                    desktopWidget: DExperiencePage()),
                const ResponsiveWidget(
                    mobileWidget: MProjectsPage(),
                    tabletWidget: TProjectsPage(),
                    desktopWidget: DProjectsPage()),
                ResponsiveWidget(
                  mobileWidget: MTestimonialPage(),
                  tabletWidget: TTestimonialPage(),
                  desktopWidget: DTestimonialPage(),
                ),
                const ResponsiveWidget(
                  mobileWidget: MBlogPage(),
                  tabletWidget: TBlogPage(),
                  desktopWidget: DBlogPage(),
                ),
                const ResponsiveWidget(
                  mobileWidget: MContactPage(),
                  tabletWidget: TContactPage(),
                  desktopWidget: DContactPage(),
                ),
                const DFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
