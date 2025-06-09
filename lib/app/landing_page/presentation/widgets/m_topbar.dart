import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/landing_page/presentation/controllers/m_top_bar_controller.dart';
import 'dart:ui';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class MTopBar extends StatelessWidget {
  const MTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MTopBarController>(
      init: MTopBarController(),
      builder: (controller) {
        return SizedBox(
          width: MqHelper.width,
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
                            child: _HamburgerMenu(
                              enabledOptions: controller.enabledOptions,
                              onItemPressed: controller.onItemPressed,
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
}

class _HamburgerMenu extends StatefulWidget {
  final List<dynamic> enabledOptions;
  final Function(String) onItemPressed;

  const _HamburgerMenu({
    required this.enabledOptions,
    required this.onItemPressed,
  });

  @override
  State<_HamburgerMenu> createState() => _HamburgerMenuState();
}

class _HamburgerMenuState extends State<_HamburgerMenu>
    with TickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _expansionController;
  late Animation<double> _heightAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _expansionController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _heightAnimation = CurvedAnimation(
      parent: _expansionController,
      curve: Curves.easeInOut,
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _expansionController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
    ));
  }

  @override
  void dispose() {
    _expansionController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _expansionController.forward();
    } else {
      _expansionController.reverse();
    }
  }

  Future<void> _onItemTap(String title) async {
    // Collapse first
    setState(() {
      _isExpanded = false;
    });
    await _expansionController.reverse();

    // Then trigger the action
    widget.onItemPressed(title);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Hamburger icon button
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: GestureDetector(
                      onTap: _toggleMenu,
                      child: AnimatedRotation(
                        turns: _isExpanded ? 0.25 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: Row(
                          spacing: 10,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!_isExpanded)
                              Text(
                                "Explore",
                                style: FontsHelper.fontUbuntu.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: ColorsHelper.white),
                              ),
                            Icon(
                              _isExpanded ? Icons.close : Icons.menu,
                              color: Colors.white.withAlpha(200),
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Expandable menu items
                AnimatedBuilder(
                  animation: _heightAnimation,
                  builder: (context, child) {
                    return SizeTransition(
                      sizeFactor: _heightAnimation,
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: SizedBox(
                          width: !_isExpanded ? 100 : 200,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: widget.enabledOptions.map((option) {
                              return _MenuItem(
                                title: option.title,
                                onTap: () => _onItemTap(option.title),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _MenuItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: TextButton(
        style: TextButton.styleFrom(
          overlayColor: ColorsHelper.defaultPrimaryColor.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: FontsHelper.poppinsFont.copyWith(
            fontSize: 14,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
            color: Colors.white.withAlpha(200),
          ),
        ),
      ),
    );
  }
}
