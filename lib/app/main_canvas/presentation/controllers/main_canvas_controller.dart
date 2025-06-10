import 'dart:developer';
import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/keys/widget_keys.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

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

void pointerComputationIsolate(SendPort mainSendPort) {
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

class MainCanvasController extends GetxController
    with GetTickerProviderStateMixin {
  final dataController = Get.find<DataController>();

  late AnimationController elasticController;
  late AnimationController carouselController;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;

  final ValueNotifier<Offset> currentPositionNotifier =
      ValueNotifier(const Offset(0, 0));
  final ValueNotifier<bool> isNearTargetNotifier = ValueNotifier(false);

  Offset _targetPosition = const Offset(0, 0);
  Offset _currentPosition = const Offset(0, 0);
  Timer? _updateTimer;

  Isolate? _computationIsolate;
  ReceivePort? _mainReceivePort;
  SendPort? _isolateSendPort;
  bool _isolateReady = false;

  bool _showScrollUpButton = false;
  bool get showScrollUpButton => _showScrollUpButton;

  static const double circleSize = 12.0;
  static const double offsetX = -8.0;
  static const double offsetY = -8.0;

  Offset get currentPosition => currentPositionNotifier.value;
  bool get isNearTarget => isNearTargetNotifier.value;
  bool get shouldShowMousePointer =>
      dataController.siteData!.followMousePosition;

  @override
  void onInit() {
    super.onInit();
    _initializeController();
  }

  void _initializeController() {
    elasticController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    carouselController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.4,
    ).animate(CurvedAnimation(
      parent: elasticController,
      curve: Curves.easeOutBack,
    ));

    slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: carouselController,
      curve: Curves.easeInOut,
    ));

    _initializeIsolate();
  }

  Future<void> _initializeIsolate() async {
    try {
      _mainReceivePort = ReceivePort();

      _computationIsolate = await Isolate.spawn(
        pointerComputationIsolate,
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
    currentPositionNotifier.value = _currentPosition;

    final wasNear = isNearTargetNotifier.value;
    if (result.isNearTarget != wasNear) {
      isNearTargetNotifier.value = result.isNearTarget;

      if (result.isNearTarget) {
        elasticController.forward();
      } else {
        elasticController.reverse();
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

        final wasNear = isNearTargetNotifier.value;
        final isNear = distance < nearDistance;

        if (isNear != wasNear) {
          isNearTargetNotifier.value = isNear;

          if (isNear) {
            elasticController.forward();
          } else {
            elasticController.reverse();
          }
        }

        currentPositionNotifier.value = _currentPosition;
      }
    });
  }

  void updateMousePosition(Offset position) {
    if (shouldShowMousePointer) {
      _targetPosition = position;
    }
  }

  void handleScrollNotification(ScrollNotification notification) {
    log('${notification.metrics.pixels}');

    final shouldShow = notification.metrics.pixels >= MqHelper.height;

    if (shouldShow != _showScrollUpButton) {
      _showScrollUpButton = shouldShow;
      update(['scroll-button']);

      if (_showScrollUpButton) {
        log('Showing scroll button');
      } else {
        log('Hiding scroll button');
      }
    }
  }

  void scrollToTop() {
    final context = landingPageKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void updateScreenSize(double width, double height) {
    Get.find<MqHelper>().setSize(width, height);
    update(['canvas']);
  }

  @override
  void onClose() {
    _updateTimer?.cancel();
    _computationIsolate?.kill();
    _mainReceivePort?.close();

    elasticController.dispose();
    carouselController.dispose();

    currentPositionNotifier.dispose();
    isNearTargetNotifier.dispose();

    super.onClose();
  }
}
