import 'package:flutter/material.dart';
import 'package:portfolio_2025/app/landing_page/data/d_topbar_options.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class DTopbar extends StatelessWidget {
  const DTopbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MqHelper.width,
      height: 90,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: MqHelper.width * 0.01),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  '<Ali/>',
                  style: FontsHelper.headerLogoFont.copyWith(
                      color: ColorsHelper.defaultPrimaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Flexible(
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Center(
                      child: _AnimatedTextButton(
                        text: DTopbarOptions.topbarItems[index].title,
                        onPressed: () {},
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: MqHelper.width * 0.01);
                  },
                  itemCount: DTopbarOptions.topbarItems.length),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedTextButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const _AnimatedTextButton({
    required this.text,
    required this.onPressed,
  });

  @override
  State<_AnimatedTextButton> createState() => _AnimatedTextButtonState();
}

class _AnimatedTextButtonState extends State<_AnimatedTextButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TextButton(
        style: TextButton.styleFrom(
          overlayColor: Colors.transparent,
        ),
        onPressed: widget.onPressed,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: FontsHelper.fontUbuntu.copyWith(
            fontSize: 18,
            fontWeight: _isHovered ? FontWeight.bold : FontWeight.normal,
            color: _isHovered ? ColorsHelper.defaultPrimaryColor : Colors.white,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}
