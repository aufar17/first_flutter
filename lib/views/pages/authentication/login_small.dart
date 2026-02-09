import 'package:first_flutter/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginSmallPage extends StatelessWidget {
  LoginSmallPage({super.key});
  final controller = Get.find<AuthController>();
  final username = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: AlignmentGeometry.bottomLeft,
            colors: [
              Colors.green.shade400,
              Colors.green.shade300,
              Colors.green.shade100,
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        alignment: Alignment.center,
        child: SizedBox(
          height: 450,
          width: 500,
          child: Card(
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/img/logo.png',
                            fit: BoxFit.contain,
                            width: 100,
                            height: 100,
                          ),
                          Center(
                            child: Text(
                              'Sign In'.toUpperCase(),
                              style: GoogleFonts.rosario(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      Obx(
                        () => Column(
                          children: [
                            TextFormField(
                              controller: username,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: GoogleFonts.rosario(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                ),
                                floatingLabelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade500,
                                    width: 1,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.person),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.green.shade300,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (value) =>
                                  value!.isEmpty ? 'Wajib diisi' : null,
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              controller: password,
                              obscureText: controller.isShow.value,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: GoogleFonts.rosario(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                ),
                                floatingLabelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade500,
                                    width: 1,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.lock_person),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.green.shade300,
                                    width: 2,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.showPassword();
                                  },
                                  icon: Icon(
                                    controller.isShow.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                ),
                              ),
                              validator: (value) =>
                                  value!.isEmpty ? 'Wajib diisi' : null,
                            ),

                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.login(
                                    username: username.value.text,
                                    password: password.value.text,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(18.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: Colors.green.shade700,
                                  foregroundColor: Colors.white,
                                  elevation: 4,
                                  textStyle: GoogleFonts.rosario(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: controller.isLoading.value
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : const Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
