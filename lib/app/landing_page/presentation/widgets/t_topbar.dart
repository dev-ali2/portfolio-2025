import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/landing_page/presentation/controllers/t_top_bar_controller.dart';
import 'dart:ui';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class TTopbar extends StatelessWidget {
  const TTopbar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TTopBarController>(
      init: TTopBarController(),
      builder: (controller) {
        return SizedBox(
          width: MqHelper.width,
          height: 80,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MqHelper.width * 0.01, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (controller.showContainer)
                  Center(
                    child: AnimatedBuilder(
                      animation: Listenable.merge([
                        controller.containerSizeAnimation,
                        controller.containerOpacityAnimation,
                      ]),
                      builder: (context, child) {
                        return Opacity(
                          opacity: controller.isContainerVisible
                              ? controller.containerOpacityAnimation.value
                              : 0.0,
                          child: Transform.scale(
                            scaleX: controller.containerSizeAnimation.value,
                            scaleY: controller.containerSizeAnimation.value,
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
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                                        children:
                                            _buildNavigationItems(controller),
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
      },
    );
  }

  List<Widget> _buildNavigationItems(TTopBarController controller) {
    List<Widget> items = [];

    for (int i = 0; i < controller.enabledOptions.length; i++) {
      final option = controller.enabledOptions[i];
      final shouldBeGreyedOut = controller.isItemGreyedOut(i);
      final isItemVisible = controller.isItemVisible(i);

      items.add(
        _OptimizedAnimatedTextButton(
          key: ValueKey('${option.title}_$i'),
          text: option.title,
          onPressed: () => controller.onItemPressed(option.title),
          onHoverChanged: controller.setHoveredItem,
          isGreyedOut: shouldBeGreyedOut,
          isVisible: isItemVisible,
          animationDelay: i * 150,
        ),
      );
    }

    return items;
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
    _baseTextStyle = FontsHelper.poppinsFont.copyWith(
      fontSize: 14,
      letterSpacing: 1,
      fontWeight: FontWeight.bold,
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
                      child: GetBuilder<MqHelper>(
                        id: 'canvas options',
                        builder: (controller) => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: MqHelper.width * 0.015, vertical: 6),
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
