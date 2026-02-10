import 'package:first_flutter/controller/auth_controller.dart';
import 'package:first_flutter/views/pages/authentication/login.dart';
import 'package:first_flutter/views/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckSession extends StatelessWidget {
  CheckSession({super.key});

  final authcontroller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return authcontroller.isLoggedIn.value ? const Homepage() : const Login();
    });
  }
}
