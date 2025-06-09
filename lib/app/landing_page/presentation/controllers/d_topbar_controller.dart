import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:isolate';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/keys/widget_keys.dart';

// Isolate message classes for topbar animations
class TopbarAnimationMessage {
  final String type;
  final Map<String, dynamic> data;

  TopbarAnimationMessage({required this.type, required this.data});
}

class TopbarAnimationResult {
  final String type;
  final Map<String, dynamic> result;

  TopbarAnimationResult({required this.type, required this.result});
}

class TopbarIsolateSetup {
  final SendPort sendPort;
  TopbarIsolateSetup(this.sendPort);
}

// Isolate for handling topbar animation calculations
void topbarAnimationIsolate(SendPort mainSendPort) {
  final receivePort = ReceivePort();
  mainSendPort.send(TopbarIsolateSetup(receivePort.sendPort));

  receivePort.listen((dynamic message) {
    if (message is TopbarAnimationMessage) {
      switch (message.type) {
        case 'calculate_hover_state':
          _calculateHoverState(message.data, mainSendPort);
          break;
        case 'calculate_animation_values':
          _calculateAnimationValues(message.data, mainSendPort);
          break;
      }
    }
  });
}

void _calculateHoverState(Map<String, dynamic> data, SendPort sendPort) {
  final hoveredItem = data['hoveredItem'] as String?;
  final itemCount = data['itemCount'] as int;
  final items = data['items'] as List<String>;

  List<bool> greyedOutStates = [];
  for (int i = 0; i < itemCount; i++) {
    final isCurrentItemHovered = hoveredItem == items[i];
    final shouldBeGreyedOut = hoveredItem != null && !isCurrentItemHovered;
    greyedOutStates.add(shouldBeGreyedOut);
  }

  sendPort.send(TopbarAnimationResult(
      type: 'hover_state_result',
      result: {'greyedOutStates': greyedOutStates}));
}

void _calculateAnimationValues(Map<String, dynamic> data, SendPort sendPort) {
  final progress = data['progress'] as double;
  final animationType = data['animationType'] as String;

  double calculatedValue;
  switch (animationType) {
    case 'container_scale':
      calculatedValue = _easeOutBack(progress);
      break;
    case 'item_entrance':
      calculatedValue = _easeOutCubic(progress);
      break;
    default:
      calculatedValue = progress;
  }

  sendPort.send(TopbarAnimationResult(
      type: 'animation_value_result',
      result: {'animationType': animationType, 'value': calculatedValue}));
}

// Easing functions
double _easeOutBack(double t) {
  const c1 = 1.70158;
  const c3 = c1 + 1;
  return 1 + c3 * (t - 1) * (t - 1) * (t - 1) + c1 * (t - 1) * (t - 1);
}

double _easeOutCubic(double t) {
  return 1 - (1 - t) * (1 - t) * (1 - t);
}

