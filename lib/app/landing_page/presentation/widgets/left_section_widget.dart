// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/material.dart';
// import 'package:portfolio_2025/app/landing_page/data/animated_texts.dart';
// import 'package:portfolio_2025/app/landing_page/presentation/widgets/landing_page_contact.dart';
// import 'package:portfolio_2025/helpers/colors_helper.dart';
// import 'package:portfolio_2025/helpers/fonts_helper.dart';

// class LeftSectionWidget extends StatelessWidget {
//   const LeftSectionWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       spacing: 10,
//       children: [
//         CircleAvatar(
//           radius: 150,
//           backgroundColor: ColorsHelper.defaultPrimaryColor.withAlpha(200),
//         ),
//         SelectableText(
//           textAlign: TextAlign.center,
//           "Ali Raza",
//           style: FontsHelper.titleNameFont
//               .copyWith(fontSize: 60, fontWeight: FontWeight.bold),
//         ),
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(
//               Icons.play_arrow,
//               color: ColorsHelper.defaultPrimaryColor,
//             ),
//             AnimatedTextKit(
//                 isRepeatingAnimation: true,
//                 repeatForever: true,
//                 pause: const Duration(seconds: 2),
//                 animatedTexts: AnimatedTexts.texts as List<AnimatedText>),
//             Text(
//               '|',
//               style: FontsHelper.animatedTextsFont.copyWith(
//                   fontSize: 19, color: ColorsHelper.defaultPrimaryColor),
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         LandingPageContact(),
//       ],
//     );
//   }
// }
