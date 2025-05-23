import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_2025/helpers/date_time_helper.dart';

class DTopbar extends StatelessWidget {
  const DTopbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        border: Border.all(width: 5, color: Colors.red),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                '</>',
                style: GoogleFonts.pacifico(
                    color: const Color.fromARGB(255, 0, 225, 255),
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            GetBuilder<DateTimeHelper>(
              id: 'timer',
              init: DateTimeHelper(),
              builder: (controller) => SelectableText(
                controller.timeAmPm.value,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            OutlinedButton.icon(
                style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(Colors.green)),
                onPressed: () {},
                label: const Text(
                  'Say Hello!',
                  style: TextStyle(color: Colors.red),
                ),
                icon: const Icon(Icons.waving_hand_rounded)),
          ],
        ),
      ),
    );
  }
}
