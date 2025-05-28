import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';

class LandingPageContact extends StatelessWidget {
  const LandingPageContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: IconButton(
                style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(
                        ColorsHelper.defaultPrimaryColor.withAlpha(50)),
                    elevation: WidgetStateProperty.all(5),
                    backgroundColor:
                        WidgetStateProperty.all(Colors.white.withAlpha(20))),
                onPressed: () {},
                icon: const Icon(BoxIcons.bxl_gmail),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: 50,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: IconButton(
                style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(
                        ColorsHelper.defaultPrimaryColor.withAlpha(50)),
                    elevation: WidgetStateProperty.all(5),
                    backgroundColor:
                        WidgetStateProperty.all(Colors.white.withAlpha(20))),
                onPressed: () {},
                icon: const Icon(BoxIcons.bxl_github),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: 50,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: IconButton(
                style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(
                        ColorsHelper.defaultPrimaryColor.withAlpha(50)),
                    elevation: WidgetStateProperty.all(5),
                    backgroundColor:
                        WidgetStateProperty.all(Colors.white.withAlpha(20))),
                onPressed: () {},
                icon: const Icon(BoxIcons.bxl_linkedin),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: 50,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: IconButton(
                style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(
                        ColorsHelper.defaultPrimaryColor.withAlpha(50)),
                    elevation: WidgetStateProperty.all(5),
                    backgroundColor: WidgetStateProperty.all(
                      Colors.white.withAlpha(20),
                    )),
                onPressed: () {},
                icon: const Icon(BoxIcons.bxl_whatsapp),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: ElevatedButton.icon(
                // style: ElevatedButton.styleFrom(
                //     foregroundColor: WidgetStateProperty.all(Colors.white),
                //     overlayColor: WidgetStateProperty.all(
                //         ColorsHelper.defaultPrimaryColor.withAlpha(50)),
                //     elevation: WidgetStateProperty.all(5),
                //     backgroundColor: WidgetStateProperty.all(
                //         ColorsHelper.defaultPrimaryColor.withAlpha(50))),
                style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(
                        ColorsHelper.defaultPrimaryColor.withAlpha(50)),
                    elevation: WidgetStateProperty.all(5),
                    backgroundColor: WidgetStateProperty.all(
                      Colors.white.withAlpha(20),
                    )),
                onPressed: () {},
                label: Text(
                  'Download CV',
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: const Color.fromRGBO(191, 200, 202, 1)),
                ),
                icon: const Icon(
                  Icons.download,
                  color: Color.fromRGBO(191, 200, 202, 1),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
