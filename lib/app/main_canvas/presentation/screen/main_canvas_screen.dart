import 'dart:developer';
import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/about/presentation/screens/d_about_page.dart';
import 'package:portfolio_2025/app/blog/presentation/screens/d_blog_page.dart';
import 'package:portfolio_2025/app/contact/presentation/screens/d_contact_page.dart';
import 'package:portfolio_2025/app/experience/presentation/screens/d_experience_page.dart';
import 'package:portfolio_2025/app/footer/presentation/widget/d_footer.dart';
import 'package:portfolio_2025/app/landing_page/presentation/screens/d_landing_page.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/d_topbar.dart';
import 'package:portfolio_2025/app/tech/presentation/screens/d_tech_page.dart';
import 'package:portfolio_2025/app/projects/presentation/screens/d_projects_page.dart';
import 'package:portfolio_2025/app/testimonial/presentation/screens/d_testimonial_page.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/keys/widget_keys.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

// Isolate message classes for communication
class PointerUpdateMessage {
  final Offset targetPosition;
  final Offset currentPosition;

  PointerUpdateMessage({
    required this.targetPosition,
    required this.currentPosition,
  });
}

class PointerResultMessage {
  final Offset newPosition;
  final bool isNearTarget;
  final double distance;

  PointerResultMessage({
    required this.newPosition,
    required this.isNearTarget,
    required this.distance,
  });
}

class IsolateSetupMessage {
  final SendPort sendPort;

  IsolateSetupMessage(this.sendPort);
}

// Isolate entry point function
void _pointerComputationIsolate(SendPort mainSendPort) {
  final receivePort = ReceivePort();
  mainSendPort.send(IsolateSetupMessage(receivePort.sendPort));

  const double lerpFactor = 0.2;
  const double nearDistance = 25.0;
  const double minMovement = 0.3;

  receivePort.listen((dynamic message) {
    if (message is PointerUpdateMessage) {
      final distance =
          (message.currentPosition - message.targetPosition).distance;

      if (distance > minMovement) {
        double dynamicLerpFactor = lerpFactor;
        if (distance > 100) {
          dynamicLerpFactor = 0.3;
        } else if (distance < 30) {
          dynamicLerpFactor = 0.15;
        }

        final newPosition = Offset.lerp(
          message.currentPosition,
          message.targetPosition,
          dynamicLerpFactor,
        )!;

        final isNearTarget = distance < nearDistance;

        mainSendPort.send(PointerResultMessage(
          newPosition: newPosition,
          isNearTarget: isNearTarget,
          distance: distance,
        ));
      }
    }
  });
}

class MainCanvasScreen extends StatefulWidget {
  const MainCanvasScreen({super.key});

  @override
  State<MainCanvasScreen> createState() => _MainCanvasScreenState();
}

