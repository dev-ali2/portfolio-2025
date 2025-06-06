import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'dart:async';
import 'dart:isolate';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

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
void _topbarAnimationIsolate(SendPort mainSendPort) {
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

class DTopbar extends StatefulWidget {
  const DTopbar({super.key});

  @override
  State<DTopbar> createState() => _DTopbarState();
}

class _DTopbarState extends State<DTopbar> with TickerProviderStateMixin {
  String? _hoveredItem;
  List<bool> _greyedOutStates = [];

  // Animation controllers and states
  late AnimationController _containerAnimationController;
  late AnimationController _itemsAnimationController;
  late Animation<double> _containerSizeAnimation;
  late Animation<double> _containerOpacityAnimation;

  bool _showContainer = false;
  bool _isContainerVisible = false;
  List<bool> _visibleItems = [];
  Timer? _itemAnimationTimer;

  // Isolate related variables
  Isolate? _animationIsolate;
  ReceivePort? _mainReceivePort;
  SendPort? _isolateSendPort;
  bool _isolateReady = false;

  // Performance optimization - cache enabled options
  late List<dynamic> _enabledOptions;

  @override
  void initState() {
    super.initState();

    // Cache enabled options to avoid repeated filtering
    // _enabledOptions =
    //     DTopbarOptions.topbarItems.where((option) => option.isEnabled).toList();
    _enabledOptions = Get.find<DataController>()
            .siteData
            ?.landingPageModel
            .topBarOptions
            .where((option) => option.isEnabled)
            .toList() ??
        [];

    _containerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _itemsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _containerSizeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _containerAnimationController,
      curve: Curves.easeOutBack,
    ));

    _containerOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _containerAnimationController,
      curve: Curves.easeInOut,
    ));

    _visibleItems = List.filled(_enabledOptions.length, false);
    _greyedOutStates = List.filled(_enabledOptions.length, false);

    _initializeIsolate();
    _startEntranceAnimation();
  }

  Future<void> _initializeIsolate() async {
    try {
      _mainReceivePort = ReceivePort();

      _animationIsolate = await Isolate.spawn(
        _topbarAnimationIsolate,
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
        if (mounted) {
          setState(() {
            _greyedOutStates =
                List<bool>.from(result.result['greyedOutStates']);
          });
        }
        break;
    }
  }

  void _startEntranceAnimation() {
    Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _showContainer = true;
        });

        Timer(const Duration(milliseconds: 50), () {
          if (mounted) {
            setState(() {
              _isContainerVisible = true;
            });
            _containerAnimationController.forward();

            Timer(const Duration(milliseconds: 300), () {
              _showItemsSequentially();
            });
          }
        });
      }
    });
  }

  void _showItemsSequentially() {
    int currentIndex = 0;

    _itemAnimationTimer = Timer.periodic(
      const Duration(milliseconds: 150),
      (timer) {
        if (currentIndex < _visibleItems.length) {
          setState(() {
            _visibleItems[currentIndex] = true;
          });
          currentIndex++;
        } else {
          timer.cancel();
        }
      },
    );
  }

  void _setHoveredItem(String? itemText) {
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
    setState(() {
      for (int i = 0; i < _enabledOptions.length; i++) {
        final isCurrentItemHovered = itemText == _enabledOptions[i].title;
        final shouldBeGreyedOut = itemText != null && !isCurrentItemHovered;
        _greyedOutStates[i] = shouldBeGreyedOut;
      }
    });
  }

  @override
  void dispose() {
    _containerAnimationController.dispose();
    _itemsAnimationController.dispose();
    _itemAnimationTimer?.cancel();
    _animationIsolate?.kill();
    _mainReceivePort?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MqHelper.width,
      height: 90,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_showContainer)
              Center(
                child: AnimatedBuilder(
                  animation: Listenable.merge([
                    _containerSizeAnimation,
                    _containerOpacityAnimation,
                  ]),
                  builder: (context, child) {
                    return Opacity(
                      opacity: _isContainerVisible
                          ? _containerOpacityAnimation.value
                          : 0.0,
                      child: Transform.scale(
                        scaleX: _containerSizeAnimation.value,
                        scaleY: _containerSizeAnimation.value,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white.withAlpha(5),
                            border: Border.all(
                              color: Colors.white.withAlpha(60),
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: _buildNavigationItems(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNavigationItems() {
    List<Widget> items = [];

    for (int i = 0; i < _enabledOptions.length; i++) {
      final isCurrentItemHovered = _hoveredItem == _enabledOptions[i].title;
      final shouldBeGreyedOut =
          i < _greyedOutStates.length ? _greyedOutStates[i] : false;
      final isItemVisible = i < _visibleItems.length ? _visibleItems[i] : false;

      items.add(
        _OptimizedAnimatedTextButton(
          key: ValueKey('${_enabledOptions[i].title}_$i'),
          text: _enabledOptions[i].title,
          onPressed: () {},
          onHoverChanged: _setHoveredItem,
          isGreyedOut: shouldBeGreyedOut,
          isVisible: isItemVisible,
          animationDelay: i * 150,
        ),
      );

      if (i < _enabledOptions.length - 1) {
        items.add(_buildOptimizedSeparator(shouldBeGreyedOut, i));
      }
    }

    return items;
  }

  Widget _buildOptimizedSeparator(bool isGreyedOut, int index) {
    final isVisible =
        (index + 1) < _visibleItems.length ? _visibleItems[index + 1] : false;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isVisible ? 1.0 : 0.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: isGreyedOut
                ? Colors.grey.withOpacity(0.3)
                : Colors.grey.withOpacity(0.6),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _OptimizedAnimatedTextButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Function(String?) onHoverChanged;
  final bool isGreyedOut;
  final bool isVisible;
  final int animationDelay;

  const _OptimizedAnimatedTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.onHoverChanged,
    required this.isGreyedOut,
    required this.isVisible,
    required this.animationDelay,
  });

  @override
  State<_OptimizedAnimatedTextButton> createState() =>
      _OptimizedAnimatedTextButtonState();
}

class _OptimizedAnimatedTextButtonState
    extends State<_OptimizedAnimatedTextButton> with TickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _hoverAnimationController;
  late AnimationController _entranceAnimationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _entranceAnimation;
  late Animation<Offset> _slideAnimation;

  // Performance cache
  late TextStyle _baseTextStyle;
  late TextStyle _hoveredTextStyle;
  late TextStyle _greyedTextStyle;

  @override
  void initState() {
    super.initState();

    // Cache text styles to avoid repeated style creation
    _baseTextStyle = FontsHelper.fontUbuntu.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.white.withAlpha(200),
    );

    _hoveredTextStyle = _baseTextStyle.copyWith(
      fontWeight: FontWeight.bold,
      color: ColorsHelper.defaultPrimaryColor,
    );

    _greyedTextStyle = _baseTextStyle.copyWith(
      color: Colors.white.withOpacity(0.5),
    );

    _hoverAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _entranceAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _hoverAnimationController,
      curve: Curves.easeInOut,
    ));

    _entranceAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _entranceAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceAnimationController,
      curve: Curves.easeOutBack,
    ));
  }

  @override
  void didUpdateWidget(_OptimizedAnimatedTextButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isVisible && !oldWidget.isVisible) {
      _entranceAnimationController.forward();
    }
  }

  @override
  void dispose() {
    _hoverAnimationController.dispose();
    _entranceAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: Listenable.merge([_entranceAnimation, _slideAnimation]),
        builder: (context, child) {
          return Opacity(
            opacity: _entranceAnimation.value,
            child: Transform.translate(
              offset: Offset(
                _slideAnimation.value.dx * 20,
                _slideAnimation.value.dy * 20,
              ),
              child: MouseRegion(
                onEnter: (_) {
                  setState(() => _isHovered = true);
                  widget.onHoverChanged(widget.text);
                  _hoverAnimationController.forward();
                },
                onExit: (_) {
                  setState(() => _isHovered = false);
                  widget.onHoverChanged(null);
                  _hoverAnimationController.reverse();
                },
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _isHovered ? _scaleAnimation.value : 1.0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: _isHovered
                              ? ColorsHelper.defaultPrimaryColor
                                  .withOpacity(0.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: _isHovered
                              ? Border.all(
                                  color: ColorsHelper.defaultPrimaryColor
                                      .withOpacity(0.3),
                                  width: 1,
                                )
                              : null,
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            overlayColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: widget.onPressed,
                          child: Text(
                            widget.text,
                            style: _getOptimizedTextStyle(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TextStyle _getOptimizedTextStyle() {
    if (_isHovered) {
      return _hoveredTextStyle;
    } else if (widget.isGreyedOut) {
      return _greyedTextStyle;
    } else {
      return _baseTextStyle;
    }
  }
}
