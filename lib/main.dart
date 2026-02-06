import 'package:first_flutter/controller/auth_controller.dart';
import 'package:first_flutter/pages/login.dart';
import 'package:first_flutter/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(AuthService());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'EPM APP',
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
