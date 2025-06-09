import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';

class ContactIconBtn extends StatelessWidget {
  final double size;
  final double? iconSize;
  final IconData icon;
  final Function() onPressed;
  const ContactIconBtn({
    super.key,
    this.iconSize,
    required this.icon,
    required this.onPressed,
    this.size = 70,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: IconButton(
            style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(
                    ColorsHelper.defaultPrimaryColor.withAlpha(70)),
                elevation: WidgetStateProperty.all(5),
                backgroundColor: WidgetStateProperty.all(
                  Colors.white.withAlpha(20),
                )),
            onPressed: onPressed,
            icon: Icon(
              icon,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
