import 'package:first_flutter/controller/auth_controller.dart';
import 'package:first_flutter/controller/product_controller.dart';
import 'package:first_flutter/views/pages/authentication/login.dart';
import 'package:first_flutter/services/auth.service.dart';
import 'package:first_flutter/services/product.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(ProductService());
  Get.put(ProductController());
  Get.put(AuthService());
  Get.put(AuthController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EPM APP',
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}
