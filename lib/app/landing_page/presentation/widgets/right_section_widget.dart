import 'package:flutter/material.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class RightSectionWidget extends StatelessWidget {
  const RightSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MqHelper.width * 0.32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SelectableText(
            textAlign: TextAlign.justify,
            'The only way to do great work is to love what you do.',
            style: FontsHelper.landingPageQuoteFont.copyWith(
                fontSize: 30,
                color: ColorsHelper.defaultPrimaryColor.withAlpha(255),
                fontWeight: FontWeight.bold),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text('- Steve Jobs',
                style: FontsHelper.landingPageQuoteFont.copyWith(
                    fontSize: 19,
                    color: ColorsHelper.defaultPrimaryColor.withAlpha(200))),
          ),
          const SizedBox(
            height: 25,
          ),
          Align(
            alignment: Alignment.center,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  visualDensity: VisualDensity.standard,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor:
                      ColorsHelper.defaultPrimaryColor.withAlpha(60),
                  foregroundColor: Colors.white,
                  overlayColor:
                      ColorsHelper.defaultPrimaryColor.withAlpha(255)),
              onPressed: () {},
              label: const Text('Download Resume'),
              icon: const Icon(Icons.download_rounded),
            ),
          )
        ],
      ),
    );
  }
}
