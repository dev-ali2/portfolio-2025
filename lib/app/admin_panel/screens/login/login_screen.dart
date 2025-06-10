import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:portfolio_2025/app/admin_panel/screens/login/login_controller.dart';

import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsHelper.canvasColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Admin Panel Login',
                    textAlign: TextAlign.center,
                    style: FontsHelper.poppinsFont.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: ColorsHelper.defaultPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: FontsHelper.poppinsFont
                          .copyWith(color: ColorsHelper.white),
                      prefixIcon: const Icon(Icons.email,
                          color: ColorsHelper.defaultPrimaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:
                            const BorderSide(color: ColorsHelper.defaultPrimaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                            color: ColorsHelper.white.withOpacity(0.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                            color: ColorsHelper.defaultPrimaryColor, width: 2),
                      ),
                    ),
                    style: FontsHelper.poppinsFont
                        .copyWith(color: ColorsHelper.white),
                    keyboardType: TextInputType.emailAddress,
                    validator: controller.validateEmail,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: FontsHelper.poppinsFont
                          .copyWith(color: ColorsHelper.white),
                      prefixIcon: const Icon(Icons.lock,
                          color: ColorsHelper.defaultPrimaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:
                            const BorderSide(color: ColorsHelper.defaultPrimaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                            color: ColorsHelper.white.withOpacity(0.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                            color: ColorsHelper.defaultPrimaryColor, width: 2),
                      ),
                    ),
                    style: FontsHelper.poppinsFont
                        .copyWith(color: ColorsHelper.white),
                    obscureText: true,
                    validator: controller.validatePassword,
                  ),
                  const SizedBox(height: 30),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsHelper.defaultPrimaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        textStyle: FontsHelper.poppinsFont.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: controller.loginUser,
                      child: Text('Login',
                          style: FontsHelper.poppinsFont.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    );
                  }),
                  const SizedBox(height: 15),
                  Obx(() {
                    if (controller.errorMessage.value.isNotEmpty) {
                      return Text(
                        controller.errorMessage.value,
                        style: FontsHelper.poppinsFont
                            .copyWith(color: Colors.redAccent, fontSize: 14),
                        textAlign: TextAlign.center,
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