class _MainCanvasScreenState extends State<MainCanvasScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final dataController = Get.find<DataController>();
  late AnimationController _elasticController;
  late AnimationController _carouselController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  final ValueNotifier<Offset> _currentPositionNotifier =
      ValueNotifier(const Offset(0, 0));
  final ValueNotifier<bool> _isNearTargetNotifier = ValueNotifier(false);

  Offset _targetPosition = const Offset(0, 0);
  Offset _currentPosition = const Offset(0, 0);
  Timer? _updateTimer;

  // Isolate related variables
  Isolate? _computationIsolate;
  ReceivePort? _mainReceivePort;
  SendPort? _isolateSendPort;
  bool _isolateReady = false;
  bool showScrollUpButton = false;

  // Carousel variables

  static const double _circleSize = 12.0;
  static const double _offsetX = -8.0;
  static const double _offsetY = -8.0;

  // Sample endorsement data - 11 endorsements

  @override
  void initState() {
    super.initState();

    _elasticController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _carouselController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.4,
    ).animate(CurvedAnimation(
      parent: _elasticController,
      curve: Curves.easeOutBack,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _carouselController,
      curve: Curves.easeInOut,
    ));

    _initializeIsolate();
  }

  Future<void> _initializeIsolate() async {
    try {
      _mainReceivePort = ReceivePort();

      _computationIsolate = await Isolate.spawn(
        _pointerComputationIsolate,
        _mainReceivePort!.sendPort,
      );

      _mainReceivePort!.listen((dynamic message) {
        if (message is IsolateSetupMessage) {
          _isolateSendPort = message.sendPort;
          _isolateReady = true;
          _startOptimizedAnimation();
        } else if (message is PointerResultMessage) {
          _handlePointerResult(message);
        }
      });
    } catch (e) {
      log('Failed to initialize isolate: $e');
      _startOptimizedAnimationMainThread();
    }
  }

  void _handlePointerResult(PointerResultMessage result) {
    _currentPosition = result.newPosition;
    _currentPositionNotifier.value = _currentPosition;

    final wasNear = _isNearTargetNotifier.value;
    if (result.isNearTarget != wasNear) {
      _isNearTargetNotifier.value = result.isNearTarget;

      if (result.isNearTarget) {
        _elasticController.forward();
      } else {
        _elasticController.reverse();
      }
    }
  }

  void _startOptimizedAnimation() {
    _updateTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (_isolateReady && _isolateSendPort != null) {
        _isolateSendPort!.send(PointerUpdateMessage(
          targetPosition: _targetPosition,
          currentPosition: _currentPosition,
        ));
      }
    });
  }

  void _startOptimizedAnimationMainThread() {
    const double lerpFactor = 0.2;
    const double nearDistance = 25.0;
    const double minMovement = 0.3;

    _updateTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      final distance = (_currentPosition - _targetPosition).distance;

      if (distance > minMovement) {
        double dynamicLerpFactor = lerpFactor;
        if (distance > 100) {
          dynamicLerpFactor = 0.3;
        } else if (distance < 30) {
          dynamicLerpFactor = 0.15;
        }

        _currentPosition =
            Offset.lerp(_currentPosition, _targetPosition, dynamicLerpFactor)!;

        final wasNear = _isNearTargetNotifier.value;
        final isNear = distance < nearDistance;

        if (isNear != wasNear) {
          _isNearTargetNotifier.value = isNear;

          if (isNear) {
            _elasticController.forward();
          } else {
            _elasticController.reverse();
          }
        }

        _currentPositionNotifier.value = _currentPosition;
      }
    });
  }

  void _updateMousePosition(Offset position) {
    _targetPosition = position;
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    _computationIsolate?.kill();
    _mainReceivePort?.close();
    _elasticController.dispose();
    _carouselController.dispose();
    _scrollController.dispose();

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
            backgroundColor: ColorsHelper.canvasColor,
            body: Stack(
              alignment: Alignment.center,
              children: [
                MouseRegion(
                  onHover: (event) {
                    if (dataController.siteData!.followMousePosition) {
                      _updateMousePosition(event.position);
                    }
                  },
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      log('${notification.metrics.pixels}');
                      if (notification.metrics.pixels >= MqHelper.height) {
                        showScrollUpButton = true;

                        Get.find<MqHelper>().update(['button']);
                      } else {
                        showScrollUpButton = false;
                        Get.find<MqHelper>().update(['button']);
                        log('Hiding button');
                      }
                      if (notification is ScrollStartNotification) {
                        // Pause the animation when scrolling starts
                        //  _elasticController.stop();
                      } else if (notification is ScrollEndNotification) {
                        // Resume the animation when scrolling ends
                        //  _elasticController.forward();
                      }
                      return true;
                    },
                    child: SingleChildScrollView(
                      // controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: GetBuilder<MqHelper>(
                        id: 'canvas options',
                        builder: (controller) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DLandingPage(),
                            const DAboutPage(),
                            const DTechPage(),
                            const DExperiencePage(),
                            const DProjectsPage(),
                            DTestimonialPage(),
                            const DBlogPage(),
                            const DContactPage(),
                            const DFooter(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (dataController.siteData!.followMousePosition)
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
                                left: currentPosition.dx + _offsetX,
                                top: currentPosition.dy + _offsetY,
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
                const Positioned(top: 10, child: DTopbar()),
                GetBuilder<MqHelper>(
                    id: 'button',
                    builder: (controller) =>
                        _buildScrollToTopButton(showScrollUpButton)),
              ],
            ),
          );
        });
  }
}

Widget _buildScrollToTopButton(bool showBtn) {
  // if (showBtn == false) {
  //   return SizedBox.shrink();
  // }
  return Positioned(
    bottom: 30,
    right: 15,
    child: AnimatedContainer(
      decoration: BoxDecoration(
        color: ColorsHelper.secondaryCanvasColor,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: ColorsHelper.defaultPrimaryColor.withAlpha(200),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      duration: const Duration(milliseconds: 600),
      width: showBtn ? 50 : 0,
      height: showBtn ? 50 : 0,
      curve: Curves.easeInOut,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        opacity: showBtn ? 1.0 : 0.0,
        curve: Curves.easeInOut,
        child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: ColorsHelper.secondaryCanvasColor,
              foregroundColor: ColorsHelper.defaultPrimaryColor,
              overlayColor: ColorsHelper.defaultPrimaryColor.withAlpha(100),
            ),
            onPressed: () {
              Scrollable.ensureVisible(landingPageKey.currentContext!,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
            icon: const Icon(Icons.arrow_upward_rounded,
                color: ColorsHelper.defaultPrimaryColor, size: 30)),
      ),
    ),
  );
}
