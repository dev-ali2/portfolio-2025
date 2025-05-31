
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:portfolio_2025/core/common/widgets/contact_icon_btn.dart';

class DContactPageOptions extends StatelessWidget {
  const DContactPageOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      spacing: 20,
      mainAxisSize: MainAxisSize.min,
      children: [
        ContactIconBtn(
          icon: BoxIcons.bxl_gmail,
          iconSize: 40,
        ),
        ContactIconBtn(
          icon: BoxIcons.bxl_github,
          iconSize: 40,
        ),
        ContactIconBtn(
          icon: BoxIcons.bxl_linkedin,
          iconSize: 40,
        ),
        ContactIconBtn(
          icon: BoxIcons.bxl_whatsapp,
          iconSize: 40,
        ),
        // SizedBox(
        //   height: 70,
        //   width: 70,
        //   child: ClipRRect(
        //     child: BackdropFilter(
        //       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        //       child: IconButton(
        //         style: ButtonStyle(
        //             overlayColor: WidgetStateProperty.all(
        //                 ColorsHelper.defaultPrimaryColor.withAlpha(70)),
        //             elevation: WidgetStateProperty.all(5),
        //             backgroundColor: WidgetStateProperty.all(
        //               Colors.white.withAlpha(20),
        //             )),
        //         onPressed: () {},
        //         icon: const Icon(
        //           BoxIcons.bxl_whatsapp,
        //           size: 40,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
