import 'package:flutter/material.dart';

class BlinkingDownArrowCircle extends StatefulWidget {
  final Color circleColor;
  final Color arrowColor;
  final Color borderColor;
  final double borderWidth;
  final Duration blinkDuration;

  const BlinkingDownArrowCircle({
    super.key,
    this.circleColor = Colors.transparent,
    this.arrowColor = Colors.white,
    this.borderColor = Colors.grey,
    this.borderWidth = 1.5,
    this.blinkDuration = const Duration(milliseconds: 700),
  });

  @override
  State<BlinkingDownArrowCircle> createState() =>
      _BlinkingDownArrowCircleState();
}

class _BlinkingDownArrowCircleState extends State<BlinkingDownArrowCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      duration: widget.blinkDuration,
      vsync: this,
    );

    // Create opacity animation that goes from 1.0 to 0.0 and back
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Start the blinking animation and repeat indefinitely
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: widget.circleColor,
        shape: BoxShape.circle,
        // border: Border.all(
        //   color: widget.borderColor,
        //   width: widget.borderWidth,
        // ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 8,
        //     spreadRadius: 2,
        //   ),
        // ],
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: _opacityAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Icon(
                Icons.keyboard_arrow_down,
                color: widget.arrowColor,
                size: 30,
              ),
            );
          },
        ),
      ),
    );
  }
}
