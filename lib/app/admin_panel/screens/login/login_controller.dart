import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as appwrite_models;
import 'package:portfolio_2025/app/admin_panel/screens/dashboard/dashboard_screen.dart';

class LoginController extends GetxController {
  late Client _client;
  late Account _account;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _client = Client()
        .setEndpoint(dotenv.env['Endpoint'] ?? '')
        .setProject(dotenv.env['Project'] ?? '')
        .setSelfSigned(status: true);

    _account = Account(_client);

    _checkActiveSession();
  }

  Future<void> _checkActiveSession() async {
    try {
      await _account.get();
      Get.offAll(routeName: '/', () => DashboardScreen());
    } on AppwriteException catch (e) {
      print("LoginController: No active session found or error: ${e.message}");
    } catch (e) {
      print(
          "LoginController: Unexpected error checking session: ${e.toString()}");
    }
  }

  Future<void> loginUser() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      errorMessage.value = '';
      try {
        await _account.createEmailPasswordSession(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        Get.off(() => DashboardScreen());
      } on AppwriteException catch (e) {
        errorMessage.value = e.message ?? 'An unknown error occurred.';
      } catch (e) {
        errorMessage.value = 'Login failed: ${e.toString()}';
      } finally {
        isLoading.value = false;
      }
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
