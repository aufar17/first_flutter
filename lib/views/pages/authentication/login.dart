import 'package:first_flutter/views/pages/authentication/login_large.dart';
import 'package:first_flutter/views/pages/authentication/login_small.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(
        children: [
          if (widthScreen > 800) ...[LoginLargePage(), LoginSmallPage()],
          if (widthScreen <= 800) ...[LoginSmallPage()],
        ],
      ),
    );
  }
}
