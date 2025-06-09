import 'package:flutter/material.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class MPagesHeader extends StatelessWidget {
  final String title;

  const MPagesHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.only(top: 80, left: 30, right: 30, bottom: 60),
      child: Align(
        alignment: Alignment.center,
        child: SelectableText(title,
            textAlign: TextAlign.center,
            style: FontsHelper.poppinsFont.copyWith(
                fontSize: 27,
                fontWeight: FontWeight.w600,
                color: ColorsHelper.white)),
      ),
    );
  }
}



// Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SelectableText(
//             title,
//             style: FontsHelper.fontUbuntu.copyWith(
//                 decorationColor: ColorsHelper.defaultPrimaryColor,
//                 fontSize: 35,
//                 color: ColorsHelper.defaultPrimaryColor,
//                 fontWeight: FontWeight.bold),
//           ),
//           Container(
//             width: title.length * 30.0,
//             height: 10,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: ColorsHelper.defaultPrimaryColor,
//               boxShadow: [
//                 BoxShadow(
//                   color: ColorsHelper.defaultPrimaryColor.withAlpha(130),
//                   offset: const Offset(0, 5),
//                   blurRadius: 7,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );