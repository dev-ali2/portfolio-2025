import 'package:flutter/material.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class TechImageWidget extends StatefulWidget {
  final String image;
  final String title;
  const TechImageWidget({super.key, required this.image, required this.title});

  @override
  State<TechImageWidget> createState() => _TechImageWidgetState();
}

class _TechImageWidgetState extends State<TechImageWidget> {
  bool isHovering = false;
  double _maxWidth = 90;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateMaxWidth();
    });
  }

  void _calculateMaxWidth() {
    final textStyle = FontsHelper.fontUbuntu.copyWith(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16);

    final textPainter = TextPainter(
      text: TextSpan(text: '${widget.title}  ', style: textStyle),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    setState(() {
      _maxWidth = 90 + 10 + textPainter.width + 8;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovering = false;
        });
      },
      child: GestureDetector(
        onTap: () async {
          await launchUrl(Uri.parse(
              'https://www.google.com/search?q=what+is+${widget.title}'));
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          padding: const EdgeInsets.all(4),
          height: 80,
          width: _maxWidth,
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(40),
            borderRadius: BorderRadius.circular(10),
            border: isHovering
                ? Border.all(color: ColorsHelper.defaultPrimaryColor, width: 2)
                : null,
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: isHovering ? 0 : (_maxWidth - 80) / 2,
                top: 0,
                bottom: 0,
                width: 80,
                child: Image.asset(widget.image, fit: BoxFit.fitHeight),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: isHovering ? 90 : _maxWidth,
                top: 0,
                bottom: 0,
                child: Center(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isHovering ? 1.0 : 0.0,
                    child: Text(
                      '${widget.title}  ',
                      style: FontsHelper.fontUbuntu.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
