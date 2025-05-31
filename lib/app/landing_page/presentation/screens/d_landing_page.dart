
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/d_topbar.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/landing_page_contact.dart';
import 'package:portfolio_2025/app/projects/presentation/widgets/blinking_down_circle_widget.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class DLandingPage extends StatefulWidget {
  const DLandingPage({super.key});

  @override
  State<DLandingPage> createState() => _DLandingPageState();
}

class _DLandingPageState extends State<DLandingPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: MqHelper.width,
          height: MqHelper.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/jpgs/bg_img.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            child: Center(
              child: Column(
                spacing: 40,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SelectableText(
                    'ALI RAZA',
                    style: GoogleFonts.poppins(
                        color: ColorsHelper.white,
                        wordSpacing: 15,
                        height: 0.8,
                        fontSize: 100,
                        fontWeight: FontWeight.bold),
                  ),
                  SelectableText(
                    'Software Engineer, Front end & APP Developer',
                    style: GoogleFonts.poppins(
                      color: ColorsHelper.white,
                      fontSize: 30,
                      height: 0.8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const LandingPageContact(),
                ],
              ),
            ),
          ),
        ),
        const Positioned(top: 10, child: DTopbar()),
        const Positioned(bottom: 10, child: BlinkingDownArrowCircle())
      ],
    );
  }
}
