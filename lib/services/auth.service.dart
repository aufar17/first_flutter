import 'package:first_flutter/response/auth_response.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final String tusername = 'aufar';
  final String tpassword = 'admin123';

  Future<AuthResponse> login({
    required String username,
    required String password,
  }) async {
    if (username.isEmpty) {
      return AuthResponse(
        success: false,
        message: 'Username cannot empty! $username',
      );
    }
    if (password.isEmpty) {
      return AuthResponse(
        success: false,
        message: 'Password cannot empty! $password',
      );
    }

    if (username.trim().toLowerCase() == tusername.toLowerCase() &&
        password.trim() == tpassword) {
      return AuthResponse(
        success: true,
        message: 'Login success! Welcome, $username',
      );
    } else {
      return AuthResponse(
        success: false,
        message: 'Username or password is wrong!',
      );
    }
  }
}
