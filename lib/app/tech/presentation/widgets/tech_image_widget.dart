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
          padding: const EdgeInsets.all(4),
          height: 70,
          width: _maxWidth,
          decoration: BoxDecoration(
              color: ColorsHelper.secondaryCanvasColor,
              borderRadius: BorderRadius.circular(80),
              border: isHovering
                  ? Border.all(
                      color: ColorsHelper.defaultPrimaryColor, width: 2)
                  : null),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
                child: SizedBox(
                  width: 64,
                  child: Image.asset(widget.image, fit: BoxFit.fitHeight),
                ),
              ),
              Expanded(
                child: Text(
                  widget.title,
                  style: FontsHelper.fontUbuntu.copyWith(
                      color: ColorsHelper.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
