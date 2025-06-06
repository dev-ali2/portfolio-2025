import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class SiteErrorScreen extends StatelessWidget {
  const SiteErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MqHelper.height,
      width: MqHelper.width,
      child: Material(
        color: Colors.black87,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: Lottie.asset('assets/lottie/error_lottie.json',
                    fit: BoxFit.fill,
                    repeat: true,
                    reverse: false,
                    animate: true),
              ),
              const SizedBox(height: 24),
              const Text(
                'Oops! Something went wrong',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Even the best code has its off days!\n Please check back later',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
