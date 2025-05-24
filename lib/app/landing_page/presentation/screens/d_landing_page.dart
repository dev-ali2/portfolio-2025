import 'dart:ui';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/bottom_quick_info.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/date_time_widget.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/left_section_widget.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/right_section_widget.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';

class DLandingPage extends StatefulWidget {
  const DLandingPage({super.key});

  @override
  State<DLandingPage> createState() => _DLandingPageState();
}

class _DLandingPageState extends State<DLandingPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      child: Stack(
        children: [
          AnimatedBackground(
              vsync: this,
              behaviour: RandomParticleBehaviour(
                  options: const ParticleOptions(
                spawnMaxRadius: 10,
                spawnMinSpeed: 20,
                spawnMaxSpeed: 30,
                particleCount: 60,
                baseColor: ColorsHelper.defaultPrimaryColor,
                opacityChangeRate: 0.1,
                spawnMinRadius: 10,
              )),
              child: const SizedBox.shrink()),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorsHelper.defaultPrimaryColor.withAlpha(60),
                          width: 2),
                      color: Colors.black.withAlpha(100),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Column(
                    spacing: 20,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DateTimeWidget(),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: LeftSectionWidget()),
                          RightSectionWidget()
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      BottomQuickInfo()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
