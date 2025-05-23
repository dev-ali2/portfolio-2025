import 'package:flutter/material.dart';
import 'package:portfolio_2025/app/landing_page/presentation/widgets/d_topbar.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class DLandingPage extends StatelessWidget {
  const DLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
          preferredSize: Size(MqHelper.width, 90), child: const DTopbar()),
    );
  }
}
