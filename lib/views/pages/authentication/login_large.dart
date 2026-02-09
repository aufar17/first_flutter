import 'package:first_flutter/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginLargePage extends StatelessWidget {
  LoginLargePage({super.key});

  final controller = Get.find<AuthController>();
  final username = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.grey.shade50,
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Products System'.toUpperCase(),
                style: GoogleFonts.rosario(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
              ),
              Image.asset(
                'assets/img/vector.png',
                fit: BoxFit.contain,
                width: 400,
                height: 400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