class DTopBarController extends GetxController
    with GetTickerProviderStateMixin {
  // Core state variables
  String? _hoveredItem;
  String? get hoveredItem => _hoveredItem;

  List<bool> _greyedOutStates = [];
  List<bool> get greyedOutStates => _greyedOutStates;

  // Animation controllers
  late AnimationController containerAnimationController;
  late AnimationController itemsAnimationController;
  late Animation<double> containerSizeAnimation;
  late Animation<double> containerOpacityAnimation;

  // Animation states
  bool _showContainer = false;
  bool get showContainer => _showContainer;

  bool _isContainerVisible = false;
  bool get isContainerVisible => _isContainerVisible;

  List<bool> _visibleItems = [];
  List<bool> get visibleItems => _visibleItems;

  Timer? _itemAnimationTimer;

  // Isolate related variables
  Isolate? _animationIsolate;
  ReceivePort? _mainReceivePort;
  SendPort? _isolateSendPort;
  bool _isolateReady = false;
  bool get isolateReady => _isolateReady;

  // Performance optimization - cache enabled options
  List<dynamic> _enabledOptions = [];
  List<dynamic> get enabledOptions => _enabledOptions;

  @override
  void onInit() {
    super.onInit();
    _initializeController();
  }

  void _initializeController() {
    // Cache enabled options to avoid repeated filtering
    _enabledOptions = Get.find<DataController>()
            .siteData
            ?.landingPageModel
            .topBarOptions
            .where((option) => option.isEnabled)
            .toList() ??
        [];

    // Initialize animation controllers
    containerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    itemsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Setup animations
    containerSizeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: containerAnimationController,
      curve: Curves.easeOutBack,
    ));

    containerOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: containerAnimationController,
      curve: Curves.easeInOut,
    ));

    // Initialize state arrays
    _visibleItems = List.filled(_enabledOptions.length, false);
    _greyedOutStates = List.filled(_enabledOptions.length, false);

    // Start initialization sequence
    _initializeIsolate();
    _startEntranceAnimation();
  }

  Future<void> _initializeIsolate() async {
    try {
      _mainReceivePort = ReceivePort();

      _animationIsolate = await Isolate.spawn(
        topbarAnimationIsolate,
        _mainReceivePort!.sendPort,
      );

      _mainReceivePort!.listen((dynamic message) {
        if (message is TopbarIsolateSetup) {
          _isolateSendPort = message.sendPort;
          _isolateReady = true;
        } else if (message is TopbarAnimationResult) {
          _handleAnimationResult(message);
        }
      });
    } catch (e) {
      // Fallback to main thread if isolate fails
      _isolateReady = false;
    }
  }

  void _handleAnimationResult(TopbarAnimationResult result) {
    switch (result.type) {
      case 'hover_state_result':
        _greyedOutStates = List<bool>.from(result.result['greyedOutStates']);
        update(); // Trigger UI rebuild
        break;
    }
  }

  void _startEntranceAnimation() {
    Timer(const Duration(milliseconds: 500), () {
      _showContainer = true;
      update();

      Timer(const Duration(milliseconds: 50), () {
        _isContainerVisible = true;
        update();
        containerAnimationController.forward();

        Timer(const Duration(milliseconds: 300), () {
          _showItemsSequentially();
        });
      });
    });
  }

  void _showItemsSequentially() {
    int currentIndex = 0;

    _itemAnimationTimer = Timer.periodic(
      const Duration(milliseconds: 150),
      (timer) {
        if (currentIndex < _visibleItems.length) {
          _visibleItems[currentIndex] = true;
          update();
          currentIndex++;
        } else {
          timer.cancel();
        }
      },
    );
  }

  void setHoveredItem(String? itemText) {
    _hoveredItem = itemText;

    if (_isolateReady && _isolateSendPort != null) {
      // Use isolate for hover state calculation
      _isolateSendPort!
          .send(TopbarAnimationMessage(type: 'calculate_hover_state', data: {
        'hoveredItem': itemText,
        'itemCount': _enabledOptions.length,
        'items': _enabledOptions.map((e) => e.title as String).toList(),
      }));
    } else {
      // Fallback to main thread
      _calculateHoverStateMainThread(itemText);
    }
  }

  void _calculateHoverStateMainThread(String? itemText) {
    for (int i = 0; i < _enabledOptions.length; i++) {
      final isCurrentItemHovered = itemText == _enabledOptions[i].title;
      final shouldBeGreyedOut = itemText != null && !isCurrentItemHovered;
      _greyedOutStates[i] = shouldBeGreyedOut;
    }
    update();
  }

  void onItemPressed(String title) {
    scrollToWidget(title);
  }

  bool isItemGreyedOut(int index) {
    return index < _greyedOutStates.length ? _greyedOutStates[index] : false;
  }

  bool isItemVisible(int index) {
    return index < _visibleItems.length ? _visibleItems[index] : false;
  }

  bool isCurrentItemHovered(String title) {
    return _hoveredItem == title;
  }

  @override
  void onClose() {
    containerAnimationController.dispose();
    itemsAnimationController.dispose();
    _itemAnimationTimer?.cancel();
    _animationIsolate?.kill();
    _mainReceivePort?.close();
    super.onClose();
  }
}

// Utility function for scrolling - can be moved to a separate utils file
void scrollToWidget(String title) {
  BuildContext? context;

  final lowercaseTitle = title.toString().toLowerCase();

  if (lowercaseTitle.contains('about')) {
    context = aboutPageKey.currentContext;
  } else if (lowercaseTitle.contains('tech')) {
    context = techPageKey.currentContext;
  } else if (lowercaseTitle.contains('projects')) {
    context = projectsPageKey.currentContext;
  } else if (lowercaseTitle.contains('experience')) {
    context = workExperiencePageKey.currentContext;
  } else if (lowercaseTitle.contains('blog')) {
    context = blogPageKey.currentContext;
  } else if (lowercaseTitle.contains('testimonials') ||
      lowercaseTitle.contains('reviews') ||
      lowercaseTitle.contains('feedback') ||
      lowercaseTitle.contains('endorsements') ||
      lowercaseTitle.contains('references')) {
    context = testimonialsPageKey.currentContext;
  } else if (lowercaseTitle.contains('contact')) {
    context = contactPageKey.currentContext;
  } else {
    context = landingPageKey.currentContext;
  }

  if (context != null) {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOut,
    );
  }
}
