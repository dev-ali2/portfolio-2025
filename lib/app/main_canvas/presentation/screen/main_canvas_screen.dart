import 'dart:developer';
import 'dart:async';

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

class MainCanvasScreen extends StatefulWidget {
  const MainCanvasScreen({super.key});

  @override
  State<MainCanvasScreen> createState() => _MainCanvasScreenState();
}

class _MainCanvasScreenState extends State<MainCanvasScreen>
    with TickerProviderStateMixin {
  late AnimationController _elasticController;
  late Animation<double> _scaleAnimation;

  final ValueNotifier<Offset> _currentPositionNotifier =
      ValueNotifier(const Offset(0, 0));
  final ValueNotifier<bool> _isNearTargetNotifier = ValueNotifier(false);

  Offset _targetPosition = const Offset(0, 0);
  Offset _currentPosition = const Offset(0, 0);
  Timer? _updateTimer;

  static const double _lerpFactor = 0.2;
  static const double _nearDistance = 25.0;
  static const double _minMovement = 0.3;

  static const double _circleSize = 12.0;

  static const double _offsetX = -8.0;
  static const double _offsetY = -8.0;

  @override
  void initState() {
    super.initState();

    _elasticController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.4,
    ).animate(CurvedAnimation(
      parent: _elasticController,
      curve: Curves.easeOutBack,
    ));

    _startOptimizedAnimation();
  }

  void _startOptimizedAnimation() {
    _updateTimer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      final distance = (_currentPosition - _targetPosition).distance;

      if (distance > _minMovement) {
        double dynamicLerpFactor = _lerpFactor;
        if (distance > 100) {
          dynamicLerpFactor = 0.3;
        } else if (distance < 30) {
          dynamicLerpFactor = 0.15;
        }

        _currentPosition =
            Offset.lerp(_currentPosition, _targetPosition, dynamicLerpFactor)!;

        _checkIfNearTarget(distance);

        _currentPositionNotifier.value = _currentPosition;
      }
    });
  }

  void _checkIfNearTarget(double distance) {
    final wasNear = _isNearTargetNotifier.value;
    final isNear = distance < _nearDistance;

    if (isNear != wasNear) {
      _isNearTargetNotifier.value = isNear;

      if (isNear) {
        _elasticController.forward();
      } else {
        _elasticController.reverse();
      }
    }
  }

  void _updateMousePosition(Offset position) {
    _targetPosition = position;
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    _elasticController.dispose();
    _currentPositionNotifier.dispose();
    _isNearTargetNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('Size values: ${MqHelper.width}, ${MqHelper.height}');
    return GetBuilder<MqHelper>(
        init: MqHelper(),
        id: 'canvas',
        builder: (controller) {
          controller.setSize(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height);
          return Scaffold(
            backgroundColor: ColorsHelper.defaultCanvasColor,
            body: Stack(
              children: [
                MouseRegion(
                  onHover: (event) {
                    _updateMousePosition(event.position);
                  },
                  child: const SingleChildScrollView(
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
                ),
                ValueListenableBuilder<Offset>(
                  valueListenable: _currentPositionNotifier,
                  builder: (context, currentPosition, child) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: _isNearTargetNotifier,
                      builder: (context, isNearTarget, child) {
                        return AnimatedBuilder(
                          animation: _scaleAnimation,
                          builder: (context, child) {
                            return Positioned(
                              left: currentPosition.dx + _offsetX - 18,
                              top: currentPosition.dy + _offsetY - 8,
                              child: IgnorePointer(
                                child: Transform.scale(
                                  scale: _scaleAnimation.value,
                                  child: Container(
                                    width: _circleSize,
                                    height: _circleSize,
                                    decoration: BoxDecoration(
                                      color: isNearTarget
                                          ? ColorsHelper.defaultPrimaryColor
                                              .withAlpha(230)
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                      boxShadow: isNearTarget
                                          ? [
                                              BoxShadow(
                                                color: ColorsHelper
                                                    .defaultPrimaryColor
                                                    .withAlpha(255),
                                                blurRadius: 12,
                                                spreadRadius: 3,
                                              )
                                            ]
                                          : [
                                              BoxShadow(
                                                color: ColorsHelper
                                                    .defaultPrimaryColor
                                                    .withAlpha(170),
                                                blurRadius: 6,
                                                spreadRadius: 1,
                                              )
                                            ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        });
  }
}
