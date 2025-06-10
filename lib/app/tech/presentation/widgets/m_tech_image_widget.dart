import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class MTechImageWidget extends StatefulWidget {
  final String image;
  final String title;
  const MTechImageWidget({super.key, required this.image, required this.title});

  @override
  State<MTechImageWidget> createState() => _MTechImageWidgetState();
}

class _MTechImageWidgetState extends State<MTechImageWidget> {
  final dataController = Get.find<DataController>();
  bool isHovering = false;
  double _maxWidth = 60;

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
      _maxWidth = 60 + 10 + textPainter.width + 8;
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
              'https://www.google.com/search?q=${dataController.siteData!.tech.prependTextOnClick.replaceAll(' ', '+')}+${widget.title}'));
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(4),
          height: 50,
          width: _maxWidth,
          decoration: BoxDecoration(
              color: ColorsHelper.secondaryCanvasColor,
              borderRadius: BorderRadius.circular(10),
              border: isHovering
                  ? Border.all(
                      color: ColorsHelper.defaultPrimaryColor, width: 2)
                  : null),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 6,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 60),
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.fitHeight,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox.shrink();
                      },
                    ),
                  )),
              Text(
                widget.title,
                style: FontsHelper.fontUbuntu.copyWith(
                    color: ColorsHelper.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
