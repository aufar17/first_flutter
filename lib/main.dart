import 'package:first_flutter/controller/product_controller.dart';
import 'package:first_flutter/pages/homepage.dart';
import 'package:first_flutter/services/auth.service.dart';
import 'package:first_flutter/services/product.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(ProductService());
  Get.put(ProductController());
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
      home: Homepage(),
    );
  }
}
