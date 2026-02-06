import 'package:first_flutter/pages/homepage.dart';
import 'package:first_flutter/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isShow = true.obs;
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  void showPassword() {
    isShow.value = !isShow.value;
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    isLoading.value = true;

    final AuthService authService = Get.find<AuthService>();

    final result = await authService.login(
      username: username,
      password: password,
    );

    isLoading.value = false;

    if (result.success) {
      isLoggedIn.value = true;
      Get.snackbar(
        'Login Success',
        result.message,
        icon: const Icon(Icons.check_sharp, color: Colors.white),
        backgroundColor: Colors.green.shade300,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      Get.offAll(() => const Homepage());
    } else {
      Get.snackbar(
        'Gagal',
        result.message,
        icon: const Icon(Icons.error, color: Colors.white),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
